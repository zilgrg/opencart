<?php  
class ControllerQuickCheckoutCheckout extends Controller { 
	public function index() {
		if ($this->config->get('quickcheckout_load_screen')) {
			$this->document->addScript('catalog/view/javascript/jquery/quickcheckout/quickcheckout.block.js');
		}
		
		if ($this->config->get('quickcheckout_countdown')) {
			$this->document->addScript('catalog/view/javascript/jquery/quickcheckout/quickcheckout.countdown.js');
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/quickcheckout.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/quickcheckout.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/quickcheckout.css');
		}
		
		if ($this->config->get('quickcheckout_layout') == '1') {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/quickcheckout_one.css')) {
				$this->data['stylesheet'] = 'catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/quickcheckout_one.css';
			} else {
				$this->data['stylesheet'] = 'catalog/view/theme/default/stylesheet/quickcheckout_one.css';
			}
		} elseif ($this->config->get('quickcheckout_layout') == '2') {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/quickcheckout_two.css')) {
				$this->data['stylesheet'] = 'catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/quickcheckout_two.css';
			} else {
				$this->data['stylesheet'] = 'catalog/view/theme/default/stylesheet/quickcheckout_two.css';
			}
		} else {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/quickcheckout_three.css')) {
				$this->data['stylesheet'] = 'catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/quickcheckout_three.css';
			} else {
				$this->data['stylesheet'] = 'catalog/view/theme/default/stylesheet/quickcheckout_three.css';
			}
		}
		
		if ($this->config->get('quickcheckout_responsive')) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/quickcheckout_mobile.css')) {
				$this->data['mobile_stylesheet'] = 'catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/quickcheckout_mobile.css';
			} else {
				$this->data['mobile_stylesheet'] = 'catalog/view/theme/default/stylesheet/quickcheckout_mobile.css';
			}
		} else {
			$this->data['mobile_stylesheet'] = '';
		}

		if (version_compare(VERSION, '1.5.5', '>=')) {
			$this->document->addStyle('catalog/view/javascript/jquery/colourbox/colorbox.css');
			$this->document->addScript('catalog/view/javascript/jquery/colourbox/jquery.colorbox.js');
		}
		
		$quickcheckout_status = $this->config->get('quickcheckout_status');
		
		if ($quickcheckout_status != 1) {
			$this->redirect($this->url->link('checkout/checkout'));
		}
		
		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
	  		$this->redirect($this->url->link('checkout/cart'));
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
				$this->redirect($this->url->link('checkout/cart'));
			}				
		}
				
		$this->language->load('quickcheckout/checkout');
		
		$this->document->setTitle($this->language->get('heading_title')); 
		
		$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_cart'),
			'href'      => $this->url->link('checkout/cart'),
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('quickcheckout/checkout', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
					
	    $this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$this->data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$this->data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$this->data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$this->data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$this->data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');		
		$this->data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$this->data['text_modify'] = $this->language->get('text_modify');
		$this->data['text_or'] = $this->language->get('text_or');
		$this->data['text_please_wait'] = $this->language->get('text_please_wait');
		
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['shipping_required'] = $this->cart->hasShipping();	
		
		if ($this->config->get('quickcheckout_html_header')) {
			$html_header = $this->config->get('quickcheckout_html_header');
			
			if (!empty($html_header[$this->config->get('config_language_id')])) {
				$this->data['html_header'] = html_entity_decode($html_header[$this->config->get('config_language_id')]);
			} else {
				$this->data['html_header'] = '';
			}
		} else {
			$this->data['html_header'] = '';
		}
		
		if ($this->config->get('quickcheckout_html_footer')) {
			$html_footer = $this->config->get('quickcheckout_html_footer');
			
			if (!empty($html_footer[$this->config->get('config_language_id')])) {
				$this->data['html_footer'] = html_entity_decode($html_footer[$this->config->get('config_language_id')]);
			} else {
				$this->data['html_footer'] = '';
			}
		} else {
			$this->data['html_footer'] = '';
		}
		
		if ($this->config->get('quickcheckout_countdown')) {
			$text = $this->config->get('quickcheckout_countdown_text');
			
			if (!empty($text[$this->config->get('config_language_id')])) {
				if ($this->config->get('quickcheckout_countdown_start')) {
					$time = date('d M Y') . ' ' . $this->config->get('quickcheckout_countdown_time');

					if (time() > strtotime($time)) {
						$this->data['countdown_end'] = date('d M Y H:i:s', strtotime($time . ' +1 day'));
					} else {
						$this->data['countdown_end'] = $time;
					}
				} else {
					if (time() >= strtotime($this->config->get('quickcheckout_countdown_date_start')) && time() <= strtotime($this->config->get('quickcheckout_countdown_date_end'))) {
						$this->data['countdown_end'] = $this->config->get('quickcheckout_countdown_date_end');
					}
				}
			
				$text = explode('{timer}', html_entity_decode($text[$this->config->get('config_language_id')]));
				
				$this->data['countdown_before'] = $text[0];
				$this->data['countdown_after'] = $text[1];
				
				$this->data['countdown_timer'] = '{dn} {dl} {hnn} {hl} {mnn} {ml} {snn} {sl}';
			}
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/checkout.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/checkout.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/checkout.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'	
		);
				
		$this->response->setOutput($this->render());
  	}
	
	public function country() {
		$json = array();
		
		$this->load->model('localisation/country');

    	$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);
		
		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']		
			);
		}
		
		$this->response->setOutput(json_encode($json));
	}
}
?>