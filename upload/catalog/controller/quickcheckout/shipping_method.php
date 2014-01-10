<?php 
class ControllerQuickCheckoutShippingMethod extends Controller {
  	public function index() {
		$this->language->load('quickcheckout/checkout');
		
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		
		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$shipping_address = $this->model_account_address->getAddress($this->request->get['address_id']);
			
			$this->session->data['shipping_address_id'] = $this->request->get['address_id'];
			
			if (isset($this->session->data['guest'])) {
				unset($this->session->data['guest']);
			}
		} elseif ($this->customer->isLogged() && isset($this->session->data['shipping_address_id']) && $this->request->get['isset']) {			
			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);	
		} elseif ($this->customer->isLogged() && isset($this->request->get['isset'])) {
			if (isset($this->request->get['country_id'])) {
				$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			} else {
				$country_info = '';
			}
			
			if (isset($this->request->get['zone_id'])) {
				$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
			} else {
				$zone_info = '';
			}
			
			if ($country_info) {
				$shipping_address['country'] = $country_info['name'];
				$shipping_address['iso_code_2'] = $country_info['iso_code_2'];
				$shipping_address['iso_code_3'] = $country_info['iso_code_3'];
				$shipping_address['address_format'] = $country_info['address_format'];
			} else {
				$shipping_address['country'] = '';
				$shipping_address['iso_code_2'] = '';
				$shipping_address['iso_code_3'] = '';
				$shipping_address['address_format'] = '';
			}
			
			if ($zone_info) {
				$shipping_address['zone'] = $zone_info['name'];
				$shipping_address['zone_code'] = $zone_info['code'];
			} else {
				$shipping_address['zone'] = '';
				$shipping_address['zone_code'] = '';
			}
			
			$shipping_address['country_id'] = $this->request->get['country_id'];	
			$shipping_address['zone_id'] = $this->request->get['zone_id'];
			$shipping_address['city'] = $this->request->get['city'];
			$shipping_address['postcode'] = $this->request->get['postcode'];
			
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
			$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];	
			
			if (isset($this->request->get['country_id'])) {
				$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			} else {
				$country_info = '';
			}
		
			if ($country_info) {
				$this->session->data['guest']['shipping']['country'] = $country_info['name'];	
				$this->session->data['guest']['shipping']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['shipping']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['shipping']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['shipping']['country'] = '';	
				$this->session->data['guest']['shipping']['iso_code_2'] = '';
				$this->session->data['guest']['shipping']['iso_code_3'] = '';
				$this->session->data['guest']['shipping']['address_format'] = '';
			}
			
			if (isset($this->request->get['zone_id'])) {
				$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
			} else {
				$zone_info = '';
			}
	
			if ($zone_info) {
				$this->session->data['guest']['shipping']['zone'] = $zone_info['name'];
				$this->session->data['guest']['shipping']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['shipping']['zone'] = '';
				$this->session->data['guest']['shipping']['zone_code'] = '';
			}
			
			if ($country_info) {
				$shipping_address['country'] = $country_info['name'];
				$shipping_address['iso_code_2'] = $country_info['iso_code_2'];
				$shipping_address['iso_code_3'] = $country_info['iso_code_3'];
				$shipping_address['address_format'] = $country_info['address_format'];
			} else {
				$shipping_address['country'] = '';
				$shipping_address['iso_code_2'] = '';
				$shipping_address['iso_code_3'] = '';
				$shipping_address['address_format'] = '';
			}
			
			if ($zone_info) {
				$shipping_address['zone'] = $zone_info['name'];
				$shipping_address['zone_code'] = $zone_info['code'];
			} else {
				$shipping_address['zone'] = '';
				$shipping_address['zone_code'] = '';
			}
			
			$shipping_address['country_id'] = $this->request->get['country_id'];		
			$shipping_address['zone_id'] = $this->request->get['zone_id'];
			$shipping_address['city'] = $this->request->get['city'];
			$shipping_address['postcode'] = $this->request->get['postcode'];
			
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->session->data['guest']['shipping'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		} else {
			$this->session->data['guest']['shipping']['country'] = '';
			$this->session->data['guest']['shipping']['iso_code_2'] = '';
			$this->session->data['guest']['shipping']['iso_code_3'] = '';
			$this->session->data['guest']['shipping']['address_format'] = '';
			$this->session->data['guest']['shipping']['zone'] = '';
			$this->session->data['guest']['shipping']['zone_code'] = '';
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
							'title'      => $quote['title'],
							'quote'      => $quote['quote'], 
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
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
		$this->data['text_estimated_delivery'] = $this->language->get('text_estimated_delivery');
		$this->data['text_delivery'] = $this->language->get('text_delivery');
		
		if ($this->config->get('quickcheckout_delivery_time') == '2') {
			$min = $this->config->get('quickcheckout_delivery_min');
			$max = $this->config->get('quickcheckout_delivery_max');
			$today = date('d M Y');
			
			$min_date = date('d M Y', strtotime($today . ' + ' . $min . ' day'));
			$max_date = date('d M Y', strtotime($today . ' + ' . $max . ' day'));
			
			$min = 0;
			$max = 0;
			
			if ($this->config->get('quickcheckout_delivery_unavailable')) {
				$dates = str_replace('"', '', html_entity_decode($this->config->get('quickcheckout_delivery_unavailable'), ENT_QUOTES));
			} else {
				$dates = array();
			}
			
			foreach (explode(',', $dates) as $unavailable) {
				$unavailable = strtotime($unavailable);
				
				if ($unavailable >= strtotime($min_date) && $unavailable <= strtotime($max_date)) {
					$max++;
				}
				
				if ($unavailable == strtotime($min_date)) {
					$min++;
				}
			}
			
			$min_date = date('d M Y', strtotime($min_date . ' + ' . $min . ' day'));
			$max_date = date('d M Y', strtotime($max_date . ' + ' . $max . ' day'));
			
			$this->data['estimated_delivery'] = $min_date . ' - ' . $max_date;
			$this->data['estimated_delivery_time'] = str_pad($this->config->get('quickcheckout_delivery_min_hour'), 2, '0', STR_PAD_LEFT) . ' 00 - ' . str_pad($this->config->get('quickcheckout_delivery_max_hour'), 2, '0', STR_PAD_LEFT) . ' 00';
		}
		
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
		
		if (isset($this->request->get['delivery_date'])) {
			$this->data['delivery_date'] = $this->request->get['delivery_date'];
		} elseif (isset($this->session->data['delivery_date'])) {
			$this->data['delivery_date'] = $this->session->data['delivery_date'];
		} else {
			$this->data['delivery_date'] = '';
		}
		
		if (isset($this->request->get['delivery_time'])) {
			$this->data['delivery_time'] = $this->request->get['delivery_time'];
		} elseif (isset($this->session->data['delivery_time'])) {
			$this->data['delivery_time'] = $this->session->data['delivery_time'];
		} else {
			$this->data['delivery_time'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/shipping_method.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/shipping_method.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/shipping_method.tpl';
		}
		
		$this->response->setOutput($this->render());
  	}
	
	public function set() {
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		
		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$this->session->data['shipping_address_id'] = $this->request->get['address_id'];
			
			if (isset($this->session->data['guest'])) {
				unset($this->session->data['guest']);
			}
		} elseif ($this->customer->isLogged() && isset($this->request->get['isset'])) {
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$this->session->data['guest']['shipping']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['shipping']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['shipping']['city'] = $this->request->get['city'];
			$this->session->data['guest']['shipping']['postcode'] = $this->request->get['postcode'];	
			
			$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
			if ($country_info) {
				$this->session->data['guest']['shipping']['country'] = $country_info['name'];	
				$this->session->data['guest']['shipping']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['shipping']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['shipping']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['shipping']['country'] = '';	
				$this->session->data['guest']['shipping']['iso_code_2'] = '';
				$this->session->data['guest']['shipping']['iso_code_3'] = '';
				$this->session->data['guest']['shipping']['address_format'] = '';
			}
			
			$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
	
			if ($zone_info) {
				$this->session->data['guest']['shipping']['zone'] = $zone_info['name'];
				$this->session->data['guest']['shipping']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['shipping']['zone'] = '';
				$this->session->data['guest']['shipping']['zone_code'] = '';
			}
			
			$this->session->data['shipping_country_id'] = $this->request->get['country_id'];
			$this->session->data['shipping_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['shipping_postcode'] = $this->request->get['postcode'];
		} else {
			$this->session->data['guest']['shipping']['country'] = '';
			$this->session->data['guest']['shipping']['iso_code_2'] = '';
			$this->session->data['guest']['shipping']['iso_code_3'] = '';
			$this->session->data['guest']['shipping']['address_format'] = '';
			$this->session->data['guest']['shipping']['zone'] = '';
			$this->session->data['guest']['shipping']['zone_code'] = '';
		}
		
		if (isset($this->request->get['delivery_date'])) {
			$this->session->data['delivery_date'] = strip_tags($this->request->get['delivery_date']);
		}
		
		if (isset($this->request->get['delivery_time'])) {
			$this->session->data['delivery_time'] = strip_tags($this->request->get['delivery_time']);
		}
		
		if (isset($this->request->get['shipping_method']) && isset($this->session->data['shipping_methods'])) {
			$shipping = explode('.', $this->request->get['shipping_method']);
						
			$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
		}
		
	}
	
	public function validate() {
		$this->language->load('quickcheckout/checkout');
		$this->load->model('account/address');
		
		if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {			
			$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);		
		} elseif (isset($this->session->data['guest']['shipping'])) {
			$shipping_address = $this->session->data['guest']['shipping'];
		} else {
			$shipping_address = array();
		}
		
		if (!isset($this->session->data['shipping_methods'])) {
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
							'title'      => $quote['title'],
							'quote'      => $quote['quote'], 
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
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
		
		$json = array();		
		
		// Validate if shipping is required. If not the customer should not have reached this page.
		if (!$this->cart->hasShipping()) {
			$json['redirect'] = $this->url->link('quickcheckout/checkout', '', 'SSL');
		}
		
		// Shipping address not set
		if (empty($shipping_address)) {								
			$json['redirect'] = $this->url->link('quickcheckout/checkout', '', 'SSL');
		}
		
		// Validate cart has products and has stock.	
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');				
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
				$json['redirect'] = $this->url->link('checkout/cart');
				
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
			
			if ($this->config->get('quickcheckout_delivery_required')) {
				if (empty($this->request->post['delivery_date'])) {
					$json['error']['warning'] = $this->language->get('error_delivery');
				}
			}
			
			if (!$json) {
				$shipping = explode('.', $this->request->post['shipping_method']);
					
				$this->session->data['shipping_method'] = $this->session->data['shipping_methods'][$shipping[0]]['quote'][$shipping[1]];
				
				$this->session->data['comment'] = strip_tags($this->request->post['comment']);
				
				$this->session->data['delivery_date'] = strip_tags($this->request->post['delivery_date']);
				
				if (isset($this->request->post['delivery_time'])) {
					$this->session->data['delivery_time'] = strip_tags($this->request->post['delivery_time']);
				} else {
					$this->session->data['delivery_time'] = '';
				}
			}							
		}

		$this->response->setOutput(json_encode($json));	
	}
}
?>