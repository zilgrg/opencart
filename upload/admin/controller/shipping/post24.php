<?php
class ControllerShippingPost24 extends Controller { 
	private $error = array();

	
	public function index() {  

		$this->load->language('shipping/post24');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

        $this->load->model('localisation/geo_zone');
        $geo_zones = $this->model_localisation_geo_zone->getGeoZones();
				 
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->error['warning'] = '';


			$this->model_setting_setting->editSetting('post24', $this->request->post);	
            $this->session->data['success'] = $this->language->get('text_success');

            if ($this->request->post['download']) 
                $this->fetchUpdates();
            else
		        $this->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
		}

        foreach ( 
            array('heading_title','text_none','text_enabled','text_disabled','entry_cost','entry_tax','entry_status','entry_sort_order','entry_import','entry_cabins','button_download','button_save','button_cancel','tab_general') 
                as $word) $this->data[$word] = $this->language->get($word);
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_shipping'),
			'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('shipping/post24', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('shipping/post24', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'); 

        $this->load->model('localisation/zone');
        $this->load->language('localisation/zone');

		foreach ($geo_zones as $geo_zone) {

            foreach (array('status','tax_class_id','cost','import','cabins') as $val) {

                $this->data['post24_'.$val.'_'.$geo_zone['geo_zone_id']] = (
                    isset($this->request->post['post24_'.$val.'_'.$geo_zone['geo_zone_id']]) ?
                        $this->request->post['post24_'.$val.'_'.$geo_zone['geo_zone_id']] :
                        $this->config->get('post24_'.$val.'_'.$geo_zone['geo_zone_id'])
                    );
            }

            # cost
            if ( empty($this->data['post24_cost_'.$geo_zone['geo_zone_id']]) ) { 
                $this->data['post24_cost_'.$geo_zone['geo_zone_id']] = 0; 
            }

		}

		$this->data['geo_zones'] = $geo_zones;

        # Common settings

		if (isset($this->request->post['post24_status'])) {
			$this->data['post24_status'] = $this->request->post['post24_status'];
		} else {
			$this->data['post24_status'] = $this->config->get('post24_status');
		}
		
        if (isset($this->request->post['post24_sort_order'])) {
            $this->data['post24_sort_order'] = $this->request->post['post24_sort_order'];
        } else {
            $this->data['post24_sort_order'] = $this->config->get('post24_sort_order');
        }

		$this->load->model('localisation/tax_class');

		$this->data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();

        $this->data['cabins'] = $this->model_setting_setting->getSetting('post24_cabins');

		$this->template = 'shipping/post24.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}
		
	private function validate() {
		if (!$this->user->hasPermission('modify', 'shipping/post24')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

        # going to fetch updates only
        # if ( !empty($this->request->post['download']) ) return true;

		if (empty($this->error)) {
			return true;
		} else {
			return false;
		}	
	}

    private function fetchUpdates() {

        $data = array();

        foreach ($this->request->post as $key => &$val) { 
            if ( preg_match('/^post24_import_([0-9]+)/',$key,$m) && trim($val) ) {
                $cabins = array();
                $csv = $this->fetchURL($val);
                $rows = str_getcsv($csv, "\n"); //parse the rows, remove first 
                array_shift($rows);
                foreach($rows as $row) $cabins[] = str_getcsv($row, ';'); //parse the items in rows 
                if ($cabins) $data['post24_cabins_'.$m[1]] = $cabins;
            }
        }

        $this->model_setting_setting->editSetting('post24_cabins', $data);
    }

    private function fetchURL($url) {

        $ch = curl_init(trim($url)) or die('cant create curl');
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_VERBOSE, 0);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_TIMEOUT_MS, 3000);

        $out = curl_exec($ch) or die(curl_error($ch));
        curl_close($ch);
        return $out;
    }

}
?>
