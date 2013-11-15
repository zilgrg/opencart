<?php
class ControllerModuleJournalProductSlider extends Controller {

	private function loadLanguageVars($vars = array()) {
		foreach ($vars as $var) {
			$this->data[$var] = $this->language->get($var);
		}
	}

	protected function index($setting) {
		static $module = 0;

		$this->load->model('journal/product_slider');
		$this->load->model('tool/image');
		$this->load->model('catalog/product');



		$lang_id = (int)$this->config->get('config_language_id');

		$this->data['products'] = array();

		if (isset($setting['banner_id'])) {
			$results = $this->model_journal_product_slider->getBanner($setting['banner_id']);

			if (!isset($results['options']) || !isset($results['products'])) {
				return;
			}

			$options = unserialize($results['options']);
			$products = unserialize($results['products']);

			// echo "<pre>" . print_r($options, TRUE) . "</pre>";
			// echo "<pre>" . print_r($products, TRUE) . "</pre>";

			foreach ($products as $product) {
				$result = $this->model_catalog_product->getProduct($product);

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

				$this->data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
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

			$this->data['options'] = array(
				'header'			=> isset($options['header'][$lang_id]) ? $options['header'][$lang_id] : '',
				'auto'				=> $options['autoAdvance'] === 'y',
				'speed'				=> (int)$options['time'],
				'mode'				=> $options['fx'],
				'pause'				=> (int)$options['transPeriod'],
				'autoHover'			=> true,
				'pager'				=> $options['pagination'] === 'y',
				'randomStart'		=> true,
				//
				//
				// 'autoAdvance'		=> $options['autoAdvance'] === 'y',
				// 'mobileAutoAdvance'	=> $options['autoAdvance'] === 'y',
				// 'navigation'		=> $options['navigation'] === 'y' || $options['navigation'] === 'h',
				// 'pagination'		=> $options['pagination'] === 'y',
				// 'hover'				=> $options['hover'] === 'y',
				// 'loader'			=> isset($options['bar']) && $options['bar'] === 'y' ? 'bar' : 'none'
			);

			// echo "<pre>" . print_r($this->data['options'], TRUE) . "</pre>"; die();

			$this->loadLanguageVars(array(
				'button_wishlist',
				'button_compare',
				'button_cart',
				'text_tax'
			));

			$this->document->addScript('catalog/view/javascript/journal/bxslider/jquery.bxslider.min.js');
			// $this->document->addStyle('catalog/view/javascript/journal/bxslider/jquery.bxslider.css');

			$this->template = $this->config->get('config_template') . '/template/module/journal_product_slider.tpl';

		}

		$this->data['module'] = $module++;

		$this->render();

	}
}
?>