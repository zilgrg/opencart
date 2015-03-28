<?php

class ModelJournal2Checkout extends Model {

    public function __construct($registry) {
        parent::__construct($registry);
        $this->load->model('checkout/order');
    }

    public function getTotal() {
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        $this->load->model('extension/extension');

        $sort_order = array();

        $results = $this->model_extension_extension->getExtensions('total');

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
            }
        }

        return $total;
    }

    public function getPaymentMethods($country_id, $zone_id) {
        $address = array(
            'country_id'    => $country_id,
            'zone_id'       => $zone_id
        );

        $total = $this->getTotal();

        $method_data = array();

        $this->load->model('extension/extension');

        $results = $this->model_extension_extension->getExtensions('payment');

        $recurring = $this->cart->hasRecurringProducts();

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('payment/' . $result['code']);

                $method = $this->{'model_payment_' . $result['code']}->getMethod($address, $total);

                if ($method) {
                    if ($recurring) {
                        if (method_exists($this->{'model_payment_' . $result['code']}, 'recurringPayments') && $this->{'model_payment_' . $result['code']}->recurringPayments()) {
                            $method_data[$result['code']] = $method;
                        }
                    } else {
                        $method_data[$result['code']] = $method;
                    }
                }
            }
        }

        $sort_order = array();

        foreach ($method_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $method_data);

//        var_dump($method_data); die();

        return $method_data;
    }

    public function getShippingMethods($country_id, $zone_id) {
        $address = array(
            'country_id'    => $country_id,
            'zone_id'       => $zone_id
        );

        $method_data = array();

        $this->load->model('extension/extension');

        $results = $this->model_extension_extension->getExtensions('shipping');

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('shipping/' . $result['code']);

                $quote = $this->{'model_shipping_' . $result['code']}->getQuote($address);

                if ($quote) {
                    $method_data[$result['code']] = array(
                        'title'      => $quote['title'],
                        'quote'      => $quote['quote'],
                        'sort_order' => $quote['sort_order'],
                        'error'      => $quote['error']
                    );
                }
            }
        }

        $sort_order = array();

        foreach ($method_data as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $method_data);

        return $method_data;
    }

    public function createOrder() {
        if (!Journal2Utils::getProperty($this->session->data, 'order_id')) {
            $this->session->data['order_id'] = $this->model_checkout_order->addOrder(array(
                'invoice_prefix'            => $this->config->get('config_invoice_prefix'),
                'store_id'                  => $this->config->get('config_store_id'),
                'store_name'                => $this->config->get('config_name'),
                'store_url'                 => $this->config->get('config_store_id') ? $this->config->get('config_url') : HTTP_SERVER,

                'language_id'               => $this->config->get('config_language_id'),
                'currency_id'               => $this->currency->getId(),
                'currency_code'             => $this->currency->getCode(),
                'currency_value'            => $this->currency->getValue($this->currency->getCode()),
                'ip'                        => $this->request->server['REMOTE_ADDR'],
                'forwarded_ip'              => Journal2Utils::getProperty($this->request->server, 'HTTP_X_FORWARDED_FOR', Journal2Utils::getProperty($this->request->server, 'HTTP_CLIENT_IP')),
                'user_agent'                => Journal2Utils::getProperty($this->request->server, 'HTTP_USER_AGENT'),
                'accept_language'           => Journal2Utils::getProperty($this->request->server, 'HTTP_ACCEPT_LANGUAGE'),

                'customer_id'               => '',
                'customer_group_id'         => '',
                'firstname'                 => '',
                'lastname'                  => '',
                'email'                     => '',
                'telephone'                 => '',
                'fax'                       => '',

                'payment_firstname'         => '',
                'payment_lastname'          => '',
                'payment_company'           => '',
                'payment_address_1'         => '',
                'payment_address_2'         => '',
                'payment_city'              => '',
                'payment_postcode'          => '',
                'payment_country'           => '',
                'payment_country_id'        => '',
                'payment_zone'              => '',
                'payment_zone_id'           => '',
                'payment_address_format'    => '',
                'payment_method'            => '',
                'payment_code'              => '',

                'shipping_firstname'        => '',
                'shipping_lastname'         => '',
                'shipping_company'          => '',
                'shipping_address_1'        => '',
                'shipping_address_2'        => '',
                'shipping_city'             => '',
                'shipping_postcode'         => '',
                'shipping_country'          => '',
                'shipping_country_id'       => '',
                'shipping_zone'             => '',
                'shipping_zone_id'          => '',
                'shipping_address_format'   => '',
                'shipping_method'           => '',
                'shipping_code'             => '',

                'comment'                   => '',
                'total'                     => '',

                'affiliate_id'              => '',
                'commission'                => '',
                'marketing_id'              => '',
                'tracking'                  => ''
            ));
        }
    }

    public function updateOrder($order_id, $data) {
        $data['customer_group_id'] = Journal2Utils::getProperty($data, 'customer_group_id');
        $this->model_checkout_order->editOrder($order_id, $data);
    }

    public function getOrder($order_id) {
        return $this->model_checkout_order->getOrder($order_id);
    }

}