<?php
//==============================================================================
// Smart Search v156.4
//
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerReportSmartsearch extends Controller {
	private $type = 'report';
	private $name = 'smartsearch';
	
	public function index() {
		$this->data['type'] = $this->type;
		$this->data['name'] = $this->name;
		
		$token = $this->data['token'] = (isset($this->session->data['token'])) ? $this->session->data['token'] : '';
		$version = $this->data['version'] = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		
		$this->data = array_merge($this->data, $this->language->load($this->type . '/' . $this->name));
		$this->load->model($this->type . '/' . $this->name);
		
		$this->{'model_'.$this->type.'_'.$this->name}->createTableIfNotExists();
		if (isset($this->request->get['table']) && $this->request->get['table'] == 'reset') {
			$this->{'model_'.$this->type.'_'.$this->name}->resetTable();
		}
		
		$this->data['filters'] = array(
			'date_start'		=> date('Y-m-d', strtotime('-1 month')),
			'date_end'			=> date('Y-m-d', time()),
			'combine_searches'	=> 0,
			'page'				=> 1
		);
		
		$url = '';
		foreach ($this->data['filters'] as $key => $value) {
			if (isset($this->request->get[$key])) {
				$url .= '&' . $key . '=' . $this->request->get[$key];
				$this->data['filters'][$key] = $this->request->get[$key];
			}
		}
		
		$this->data['results'] = $this->{'model_'.$this->type.'_'.$this->name}->getResults($this->data['filters']);
		$all_results = $this->{'model_'.$this->type.'_'.$this->name}->getResults($this->data['filters'], true);
		
		if (!$this->data['filters']['combine_searches']) {
			$this->load->model('sale/customer');
			foreach ($this->data['results'] as &$result) {
				if (empty($result['customer_id'])) {
					$result['customer_id'] = $this->data['text_guest'];
				} else {
					$customer = $this->model_sale_customer->getCustomer($result['customer_id']);
					$result['customer_id'] = '<a href="' . HTTPS_SERVER . 'index.php?route=sale/customer/update&token=' . $token . '&customer_id=' . $result['customer_id'] . '" title="' . $this->data['text_view_customer'] . '">' . $customer['firstname'] . ' ' . $customer['lastname'] . '</a>';
				}
			}
		}
		
		$pagination = new Pagination();
		$pagination->total = count($all_results);
		$pagination->page = $this->data['filters']['page'];
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->data['text_pagination'];
		$pagination->url = $this->makeURL($this->type . '/' . $this->name, 'token=' . $token . $url . '&page={page}', 'SSL');
		$this->data['pagination'] = $pagination->render();
		
		$breadcrumbs = array();
		$breadcrumbs[] = array(
			'href'		=> $this->makeURL('common/home', 'token=' . $token, 'SSL'),
			'text'		=> $this->data['text_home'],
			'separator' => false
		);
		$breadcrumbs[] = array(
			'href'		=> $this->makeURL($this->type . '/' . $this->name, 'token=' . $token . $url, 'SSL'),
			'text'      => $this->data['heading_title'],
			'separator' => ' :: '
		);
		
		$this->template = $this->type . '/' . $this->name . '.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		if ($version < 150) {
			$this->document->title = $this->data['heading_title'];
			$this->document->breadcrumbs = $breadcrumbs;
			$this->response->setOutput($this->render(true), $this->config->get('config_compression'));
		} else {
			$this->document->setTitle($this->data['heading_title']);
			$this->data['breadcrumbs'] = $breadcrumbs;
			$this->response->setOutput($this->render());
		}
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL') {
		if (!defined('VERSION') || VERSION < 1.5) {
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			$url .= ($args) ? '&' . ltrim($args, '&') : '';
			return $url;
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
	
	public function exportCSV() {
		if ($this->user->hasPermission('access', $this->type . '/' . $this->name)) {
			header('Pragma: public');
			header('Expires: 0');
			header('Content-Description: File Transfer');
			header('Content-Type: application/octet-stream');
			header('Content-Disposition: attachment; filename=' . $this->name . '_history.csv');
			header('Content-Transfer-Encoding: binary');
			
			$data = array(
				'date_start'		=> (!empty($this->request->get['date_start'])) ? $this->request->get['date_start'] : '',
				'date_end'			=> (!empty($this->request->get['date_end'])) ? $this->request->get['date_end'] : '',
				'combine_searches'	=> (!empty($this->request->get['combine_searches'])) ? $this->request->get['combine_searches'] : '',
			);
			
			$this->load->model($this->type . '/' . $this->name);
			$columns = array();
			foreach ($this->{'model_'.$this->type.'_'.$this->name}->getColumns($data) as $column) {
				$columns[] = $column['Field'];
			}
			echo '"' . implode('","', $columns) . '"' . "\n";
			foreach ($this->{'model_'.$this->type.'_'.$this->name}->getResults($data, true) as $result) {
				echo '"' . implode('","', str_replace('"', "''", $result)) . '"' . "\n";
			}
			
			exit();
		}
	}
	
	public function deleteRecord() {
		if ($this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
			if (!$this->request->post['combined']) {
				$this->db->query("DELETE FROM " . DB_PREFIX . $this->name . " WHERE smartsearch_id = " . (int)$this->request->post['key']);
			} else {
				$this->db->query("DELETE FROM " . DB_PREFIX . $this->name . " WHERE search = '" . $this->db->escape($this->request->post['key']) . "'");
			}
		}
	}
}
?>