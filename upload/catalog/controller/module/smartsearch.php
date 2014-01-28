<?php
//==============================================================================
// Smart Search v156.5
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

class ControllerModuleSmartsearch extends Controller {
	private $type = 'module';
	private $name = 'smartsearch';
	
	public function smartsearch() {
		$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
		$settings = ($version < 151) ? unserialize($this->config->get($this->name . '_data')) : $this->config->get($this->name . '_data');
		$this->data = array_merge($this->data, $this->language->load('product/search'));
		
		$data = array(
			'filter_name'			=> $this->request->get['search'],
			'filter_tag'			=> $this->request->get['search'],
			'filter_description'	=> '',
			'filter_category_id'	=> 0,
			'filter_sub_category'	=> '',
			'sort'					=> 'p.sort_order',
			'order'					=> 'ASC',
			'start'					=> 0,
			'limit'					=> $settings['ajax_limit'],
			'ajax'					=> true
		);
		
		$this->load->model('catalog/smartsearch');
		$smartsearch_results = $this->model_catalog_smartsearch->smartsearch($data);
		$results = $this->model_catalog_smartsearch->getProducts($smartsearch_results, $data);
		
		$this->load->model('catalog/product');
		$this->load->model('catalog/review');
		$this->load->model('tool/image');
		
		$products = array();
		
		foreach ($results as $result) {
			if (empty($result)) continue;
			
			if ($version < 150) {
				$result['special'] = $this->model_catalog_product->getProductSpecial($result['product_id']);
				$result['rating'] = $this->model_catalog_review->getAverageRating($result['product_id']);
				$result['reviews'] = $this->model_catalog_review->getTotalReviewsByProductId($result['product_id']);
			}
			
			$image = $this->model_tool_image->resize(($result['image']) ? $result['image'] : 'no_image.jpg', (int)$settings['ajax_image_width'], (int)$settings['ajax_image_height']);
			$options = $this->model_catalog_product->getProductOptions($result['product_id']);
			$rating = ($this->config->get('config_review' . ($version < 150 ? '' : '_status'))) ? (int)$result['rating'] : false;
			
			$result['add']			= $this->makeURL(($options ? 'product/product' : 'checkout/cart'), 'product_id=' . $result['product_id']);
			$result['description']	= implode('', array_slice(preg_split("//u", strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), -1, PREG_SPLIT_NO_EMPTY), 0, (int)$settings['ajax_description'])) . '...';
			$result['href']			= $this->makeURL('product/product', 'product_id=' . $result['product_id']);
			$result['image']		= $image;
			$result['options']		= $options;
			$result['price']		= (!$this->config->get('config_customer_price') || $this->customer->isLogged()) ? $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;
			$result['rating']		= $rating;
			$result['reviews']		= ($version > 149) ? sprintf($this->data['text_reviews'], (int)$result['reviews']) : '';
			$result['special']		= ((float)$result['special']) ? $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax'))) : false;
			$result['stars']		= ($version < 150) ? sprintf($this->data['text_stars'], $rating) : '';
			$result['tax']			= ($this->config->get('config_tax')) ? $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']) : false;
			$result['thumb']		= $image;
			
			$products[] = $result;
		}
		
		$this->response->setOutput(json_encode($products));
	}
	
	private function makeURL($route, $args = '', $connection = 'NONSSL') {
		if (!defined('VERSION') || VERSION < 1.5) {
			$this->load->model('tool/seo_url');
			$url = ($connection == 'NONSSL') ? HTTP_SERVER : HTTPS_SERVER;
			$url .= 'index.php?route=' . $route;
			$url .= ($args) ? '&' . ltrim($args, '&') : '';
			return $this->model_tool_seo_url->rewrite($url);
		} else {
			return $this->url->link($route, $args, $connection);
		}
	}
}
?>