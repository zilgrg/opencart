<?php

/**
 * Class ModelJournal2Checkout
 * @property Customer $customer
 */
class ModelJournal2Checkout extends Model {

    private $order_id;
    private $order_data;

    private static $ADDRESS_FIELDS = array(
        'firstname',
        'lastname',
        'company',
        'address_id',
        'address_1',
        'address_2',
        'city',
        'postcode',
        'country_id',
        'zone_id',
        'custom_field'
    );

    public function __construct($registry) {
        parent::__construct($registry);
        $this->load->model('checkout/order');
        $this->load->model('localisation/country');
        $this->load->model('localisation/zone');
        $this->order_id = Journal2Utils::getProperty($this->session->data, 'order_id');
        $this->order_data = $this->order_id ? $this->model_checkout_order->getOrder($this->order_id) : array();
        $this->save();
    }

    public function save() {
        /* default values */
        $order_data = array(
            'invoice_prefix'            => $this->config->get('config_invoice_prefix'),
            'store_id'                  => $this->config->get('config_store_id'),
            'store_name'                => $this->config->get('config_name'),
            'store_url'                 => $this->config->get('config_store_id') ? $this->config->get('config_url') : HTTP_SERVER,

            'customer_id'               => $this->customer->isLogged() ? $this->customer->getId() : 0,
            'customer_group_id'         => $this->customer->isLogged() ? (Front::$IS_OC2 ? $this->customer->getGroupId() : $this->customer->getCustomerGroupId()) : $this->config->get('config_customer_group_id'),
            'firstname'                 => '',
            'lastname'                  => '',
            'email'                     => '',
            'telephone'                 => '',
            'fax'                       => '',

            'payment_firstname'         => '',
            'payment_lastname'          => '',
            'payment_company'           => '',
            'payment_company_id'        => '',
            'payment_address_1'         => '',
            'payment_address_2'         => '',
            'payment_city'              => '',
            'payment_postcode'          => '',
            'payment_country'           => '',
            'payment_country_id'        => '',
            'payment_tax_id'            => '',
            'payment_zone'              => '',
            'payment_zone_id'           => '',
            'payment_address_format'    => '',
            'payment_method'            => '',
            'payment_code'              => '',
            'payment_custom_field'      => array(),

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
            'shipping_custom_field'     => array(),

            'comment'                   => '',
            'total'                     => '',

            'affiliate_id'              => '',
            'commission'                => '',
            'marketing_id'              => '',
            'tracking'                  => ''
        );

        if (!Front::$IS_OC2) {
            $order_data['products'] = array();
            $order_data['vouchers'] = array();
            $order_data['totals']   = array();
        }

        /* merge default values with order values */
        $this->order_data = array_replace($order_data, $this->order_data);

        /* update order data */
        $this->order_data = array_replace($this->order_data, array(
            'language_id'               => $this->config->get('config_language_id'),
            'currency_id'               => $this->currency->getId(),
            'currency_code'             => $this->currency->getCode(),
            'currency_value'            => $this->currency->getValue($this->currency->getCode()),
            'ip'                        => $this->request->server['REMOTE_ADDR'],
            'forwarded_ip'              => Journal2Utils::getProperty($this->request->server, 'HTTP_X_FORWARDED_FOR', Journal2Utils::getProperty($this->request->server, 'HTTP_CLIENT_IP')),
            'user_agent'                => Journal2Utils::getProperty($this->request->server, 'HTTP_USER_AGENT'),
            'accept_language'           => Journal2Utils::getProperty($this->request->server, 'HTTP_ACCEPT_LANGUAGE'),
        ));

        /* get total */
        $this->order_data['total'] = $this->getTotal();

        if ($this->order_id) {
            if (Front::$IS_OC2) {
                $this->model_checkout_order->editOrder($this->order_id, $this->order_data);
            } else {
                $this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_prefix = '" . $this->db->escape($this->order_data['invoice_prefix']) . "', store_id = '" . (int)$this->order_data['store_id'] . "', store_name = '" . $this->db->escape($this->order_data['store_name']) . "', store_url = '" . $this->db->escape($this->order_data['store_url']) . "', customer_id = '" . (int)$this->order_data['customer_id'] . "', customer_group_id = '" . (int)$this->order_data['customer_group_id'] . "', firstname = '" . $this->db->escape($this->order_data['firstname']) . "', lastname = '" . $this->db->escape($this->order_data['lastname']) . "', email = '" . $this->db->escape($this->order_data['email']) . "', telephone = '" . $this->db->escape($this->order_data['telephone']) . "', fax = '" . $this->db->escape($this->order_data['fax']) . "', payment_firstname = '" . $this->db->escape($this->order_data['payment_firstname']) . "', payment_lastname = '" . $this->db->escape($this->order_data['payment_lastname']) . "', payment_company = '" . $this->db->escape($this->order_data['payment_company']) . "', payment_company_id = '" . $this->db->escape($this->order_data['payment_company_id']) . "', payment_tax_id = '" . $this->db->escape($this->order_data['payment_tax_id']) . "', payment_address_1 = '" . $this->db->escape($this->order_data['payment_address_1']) . "', payment_address_2 = '" . $this->db->escape($this->order_data['payment_address_2']) . "', payment_city = '" . $this->db->escape($this->order_data['payment_city']) . "', payment_postcode = '" . $this->db->escape($this->order_data['payment_postcode']) . "', payment_country = '" . $this->db->escape($this->order_data['payment_country']) . "', payment_country_id = '" . (int)$this->order_data['payment_country_id'] . "', payment_zone = '" . $this->db->escape($this->order_data['payment_zone']) . "', payment_zone_id = '" . (int)$this->order_data['payment_zone_id'] . "', payment_address_format = '" . $this->db->escape($this->order_data['payment_address_format']) . "', payment_method = '" . $this->db->escape($this->order_data['payment_method']) . "', payment_code = '" . $this->db->escape($this->order_data['payment_code']) . "', shipping_firstname = '" . $this->db->escape($this->order_data['shipping_firstname']) . "', shipping_lastname = '" . $this->db->escape($this->order_data['shipping_lastname']) . "', shipping_company = '" . $this->db->escape($this->order_data['shipping_company']) . "', shipping_address_1 = '" . $this->db->escape($this->order_data['shipping_address_1']) . "', shipping_address_2 = '" . $this->db->escape($this->order_data['shipping_address_2']) . "', shipping_city = '" . $this->db->escape($this->order_data['shipping_city']) . "', shipping_postcode = '" . $this->db->escape($this->order_data['shipping_postcode']) . "', shipping_country = '" . $this->db->escape($this->order_data['shipping_country']) . "', shipping_country_id = '" . (int)$this->order_data['shipping_country_id'] . "', shipping_zone = '" . $this->db->escape($this->order_data['shipping_zone']) . "', shipping_zone_id = '" . (int)$this->order_data['shipping_zone_id'] . "', shipping_address_format = '" . $this->db->escape($this->order_data['shipping_address_format']) . "', shipping_method = '" . $this->db->escape($this->order_data['shipping_method']) . "', shipping_code = '" . $this->db->escape($this->order_data['shipping_code']) . "', comment = '" . $this->db->escape($this->order_data['comment']) . "', total = '" . (float)$this->order_data['total'] . "', language_id = '" . (int)$this->order_data['language_id'] . "', currency_id = '" . (int)$this->order_data['currency_id'] . "', currency_code = '" . $this->db->escape($this->order_data['currency_code']) . "', currency_value = '" . (float)$this->order_data['currency_value'] . "', ip = '" . $this->db->escape($this->order_data['ip']) . "', forwarded_ip = '" .  $this->db->escape($this->order_data['forwarded_ip']) . "', user_agent = '" . $this->db->escape($this->order_data['user_agent']) . "', accept_language = '" . $this->db->escape($this->order_data['accept_language']) . "', date_added = NOW(), date_modified = NOW() WHERE order_id = '" . (int)$this->order_id . "'");

                $this->db->query("DELETE FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$this->order_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$this->order_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "order_download WHERE order_id = '" . (int)$this->order_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$this->order_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$this->order_id . "'");


                foreach ($this->order_data['products'] as $product) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$this->order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '" . (float)$product['tax'] . "', reward = '" . (int)$product['reward'] . "'");

                    $order_product_id = $this->db->getLastId();

                    foreach ($product['option'] as $option) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$this->order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
                    }

                    foreach ($product['download'] as $download) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "order_download SET order_id = '" . (int)$this->order_id . "', order_product_id = '" . (int)$order_product_id . "', name = '" . $this->db->escape($download['name']) . "', filename = '" . $this->db->escape($download['filename']) . "', mask = '" . $this->db->escape($download['mask']) . "', remaining = '" . (int)($download['remaining'] * $product['quantity']) . "'");
                    }
                }

