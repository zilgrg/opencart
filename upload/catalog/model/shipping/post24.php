<?php 
class ModelShippingPost24 extends Model {    
  	public function getQuote($address) {

		$this->load->language('shipping/post24');

		$quote_data = array();

        $query = $this->db->query("SELECT geo_zone_id FROM " . DB_PREFIX . "zone_to_geo_zone WHERE country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0') ORDER BY zone_id DESC");

        foreach ($query->rows as $result) {
            if ($this->config->get('post24_status_'.$result['geo_zone_id']) && ($cabins = $this->config->get('post24_cabins_'.$result['geo_zone_id']))) {
                break;
            } else {
                $result = null;
            }
        }

        if ($result) $cost = $this->config->get('post24_cost_'.$result['geo_zone_id']);


        if ( !empty($result) && $cabins && (string)$cost != '' ) {

            $cabine_select = '</label><select name="post24" id="post24" onchange="document.getElementById(\'post24.post24_'.$result['geo_zone_id'].'\').checked = true;document.getElementById(\'post24.post24_'.$result['geo_zone_id'].'\').value=getElementById(\'post24\').value;">';

            $sub_quote['post24_hack_s'] = array( 'code' => 'post24.post24_hack_s', 'title' => '<!--', 'cost' =>'', 'tax_class_id' => '', 'text' => '');

            foreach ($cabins as $cabin) {   
                $cabine_select .= '<option value="post24.post24_'.$cabin[3].'">'.$cabin[1].':'.$cabin[0].' '.$cabin[2].'</option>'."\n";
                $sub_quote['post24_' .$cabin[3]] = array(                    
                    'code'         => 'post24.post24_' . $cabin[3],
                    'title'        => $this->language->get('text_post24').': '.$cabin[1].':'.$cabin[0].' '.$cabin[2],
                    'cost'         => $cost,
                    'tax_class_id' => $this->config->get('post24_tax_class_id_'.$result['geo_zone_id']),
                    'text'         => $cabin[1].':'.$cabin[0].' '.$cabin[2].' '.$this->currency->format($this->tax->calculate($cost, $this->config->get('post24_tax_class_id_'.$result['geo_zone_id']), $this->config->get('config_tax')))
                );
            }
            $cabine_select .= '</select><label>';

            $sub_quote['post24_hack_f'] = array( 'code' => '', 'title' => ' --> <script type=\'text/javascript\'>document.getElementById(\'post24.post24_hack_s\').parentNode.parentNode.style.display=\'none\';document.getElementById(\'post24.post24_'.$result['geo_zone_id'].'\').value=document.getElementById(\'post24\').value;</script>', 'cost' =>'', 'tax_class_id' => '', 'text' => '');
				
            $quote_data['post24_' . $result['geo_zone_id']] = array(
                    'code'         => 'post24.post24_' . $result['geo_zone_id'],
                    'title'        => $this->language->get('text_post24').': '.$cabine_select,
                    'cost'         => $cost,
                    'tax_class_id' => $this->config->get('post24_tax_class_id_'.$result['geo_zone_id']),
                    'text'         => $this->currency->format($this->tax->calculate($cost, $this->config->get('post24_tax_class_id_'.$result['geo_zone_id']), $this->config->get('config_tax')))
            );
        }

		$method_data = array();
	
		if ($quote_data) {
      		$method_data = array(
        		'code'       => 'post24',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => array_merge($quote_data,$sub_quote),
				'sort_order' => $this->config->get('post24_sort_order'),
        		'error'      => false
      		);
		}

		return $method_data;
  	}
}
?>
