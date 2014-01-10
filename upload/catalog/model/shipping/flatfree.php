<?php
class ModelShippingFlatFree extends Model {
	function getQuote($address) {
		$this->language->load('shipping/flatfree');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('flatfree_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
	
		if (!$this->config->get('flatfree_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}

		$method_data = array();
	
		if ($status) {
			$quote_data = array();
			if ($this->cart->getSubTotal() < $this->config->get('flatfree_total')) {
				$quote_data['flatfree'] = array(
					'code'         => 'flatfree.flatfree',
					'title'        => $this->language->get('text_flat_description'),
					'cost'         => $this->config->get('flatfree_cost'),
					'tax_class_id' => $this->config->get('flatfree_tax_class_id'),
					'text'         => $this->currency->format($this->tax->calculate($this->config->get('flatfree_cost'), $this->config->get('flatfree_tax_class_id'), $this->config->get('config_tax')))
				);
			}
			else
			{
				$quote_data['flatfree'] = array(
					'code'         => 'flatfree.flatfree',
					'title'        => $this->language->get('text_description'),
					'cost'         => 0.00,
					'tax_class_id' => 0,
					'text'         => $this->currency->format(0.00)
				);
			}
      		$method_data = array(
        		'code'       => 'flatfree',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('flatfree_sort_order'),
        		'error'      => false
      		);
			
		}
	
		return $method_data;
	}
}
?>