<?php
class ControllerModuleJournalCp extends Controller {

	private $error = array();
	private $tips = array(
		"extended_filter"=>"extended.jpg",
		"mobile_menu_title"=>"mobile.jpg",
		"preloader_visibility"=>"preloader.jpg",
		"preloader_image"=>"preloader.jpg",
		"preloader_color"=>"preloader.jpg",
		"sale_product_badge"=>"sale-badge.jpg",

		"sale_product_badge_color"=>"sale-badge.jpg",
		"sale_product_badge_font"=>"sale-badge.jpg",
		"sale_product_badge_background_color"=>"sale-badge.jpg",

	);

	public function __construct($reg) {
		parent::__construct($reg);

		// add imports
		$this->document->addStyle('//fonts.googleapis.com/css?family=Oswald', 'stylesheet prefetch');
		$this->document->addScript('view/javascript/journal/journal.js');
		$this->document->addStyle('view/stylesheet/journal/journal.css');

		$this->document->addStyle('view/javascript/journal/bootstrap/css/bootstrap.css');
		$this->document->addScript('view/javascript/journal/bootstrap/js/bootstrap.min.js');
		$this->document->addStyle('view/javascript/journal/bootstrap-fileupload/bootstrap-fileupload.min.css');
		$this->document->addScript('view/javascript/journal/bootstrap-fileupload/bootstrap-fileupload.min.js');
		$this->document->addStyle('view/javascript/journal/jquery.switch/jquery.switch.css');
		$this->document->addScript('view/javascript/journal/jquery.switch/jquery.switch.min.js');
		$this->document->addStyle('view/javascript/journal/jquery.switch/prettyCheckable.css');
		$this->document->addScript('view/javascript/journal/jquery.switch/prettyCheckable.js');
		$this->document->addScript('view/javascript/journal/plugins.js');
		$this->document->addScript('view/javascript/journal/jquery.address-1.5.min.js');
		$this->document->addScript('view/javascript/journal/cookie.js');

		// load models
		$this->load->model('journal/cp');
		$this->load->model('tool/image');
		$this->load->model('localisation/language');

		// load language vars
		$this->load->language('module/journal_cp');
		$this->loadLanguageVars(array(
			'doc_title',
			'heading_title',
			'text_image_manager',

			'button_save',
			'button_cancel',
			'button_update',

			'th_var_name',
			'th_font_name',
			'th_font_size',
			'th_line_height',
			'th_font_weight',
			'th_font_style',
			'th_font_transform',

			'error_menu_name',
			'error_contact_method_name',

			'no_images',

			'text_yes',
			'text_no',

			'text_update_in_progress',

		));

		$this->document->setTitle($this->language->get('doc_title'));
	}

	public function install() {
		$this->model_journal_cp->install();
	}

	public function uninstall() {
		$this->model_journal_cp->uninstall();
	}