                foreach ($this->order_data['vouchers'] as $voucher) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$this->order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");
                }

                foreach ($this->order_data['totals'] as $total) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$this->order_id . "', code = '" . $this->db->escape($total['code']) . "', title = '" . $this->db->escape($total['title']) . "', text = '" . $this->db->escape($total['text']) . "', `value` = '" . (float)$total['value'] . "', sort_order = '" . (int)$total['sort_order'] . "'");
                }
            }
        } else {
            if ($this->customer->isLogged()) {
                $address_id = $this->customer->getAddressId();
                $address_info = $this->model_account_address->getAddress($address_id);
                $this->setAddress('payment', $address_info);
                $this->setAddress('shipping', $address_info);
            } else {
                $this->order_data['payment_country_id']     = $this->config->get('config_country_id');
                $this->order_data['payment_zone_id']        = $this->config->get('config_zone_id');
                $this->order_data['shipping_country_id']    = $this->config->get('config_country_id');
                $this->order_data['shipping_zone_id']       = $this->config->get('config_zone_id');
            }
            $this->order_id = $this->model_checkout_order->addOrder($this->order_data);
            $this->session->data['order_id'] = $this->order_id;
        }
    }

    public function getAddress($type) {
        $result = array();
        foreach (self::$ADDRESS_FIELDS as $field) {
            $result[$field] = Journal2Utils::getProperty($this->order_data, $type . '_' . $field);
        }
        $country_info = $this->model_localisation_country->getCountry($result['country_id']);
        if ($country_info) {
            $result['country_name'] = $country_info['name'];
            $result['iso_code_2'] = $country_info['iso_code_2'];
            $result['iso_code_3'] = $country_info['iso_code_3'];
            $result['address_format'] = $country_info['address_format'];
        }
        $zone_info = $this->model_localisation_zone->getZone($result['zone_id']);
        if ($zone_info) {
            $result['zone_name'] = $zone_info['name'];
            $result['zone_code'] = $zone_info['code'];
        } else {
            $result['zone_name'] = '';
            $result['zone_code'] = '';
        }
        $this->session->data[$type . '_address'] = $result;
        return $result;
    }

    public function setAddress($type, $address) {
        foreach ($address as $key => $value) {
            $this->order_data[$type . '_' . $key] = $value;
        }
        $this->getAddress($type);
    }

    public function getPaymentMethods() {
        $total = $this->getTotal();

        $method_data = array();

        if (Front::$IS_OC2) {
            $this->load->model('extension/extension');
            $results = $this->model_extension_extension->getExtensions('payment');
        } else {
            $this->load->model('setting/extension');
            $results = $this->model_setting_extension->getExtensions('payment');
        }

        if (version_compare(VERSION, '1.5.6', '>=')) {
            $recurring = $this->cart->hasRecurringProducts();
        } else {
            $recurring = false;
        }

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('payment/' . $result['code']);

                $method = $this->{'model_payment_' . $result['code']}->getMethod($this->session->data['payment_address'], $total);

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

        $this->session->data['payment_methods'] = $method_data;

        return $method_data;
    }

    public function getPaymentMethodCode() {
        if ($value = Journal2Utils::getProperty($this->session->data, 'payment_methods.' . Journal2Utils::getProperty($this->session->data, 'payment_method.code'))) {
            $code = $value['code'];
            $this->session->data['payment_method'] = $value;
        } else {
            $code = array_get_first_key(Journal2Utils::getProperty($this->session->data, 'payment_methods', array()));
            $this->session->data['payment_method'] = $this->session->data['payment_methods'][$code];
        }

        if (!$code) {
            unset($this->session->data['payment_method']);
        }

        return $code;
    }

    public function getShippingMethods() {
        $method_data = array();

        if (Front::$IS_OC2) {
            $this->load->model('extension/extension');
            $results = $this->model_extension_extension->getExtensions('shipping');
        } else {
            $this->load->model('setting/extension');
            $results = $this->model_setting_extension->getExtensions('shipping');
        }

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('shipping/' . $result['code']);

                $quote = $this->{'model_shipping_' . $result['code']}->getQuote($this->session->data['shipping_address']);

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

        $this->session->data['shipping_methods'] = $method_data;

        return $method_data;
    }

    public function getShippingMethodCode() {
        $code = '';

        $parts = explode('.', Journal2Utils::getProperty($this->session->data, 'shipping_method.code'));

        if (count($parts) > 1 && $value = Journal2Utils::getProperty($this->session->data, 'shipping_methods.' . $parts[0] . '.quote.' . $parts[1])) {
            $code = $value['code'];
            $this->session->data['shipping_method'] = $value;
        } else {
            $part1 = array_get_first_key(Journal2Utils::getProperty($this->session->data, 'shipping_methods', array()));
            $part2 = array_get_first_key(Journal2Utils::getProperty($this->session->data, 'shipping_methods.' . $part1 . '.quote', array()));
            if ($part1 && $part2) {
                $code = $part1 . '.' . $part2;
                $this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$part1]['quote'][$part2];
            }
        }

        if (!$code) {
            unset($this->session->data['shipping_method']);
        }

        return $code;
    }

    public function getTotal() {
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        if (Front::$IS_OC2) {
            $this->load->model('extension/extension');
            $results = $this->model_extension_extension->getExtensions('total');
        } else {
            $this->load->model('setting/extension');
            $results = $this->model_setting_extension->getExtensions('total');
        }

        $sort_order = array();

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

    public function getTotals() {
        $total = 0;
        $taxes = $this->cart->getTaxes();

        if (Front::$IS_OC2) {
            $this->load->model('extension/extension');
            $results = $this->model_extension_extension->getExtensions('total');
        } else {
            $this->load->model('setting/extension');
            $results = $this->model_setting_extension->getExtensions('total');
        }

        $sort_order = array();

        foreach ($results as $key => $value) {
            $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
        }

        array_multisort($sort_order, SORT_ASC, $results);

        foreach ($results as $result) {
            if ($this->config->get($result['code'] . '_status')) {
                $this->load->model('total/' . $result['code']);

                $this->{'model_total_' . $result['code']}->getTotal($this->order_data['totals'], $total, $taxes);
            }
        }

        $sort_order = array();

        foreach ($this->order_data['totals'] as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }

        array_multisort($sort_order, SORT_ASC, $this->order_data['totals']);

        $result = array();

        foreach ($this->order_data['totals'] as $total) {
            $result[] = array(
                'title' => $total['title'],
                'text'  => $this->currency->format($total['value']),
            );
        }

        return $result;
    }

    public function getProducts() {
        $result = array();

        foreach ($this->cart->getProducts() as $product) {
            $option_data = array();

            if ($product['image']) {
                $image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
            } else {
                $image = '';
            }

            foreach ($product['option'] as $option) {
                if ($option['type'] != 'file') {
                    $value = Front::$IS_OC2 ? $option['value'] : $option['option_value'];
                } else {
                    $upload_info = $this->model_tool_upload->getUploadByCode(Front::$IS_OC2 ? $option['value'] : $option['option_value']);

                    if ($upload_info) {
                        $value = $upload_info['name'];
                    } else {
                        $value = '';
                    }
                }

                $option_data[] = array(
                    'name'  => $option['name'],
                    'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
                );
            }

            $recurring = '';

            if (version_compare(VERSION, '1.5.6', '>=') && $product['recurring']) {
                $frequencies = array(
                    'day'        => $this->language->get('text_day'),
                    'week'       => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month'      => $this->language->get('text_month'),
                    'year'       => $this->language->get('text_year'),
                );

                if ($product['recurring']['trial']) {
                    $recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
                }

                if ($product['recurring']['duration']) {
                    $recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                } else {
                    $recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
                }
            }

            $result[] = array(
                'key'        => $product['key'],
                'product_id' => $product['product_id'],
                'name'       => $product['name'],
                'thumb'      => $image,
                'model'      => $product['model'],
                'option'     => $option_data,
                'recurring'  => $recurring,
                'quantity'   => $product['quantity'],
                'subtract'   => $product['subtract'],
                'price'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))),
                'total'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']),
                'href'       => $this->url->link('product/product', 'product_id=' . $product['product_id']),
            );
        }

        return $result;
    }

    public function getVouchers() {
        $result = array();

        if (!empty($this->session->data['vouchers'])) {
            foreach ($this->session->data['vouchers'] as $voucher) {
                $result[] = array(
                    'description' => $voucher['description'],
                    'amount'      => $this->currency->format($voucher['amount'])
                );
            }
        }

        return $result;
    }

    public function getCustomerGroupId() {
        return Journal2Utils::getProperty($this->request->get, 'customer_group_id', $this->order_data['customer_group_id']);
    }

    public function getCustomFields($type = null) {
        if (!Front::$IS_OC2) {
            return array();
        }

        $custom_fields = $this->model_account_custom_field->getCustomFields($this->getCustomerGroupId());

        foreach ($custom_fields as &$custom_field) {
            if ($type === null) {
                $custom_field['value'] = Journal2Utils::getProperty($this->order_data, 'custom_field.' . $custom_field['custom_field_id']);
            } else {
                $custom_field['value'] = Journal2Utils::getProperty($this->order_data, $type . '_custom_field.' . $custom_field['custom_field_id']);
            }
        }

        return $custom_fields;
    }

    public function getOrder() {
        return $this->order_data;
    }

    public function setOrderData ($order_data) {
        $this->order_data = $order_data;
    }

    public function getComment() {
        return Journal2Utils::getProperty($this->order_data, 'comment');
    }

}