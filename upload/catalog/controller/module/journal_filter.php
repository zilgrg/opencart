<?php
class ControllerModuleJournalFilter extends Controller {

	private function loadLanguageVars($vars = array()) {
		foreach ($vars as $var) {
			$this->data[$var] = $this->language->get($var);
		}
	}

	private function sort(&$data) {
		$sort_order = array();

		foreach ($data as $key => $value) {
      		$sort_order[$key] = $value['sort_order'];
    	}

		array_multisort($sort_order, SORT_ASC, $data);
	}

	protected function index($setting) {
		static $module = 0;

		$this->load->model('journal/filter');
		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		$filters = $this->model_journal_filter->getFilter($setting['filter_id']);

		if (count($filters) == 0) {
			return;
		}

		$filters = unserialize($filters['filters']);

		$this->data['filters'] = array();
		$this->data['products'] = array();
		$this->data['default_filter'] = null;
		$this->data['scrolltop'] = $setting['scrolltop'];

		$lang_id = (int)$this->config->get('config_language_id');

		$this->sort($filters);

		$section_id = 0;

		foreach ($filters as $filter) {
			if (!$filter['status']) continue;

			$lid = isset($filter['filter'][$lang_id]) ? $lang_id : key($filter['filter']);

			$this->data['filters'][] = array(
				'key'	=> "section-{$module}-{$section_id}",
				'name'	=> $filter['filter'][$lid]
			);

			if (isset($filter['default']) && $filter['default']=='on') {
				$this->data['default_filter'] = "section-{$module}-{$section_id}";
			}
			foreach ($filter['products'] as $prod_id) {
				$this->data['products'][$prod_id]['prod_id'] = $prod_id;
				$this->data['products'][$prod_id]['filters'][] = "section-{$module}-{$section_id}";

				$this->data['products'][$prod_id]['custom_filters'] = implode(' ', $this->data['products'][$prod_id]['filters']);
			}
			$section_id++;
		}

		foreach ($this->data['products'] as $key => &$prod) {
			$result = $this->model_catalog_product->getProduct($key);
			$additional_thumb = null;

			foreach ($this->model_catalog_product->getProductImages($key) as $r) {
				$additional_thumb = $this->model_tool_image->resize($r['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				break;
			}

			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
			} else {
				$image = false;
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}

			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
			} else {
				$tax = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = (int)$result['rating'];
			} else {
				$rating = false;
			}

			$prod['details'] = array(
				'product_id'  => $result['product_id'],
				'thumb'       => $image,
				'thumb2'	  => $additional_thumb,
				'name'        => $result['name'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
				'price'       => $price,
				'special'     => $special,
				'tax'         => $tax,
				'rating'      => $result['rating'],
				'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
				'href'        => $this->url->link('product/product', '&product_id=' . $result['product_id'])
			);
		}

		$this->loadLanguageVars(array(
			'button_wishlist',
			'button_compare',
			'button_cart',
			'text_tax'
		));

		$this->document->addScript('catalog/view/javascript/journal/jquery.isotope.min.js');
		$this->document->addScript('catalog/view/javascript/journal/imagesloaded.js');

		$this->data['module'] = $module++;

		$this->template = $this->config->get('config_template') . '/template/module/journal_filter.tpl';

		$this->render();
	}
}
?>