	public function index() {
		// import settings
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->files['import_file']) && ($this->request->files['import_file']['size'] > 0) && $this->user->hasPermission('modify', 'module/journal_cp')) {
			if (is_uploaded_file($this->request->files['import_file']['tmp_name'])) {
				$content = file_get_contents($this->request->files['import_file']['tmp_name']);
			} else {
				$content = false;
			}
			if ($content) {
				$this->import_journal($content);

				$this->session->data['success'] = $this->language->get('text_success');

				$this->redirect($this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->error['warning'] = $this->language->get('error_empty');
			}
		}

		// end of import settings
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$db_settings = $this->model_journal_cp->getSettings_v2();

			$settings = $this->request->post['journal_settings'];

			// echo "<pre>"; print_r($settings['custom_blocks']); die();

			/* fix no payment images clear */
			if (!isset($settings['payment_images'])) {
				$settings['payment_images'] = array();
			}
			/* end fix */

			/* fix no top menu items clear */
			if (!isset($settings['top_menu'])) {
				$settings['top_menu'] = array();
			}
			/* end fix */

			/* fix no categories menu items clear */
			if (!isset($settings['categories_menu'])) {
				$settings['categories_menu'] = array();
			}
			/* end fix */

			/* fix no categories menu extended items clear */
			if (!isset($settings['categories_menu_extended'])) {
				$settings['categories_menu_extended'] = array();
			}
			/* end fix */

			/* fix contact methods clear */
			if (!isset($settings['contact_methods'])) {
				$settings['contact_methods'] = array();
			}
			/* end fix */

			/* fix social icons clear */
			if (!isset($settings['social_icons'])) {
				$settings['social_icons'] = array();
			}
			/* end fix */

			/* fix no payment images clear */
			if (!isset($settings['custom_blocks'])) {
				$settings['custom_blocks'] = array();
			}
			/* end fix */

			foreach ($settings as $name => &$value) {
				if ($db_settings[$name]['is_serialized'] == 'yes') {
					$value = json_encode($value);
				}
			}

			$is_new_theme = isset($this->request->post['journal_new_theme']);

			if ($is_new_theme) {
				$name = $this->request->post['journal_new_theme'];
				$theme = preg_replace('/[^a-z0-9]+/', '_', strtolower($name));
				$this->model_journal_cp->addTheme($theme, $name);
			} else {
				$theme = $this->request->post['journal_theme'];
			}

			$status = $this->request->post['journal_theme_status'];

			// echo "<pre>" . print_r($this->request->post['journal_settings'], TRUE) . "</pre>"; die();

			$this->model_journal_cp->saveThemeSettings($theme, $settings, $is_new_theme);
			$this->model_journal_cp->setActiveTheme($theme);
			$this->model_journal_cp->setThemeStatus($theme, $status);

			if (isset($this->request->post['store_ids'])) {
				$this->model_journal_cp->saveThemeStores($theme, $this->request->post['store_ids']);
			}

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/journal_cp', 'token=' . $this->session->data['token'] . '&theme=' . $theme, 'SSL'));
		}

		$this->data['current_theme'] = $this->model_journal_cp->getActiveTheme();
		if (isset($this->request->get['theme'])) {
			$this->data['current_theme'] = $this->request->get['theme'];
		}

		$this->data['theme_status'] = $this->model_journal_cp->getThemeStatus($this->data['current_theme']);
		$this->data['core_theme'] = $this->model_journal_cp->isCoreTheme($this->data['current_theme']);

		$this->data['journal_version'] = $this->model_journal_cp->getCurrentVersion();
		$this->data['update_avaliable'] = $this->model_journal_cp->update_avaliable();

		$this->data['token'] = $this->session->data['token'];
		$this->data['action'] = $this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['update'] = $this->url->link('module/journal_cp/update_journal', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['export'] = $this->url->link('module/journal_cp/export_journal', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('module/journal_cp/delete', 'token=' . $this->session->data['token'] . "&theme=" . $this->data['current_theme'], 'SSL');
		$this->data['fonts_url'] = $this->url->link('module/journal_cp/fonts', 'token=' . $this->session->data['token'] . "&theme=" . $this->data['current_theme'], 'SSL');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['warning'])) {
			$this->data['error_warning'] = $this->session->data['warning'];
			unset($this->session->data['warning']);
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
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
			'href'      => $this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		// multistore settings
   		$this->load->model('setting/store');
   		$this->data['stores'] = $this->model_setting_store->getStores();
   		array_unshift($this->data['stores'], array(
			'store_id' => 0,
			'name'     => $this->config->get('config_name'),
		));
		$this->data['store_ids'] = $this->model_journal_cp->getThemeStores($this->data['current_theme']);
   		// end of multistore settings

   		$this->getThemes();
		$this->getTabs();
		$this->getSettings();

		$this->data['no_image'] = $this->image_link('data/journal/no_image.png');

		$this->template = 'module/journal_cp_index.tpl';

		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	public function delete() {
		if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
			$theme_id = $this->request->get['theme'];
			if (!$this->model_journal_cp->isCoreTheme($theme_id)) {
				$active_theme_id = $this->model_journal_cp->getActiveTheme();
				$this->model_journal_cp->removeTheme($theme_id);
			}
		} else {
			$this->session->data['warning'] = $this->language->get('error_permission');
		}

		$this->redirect($this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function fonts() {
		$this->data['current_theme'] = $this->model_journal_cp->getActiveTheme();
		if (isset($this->request->get['theme'])) {
			$this->data['current_theme'] = $this->request->get['theme'];
		}

		$this->data['theme_status'] = $this->model_journal_cp->getThemeStatus($this->data['current_theme']);
		$this->data['core_theme'] = $this->model_journal_cp->isCoreTheme($this->data['current_theme']);

		$this->getFontsSettings();

		$this->template = 'module/journal_cp_fonts.tpl';

		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	public function update_journal() {
		if ($this->validate()) {
			$this->model_journal_cp->update_journal();
			$this->session->data['success'] = $this->language->get('text_update_success');
		}
		$this->redirect($this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL'));
	}

	private function getThemes() {
		$themes = $this->model_journal_cp->getThemes();
		$this->data['themes'] = array();
		foreach ($themes as $theme) {
			if ($theme['core'] == 1) {
				$this->data['themes']['core']['category'] = $this->language->get('core_themes');
				$this->data['themes']['core']['themes'][] = $theme;
			} else {
				$this->data['themes']['custom']['category'] = $this->language->get('custom_themes');
				$this->data['themes']['custom']['themes'][] = $theme;
			}
		}
	}

	private function getTabs() {
		$this->data['tabs'] = array();
		$this->data['tabs_labels'] = array();

		$categories = $this->model_journal_cp->getCategories();

		foreach ($categories as $categ) {
			$this->data['tabs'][$categ['category_name']] = array();
			$this->data['tabs_labels']['htab_' . $categ['category_name']] = $this->language->get('htab_' . $categ['category_name']);
			$subcategories = $this->model_journal_cp->getSubcategories($categ['category_name']);
			foreach ($subcategories as $subcateg) {
				$this->data['tabs'][$categ['category_name']][] = $subcateg['subcategory_name'];
				$this->data['tabs_labels']['vtab_' . $subcateg['subcategory_name']] = $this->language->get('vtab_' . $subcateg['subcategory_name']);
			}
		}
	}

	private function getFontsSettings() {
		$this->data['journal_settings'] = array();
		$global_settings = $this->model_journal_cp->getSettings();
		$theme_settings = $this->model_journal_cp->getThemeSettings($this->data['current_theme']);
		$fonts = $this->model_journal_cp->getFonts();
		$hash = array();

		foreach ($theme_settings as $setting) {
			$hash[$setting['setting_name']] = $setting;
		}

		foreach ($global_settings as $setting) {
			$value = NULL;
			$default_value = NULL;

			if (isset($hash[$setting['name']])) {
				$value = $hash[$setting['name']]['value'];
				$default_value = $hash[$setting['name']]['default_value'];
			}

			if ($setting['is_serialized'] == 'yes') {
				$value = json_decode($value, true);
				$default_value = json_decode($default_value, true);
			} else {
				$value = html_entity_decode($value);
				$default_value = html_entity_decode($default_value);
			}

			if ($setting['input'] == 'font') {
				$setting['font_families'] = $fonts;
			}

			if ($setting['subcategory']) {
				$setting['value'] = $value;
				$setting['default_value'] = $default_value;
				$setting['label'] = $this->language->get($setting['name']);
				$this->data['journal_settings'][$setting['category']]['subcategories'][$setting['subcategory']][] = $setting;
			} else {
				$setting['value'] = $value;
				$setting['default_value'] = $default_value;
				$setting['label'] = $this->language->get($setting['name']);
				$this->data['journal_settings'][$setting['category']][] = $setting;
			}
		}
	}

	private function getSettings() {
		$this->data['journal_settings'] = array();
		$global_settings = $this->model_journal_cp->getSettings();
		$theme_settings = $this->model_journal_cp->getThemeSettings($this->data['current_theme']);
		$fonts = $this->model_journal_cp->getFonts();
		$hash = array();
		foreach ($theme_settings as $setting) {
			$hash[$setting['setting_name']] = $setting;
		}

		// $fonts = $this->model_journal_cp->getFonts();

		// echo "<pre>" . print_r($hash, TRUE) . "</pre>";
		// echo "<pre>" . print_r($global_settings, TRUE) . "</pre>";

		foreach ($global_settings as $setting) {
			$value = NULL;
			$default_value = NULL;

			$setting['tip'] = isset($this->tips[$setting['name']]) ? $this->tips[$setting['name']] : null;

			if (isset($hash[$setting['name']])) {
				$value = $hash[$setting['name']]['value'];
				$default_value = $hash[$setting['name']]['default_value'];
			}

			if ($setting['input'] == 'upload') {
				if ($value) {
					$setting['thumb'] = $this->image_link($value);
					$setting['default_thumb'] = $this->image_link($default_value);
				} else {
					$setting['thumb'] = $this->image_link('data/journal/no_image.png');
					$setting['default_thumb'] = $this->image_link('data/journal/no_image.png');
				}

			}

			if ($setting['input'] == 'select') {
				$opts = array();
				foreach(explode(',', $setting['options']) as $opt) {
					$opts[$opt] = $this->language->get($setting['name'] . '_opt_' . $opt);
				}
				$setting['options'] = $opts;
			}




			if ($setting['is_serialized'] == 'yes') {
				$value = json_decode($value, true);
				// echo "<pre>" . print_r($setting['input'], TRUE) . "</pre>";
				$default_value = json_decode($default_value, true);
			} else {
				$value = html_entity_decode($value);
				$default_value = html_entity_decode($default_value);
			}


			if (in_array($setting['input'], array('multiupload', 'menu', 'custom_block'))) {
				if (is_array($value)) {
					foreach ($value as &$val) {
						$val = (array)$val;
						$val['thumb'] = $this->image_link($val['img']);
					}
				} else {
					$value = array();
				}
				if (is_array($default_value)) {
					foreach ($default_value as &$val) {
						$val = (array)$val;
						$val['thumb'] = $this->image_link($val['img']);
					}
				} else {
					$default_value = array();
				}
			}

			if ($setting['input'] == 'font') {
				$setting['font_families'] = $fonts;
			}

			if ($setting['subcategory']) {
				$setting['value'] = $value;
				$setting['default_value'] = $default_value;
				$setting['label'] = $this->language->get($setting['name']);
				$this->data['journal_settings'][$setting['category']]['subcategories'][$setting['subcategory']][] = $setting;
			} else {
				$setting['value'] = $value;
				$setting['default_value'] = $default_value;
				$setting['label'] = $this->language->get($setting['name']);
				$this->data['journal_settings'][$setting['category']][] = $setting;
			}
		}

		$this->data['journal_settings']['all_languages'] = $this->model_localisation_language->getLanguages();
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
	}

	private function loadLanguageVars($vars = array()) {
        foreach ($vars as $var) {
            $this->data[$var] = $this->language->get($var);
        }
    }

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/journal_cp')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function export_journal() {
		if (!$this->user->hasPermission('modify', 'module/journal_cp')) {
			$this->session->data['warning'] = $this->language->get('error_permission');
			$this->redirect($this->url->link('module/journal_cp', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->response->addheader('Pragma: public');
		$this->response->addheader('Expires: 0');
		$this->response->addheader('Content-Description: File Transfer');
		$this->response->addheader('Content-Type: application/octet-stream');
		$this->response->addheader('Content-Disposition: attachment; filename=journal_cp_backup_' . date('Y-m-d_H-i-s', time()) . '.jbkp');
		$this->response->addheader('Content-Transfer-Encoding: binary');

		$this->load->model('tool/backup');

		$tables = array(
			'journal_cp_themes',
			'journal_cp_theme_settings',
			'journal_cp_theme_to_store'
		);

		$data = array();

		foreach ($tables as $table) {
			$result = $this->db->query('SELECT * FROM `' . DB_PREFIX . $table . '`')->rows;
			foreach ($result as &$res) {
				foreach ($res as $k => &$v) {
					$v = base64_encode($v);
				}
			}
			$data[$table] = $result;
		}

		$this->response->setOutput(json_encode($data));
	}

	private function import_journal($content) {
		$content = json_decode($content, true);
		// echo "<pre>" . print_r($content, TRUE) . "</pre>";die();
		$this->db->query('SET FOREIGN_KEY_CHECKS=0;');
		foreach ($content as $table => $rows) {
			$this->db->query('TRUNCATE TABLE `' . DB_PREFIX . $table . '`');
			foreach ($rows as $row) {
				$values = array();
				foreach (array_values($row) as $value) {
					$values[] = '"' . $this->db->escape(base64_decode($value)) . '"';
				}
				$sql = "INSERT INTO `" . DB_PREFIX . $table . "` (" . implode(",", array_keys($row)) . ") VALUES (" . implode(",", array_values($values)) . ")";
				$this->db->query($sql);
			}
		}
		$this->db->query('SET FOREIGN_KEY_CHECKS=1;');
	}

	private function image_link($new_image) {
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return HTTPS_CATALOG . 'image/' . $new_image;
		} else {
			return HTTP_CATALOG . 'image/' . $new_image;
		}
	}

	public function category_autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/category');

			$data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 20
			);

			$results = $this->model_journal_cp->getProductCategories($data);

			foreach ($results as $result) {
				$json[] = array(
					'category_id' => $result['category_id'],
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->setOutput(json_encode($json));
	}

}
