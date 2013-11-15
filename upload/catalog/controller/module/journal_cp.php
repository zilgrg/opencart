<?php
class ControllerModuleJournalCp extends Controller {

	const ICON_WIDTH = 50;
	const ICON_HEIGHT = 50;

	private function extend_css($css, $preety_print = true) {
		$this->document->journal_css = '';
		foreach ($css as $selector) {
			$this->document->journal_css .= "{$selector['selector']} {" . ($preety_print ? "\n" : "");
			foreach ($selector['rules'] as $rule) {
				$rule = str_replace('url()', 'none', $rule);
				$this->document->journal_css .= ($preety_print ? "\t" : "") . $rule . ($preety_print ? "\n" : "");
			}
			$this->document->journal_css .= "} " . ($preety_print ? "\n" : "");
		}
	}

	private function extend_vars($vars) {
		foreach ($vars as $key => $value) {
			$this->document->{$key} = $value;
		}
	}

	private function extend_payment_images() {
		if (!isset($this->document->journal_payment_images)) return;

		$images = json_decode($this->document->journal_payment_images, true);

		if (!is_array($images)) {
			unset($this->document->journal_payment_images);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($images as $k => $v) {
			if (!$v['img'] || !file_exists(DIR_IMAGE . $v['img'])) continue;

			$data[] = array(
				'img'			=> 'image/' . $v['img'],
				'href'			=> $v['link'],
				'new_window'	=> $v['new_window'],
				'name'			=> isset($v['name'][$lang_id]) ? $v['name'][$lang_id] : 'Not trans',
				'sort_order'	=> $v['sort_order']
			);
		}

		$this->sort($data);

		$this->document->journal_payment_images = $data;
	}

	private function extend_social_icons() {
		if (!isset($this->document->journal_social_icons)) return;

		$images = json_decode($this->document->journal_social_icons, true);

		if (!is_array($images)) {
			unset($this->document->journal_social_icons);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($images as $k => $v) {
			if (!$v['img'] || !file_exists(DIR_IMAGE . $v['img'])) continue;

			$data[] = array(
				'img'			=> 'image/' . $v['img'],
				'href'			=> $v['link'],
				'new_window'	=> $v['new_window'],
				'name'			=> isset($v['name'][$lang_id]) ? $v['name'][$lang_id] : 'Not trans',
				'sort_order'	=> $v['sort_order']
			);
		}

		$this->sort($data);

		$this->document->journal_social_icons = $data;
	}

	private function extend_contact_methods() {

		if (!isset($this->document->journal_contact_methods)) return;

		$contact_methods = json_decode($this->document->journal_contact_methods, true);

		if (!is_array($contact_methods)) {
			unset($this->document->journal_contact_methods);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($contact_methods as $k => $v) {
			$href = '';

			if (strlen($v['link'])) {
				if (strpos($v['link'], 'http') === 0 || strpos($v['link'], 'mailto') === 0 || strpos($v['link'], 'ymsgr') === 0 || strpos($v['link'], 'skype') === 0) {
					$href = $v['link'];
				} else {
					$href = $this->url->link($v['link']);
				}
			}

			$data[] = array(
				'img'			=> $this->model_tool_image->resize($v['img'], 20, 20),
				'href'			=> $href,
				'new_window'	=> $v['new_window'],
				'name'			=> isset($v['name'][$lang_id]) ? $v['name'][$lang_id] : 'Not trans',
				'sort_order'	=> $v['sort_order']
			);
		}

		$this->sort($data);

		$this->document->journal_contact_methods = $data;
	}

	private function extend_top_menu() {
		if (!isset($this->document->journal_top_menu)) return;

		$top_menu = json_decode($this->document->journal_top_menu, true);

		if (!is_array($top_menu)) {
			unset($this->document->journal_top_menu);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($top_menu as $k => $v) {
			$href = $v['link'];

			if (strlen($href) > 0 && strpos($href, 'http') !== 0) {
				$href = $this->url->link($v['link']);
			}

			$data[] = array(
				'img'			=> $this->model_tool_image->resize($v['img'], 20, 20),
				'href'			=> $href,
				'new_window'	=> $v['new_window'],
				'name'			=> isset($v['name'][$lang_id]) ? $v['name'][$lang_id] : 'Not trans',
				'sort_order'	=> $v['sort_order']
			);
		}

		$this->sort($data);

		$this->document->journal_top_menu = $data;
	}

	private function get_categs($categ_id) {
		$result = array();
		$categs = $this->model_catalog_category->getCategories($categ_id);
		foreach ($categs as $categ) {
			$result[] = array(
				'href'			=> $this->rewrite($this->url->link('product/category', 'path=' . $categ['category_id'])),
				'new_window'	=> 0,
				'name'			=> $categ['name'],
				'sort_order'	=> $categ['sort_order'],
				'status'		=> $categ['status'],
				'subcategs'		=> $this->get_categs($categ['category_id'])
			);
		}
		return $result;
	}

	private function extend_categories_menu() {
		if (!isset($this->document->journal_categories_menu)) return;

		$categories_menu = json_decode($this->document->journal_categories_menu, true);

		if (!is_array($categories_menu)) {
			unset($this->document->journal_categories_menu);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($categories_menu as $k => $v) {
			$href = $v['link'];

			if (strlen($href) > 0 && strpos($href, 'http') !== 0) {
				$href = $this->url->link($v['link']);
			}

			$data_subcategs = array();

			if (isset($v['subcategs'])) {
				foreach ($v['subcategs'] as $sk => $sv) {
					$shref = $sv['link'];

					if (strlen($shref) > 0 && strpos($shref, 'http') !== 0) {
						$shref = $this->url->link($sv['link']);
					}


					$data_subcategs[] = array(
						'href'			=> $shref,
						'new_window'	=> $sv['new_window'],
						'name'			=> isset($sv['name'][$lang_id]) ? $sv['name'][$lang_id] : 'Not trans',
						'sort_order'	=> $sv['sort_order']
					);
				}

				$this->sort($data_subcategs);
			}

			$data[] = array(
				'href'			=> $href,
				'new_window'	=> $v['new_window'],
				'name'			=> isset($v['name'][$lang_id]) ? $v['name'][$lang_id] : 'Not trans',
				'sort_order'	=> $v['sort_order'],
				'subcategs'		=> $data_subcategs
			);
		}

		$this->sort($data);

		$this->document->journal_categories_menu = $data;
	}

	private function getCategoryName($categ_id) {
		$categ = $this->model_catalog_category->getCategory($categ_id);
		return isset($categ['name']) ? $categ['name'] : 'Category Not Found';
	}

	private function extend_categories_menu_extended() {
		if (!isset($this->document->journal_categories_menu_extended)) return;

		$categories_menu = json_decode($this->document->journal_categories_menu_extended, true);

		// echo "<pre>" . print_r($categories_menu, TRUE) . "</pre>"; die();

		if (!is_array($categories_menu)) {
			unset($this->document->journal_categories_menu_extended);
			return;
		}

		$data = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($categories_menu as $k => $v) {

			$href = $v['link'];

			if (strlen($href) > 0 && strpos($href, 'http') !== 0) {
				$href = $this->url->link($v['link']);
			}	elseif (isset($v['id']) && $v['id']){
				$href = $this->url->link('product/category', 'path=' . $v['id']);
			}

			$data_subcategs = array();

			if (isset($v['subcategs'])) {
				foreach ($v['subcategs'] as $sk => $sv) {
					$shref = $sv['link'];

					if (strlen($shref) > 0 && strpos($shref, 'http') !== 0) {
						$shref = $this->url->link($sv['link']);
					} elseif (isset($sv['id']) && $sv['id']){
						$shref = $this->url->link('product/category', 'path=' . $sv['id']);
					}

					$data_subcategs[] = array(
						'href'			=> $this->rewrite($shref),
						'new_window'	=> $sv['new_window'],
						'name'			=> $sv['id'] ? $this->getCategoryName($sv['id']) : $sv['name'][$lang_id],
						'sort_order'	=> $sv['sort_order'],
						'subcategs'		=> isset($sv['id']) && $sv['id'] ? $this->get_categs($sv['id']) : array()
					);
				}

				$this->sort($data_subcategs);
			}

			if (isset($v['id']) && $v['id']) {
				foreach ($this->get_categs($v['id']) as $xk => $xv ) {
					$data_subcategs[] = $xv;
				}
			}



			$data[] = array(
				'href'			=> $this->rewrite($href),
				'new_window'	=> $v['new_window'],
				'name'			=> $v['id'] ? $this->getCategoryName($v['id']) : $v['name'][$lang_id],
				'sort_order'	=> $v['sort_order'],
				'subcategs'		=> $data_subcategs
			);
		}

		$this->sort($data);

		$this->document->journal_categories_menu_extended = $data;
		// echo "<pre>" . print_r($data, TRUE) . "</pre>"; die();
	}

	private static function sort_blocks($a, $b) {
		return $b['offset_top'] - $a['offset_top'];
	}

	private function extend_custom_blocks() {
		$this->document->journal_custom_blocks_count = '';
		if (!isset($this->document->journal_custom_blocks)) return;

		$custom_blocks = json_decode($this->document->journal_custom_blocks, true);

		if (!is_array($custom_blocks)) {
			$custom_blocks = array();
		}

		usort($custom_blocks, array("ControllerModuleJournalCp", "sort_blocks"));

		$data = array();
		$data['left'] = array();
		$data['right'] = array();

		$lang_id = (int)$this->config->get('config_language_id');

		foreach ($custom_blocks as $custom_block) {
			$text = isset($custom_block['language'][$lang_id]) ? $custom_block['language'][$lang_id] : '';
			$alignment = $custom_block['alignment'] ? 'left' : 'right';
			if ($custom_block['status']) {
				$content_width = $custom_block['width'] ? $custom_block['width'] : 0;
				$content_padding = $custom_block['content_padding'] ? $custom_block['content_padding'] : 0;
				$data[$alignment][] = array(
					'height'			=> self::ICON_HEIGHT,
					'width'				=> self::ICON_WIDTH,
					'img'				=> $custom_block['img'] ? 'image/' . $custom_block['img'] : 'no_image.jpg',
					'text'				=> html_entity_decode($text, ENT_QUOTES, 'UTF-8'),
					'position'  		=> $custom_block['position'] ? 'absolute' : 'fixed',
					'offset'			=> $custom_block['offset_top'] ? $custom_block['offset_top'] : 140,
					'icon_bgcolor'		=> $custom_block['icon_bgcolor'] ? '#' . $custom_block['icon_bgcolor'] : 'transparent',
					'content_bgcolor'	=> $custom_block['content_bgcolor'] ? '#' . $custom_block['content_bgcolor'] : 'transparent',
					'content_width'		=> $content_width + 2 * $content_padding,
					'content_padding'	=> $content_padding,
				);
			}
		}

		$this->document->journal_custom_blocks = $data;

		$this->document->journal_custom_blocks_count = count($data['left']) + count($data['right']) > 0 ? 'custom-blocks-active' : '';
	}

	private function sort(&$array, $desc = FALSE) {
		$tmp_array = array();

		foreach ($array as $k => $v) {
			if ($v['sort_order']) {
				$tmp_array[] = $v;
			}
		}

		usort($tmp_array, array("ControllerModuleJournalCp", $desc ? 'sort_desc' : 'sort_asc'));

		foreach ($array as $k => $v) {
			if (!$v['sort_order']) {
				$tmp_array[] = $v;
			}
		}

		$array = $tmp_array;
	}

	private static function sort_asc($a, $b) {
		$a = (int)$a['sort_order'];
		$b = (int)$b['sort_order'];
		return $a - $b;
	}

	private static function sort_desc($a, $b) {
		$a = (int)$a['sort_order'];
		$b = (int)$b['sort_order'];
		return $b - $a;
	}

	private function is_installed() {
		$is_installed = $this->model_journal_cp->is_installed();
		if (!$is_installed) {
			echo 'Journal modules are not enabled!';
		} else {
			$this->document->journal_install = true;
		}
		return $is_installed;
	}


	public function index() {

		$this->load->model('journal/cp');
		$this->load->model('tool/image');
		$this->load->model('catalog/product');
		$this->load->model('catalog/category');

		/* check journal is installed */
		if (!$this->is_installed()) {
			die();
		}

		// echo "<pre>" . print_r($this->request->get, TRUE) . "</pre>";

		$this->document->journal_decimal_point = $this->language->get('decimal_point');

		/* quick seo url fix */
		$temp_route = '';

		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);

			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);

					// if ($url[0] == 'product_id') {
					// 	$this->request->get['product_id'] = $url[1];
					// }

					if ($url[0] == 'category_id') {
						if (!isset($temp_path)) {
							$temp_path = $url[1];
						} else {
							$temp_path .= '_' . $url[1];
						}
					}

					// if ($url[0] == 'manufacturer_id') {
					// 	$this->request->get['manufacturer_id'] = $url[1];
					// }

					// if ($url[0] == 'information_id') {
					// 	$this->request->get['information_id'] = $url[1];
					// }
				} else {
					$temp_route = 'error/not_found';
				}
			}

			if (isset($this->request->get['product_id'])) {
				$temp_route = 'product/product';
			} elseif (isset($this->request->get['path'])) {
				$temp_route = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$temp_route = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$temp_route = 'information/information';
			}

			// if (isset($this->request->get['route'])) {
			// 	return $this->forward($this->request->get['route']);
			// }
		}

		// echo "<pre>" . print_r($temp_route, TRUE) . "</pre>";

		$active_theme = $this->model_journal_cp->getActiveTheme();
		$this->document->journal_active_theme = $active_theme['theme_id'];

		if (!$active_theme['status']) return;

		if (isset($this->session->data['theme'])) {
			$sess_theme_id = $this->model_journal_cp->getThemeId($this->session->data['theme']);
		}

		if (isset($sess_theme_id) && is_array($sess_theme_id)) {
			$active_theme = $sess_theme_id;
		}

		$settings = $this->model_journal_cp->getThemeSettings($active_theme['theme_id']);

		$vars = array();
		$css = array();

		foreach ($settings as &$setting) {
			if (is_array($setting['value'])) {
				$setting['value'] = json_decode($setting['value'], true);
			} elseif ($setting['input'] !== 'custom_block') {
				$setting['value'] = html_entity_decode($setting['value'], ENT_QUOTES, 'UTF-8');
			}

			if ($setting['type'] === 'css') {
				// apply all css properties
				$selector = $setting['css_selector'];
				$property = $setting['css_property'];
				$value = $setting['value'];

				switch ($setting['input']) {
					case 'font'		: $value = json_decode($value, true); break;
					case 'upload'	: $value = is_file(DIR_IMAGE . $value) ? 'image/' . $value : null; break;
					case 'color'	: $value = $value ? '#' . $value : 'transparent'; break;
				}

				// background position
				if (strpos($setting['name'], '_position') != FALSE) {
					if (in_array($value, array('left', 'right'))) {
						$value = 'top ' . $value;
					}
				}

				$css[md5($selector)]['selector'] = $selector;

				if (is_array($value)) {
					$rules = array();
					foreach ($value as $k => $v) {
						if ($k == 'font-size' || $k == 'line-height') $v .= 'px';
						if ($k == 'font-family') {
							$font_info = $this->model_journal_cp->getFontInfo($v);
							$v = $font_info['font_family'];
							if ($font_info['group'] == 'google') {
								$this->document->addStyle('//fonts.googleapis.com/css?family=' . $font_info['css_name'] . '&amp;subset=latin,latin-ext,cyrillic', 'stylesheet prefetch');
								$v = '"' . $v . '"';
							}
						}
						$css[md5($selector)]['rules'][] = "{$k}:{$v};";
					}
				} else {
					$css[md5($selector)]['rules'][] = strpos($property, '%s') === FALSE ? "{$property}:{$value};" : sprintf($property, $value) . ";";
				}
			} else {
				$value = $setting['value'] ? $setting['value'] : NULL;

				if($setting['input'] === 'multilang') {
					$setting['value'] = json_decode($setting['value'], true);
					if (isset($setting['value']['l_' . (int)$this->config->get('config_language_id')])) {
						$value = $setting['value']['l_' . (int)$this->config->get('config_language_id')];
					} else {
						$value = false;
					}
				}

				if ($value) {
					$vars['journal_' . $setting['name']] = $value;
				}
			}

		}
		$this->extend_css($css);
		$this->extend_vars($vars);
		$this->extend_payment_images();
		$this->extend_contact_methods();
		$this->extend_top_menu();
		$this->extend_categories_menu();
		$this->extend_categories_menu_extended();
		$this->extend_social_icons();
		$this->extend_custom_blocks();

		/* get subcateg pictures */
		$is_categ_route = isset($this->request->get['route']) && $this->request->get['route'] === 'product/category';
		$categ_path	= isset($this->request->get['path']) ? $this->request->get['path'] : false;
		if (isset($temp_path) && $temp_path) {
			$categ_path = $temp_path;
			$is_categ_route = true;
		}
		if ($is_categ_route && $categ_path) {
			$this->load->model('catalog/category');

			$parts = explode('_', (string)$categ_path);
			$category_id = (int)array_pop($parts);

			$categories = $this->model_catalog_category->getCategories($category_id);
			$data = array();

			/* compatibility */
			if (!isset($this->document->journal_refine_categories_image_width)) {
				$this->document->journal_refine_categories_image_width = 90;
			}

			$this->document->journal_refine_categories_image_height = $this->document->journal_refine_categories_image_width;

			if (!isset($this->document->journal_refine_categories_image_margins)) {
				$this->document->journal_refine_categories_image_margins = 0;
			}

			foreach ($categories as $subcateg) {
				$filters = array(
					'filter_category_id'  => $subcateg['category_id'],
					'filter_sub_category' => true
				);

				$product_total = $this->model_catalog_product->getTotalProducts($filters);

				$data[] = array(
					'name'  => $subcateg['name'] . ($this->config->get('config_product_count') ? ' (' . $product_total . ')' : ''),
					'href'  => $this->rewrite($this->url->link('product/category', 'path=' . $categ_path . '_' . $subcateg['category_id'])),
					'thumb'	=> $this->model_tool_image->resize($subcateg['image'] ? $subcateg['image'] : 'no_image.jpg', $this->document->journal_refine_categories_image_width, $this->document->journal_refine_categories_image_height)
				);
			}
			$this->document->journal_image_subcategories = $data;
		}
		/* end get subcateg pictures */

		if (
			(isset($this->document->journal_refine_subcategories) && $this->document->journal_refine_subcategories === 'yes'
			&& isset($this->document->journal_refine_subcategories_carousel) && $this->document->journal_refine_subcategories_carousel === 'yes')
			|| (isset($this->document->journal_standard_modules_carousel) && $this->document->journal_standard_modules_carousel === 'yes')
		) {
			$this->document->addStyle('catalog/view/javascript/journal/flexslider/flexslider.css', 'stylesheet prefetch');
			$this->document->addScript('catalog/view/javascript/journal/flexslider/jquery.flexslider-min.js');
		}

		$custom_css_file = $this->config->get('config_template') . '/stylesheet/' . $active_theme['theme_id'] . '_theme.css';
		$this->document->journal_custom_css_file = '<link rel="stylesheet" type="text/css" href="catalog/view/theme/' . $custom_css_file . '" />';
		if (!file_exists(DIR_TEMPLATE . $custom_css_file)) {
			unset($this->document->journal_custom_css_file);
		}

		/* setup product notification title*/
		if (isset($this->document->journal_product_notification_title)) {
			$title = json_decode($this->document->journal_product_notification_title, true);
			$lang_id = 'l_' . (int)$this->config->get('config_language_id');
			$this->document->journal_product_notification_title = isset($title[$lang_id]) ? $title[$lang_id] : '';
		}

		$this->menu();
		$this->tabs();
	}

	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));

		$url = '';

		$data = array();

		if (isset($url_info['query'])) {
			parse_str($url_info['query'], $data);
		}

		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

					if ($query->num_rows) {
						$url .= '/' . $query->row['keyword'];

						unset($data[$key]);
					}
				} elseif ($key == 'path') {
					$categories = explode('_', $value);

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
						}
					}

					unset($data[$key]);
				}
			}
		}

		if ($url) {
			unset($data['route']);

			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . $key . '=' . $value;
				}

				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}

	public function search_products() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_category_id'])) {
			$this->load->model('catalog/product');
			// $this->load->model('catalog/option');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 20;
			}

			$data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->model_catalog_product->getProducts($data);

			foreach ($results as $result) {
				$option_data = array();

				// $product_options = $this->model_catalog_product->getProductOptions($result['product_id']);

				// foreach ($product_options as $product_option) {
				// 	$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

				// 	if ($option_info) {
				// 		if ($option_info['type'] == 'select' || $option_info['type'] == 'radio' || $option_info['type'] == 'checkbox' || $option_info['type'] == 'image') {
				// 			$option_value_data = array();

				// 			foreach ($product_option['product_option_value'] as $product_option_value) {
				// 				$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

				// 				if ($option_value_info) {
				// 					$option_value_data[] = array(
				// 						'product_option_value_id' => $product_option_value['product_option_value_id'],
				// 						'option_value_id'         => $product_option_value['option_value_id'],
				// 						'name'                    => $option_value_info['name'],
				// 						'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
				// 						'price_prefix'            => $product_option_value['price_prefix']
				// 					);
				// 				}
				// 			}

				// 			$option_data[] = array(
				// 				'product_option_id' => $product_option['product_option_id'],
				// 				'option_id'         => $product_option['option_id'],
				// 				'name'              => $option_info['name'],
				// 				'type'              => $option_info['type'],
				// 				'option_value'      => $option_value_data,
				// 				'required'          => $product_option['required']
				// 			);
				// 		} else {
				// 			$option_data[] = array(
				// 				'product_option_id' => $product_option['product_option_id'],
				// 				'option_id'         => $product_option['option_id'],
				// 				'name'              => $option_info['name'],
				// 				'type'              => $option_info['type'],
				// 				'option_value'      => $product_option['option_value'],
				// 				'required'          => $product_option['required']
				// 			);
				// 		}
				// 	}
				// }

				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'model'      => $result['model'],
					'option'     => $option_data,
					'price'      => $result['price'],
					'href'       => html_entity_decode($this->url->link('product/product', '&product_id=' . $result['product_id']), ENT_QUOTES, 'UTF-8')
				);
			}
		}

		$this->response->setOutput(json_encode($json));
	}

	public function menu() {
		$menu = $this->config->get('journal_menu');
		$lang_id = $this->config->get('config_language_id');

		$this->load->model('catalog/manufacturer');

		$journal_menu = array();

		if (!isset($menu['tabs'])) return;
		if (!isset($menu['status']) || !$menu['status']) return;
		if (!is_array($menu['tabs'])) return;

		// $this->document->journal_mega_menu_animation = $menu['animation'];
		$this->document->journal_mega_menu_animation = 1;

		$this->document->addStyle('catalog/view/theme/journal/stylesheet/super-menu.css');

        $this->sort($menu['tabs']);

		foreach ($menu['tabs'] as $tab) {
			if (!$tab['status']) {
				continue;
			}
			$menu_item = array(
				'name'		=> isset($tab['name'][$lang_id]) ? $tab['name'][$lang_id] : 'NotTrans',
				'type'		=> $tab['itemType'],
			);

			switch($tab['itemType']) {
				case 'megamenu':
					$menu_item['show_images'] = $tab['megamenu']['showImages'];
					$menu_item['maxSubItems'] = isset($tab['megamenu']['maxSubItems']) ? $tab['megamenu']['maxSubItems'] : 0;
					$menu_item['link'] = isset($tab['megamenu']['top_link']) ? $tab['megamenu']['top_link'] : false;
					$menu_item['moreText'] = isset($tab['megamenu']['moreText'][$lang_id]) ? $tab['megamenu']['moreText'][$lang_id] : 'NotTrans';
					$menu_item['new_window'] = '';
					$menu_item['items'] = array();
                    if (isset($tab['megamenu']['categories']) && is_array($tab['megamenu']['categories'])) {
                        foreach ($tab['megamenu']['categories'] as $category) {
                        	if (!isset($category['data'])) continue;
                            /* get subcategs if available */
                            $subcategs = array();
                            $results = $this->model_catalog_category->getCategories($category['data']['category_id']);
                            foreach ($results as $result) {
                                $subcategs[] = array(
                                    'name'		=> $result['name'],
                                    'link'		=> $this->rewrite($this->url->link('product/category', 'path=' . $result['category_id'])),
                                    'image' 	=> $this->model_tool_image->resize($result['image'] ? $result['image'] : 'no_image.jpg', 100, 100),
                                );
                            }
                            /* get categ data */
                            $result = $this->model_catalog_category->getCategory($category['data']['category_id']);
                            if (!count($result)) continue;
                            $menu_item['items'][] = array(
                                'name'		=> $result['name'],
                                'link'		=> $this->rewrite($this->url->link('product/category', 'path=' . $result['category_id'])),
                                'image' 	=> $this->model_tool_image->resize($result['image'] ? $result['image'] : 'no_image.jpg', 100, 100),
                                'subcategs' => $subcategs,
                            );

                        }
                    }
					break;
				case 'brands':
					$menu_item['show_images'] = $tab['brands']['showImages'];
					$menu_item['items'] = array();
                    if (isset($tab['brands']['brands']) && is_array($tab['brands']['brands'])) {
                        foreach ($tab['brands']['brands'] as $brand) {
                        	if (!isset($brand['data'])) continue;
                            $result = $this->model_catalog_manufacturer->getManufacturer($brand['data']['manufacturer_id']);
                            if (!count($result)) continue;
                            $menu_item['items'][] = array(
                                'name'		=> $result['name'],
                                'link'		=> $this->rewrite($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])),
                                'image' 	=> $this->model_tool_image->resize($result['image'] ? $result['image'] : 'no_image.jpg', 100, 100),
                            );
                        }
                    }
					break;
				case 'simplemenu':
					$menu_item['link'] = $tab['simplemenu']['link'];
					$menu_item['new_window'] = $tab['simplemenu']['newWindow'] ? 'target="_blank"' : '';
					$menu_item['items'] = array();
                    if (isset($tab['simplemenu']['items']) && is_array($tab['simplemenu']['items'])) {
                        foreach ($tab['simplemenu']['items'] as $item) {
                            $menu_item['items'][] = array(
                                'name'			=> isset($item['name'][$lang_id]) ? $item['name'][$lang_id] : 'NotTrans',
                                'link'			=> $item['link'],
                                'new_window'	=> $item['newWindow'] ? 'target="_blank"' : ''
                            );
                        }
                    }
					break;
				case 'customblock':
					$menu_item['text'] = html_entity_decode(isset($tab['customblock'][$lang_id]) ? $tab['customblock'][$lang_id] : 'NotTrans', ENT_QUOTES, 'UTF-8');
					break;
				case 'products':
					$menu_item['show_images'] = $tab['products']['showImages'];
					$menu_item['items'] = array();
                    if (isset($tab['products']['products']) && is_array($tab['products']['products'])) {
                        foreach ($tab['products']['products'] as $product) {
                        	if (!isset($product['data'])) continue;
                            $result = $this->model_catalog_product->getProduct($product['data']['product_id']);
                            if (!count($result)) continue;
                            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                            } else {
                                $price = $result['price'];
                            }

                            if ((float)$result['special']) {
                                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                            } else {
                                $special = false;
                            }
                            $menu_item['items'][] = array(
                                'name'		=> $result['name'],
                                'link'		=> $this->rewrite($this->url->link('product/product', 'product_id=' . $result['product_id'])),
                                'image' 	=> $this->model_tool_image->resize($result['image'] ? $result['image'] : 'no_image.jpg', 195, 195),
                                'price'		=> $price,
                                'special'	=> $special,
                                'product_id'=> $result['product_id'],
                                'add_to_cart'=>$this->language->get('button_cart')
                            );
                        }
                    }
					break;
			}

			$journal_menu[] = $menu_item;
		}

		// echo "<pre>" . print_r($journal_menu, TRUE) . "</pre>";
		// echo "<pre>" . print_r($menu, TRUE) . "</pre>";

		$this->document->journal_mega_menu = $journal_menu;
	}

	public function tabs() {
		/* check product_tabs table exists */
		if (!$this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "journal_product_tabs'")->num_rows) return;

		/* check if we are on a product page */
		$product_id = 0;

		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} elseif (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);
			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");
				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);
					if ($url[0] == 'product_id') {
						$product_id = $url[1]; break;
					}
				}
			}
		}

		if (!$product_id) return;

		/* tabs data */
		$tabs_data = array();

		/* get global tabs */
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_tabs WHERE " . DB_PREFIX . "journal_product_tabs.product_id = '0'");
		if ($query->num_rows > 0) {
			$data = unserialize($query->row['data']);
			if (is_array($data)) {
				foreach ($data as $tab) {
					$tabs_data[] = $tab;
				}
			}
		}

		/* get current product tabs */
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "journal_product_tabs LEFT JOIN " . DB_PREFIX . "product_description ON " . DB_PREFIX . "journal_product_tabs.product_id = " . DB_PREFIX . "product_description.product_id WHERE (" . DB_PREFIX . "product_description.language_id='" . (int)$this->config->get('config_language_id') . "' OR " . DB_PREFIX . "product_description.language_id IS NULL) AND (" . DB_PREFIX . "journal_product_tabs.product_id = '" . $product_id . "')");
		if ($query->num_rows > 0) {
			$data = unserialize($query->row['data']);
			if (is_array($data)) {
				foreach ($data as $tab) {
					$tabs_data[] = $tab;
				}
			}
		}

		/* generate tabs */
		$tabs = array(
			1 => array(),
			2 => array(),
			3 => array(),
			4 => array(),
		);

		$this->sort($tabs_data);
		$lang_id = (int)$this->config->get('config_language_id');

		$found = false;

		foreach ($tabs_data as $tab) {
			if (!$tab['status']) continue;
			$found = true;
			$tabs[$tab['position']][] = array(
				'title'		=> isset($tab['name'][$lang_id]) ? html_entity_decode($tab['name'][$lang_id], ENT_QUOTES, 'UTF-8') : '',
				'content'	=> isset($tab['text'][$lang_id]) ? html_entity_decode($tab['text'][$lang_id], ENT_QUOTES, 'UTF-8') : '',
			);
		}

		if ($found) {
			$this->document->journal_custom_product_tabs = $tabs;
		}

	}

}
?>