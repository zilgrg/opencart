<?php

class ControllerSupercheckoutShippingMethod extends Controller {

    public function index() {
        $this->language->load('supercheckout/supercheckout');

        $this->load->model('account/address');

        //if customer is logged in whether through store or through facebook or google
        if ($this->customer->isLogged()) {

            $shipping_address['country_id'] = $this->session->data['shipping_country_id'];
            $shipping_address['zone_id'] = $this->session->data['shipping_zone_id'];

        } elseif (isset($this->session->data['guest'])) {

            $shipping_address = $this->session->data['guest']['shipping'];

        }
        //loading settings for supercheckout plugin from database or from default settigs
        $this->load->model('setting/setting');

        $result = $this->model_setting_setting->getSetting('velocity_supercheckout', $this->config->get('config_store_id'));

        $this->settings = $result['supercheckout'];

        $this->data['settings'] = $result['supercheckout'];

        if (empty($this->data['settings'])) {

            $this->config->load('supercheckout_settings');
            $settings = $this->config->get('supercheckout_settings');
            $this->data['settings'] = $settings;

        }

        if (!empty($shipping_address)) {
            // Shipping Methods
            $quote_data = array();

            $this->load->model('setting/extension');

            $results = $this->model_setting_extension->getExtensions('shipping');

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('shipping/' . $result['code']);

                    $quote = $this->{'model_shipping_' . $result['code']}->getQuote($shipping_address);

                    if ($quote) {
                        $quote_data[$result['code']] = array(
                                'title' => $quote['title'],
                                'quote' => $quote['quote'],
                                'sort_order' => $quote['sort_order'],
                                'error' => $quote['error']
                        );
                    }
                }
            }

            $sort_order = array();

            foreach ($quote_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $quote_data);

            $this->session->data['shipping_methods'] = $quote_data;
        }

        $this->data['text_shipping_method'] = $this->language->get('text_shipping_method');
        $this->data['text_comments'] = $this->language->get('text_comments');
        $this->data['button_continue'] = $this->language->get('button_continue');

        if (empty($this->session->data['shipping_methods'])) {

            $this->data['error_warning'] = sprintf($this->language->get('error_no_shipping'), $this->url->link('information/contact'));
        } else {

            $this->data['error_warning'] = '';
        }

        if (isset($this->session->data['shipping_methods'])) {

            $this->data['shipping_methods'] = $this->session->data['shipping_methods'];
        } else {

            $this->data['shipping_methods'] = array();
        }

        //for getting first method set to default IF and only IF default is not set at the admin
        $get_first_method_payment = array();
        foreach ($this->session->data['payment_methods'] as $methods) {

            $get_first_method_payment[] = $methods['code'];
        }

        $get_first_method_shipping = array();
        foreach ($this->session->data['shipping_methods'] as $methods => $key) {

            $get_first_method_shipping[] = $methods;
        }

        $default_payment = $this->settings['step']['payment_method']['default_option'];

        $default_shipping = $this->settings['step']['shipping_method']['default_option'];


        if (!in_array($default_payment, $get_first_method_payment)) {

            $this->session->data['payment_method'] = $this->session->data['payment_methods'][$get_first_method_payment[0]];

        } else {

            $this->session->data['payment_method'] = $this->session->data['payment_methods'][$default_payment];

        }
        if(!empty ($get_first_method_shipping)) {
            if (!in_array($default_shipping, $get_first_method_shipping)) {

                $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$get_first_method_shipping[0]]['quote'][$get_first_method_shipping[0]];

            } else {
                foreach($this->session->data['shipping_methods'][$default_shipping]['quote'] as $shipping_methods_key => $shipping_methods_val) {
                    $this->session->data['shipping_method'] = $shipping_methods_val;
                    break;
                }
            }
        }else {
            unset($this->session->data['shipping_method']);
        }
        if (isset($this->session->data['shipping_method']['code'])) {

            $this->data['code'] = $this->session->data['shipping_method']['code'];

        } else {

            $this->data['code'] = '';

        }

        if (isset($this->session->data['comment'])) {

            $this->data['comment'] = $this->session->data['comment'];

        } else {

            $this->data['comment'] = '';

        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/supercheckout/shipping_method.tpl')) {

            $this->template = $this->config->get('config_template') . '/template/supercheckout/shipping_method.tpl';

        } else {

            $this->template = 'default/template/supercheckout/shipping_method.tpl';

        }

        $this->response->setOutput($this->render());
    }

    public function validate() {
        $this->language->load('supercheckout/supercheckout');

        $json = array();

        // Validate if shipping address has been set.
        $this->load->model('account/address');

        //if customer is logged in whether through store or through facebook or google
        if ($this->customer->isLogged()) {

            $shipping_address['country_id'] = $this->session->data['shipping_country_id'];
            $shipping_address['zone_id'] = $this->session->data['shipping_zone_id'];

        } elseif (isset($this->session->data['guest'])) {

            $shipping_address = $this->session->data['guest']['shipping'];

        }

        if (empty($shipping_address)) {
//			$json['redirect'] = $this->url->link('supercheckout/supercheckout', '', 'SSL');
        }

        // Validate cart has products and has stock.
        if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
//			$json['redirect'] = $this->url->link('supercheckout/cart');				
        }

        // Validate minimum quantity requirments.
        $products = $this->cart->getProducts();

        foreach ($products as $product) {
            $product_total = 0;

            foreach ($products as $product_2) {
                if ($product_2['product_id'] == $product['product_id']) {
                    $product_total += $product_2['quantity'];
                }
            }

            if ($product['minimum'] > $product_total) {
                $json['redirect'] = $this->url->link('supercheckout/cart');

                break;
            }
        }

        if (!$json) {
            if (!isset($this->request->post['shipping_method'])) {

                $json['error']['warning'] = $this->language->get('error_shipping');

            } else {

                $shipping = explode('.', $this->request->post['shipping_method']);

                if (!isset($shipping[0]) || !isset($shipping[1]) || !isset($this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]])) {

                    $json['error']['warning'] = $this->language->get('error_shipping');

                }
            }

            if (!$json) {
                $shipping = explode('.', $this->request->post['shipping_method']);

                $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
            }
        }

        $this->response->setOutput(json_encode($json));
    }

}

?>