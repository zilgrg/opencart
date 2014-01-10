<?php
class ControllerModuleQuickCheckOut extends Controller {
	private $error = array(); 

	public function index() {  
		$this->language->load('module/quickcheckout');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('quickcheckout', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_technical'] = $this->language->get('tab_technical');
		$this->data['tab_field'] = $this->language->get('tab_field');
		$this->data['tab_module'] = $this->language->get('tab_module');
		$this->data['tab_survey'] = $this->language->get('tab_survey');
		$this->data['tab_delivery'] = $this->language->get('tab_delivery');
		$this->data['tab_countdown'] = $this->language->get('tab_countdown');
		$this->data['tab_support'] = $this->language->get('tab_support');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_radio'] = $this->language->get('text_radio');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_text'] = $this->language->get('text_text');
		$this->data['text_one_column'] = $this->language->get('text_one_column');
		$this->data['text_two_column'] = $this->language->get('text_two_column');
		$this->data['text_three_column'] = $this->language->get('text_three_column');
		$this->data['text_estimate'] = $this->language->get('text_estimate');
		$this->data['text_choose'] = $this->language->get('text_choose');
		$this->data['text_day'] = $this->language->get('text_day');
		$this->data['text_specific'] = $this->language->get('text_specific');
		$this->data['text_purchase'] = $this->language->get('text_purchase');
		$this->data['text_review'] = $this->language->get('text_review');
		$this->data['text_support'] = $this->language->get('text_support');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_load_screen'] = $this->language->get('entry_load_screen');
		$this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
		$this->data['entry_payment_logo'] = $this->language->get('entry_payment_logo');
		$this->data['entry_shipping'] = $this->language->get('entry_shipping');
		$this->data['entry_payment'] = $this->language->get('entry_payment');
		$this->data['entry_highlight_error'] = $this->language->get('entry_highlight_error');
		$this->data['entry_text_error'] = $this->language->get('entry_text_error');
		$this->data['entry_edit_cart'] = $this->language->get('entry_edit_cart');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_auto_submit'] = $this->language->get('entry_auto_submit');
		$this->data['entry_responsive'] = $this->language->get('entry_responsive');
		$this->data['entry_country_reload'] = $this->language->get('entry_country_reload');
		$this->data['entry_payment_reload'] = $this->language->get('entry_payment_reload');
		$this->data['entry_firstname'] = $this->language->get('entry_firstname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_fax'] = $this->language->get('entry_fax');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_address_1'] = $this->language->get('entry_address_1');
		$this->data['entry_address_2'] = $this->language->get('entry_address_2');
		$this->data['entry_city'] = $this->language->get('entry_city');
		$this->data['entry_postcode'] = $this->language->get('entry_postcode');
		$this->data['entry_country'] = $this->language->get('entry_country');
		$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_voucher'] = $this->language->get('entry_voucher');
		$this->data['entry_coupon'] = $this->language->get('entry_coupon');
		$this->data['entry_reward'] = $this->language->get('entry_reward');
		$this->data['entry_cart'] = $this->language->get('entry_cart');
		$this->data['entry_login'] = $this->language->get('entry_login');
		$this->data['entry_html_header'] = $this->language->get('entry_html_header');
		$this->data['entry_html_footer'] = $this->language->get('entry_html_footer');
		$this->data['entry_survey'] = $this->language->get('entry_survey');
		$this->data['entry_survey_required'] = $this->language->get('entry_survey_required');
		$this->data['entry_survey_text'] = $this->language->get('entry_survey_text');
		$this->data['entry_survey_type'] = $this->language->get('entry_survey_type');
		$this->data['entry_survey_answer'] = $this->language->get('entry_survey_answer');
		$this->data['entry_delivery'] = $this->language->get('entry_delivery');
		$this->data['entry_delivery_time'] = $this->language->get('entry_delivery_time');
		$this->data['entry_delivery_required'] = $this->language->get('entry_delivery_required');
		$this->data['entry_delivery_unavailable'] = $this->language->get('entry_delivery_unavailable');
		$this->data['entry_delivery_min'] = $this->language->get('entry_delivery_min');
		$this->data['entry_delivery_max'] = $this->language->get('entry_delivery_max');
		$this->data['entry_delivery_min_hour'] = $this->language->get('entry_delivery_min_hour');
		$this->data['entry_delivery_max_hour'] = $this->language->get('entry_delivery_max_hour');
		$this->data['entry_delivery_times'] = $this->language->get('entry_delivery_times');
		$this->data['entry_countdown'] = $this->language->get('entry_countdown');
		$this->data['entry_countdown_start'] = $this->language->get('entry_countdown_start');
		$this->data['entry_countdown_date_start'] = $this->language->get('entry_countdown_date_start');
		$this->data['entry_countdown_date_end'] = $this->language->get('entry_countdown_date_end');
		$this->data['entry_countdown_time'] = $this->language->get('entry_countdown_time');
		$this->data['entry_countdown_text'] = $this->language->get('entry_countdown_text');
		$this->data['entry_mail_name'] = $this->language->get('entry_mail_name');
		$this->data['entry_mail_order_id'] = $this->language->get('entry_mail_order_id');
		$this->data['entry_mail_message'] = $this->language->get('entry_mail_message');
		$this->data['entry_mail_email'] = $this->language->get('entry_mail_email');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_mail'] = $this->language->get('button_mail');
		$this->data['button_add'] = $this->language->get('button_add');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
		$this->data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (!$this->config->get('quickcheckout_status')) {
			$this->data['text_quick_start'] = sprintf($this->language->get('text_quick_start'), $this->url->link('module/quickcheckout/quick_start', 'token=' . $this->session->data['token'], 'SSL'));
		} else {
			$this->data['text_quick_start'] = '';
		}

  		$this->data['breadcrumbs'] = array();
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false

   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		
		if (isset($this->request->post['quickcheckout_status'])) {
			$this->data['quickcheckout_status'] = $this->request->post['quickcheckout_status'];
		} else {
			$this->data['quickcheckout_status'] = $this->config->get('quickcheckout_status');
		}
		
		if (isset($this->request->post['quickcheckout_load_screen'])) {
			$this->data['quickcheckout_load_screen'] = $this->request->post['quickcheckout_load_screen'];
		} else {
			$this->data['quickcheckout_load_screen'] = $this->config->get('quickcheckout_load_screen');
		}
		
		if (isset($this->request->post['quickcheckout_newsletter'])) {
			$this->data['quickcheckout_newsletter'] = $this->request->post['quickcheckout_newsletter'];
		} else {
			$this->data['quickcheckout_newsletter'] = $this->config->get('quickcheckout_newsletter');
		}
		
		if (isset($this->request->post['quickcheckout_payment_logo'])) {
			$this->data['quickcheckout_payment_logo'] = $this->request->post['quickcheckout_payment_logo'];
		} else {
			$this->data['quickcheckout_payment_logo'] = $this->config->get('quickcheckout_payment_logo');
		}
		
		if (isset($this->request->post['quickcheckout_shipping'])) {
			$this->data['quickcheckout_shipping'] = $this->request->post['quickcheckout_shipping'];
		} else {
			$this->data['quickcheckout_shipping'] = $this->config->get('quickcheckout_shipping');
		}
		
		if (isset($this->request->post['quickcheckout_payment'])) {
			$this->data['quickcheckout_payment'] = $this->request->post['quickcheckout_payment'];
		} else {
			$this->data['quickcheckout_payment'] = $this->config->get('quickcheckout_payment');
		}
		
		if (isset($this->request->post['quickcheckout_highlight_error'])) {
			$this->data['quickcheckout_highlight_error'] = $this->request->post['quickcheckout_highlight_error'];
		} else {
			$this->data['quickcheckout_highlight_error'] = $this->config->get('quickcheckout_highlight_error');
		}
		
		if (isset($this->request->post['quickcheckout_text_error'])) {
			$this->data['quickcheckout_text_error'] = $this->request->post['quickcheckout_text_error'];
		} else {
			$this->data['quickcheckout_text_error'] = $this->config->get('quickcheckout_text_error');
		}
		
		if (isset($this->request->post['quickcheckout_edit_cart'])) {
			$this->data['quickcheckout_edit_cart'] = $this->request->post['quickcheckout_edit_cart'];
		} else {
			$this->data['quickcheckout_edit_cart'] = $this->config->get('quickcheckout_edit_cart');
		}
		
		if (isset($this->request->post['quickcheckout_layout'])) {
			$this->data['quickcheckout_layout'] = $this->request->post['quickcheckout_layout'];
		} elseif ($this->config->get('quickcheckout_layout')) {
			$this->data['quickcheckout_layout'] = $this->config->get('quickcheckout_layout');
		} else {
			$this->data['quickcheckout_layout'] = '2';
		}
		
		if (isset($this->request->post['quickcheckout_auto_submit'])) {
			$this->data['quickcheckout_auto_submit'] = $this->request->post['quickcheckout_auto_submit'];
		} else {
			$this->data['quickcheckout_auto_submit'] = $this->config->get('quickcheckout_auto_submit');
		}
		
		if (isset($this->request->post['quickcheckout_responsive'])) {
			$this->data['quickcheckout_responsive'] = $this->request->post['quickcheckout_responsive'];
		} else {
			$this->data['quickcheckout_responsive'] = $this->config->get('quickcheckout_responsive');
		}
		
		if (isset($this->request->post['quickcheckout_country_reload'])) {
			$this->data['quickcheckout_country_reload'] = $this->request->post['quickcheckout_country_reload'];
		} else {
			$this->data['quickcheckout_country_reload'] = $this->config->get('quickcheckout_country_reload');
		}
		
		if (isset($this->request->post['quickcheckout_payment_reload'])) {
			$this->data['quickcheckout_payment_reload'] = $this->request->post['quickcheckout_payment_reload'];
		} else {
			$this->data['quickcheckout_payment_reload'] = $this->config->get('quickcheckout_payment_reload');
		}
		
		if (isset($this->request->post['quickcheckout_firstname'])) {
			$this->data['quickcheckout_firstname'] = $this->request->post['quickcheckout_firstname'];
		} else {
			$this->data['quickcheckout_firstname'] = $this->config->get('quickcheckout_firstname');
		}
		
		if (isset($this->request->post['quickcheckout_lastname'])) {
			$this->data['quickcheckout_lastname'] = $this->request->post['quickcheckout_lastname'];
		} else {
			$this->data['quickcheckout_lastname'] = $this->config->get('quickcheckout_lastname');
		}
		
		if (isset($this->request->post['quickcheckout_telephone'])) {
			$this->data['quickcheckout_telephone'] = $this->request->post['quickcheckout_telephone'];
		} else {
			$this->data['quickcheckout_telephone'] = $this->config->get('quickcheckout_telephone');
		}
		
		if (isset($this->request->post['quickcheckout_fax'])) {
			$this->data['quickcheckout_fax'] = $this->request->post['quickcheckout_fax'];
		} else {
			$this->data['quickcheckout_fax'] = $this->config->get('quickcheckout_fax');
		}
		
		if (isset($this->request->post['quickcheckout_company'])) {
			$this->data['quickcheckout_company'] = $this->request->post['quickcheckout_company'];
		} else {
			$this->data['quickcheckout_company'] = $this->config->get('quickcheckout_company');
		}
		
		if (isset($this->request->post['quickcheckout_address_1'])) {
			$this->data['quickcheckout_address_1'] = $this->request->post['quickcheckout_address_1'];
		} else {
			$this->data['quickcheckout_address_1'] = $this->config->get('quickcheckout_address_1');
		}
		
		if (isset($this->request->post['quickcheckout_address_2'])) {
			$this->data['quickcheckout_address_2'] = $this->request->post['quickcheckout_address_2'];
		} else {
			$this->data['quickcheckout_address_2'] = $this->config->get('quickcheckout_address_2');
		}
		
		if (isset($this->request->post['quickcheckout_city'])) {
			$this->data['quickcheckout_city'] = $this->request->post['quickcheckout_city'];
		} else {
			$this->data['quickcheckout_city'] = $this->config->get('quickcheckout_city');
		}
		
		if (isset($this->request->post['quickcheckout_postcode'])) {
			$this->data['quickcheckout_postcode'] = $this->request->post['quickcheckout_postcode'];
		} else {
			$this->data['quickcheckout_postcode'] = $this->config->get('quickcheckout_postcode');
		}
		
		if (isset($this->request->post['quickcheckout_country'])) {
			$this->data['quickcheckout_country'] = $this->request->post['quickcheckout_country'];
		} else {
			$this->data['quickcheckout_country'] = $this->config->get('quickcheckout_country');
		}
		
		if (isset($this->request->post['quickcheckout_zone'])) {
			$this->data['quickcheckout_zone'] = $this->request->post['quickcheckout_zone'];
		} else {
			$this->data['quickcheckout_zone'] = $this->config->get('quickcheckout_zone');
		}
		
		if (isset($this->request->post['quickcheckout_coupon'])) {
			$this->data['quickcheckout_coupon'] = $this->request->post['quickcheckout_coupon'];
		} else {
			$this->data['quickcheckout_coupon'] = $this->config->get('quickcheckout_coupon');
		}
		
		if (isset($this->request->post['quickcheckout_voucher'])) {
			$this->data['quickcheckout_voucher'] = $this->request->post['quickcheckout_voucher'];
		} else {
			$this->data['quickcheckout_voucher'] = $this->config->get('quickcheckout_voucher');
		}
		
		if (isset($this->request->post['quickcheckout_reward'])) {
			$this->data['quickcheckout_reward'] = $this->request->post['quickcheckout_reward'];
		} else {
			$this->data['quickcheckout_reward'] = $this->config->get('quickcheckout_reward');
		}
		
		if (isset($this->request->post['quickcheckout_cart'])) {
			$this->data['quickcheckout_cart'] = $this->request->post['quickcheckout_cart'];
		} else {
			$this->data['quickcheckout_cart'] = $this->config->get('quickcheckout_cart');
		}
		
		if (isset($this->request->post['quickcheckout_login'])) {
			$this->data['quickcheckout_login'] = $this->request->post['quickcheckout_login'];
		} else {
			$this->data['quickcheckout_login'] = $this->config->get('quickcheckout_login');
		}
		
		if (isset($this->request->post['quickcheckout_html_header'])) {
			$this->data['quickcheckout_html_header'] = $this->request->post['quickcheckout_html_header'];
		} elseif ($this->config->get('quickcheckout_html_header')) {
			$this->data['quickcheckout_html_header'] = $this->config->get('quickcheckout_html_header');
		} else {
			$this->data['quickcheckout_html_header'] = array();
		}
		
		if (isset($this->request->post['quickcheckout_html_footer'])) {
			$this->data['quickcheckout_html_footer'] = $this->request->post['quickcheckout_html_footer'];
		} elseif ($this->config->get('quickcheckout_html_footer')) {
			$this->data['quickcheckout_html_footer'] = $this->config->get('quickcheckout_html_footer');
		} else {
			$this->data['quickcheckout_html_footer'] = array();
		}
		
		if (isset($this->request->post['quickcheckout_survey'])) {
			$this->data['quickcheckout_survey'] = $this->request->post['quickcheckout_survey'];
		} else {
			$this->data['quickcheckout_survey'] = $this->config->get('quickcheckout_survey');
		}
		
		if (isset($this->request->post['quickcheckout_survey_required'])) {
			$this->data['quickcheckout_survey_required'] = $this->request->post['quickcheckout_survey_required'];
		} else {
			$this->data['quickcheckout_survey_required'] = $this->config->get('quickcheckout_survey_required');
		}
		
		if (isset($this->request->post['quickcheckout_survey_text'])) {
			$this->data['quickcheckout_survey_text'] = $this->request->post['quickcheckout_survey_text'];
		} elseif ($this->config->get('quickcheckout_survey_text')) {
			$this->data['quickcheckout_survey_text'] = $this->config->get('quickcheckout_survey_text');
		} else {
			$this->data['quickcheckout_survey_text'] = array();
		}
		
		if (isset($this->request->post['quickcheckout_survey_type'])) {
			$this->data['quickcheckout_survey_type'] = $this->request->post['quickcheckout_survey_type'];
		} else {
			$this->data['quickcheckout_survey_type'] = $this->config->get('quickcheckout_survey_type');
		}
		
		if (isset($this->request->post['quickcheckout_survey_answers'])) {
			$this->data['quickcheckout_survey_answers'] = $this->request->post['quickcheckout_survey_answers'];
		} elseif ($this->config->get('quickcheckout_survey_answers')) {
			$this->data['quickcheckout_survey_answers'] = $this->config->get('quickcheckout_survey_answers');
		} else {
			$this->data['quickcheckout_survey_answers'] = array();
		}
		
		if (isset($this->request->post['quickcheckout_delivery'])) {
			$this->data['quickcheckout_delivery'] = $this->request->post['quickcheckout_delivery'];
		} else {
			$this->data['quickcheckout_delivery'] = $this->config->get('quickcheckout_delivery');
		}
		
		if (isset($this->request->post['quickcheckout_delivery_time'])) {
			$this->data['quickcheckout_delivery_time'] = $this->request->post['quickcheckout_delivery_time'];
		} else {
			$this->data['quickcheckout_delivery_time'] = $this->config->get('quickcheckout_delivery_time');
		}
		
		if (isset($this->request->post['quickcheckout_delivery_required'])) {
			$this->data['quickcheckout_delivery_required'] = $this->request->post['quickcheckout_delivery_required'];
		} else {
			$this->data['quickcheckout_delivery_required'] = $this->config->get('quickcheckout_delivery_required');
		}
		
		if (isset($this->request->post['quickcheckout_delivery_unavailable'])) {
			$this->data['quickcheckout_delivery_unavailable'] = $this->request->post['quickcheckout_delivery_unavailable'];
		} elseif ($this->config->get('quickcheckout_delivery_unavailable')) {
			$this->data['quickcheckout_delivery_unavailable'] = $this->config->get('quickcheckout_delivery_unavailable');
		} else {
			$this->data['quickcheckout_delivery_unavailable'] = '"6-3-2013", "7-3-2013", "8-3-2013"';
		}
		
		if (isset($this->request->post['quickcheckout_delivery_min'])) {
			$this->data['quickcheckout_delivery_min'] = $this->request->post['quickcheckout_delivery_min'];
		} elseif ($this->config->get('quickcheckout_delivery_min')) {
			$this->data['quickcheckout_delivery_min'] = (int)$this->config->get('quickcheckout_delivery_min');
		} else {
			$this->data['quickcheckout_delivery_min'] = 1;
		}
		
		if (isset($this->request->post['quickcheckout_delivery_max'])) {
			$this->data['quickcheckout_delivery_max'] = $this->request->post['quickcheckout_delivery_max'];
		} elseif ($this->config->get('quickcheckout_delivery_max')) {
			$this->data['quickcheckout_delivery_max'] = (int)$this->config->get('quickcheckout_delivery_max');
		} else {
			$this->data['quickcheckout_delivery_max'] = 30;
		}
		
		if (isset($this->request->post['quickcheckout_delivery_min_hour'])) {
			$this->data['quickcheckout_delivery_min_hour'] = $this->request->post['quickcheckout_delivery_min_hour'];
		} elseif ($this->config->get('quickcheckout_delivery_min_hour')) {
			$this->data['quickcheckout_delivery_min_hour'] = $this->config->get('quickcheckout_delivery_min_hour');
		} else {
			$this->data['quickcheckout_delivery_min_hour'] = 9;
		}
		
		if (isset($this->request->post['quickcheckout_delivery_max_hour'])) {
			$this->data['quickcheckout_delivery_max_hour'] = $this->request->post['quickcheckout_delivery_max_hour'];
		} elseif ($this->config->get('quickcheckout_delivery_max_hour')) {
			$this->data['quickcheckout_delivery_max_hour'] = $this->config->get('quickcheckout_delivery_max_hour');
		} else {
			$this->data['quickcheckout_delivery_max_hour'] = 17;
		}
		
		if (isset($this->request->post['quickcheckout_delivery_times'])) {
			$this->data['quickcheckout_delivery_times'] = $this->request->post['quickcheckout_delivery_times'];
		} elseif ($this->config->get('quickcheckout_delivery_times')) {
			$this->data['quickcheckout_delivery_times'] = $this->config->get('quickcheckout_delivery_times');
		} else {
			$this->data['quickcheckout_delivery_times'] = array();
		}
		
		if (isset($this->request->post['quickcheckout_countdown'])) {
			$this->data['quickcheckout_countdown'] = $this->request->post['quickcheckout_countdown'];
		} else {
			$this->data['quickcheckout_countdown'] = $this->config->get('quickcheckout_countdown');
		}
		
		if (isset($this->request->post['quickcheckout_countdown_start'])) {
			$this->data['quickcheckout_countdown_start'] = $this->request->post['quickcheckout_countdown_start'];
		} else {
			$this->data['quickcheckout_countdown_start'] = $this->config->get('quickcheckout_countdown_start');
		}
		
		if (isset($this->request->post['quickcheckout_countdown_date_start'])) {
			$this->data['quickcheckout_countdown_date_start'] = $this->request->post['quickcheckout_countdown_date_start'];
		} else {
			$this->data['quickcheckout_countdown_date_start'] = $this->config->get('quickcheckout_countdown_date_start');
		}
		
		if (isset($this->request->post['quickcheckout_countdown_date_end'])) {
			$this->data['quickcheckout_countdown_date_end'] = $this->request->post['quickcheckout_countdown_date_end'];
		} else {
			$this->data['quickcheckout_countdown_date_end'] = $this->config->get('quickcheckout_countdown_date_end');
		}
		
		if (isset($this->request->post['quickcheckout_countdown_time'])) {
			$this->data['quickcheckout_countdown_time'] = $this->request->post['quickcheckout_countdown_time'];
		} else {
			$this->data['quickcheckout_countdown_time'] = $this->config->get('quickcheckout_countdown_time');
		}
		
		if (isset($this->request->post['quickcheckout_countdown_text'])) {
			$this->data['quickcheckout_countdown_text'] = $this->request->post['quickcheckout_countdown_text'];
		} else {
			$this->data['quickcheckout_countdown_text'] = $this->config->get('quickcheckout_countdown_text');
		}
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['action'] = $this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'module/quickcheckout.tpl';

		$this->children = array(
			'common/header',
			'common/footer',
		);	
		
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/quickcheckout')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	public function mail() {
		$this->language->load('module/quickcheckout');
		
		$json = array();
		
		if ($this->validate()) {
			if (strlen($this->request->post['mail_name']) < 5 || strlen($this->request->post['mail_name']) > 32) {
				$json['error']['name'] = $this->language->get('mail_error_name');
			}
			
			if ((strlen($this->request->post['mail_email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['mail_email'])) {
				$json['error']['email'] = $this->language->get('mail_error_email');
			}
			
			if (strlen($this->request->post['mail_order_id']) < 3 || (int)$this->request->post['mail_order_id'] == 0) {
				$json['error']['order_id'] = $this->language->get('mail_error_order_id');
			}
			
			if (strlen($this->request->post['mail_message']) < 20 || strlen($this->request->post['mail_message']) > 2400) {
				$json['error']['message'] = $this->language->get('mail_error_message');
			}
		
			if (!$json) {
				$subject = '[Quick Checkout] Support ' . $this->request->post['mail_name'];
				
				$message = 'Order ID: ' . $this->request->post['mail_order_id'] . "\n\n";
				$message .= $this->request->post['mail_message'];
				
				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');				
				$mail->setTo('support@marketinsg.com');
				$mail->setFrom($this->request->post['mail_email']);
				$mail->setSender($this->request->post['mail_name']);
				$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
				
				$json['success'] = $this->language->get('mail_success');
			}
		} else {
			$json['error']['warning'] = $this->error['warning'];
		}
		
		$this->response->setOutput(json_encode($json));	
	}
	
	private function getlayoutid(){
		$this->load->model('design/layout');
		
		$layouts = $this->model_design_layout->getLayouts();
		
		foreach($layouts as $layout){
			if($layout['name']=='Quick Checkout'){
				return $layout['layout_id'];
			}
		}
		
		return false;
	}
	
	public function install(){
		$layout_id = $this->getlayoutid();
		
		if(!$layout_id){
			$layout_data = array();
			$layout_data['name'] = 'Quick Checkout';
			$layout_data['layout_route'][1] = array(
				'store_id'	=> '0',
				'route'		=> 'quickcheckout/'
			);
			
			$this->load->model('design/layout');
			
			$this->model_design_layout->addLayout($layout_data);
		}
	}
	
	public function uninstall(){		
		$layout_id = $this->getlayoutid();
		
		if ($layout_id){
			$this->load->model('design/layout');
			
			$this->model_design_layout->deleteLayout($layout_id);
		}
	}
	
	public function quick_start() {
		$this->language->load('module/quickcheckout');
		
		$this->load->model('setting/setting');
		
		$data = array(
			'quickcheckout_status'				=> '1',
			'quickcheckout_load_screen'			=> '1',
			'quickcheckout_newsletter'			=> '1',
			'quickcheckout_payment_logo'		=> '1',
			'quickcheckout_shipping'			=> '1',
			'quickcheckout_payment'				=> '1',
			'quickcheckout_highlight_error'		=> '1',
			'quickcheckout_text_error'			=> '1',
			'quickcheckout_edit_cart'			=> '1',
			'quickcheckout_layout'				=> '2',
			'quickcheckout_auto_submit'			=> '0',
			'quickcheckout_responsive'			=> '0',
			'quickcheckout_country_reload'		=> '0',
			'quickcheckout_payment_reload'		=> '0',
			'quickcheckout_telephone'			=> '1',
			'quickcheckout_fax'					=> '0',
			'quickcheckout_firstname'			=> '1',
			'quickcheckout_lastname'			=> '1',
			'quickcheckout_company'				=> '0',
			'quickcheckout_address_1'			=> '1',
			'quickcheckout_address_2'			=> '0',
			'quickcheckout_city'				=> '1',
			'quickcheckout_postcode'			=> '1',
			'quickcheckout_country'				=> '1',
			'quickcheckout_zone'				=> '1',
			'quickcheckout_coupon'				=> '1',
			'quickcheckout_voucher'				=> '1',
			'quickcheckout_reward'				=> '1',
			'quickcheckout_cart'				=> '1',
			'quickcheckout_login'				=> '1',
			'quickcheckout_html_header'			=> array(),
			'quickcheckout_html_footer'			=> array(),
			'quickcheckout_survey'				=> '0',
			'quickcheckout_survey_required'		=> '0',
			'quickcheckout_survey_text'			=> array(),
			'quickcheckout_delivery'			=> '0',
			'quickcheckout_delivery_time'		=> '0',
			'quickcheckout_delivery_required'	=> '0',
			'quickcheckout_delivery_unavailable'=> '"6-3-2013", "7-3-2013", "8-3-2013"',
			'quickcheckout_delivery_min'		=> '1',
			'quickcheckout_delivery_max'		=> '30',
			'quickcheckout_delivery_min_hour'	=> '9',
			'quickcheckout_delivery_max_hour'	=> '17'
		);
		
		$this->model_setting_setting->editSetting('quickcheckout', $data);
		
		$this->session->data['success'] = $this->language->get('text_success');
		
		$this->redirect($this->url->link('module/quickcheckout', 'token=' . $this->session->data['token'], 'SSL'));
	}
}

?>