<?php
//==============================================================================
// Automatic Shipping v155.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ModelTotalAutomaticShipping extends Model {		
	private $type = 'total';
	private $name = 'automatic_shipping';
	
	private function getSetting($setting) {
		$value = $this->config->get($this->name . '_' . $setting);
		return (is_string($value) && strpos($value, 'a:') === 0) ? unserialize($value) : $value;
	}
	
	public function getTotal(&$total_data, &$order_total, &$taxes) {
//		if (!$this->getSetting('status') || isset($this->session->data['shipping_method']) || empty($this->session->data['cart'])) {
//ZG modified to include below instead of above fix disable the extension when no products require shipping
		if (!$this->getSetting('status') || isset($this->session->data['shipping_method']) || empty($this->session->data['cart']) || !$this->cart->hasShipping()) {
			return;
		}
		
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		
		$checkoutsetting = ($version < 150) ? 'checkout' : 'setting';
		$keycode = ($version < 150) ? 'key' : 'code';
		
		$this->load->model('account/address');
		$address_type = ($this->cart->hasShipping()) ? 'shipping' : 'payment';
		$address = array();
		if ($this->customer->isLogged()) 								$address = $this->model_account_address->getAddress($this->customer->getAddressId());
		if (isset($this->session->data['country_id']))					$address['country_id'] = $this->session->data['country_id'];
		if (isset($this->session->data['zone_id']))						$address['zone_id'] = $this->session->data['zone_id'];
		if (isset($this->session->data['postcode']))					$address['postcode'] = $this->session->data['postcode'];
		if (isset($this->session->data['shipping_country_id']))			$address['country_id'] = $this->session->data['shipping_country_id'];
		if (isset($this->session->data['shipping_zone_id']))			$address['zone_id'] = $this->session->data['shipping_zone_id'];
		if (isset($this->session->data['shipping_postcode']))			$address['postcode'] = $this->session->data['shipping_postcode'];
		if (isset($this->session->data['guest']))						$address = $this->session->data['guest'];
		if (isset($this->session->data['guest'][$address_type]))		$address = $this->session->data['guest'][$address_type];
		if (isset($this->session->data[$address_type . '_address_id']))	$address = $this->model_account_address->getAddress($this->session->data[$address_type . '_address_id']);		
		if (isset($this->session->data[$address_type . '_country_id']))	$address['country_id'] = $this->session->data[$address_type . '_country_id'];
		if (isset($this->session->data[$address_type . '_zone_id']))	$address['zone_id'] = $this->session->data[$address_type . '_zone_id'];
		if (isset($this->session->data[$address_type . '_postcode']))	$address['postcode'] = $this->session->data[$address_type . '_postcode'];
		if (empty($address['country_id']))								$address['country_id'] = $this->config->get('config_country_id');
		if (empty($address['zone_id']))									$address['zone_id'] =  $this->config->get('config_zone_id');
		if (empty($address['postcode']))								$address['postcode'] = '';
		
		$this->load->model('localisation/country');
		$country = $this->model_localisation_country->getCountry($address['country_id']);
		$this->load->model('localisation/zone');
		$zone = $this->model_localisation_zone->getZone($address['zone_id']);
		if (empty($address['firstname'])) $address['firstname'] = '';
		if (empty($address['lastname'])) $address['lastname'] = '';
		if (empty($address['company'])) $address['company'] = '';
		if (empty($address['address_1'])) $address['address_1'] = '';
		if (empty($address['address_2'])) $address['address_2'] = '';
		if (empty($address['city'])) $address['city'] = '';
		if (empty($address['postcode'])) $address['postcode'] = '';
		if (empty($address['zone'])) $address['zone'] = (isset($zone['name'])) ? $zone['name'] : '';
		if (empty($address['zone_code'])) $address['zone_code'] = (isset($zone['code'])) ? $zone['code'] : '';
		if (empty($address['country'])) $address['country'] = (isset($country['name'])) ? $country['name'] : '';
		if (empty($address['iso_code_2'])) $address['iso_code_2'] = (isset($country['iso_code_2'])) ? $country['iso_code_2'] : '';
		if (empty($address['iso_code_3'])) $address['iso_code_3'] = (isset($country['iso_code_3'])) ? $country['iso_code_3'] : '';
		if (empty($address['address_format'])) $address['address_format'] = (isset($country['address_format'])) ? $country['address_format'] : '';
		
		$quote_data = array();
		$this->load->model($checkoutsetting . '/extension');
		$shipping_methods = $this->{'model_'.$checkoutsetting.'_extension'}->getExtensions('shipping');
		foreach ($shipping_methods as $method) {
			if (!$this->config->get($method[$keycode] . '_status') || !in_array($method[$keycode], $this->getSetting('shipping_methods'))) continue;
			$this->load->model('shipping/' . $method[$keycode]);
			$quote = $this->{'model_shipping_'.$method[$keycode]}->getQuote($address);
			if (!$quote) continue;
			$quote_data[$method[$keycode]] = array( 
				'title'			=> $quote['title'],
				'quote'			=> $quote['quote'],
				'sort_order'	=> $quote['sort_order'],
				'error'			=> $quote['error']
			);
		}
		
		$title = '';
		$cost = 999999;
		$tax_class_id = '';
		
		foreach ($quote_data as $quote) {
			if (!empty($quote['error'])) continue;
			foreach ($quote['quote'] as $q) {
				if ($q['cost'] < $cost) {
					$title = $q['title'];
					$cost = $q['cost'];
					$tax_class_id = $q['tax_class_id'];
				}
			}
		}
		
		if (!$title) return;
		
		$total_data[] = array(
			'code'			=> $this->name,
			'title'			=> $title . ($version < 150 ? ':' : ''),
			'text'			=> $this->currency->format($cost),
			'value'			=> $cost,
			'sort_order'	=> $this->getSetting('sort_order')
		);
		
		$order_total += $cost;
		
		if ($tax_class_id) {
			if (method_exists($this->tax, 'getRates')) {
				$tax_rates = $this->tax->getRates($cost, $tax_class_id);
				foreach ($tax_rates as $tax_rate) {
					$taxes[$tax_rate['tax_rate_id']] = (isset($taxes[$tax_rate['tax_rate_id']])) ? $taxes[$tax_rate['tax_rate_id']] : 0;
					$taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
				}
			} else {
				$taxes[$tax_class_id] = (isset($taxes[$tax_class_id])) ? $taxes[$tax_class_id] : 0;
				$taxes[$tax_class_id] += $cost * $this->tax->getRate($tax_class_id) / 100;
			}
		}
	}
}
?>