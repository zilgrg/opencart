<?php
class ControllerCatalogMultiTieredDiscount extends Controller {
	private $error = array();
 
	public function index() {
		$this->language->load('catalog/multi_tiered_discount'); 
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('catalog/multi_tiered_discount');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_catalog_multi_tiered_discount->saveDiscount($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('catalog/multi_tiered_discount', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_percent'] = $this->language->get('text_percent');
		$this->data['text_amount'] = $this->language->get('text_amount');
		$this->data['entry_discount_code'] = $this->language->get('entry_discount_code');
		$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$this->data['entry_discount_amount'] = $this->language->get('entry_discount_amount');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_override_special'] = $this->language->get('entry_override_special');
		$this->data['column_discount_code'] = $this->language->get('column_discount_code');
		$this->data['column_discount_amount'] = $this->language->get('column_discount_amount');
		$this->data['column_override_special'] = $this->language->get('column_override_special');
		$this->data['column_customer_group'] = $this->language->get('column_customer_group');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['discount_amount'])) {
			$this->data['error_discount_amount'] = $this->error['discount_amount'];
		} else {
			$this->data['error_discount_amount'] = "";
		}
		
		if (isset($this->error['customer_group'])) {
			$this->data['error_customer_group'] = $this->error['customer_group'];
		} else {
			$this->data['error_customer_group'] = "";
		}
		
		if (isset($this->error['discount_code'])) {
			$this->data['error_discount_code'] = $this->error['discount_code'];
		} else {
			$this->data['error_discount_code'] = "";
		}
		
  		$this->data['breadcrumbs'] = array();
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/multi_tiered_discount', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->load->model('sale/customer_group');
		$this->data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		
		$this->data['discounts'] = array();
		$results = $this->model_catalog_multi_tiered_discount->getDiscounts();
		if ($results) {
			foreach ($results as $result) {
				$customer_group = $this->model_sale_customer_group->getCustomerGroup($result['customer_group_id']);
				if ($result['discount_type'] == "percent") {
					$formated_amount = $result['discount_amount'] . "%";
				} else {
					$formated_amount = $this->currency->format($result['discount_amount']);
				}
				$this->data['discounts'][] = array(
					'multi_tier_id'		=> $result['multi_tier_id'],
					'discount_code'		=> $result['discount_code'],
					'discount_amount'	=> $result['discount_amount'],
					'formated_amount'	=> $formated_amount,
					'discount_type'		=> $result['discount_type'],
					'customer_group'	=> $customer_group['name'],
					'override_special'	=> $result['override_special'],
					'status'			=> $result['status'],
					'delete_href'		=> $this->url->link('catalog/multi_tiered_discount/deleteDiscount', 'token=' . $this->session->data['token'] . '&multi_tier_id=' . $result['multi_tier_id'], 'SSL')
				);
			}
		}
		
		$this->data['action'] = $this->url->link('catalog/multi_tiered_discount', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		$this->template = 'catalog/multi_tiered_discount.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function updateOverrideSpecial() {
		$this->load->model('catalog/multi_tiered_discount');
		$this->model_catalog_multi_tiered_discount->updateOverrideSpecial($this->request->post['multi_tier_id'], $this->request->post['override_special']);
		echo json_encode("");
	}

	public function updateDiscountAmount() {
		$this->load->model('catalog/multi_tiered_discount');
		$result = $this->model_catalog_multi_tiered_discount->updateDiscountAmount($this->request->post['multi_tier_id'], $this->request->post['amount']);
		if ($result == "percent") {
			$json = array(
				'html'	=> $this->currency->format($this->request->post['amount'], 1.000, 1.000, false) . "%",
				'value'	=> $this->currency->format($this->request->post['amount'], 1.000, 1.000, false)
			);
		} else {
			$json = array(
				'html'	=> $this->currency->format($this->request->post['amount']),
				'value'	=> $this->currency->format($this->request->post['amount'], 1.000, 1.000, false)
			);
		}
		echo json_encode($json);
	}

	public function updateDiscountType() {
		$this->load->model('catalog/multi_tiered_discount');
		$result = $this->model_catalog_multi_tiered_discount->updateDiscountType($this->request->post['multi_tier_id'], $this->request->post['type']);
		if ($this->request->post['type'] == "percent") {
			$json = array(
				'html'	=> $this->currency->format($result, 1.000, 1.000, false) . "%"
			);
		} else {
			$json = array(
				'html'	=> $this->currency->format($result)
			);
		}
		echo json_encode($json);
	}

	public function updateStatus() {
		$this->load->model('catalog/multi_tiered_discount');
		$this->model_catalog_multi_tiered_discount->updateStatus($this->request->post['multi_tier_id'], $this->request->post['status']);
		echo json_encode("");
	}

	public function deleteDiscount() {
		$this->load->language('catalog/multi_tiered_discount');
		$this->load->model('catalog/multi_tiered_discount');
		$this->model_catalog_multi_tiered_discount->deleteDiscount($this->request->get['multi_tier_id']);
		$this->session->data['success'] = $this->language->get('text_delete_success');
		$this->redirect($this->url->link('catalog/multi_tiered_discount', 'token=' . $this->session->data['token'], 'SSL'));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'catalog/multi_tiered_discount')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if ($this->request->post['discount_amount'] == "") {
			$this->error['discount_amount'] = $this->language->get('error_discount_amount');
		}
		
		if ($this->request->post['customer_group_id'] == "") {
			$this->error['customer_group'] = $this->language->get('error_customer_group');
		}
		
		if ($this->request->post['discount_code'] == "") {
			$this->error['discount_code'] = $this->language->get('error_discount_code');
		}
		
		if ($this->model_catalog_multi_tiered_discount->verify($this->request->post)) {
			$this->error['warning'] = $this->language->get('error_exists');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}

?>