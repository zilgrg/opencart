<?php
class ControllerModuleJournalGallery extends Controller {

	private function url($new_image) {
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $this->config->get('config_ssl') . 'image/' . $new_image;
		} else {
			return $this->config->get('config_url') . 'image/' . $new_image;
		}
	}

	protected function index($setting) {
		static $module = 0;

		$this->load->model('journal/gallery');
		$this->load->model('tool/image');


		$this->data['images'] = array();

		if (isset($setting['banner_id'])) {

			$results = $this->model_journal_gallery->getGallery($setting['banner_id']);

			if (!isset($results['images'])) {
				return;
			}

			$images = unserialize($results['images']);
			$options = unserialize($results['options']);

			$lang_id = $this->config->get('config_language_id');

			$limit = isset($options['thumb_limit']) && $options['thumb_limit'] ? $options['thumb_limit'] : 0;
			
			$this->data['module_name'] = $options['name'];

			if (isset($options['gallery_name_' . $lang_id])) {
				$this->data['module_name'] = $options['gallery_name_' . $lang_id];
			}

			$this->data['border_width'] = isset($options['border_width']) && $options['border_width'] ? $options['border_width'] : 0;
			$this->data['border_speed'] = isset($options['border_speed']) && $options['border_speed'] ? $options['border_speed'] : 0;
			$this->data['border_color'] = isset($options['border_color']) && $options['border_color'] ? $options['border_color'] : 'FFF';

			$index = 0;

			$this->sort($images);


			foreach ($images as $image) {
				if (file_exists(DIR_IMAGE . $image['image'])) {
					list($width_orig, $height_orig) = getimagesize(DIR_IMAGE . $image['image']);
					$this->data['images'][] = array(
						'caption'  => isset($image['new_caption']) && isset($image['new_caption'][$lang_id]) ? $image['new_caption'][$lang_id] : '',
						'popup' => $this->url($image['image']),
						'thumb' => $this->model_tool_image->resize($image['image'], 160, 160, $width_orig < $height_orig ? 'w' : 'h'),
						'visible'	=> $limit && $index >= $limit ? 'display: none' : ''
					);
					$index++;
				}
			}

			$this->document->addScript('catalog/view/javascript/journal/jquery.insetborder.js');
			$this->document->addScript('catalog/view/javascript/journal/swipebox/lib/ios-orientationchange-fix.js');
			$this->document->addScript('catalog/view/javascript/journal/swipebox/source/jquery.swipebox.js');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/journal_gallery.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/module/journal_gallery.tpl';
			} else {
				$this->template = 'default/template/module/journal_gallery.tpl';
			}

		}

		$this->data['module'] = $module++;

		$this->render();

	}

	private function sort(&$array, $desc = FALSE) {
		$tmp_array = array();

		foreach ($array as $k => $v) {
			if (isset($v['sort_order']) && $v['sort_order']) {
				$tmp_array[] = $v;
			}
		}

		usort($tmp_array, array("Controllermodulejournalgallery", $desc ? 'sort_desc' : 'sort_asc'));

		foreach ($array as $k => $v) {
			if (!isset($v['sort_order']) || !$v['sort_order']) {
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
}
?>