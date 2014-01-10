<?php  
class ControllerQuickCheckoutPaymentMethod extends Controller {
  	public function index() {
		$this->language->load('quickcheckout/checkout');
		
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		
		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$payment_address = $this->model_account_address->getAddress($this->request->get['address_id']);
			
			$this->session->data['payment_address_id'] = $this->request->get['address_id'];
			
			if (isset($this->session->data['guest']['payment'])) {
				unset($this->session->data['guest']['payment']);
			}
		} elseif ($this->customer->isLogged() && isset($this->session->data['payment_address_id'])) {
			$payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);	
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
				$payment_address['country'] = $country_info['name'];
				$payment_address['iso_code_2'] = $country_info['iso_code_2'];
				$payment_address['iso_code_3'] = $country_info['iso_code_3'];
				$payment_address['address_format'] = $country_info['address_format'];
			} else {
				$payment_address['country'] = '';
				$payment_address['iso_code_2'] = '';
				$payment_address['iso_code_3'] = '';
				$payment_address['address_format'] = '';
			}
			
			if ($zone_info) {
				$payment_address['zone'] = $zone_info['name'];
				$payment_address['zone_code'] = $zone_info['code'];
			} else {
				$payment_address['zone'] = '';
				$payment_address['zone_code'] = '';
			}
		
			$payment_address['country_id'] = $this->request->get['country_id'];	
			$payment_address['zone_id'] = $this->request->get['zone_id'];
			$payment_address['city'] = $this->request->get['city'];
			$payment_address['postcode'] = $this->request->get['postcode'];
			
			
			$this->session->data['payment_country_id'] = $this->request->get['country_id'];
			$this->session->data['payment_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['payment_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$this->session->data['guest']['payment']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['payment']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['payment']['city'] = $this->request->get['city'];
			$this->session->data['guest']['payment']['postcode'] = $this->request->get['postcode'];
			
			if (isset($this->request->get['country_id'])) {
				$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			} else {
				$country_info = '';
			}
			
			if ($country_info) {
				$this->session->data['guest']['payment']['country'] = $country_info['name'];	
				$this->session->data['guest']['payment']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['payment']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['payment']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['payment']['country'] = '';	
				$this->session->data['guest']['payment']['iso_code_2'] = '';
				$this->session->data['guest']['payment']['iso_code_3'] = '';
				$this->session->data['guest']['payment']['address_format'] = '';
			}
			
			if (isset($this->request->get['zone_id'])) {
				$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
			} else {
				$zone_info = '';
			}
			
			if ($zone_info) {
				$this->session->data['guest']['payment']['zone'] = $zone_info['name'];
				$this->session->data['guest']['payment']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['payment']['zone'] = '';
				$this->session->data['guest']['payment']['zone_code'] = '';
			}
			
			if ($country_info) {
				$payment_address['country'] = $country_info['name'];
				$payment_address['iso_code_2'] = $country_info['iso_code_2'];
				$payment_address['iso_code_3'] = $country_info['iso_code_3'];
				$payment_address['address_format'] = $country_info['address_format'];
			} else {
				$payment_address['country'] = '';
				$payment_address['iso_code_2'] = '';
				$payment_address['iso_code_3'] = '';
				$payment_address['address_format'] = '';
			}
			
			if ($zone_info) {
				$payment_address['zone'] = $zone_info['name'];
				$payment_address['zone_code'] = $zone_info['code'];
			} else {
				$payment_address['zone'] = '';
				$payment_address['zone_code'] = '';
			}
			
			$payment_address['country_id'] = $this->request->get['country_id'];		
			$payment_address['zone_id'] = $this->request->get['zone_id'];
			$payment_address['city'] = $this->request->get['city'];
			$payment_address['postcode'] = $this->request->get['postcode'];
			
			$this->session->data['payment_country_id'] = $this->request->get['country_id'];
			$this->session->data['payment_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['payment_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->session->data['guest']['payment'])) {
			$payment_address = $this->session->data['guest']['payment'];
		} else {
			$this->session->data['guest']['payment']['country'] = '';	
			$this->session->data['guest']['payment']['iso_code_2'] = '';
			$this->session->data['guest']['payment']['iso_code_3'] = '';
			$this->session->data['guest']['payment']['address_format'] = '';
			$this->session->data['guest']['payment']['zone'] = '';
			$this->session->data['guest']['payment']['zone_code'] = '';
		}
		
		if (!empty($payment_address)) {
			// Totals
			$total_data = array();					
			$total = 0;
			$taxes = $this->cart->getTaxes();
			
			$this->load->model('setting/extension');
			
			$sort_order = array(); 
			
			$results = $this->model_setting_extension->getExtensions('total');
			
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
			
			// Payment Methods
			$method_data = array();
			
			$this->load->model('setting/extension');
			
			$results = $this->model_setting_extension->getExtensions('payment');
	
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('payment/' . $result['code']);
					
					$method = $this->{'model_payment_' . $result['code']}->getMethod($payment_address, $total); 
					
					if ($method) {
						$method_data[$result['code']] = $method;
					}
				}
			}
						 
			$sort_order = array(); 
		  
			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $method_data);			
			
			$this->session->data['payment_methods'] = $method_data;			
		}			
		
		$this->data['text_payment_method'] = $this->language->get('text_payment_method');
		$this->data['text_comments'] = $this->language->get('text_comments');
		
		if ($this->config->get('quickcheckout_survey_text')) {
			$text_survey = $this->config->get('quickcheckout_survey_text');
			
			if (!empty($text_survey[$this->config->get('config_language_id')])) {
				$this->data['text_survey'] = $text_survey[$this->config->get('config_language_id')];
			} else {
				$this->data['text_survey'] = '';
			}
		} else {
			$this->data['text_survey'] = '';
		}
   
		if (empty($this->session->data['payment_methods'])) {
			$this->data['error_warning'] = sprintf($this->language->get('error_no_payment'), $this->url->link('information/contact'));
		} else {
			$this->data['error_warning'] = '';
		}	

		if (isset($this->session->data['payment_methods'])) {
			$this->data['payment_methods'] = $this->session->data['payment_methods']; 
		} else {
			$this->data['payment_methods'] = array();
		}
	  
		if (isset($this->session->data['payment_method']['code'])) {
			$this->data['code'] = $this->session->data['payment_method']['code'];
		} else {
			$this->data['code'] = '';
		}
		
		if (!isset($this->session->data['comment'])) {
			$this->session->data['comment'] = '';
		}
		
		$part = explode('@@Comment: ', $this->session->data['comment']);
		
		if (isset($this->session->data['comment'])) {
			$this->data['comment'] = isset($part[1]) ? $part[1] : '';
		} else {
			$this->data['comment'] = '';
		}
		
		if (isset($this->request->get['survey'])) {
			$this->data['survey'] = $this->request->get['survey'];
		} elseif (isset($this->session->data['survey'])) {
			$this->data['survey'] = $this->session->data['survey'];
		} else {
			$this->data['survey'] = '';
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/payment_method.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/payment_method.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/payment_method.tpl';
		}
		
		$this->response->setOutput($this->render());
  	}
	
	public function set() {
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		
		if (isset($this->request->get['address_id']) && $this->request->get['address_id']) {
			$this->session->data['payment_address_id'] = $this->request->get['address_id'];
			
			if (isset($this->session->data['guest']['payment'])) {
				unset($this->session->data['guest']['payment']);
			}
		} elseif ($this->customer->isLogged() && isset($this->request->get['isset'])) {
			$this->session->data['payment_country_id'] = $this->request->get['country_id'];
			$this->session->data['payment_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['payment_postcode'] = $this->request->get['postcode'];
		} elseif (isset($this->request->get['isset']) && $this->request->get['isset']) {
			$this->session->data['guest']['payment']['country_id'] = $this->request->get['country_id'];
			$this->session->data['guest']['payment']['zone_id'] = $this->request->get['zone_id'];
			$this->session->data['guest']['payment']['city'] = $this->request->get['city'];
			$this->session->data['guest']['payment']['postcode'] = $this->request->get['postcode'];
			
			$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
			
			if ($country_info) {
				$this->session->data['guest']['payment']['country'] = $country_info['name'];	
				$this->session->data['guest']['payment']['iso_code_2'] = $country_info['iso_code_2'];
				$this->session->data['guest']['payment']['iso_code_3'] = $country_info['iso_code_3'];
				$this->session->data['guest']['payment']['address_format'] = $country_info['address_format'];
			} else {
				$this->session->data['guest']['payment']['country'] = '';	
				$this->session->data['guest']['payment']['iso_code_2'] = '';
				$this->session->data['guest']['payment']['iso_code_3'] = '';
				$this->session->data['guest']['payment']['address_format'] = '';
			}
			
			$zone_info = $this->model_localisation_zone->getZone($this->request->get['zone_id']);
			
			if ($zone_info) {
				$this->session->data['guest']['payment']['zone'] = $zone_info['name'];
				$this->session->data['guest']['payment']['zone_code'] = $zone_info['code'];
			} else {
				$this->session->data['guest']['payment']['zone'] = '';
				$this->session->data['guest']['payment']['zone_code'] = '';
			}
			
			$this->session->data['payment_country_id'] = $this->request->get['country_id'];
			$this->session->data['payment_zone_id'] = $this->request->get['zone_id'];
			$this->session->data['payment_postcode'] = $this->request->get['postcode'];
		} else {
			$this->session->data['guest']['payment']['country'] = '';	
			$this->session->data['guest']['payment']['iso_code_2'] = '';
			$this->session->data['guest']['payment']['iso_code_3'] = '';
			$this->session->data['guest']['payment']['address_format'] = '';
			$this->session->data['guest']['payment']['zone'] = '';
			$this->session->data['guest']['payment']['zone_code'] = '';
		}
		
		if (isset($this->request->get['survey'])) {
			$this->session->data['survey'] = strip_tags($this->request->get['survey']);
		}
		
		if (isset($this->request->get['payment_method']) && isset($this->session->data['payment_methods'])) {
			$this->session->data['payment_method'] = $this->session->data['payment_methods'][$this->request->get['payment_method']];
		}
	}
	
	public function validate() {
		$this->language->load('quickcheckout/checkout');
		$this->load->model('account/address');
		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		
		if ($this->customer->isLogged() && isset($this->session->data['payment_address_id'])) {			
			$payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);		
		} elseif (isset($this->session->data['guest']['payment'])) {
			$payment_address = $this->session->data['guest']['payment'];
		} else {
			$payment_address = array();
		}
		
		if (!empty($payment_address)) {
			// Totals
			$total_data = array();					
			$total = 0;
			$taxes = $this->cart->getTaxes();
			
			$this->load->model('setting/extension');
			
			$sort_order = array(); 
			
			$results = $this->model_setting_extension->getExtensions('total');
			
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
			
			// Payment Methods
			$method_data = array();
			
			$this->load->model('setting/extension');
			
			$results = $this->model_setting_extension->getExtensions('payment');
	
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('payment/' . $result['code']);
					
					$method = $this->{'model_payment_' . $result['code']}->getMethod($payment_address, $total); 
					
					if ($method) {
						$method_data[$result['code']] = $method;
					}
				}
			}
						 
			$sort_order = array(); 
		  
			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $method_data);			
			
			$this->session->data['payment_methods'] = $method_data;			
		}
		
		$json = array();
		
		// Validate if payment address has been set.
		if ($this->customer->isLogged() && isset($this->session->data['payment_address_id'])) {
			$payment_address = $this->model_account_address->getAddress($this->session->data['payment_address_id']);		
		} elseif (isset($this->session->data['guest'])) {
			$payment_address = $this->session->data['guest']['payment'];
		}	
				
		// Payment address not set
		if (empty($payment_address)) {
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
			if (!isset($this->request->post['payment_method'])) {
				$json['error']['warning'] = $this->language->get('error_payment');
			} else {
				if (!isset($this->session->data['payment_methods'][$this->request->post['payment_method']])) {
					$json['error']['warning'] = $this->language->get('error_payment');
				}
			}	
			
			if ($this->config->get('quickcheckout_survey_required')) {
				if (empty($this->request->post['survey'])) {
					$json['error']['warning'] = $this->language->get('error_survey');
				}
			}
			
			if (!$json) {
				$this->session->data['payment_method'] = $this->session->data['payment_methods'][$this->request->post['payment_method']];
			  
				$this->session->data['comment'] = strip_tags($this->request->post['comment']);
				
				$this->session->data['survey'] = strip_tags($this->request->post['survey']);
			}							
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>