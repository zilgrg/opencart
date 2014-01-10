<?php 
class ControllerQuickCheckoutVoucher extends Controller {
	public function index() {
		$this->language->load('quickcheckout/checkout');
		
		$points_total = 0;
		
		foreach ($this->cart->getProducts() as $product) {
			if ($product['points']) {
				$points_total += $product['points'];
			}
		}	
		
      	$this->data['text_use_coupon'] = $this->language->get('text_use_coupon');
		$this->data['text_use_voucher'] = $this->language->get('text_use_voucher');
		$this->data['text_use_reward'] = $this->language->get('text_use_reward');
		$this->data['entry_coupon'] = $this->language->get('entry_coupon');
		$this->data['entry_voucher'] = $this->language->get('entry_voucher');
		$this->data['entry_reward'] = sprintf($this->language->get('entry_reward'), $points_total);
		
		if ($points_total) {
			$this->data['reward'] = true;
		} else {
			$this->data['reward'] = false;
		}
	
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/quickcheckout/voucher.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/quickcheckout/voucher.tpl';
		} else {
			$this->template = 'default/template/quickcheckout/voucher.tpl';
		}
				
		$this->response->setOutput($this->render());		
	}
	
	public function validateCoupon() {
		$this->language->load('quickcheckout/checkout');
		$this->load->model('checkout/coupon');
		
		$json = array();
		
		if (!isset($this->request->post['coupon']) || empty($this->request->post['coupon'])) {
			$this->request->post['coupon'] = '';
			$this->session->data['coupon'] = '';
		}
				
		$coupon_info = $this->model_checkout_coupon->getCoupon($this->request->post['coupon']);			
		
		if (!$coupon_info) {			
			$json['error']['warning'] = $this->language->get('error_coupon');
		}
		
		if (!$json) {
			$this->session->data['coupon'] = $this->request->post['coupon'];
					
			$json['success'] = $this->language->get('text_coupon');
		}
		
		$this->response->setOutput(json_encode($json));		
	}
	
	public function validateVoucher() {
		$this->language->load('quickcheckout/checkout');
		$this->load->model('checkout/voucher');
		
		$json = array();
		
		if (!isset($this->request->post['voucher']) || empty($this->request->post['voucher'])) {
			$this->request->post['voucher'] = '';
			$this->session->data['voucher'] = '';
		}
				
		$voucher_info = $this->model_checkout_voucher->getVoucher($this->request->post['voucher']);			
		
		if (!$voucher_info) {			
			$json['error']['warning'] = $this->language->get('error_voucher');
		}
		
		if (!$json) {
			$this->session->data['voucher'] = $this->request->post['voucher'];
					
			$json['success'] = $this->language->get('text_coupon');
		}
		
		$this->response->setOutput(json_encode($json));			
	}
	
	public function validateReward() {
		$this->language->load('quickcheckout/checkout');
		
		$points = $this->customer->getRewardPoints();
		
		$points_total = 0;
		
		foreach ($this->cart->getProducts() as $product) {
			if ($product['points']) {
				$points_total += $product['points'];
			}
		}	
		
		$json = array();
				
		if (empty($this->request->post['reward'])) {
			$json['error']['warning'] = $this->language->get('error_reward');
		}
	
		if ($this->request->post['reward'] > $points) {
			$json['error']['warning'] = sprintf($this->language->get('error_points'), $this->request->post['reward']);
		}
		
		if ($this->request->post['reward'] > $points_total) {
			$json['error']['warning'] = sprintf($this->language->get('error_maximum'), $points_total);
		}
		
		if (!$json) {
			$this->session->data['reward'] = abs($this->request->post['reward']);
			
			$json['success'] = $this->language->get('text_reward');
		}	
		
		$this->response->setOutput(json_encode($json));	
	}
}
?>