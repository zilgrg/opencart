<?php
class ControllerModuleJournalRevSlider extends Controller {
	protected function index($setting) {
		static $module = 0;

		if (!isset($setting['slider'])) return;

		// load models
		$this->load->model('journal/rev_slider');
		$this->load->model('journal/cp');
		$this->load->model('tool/image');

		// get slider from db
		$slider = $this->model_journal_rev_slider->getSlider($setting['slider']);

		// echo "<pre>" . print_r($slider, true) . "</pre>";

		$slider_data = array();

		$full_width = $slider['data']['fullWidth'];

		// set slider options
		$slider_data['options'] = $slider['data'];
		$slider_data['options']['startwidth'] = (int)(isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes' ? '1220' : '980');
		$slider_data['options']['startheight'] = (int)$slider['height'];
		$slider_data['options']['onHoverStop'] = $slider_data['options']['onHoverStop'] ? "on" : "off";
		$slider_data['options']['touchenabled'] = $slider_data['options']['touchenabled'] ? "on" : "off";
		$slider_data['options']['fullWidth'] = 'on';
		$slider_data['options']['videoJsPath'] = "catalog/view/javascript/journal/rs-plugin/videojs/";
		$this->data['slider_timer'] = isset($slider['timer']) ? $slider['timer'] : 'none';

		// generate slides data
		$slider_data['slides'] = array();

		if (isset($slider['slides'])) {

			$this->sort($slider['slides']);

			foreach ($slider['slides'] as $slide) {
				$slide_data = array();
				// set slide bg
				$slide_data['bgimage'] = 'image/' . $slide['bgimage'];
				// set slide data
				$slide_data['data'] = array();
				foreach ($slide['data'] as $k => $v) {
					if ($k == 'data-new_window') {
						$k = 'data-target';
						$v = $v ? '_blank' : '_self';
					} 
					if (strlen($v)) {
						$slide_data['data'][] = "data-{$k}=\"{$v}\"";
					}
				};
				$slide_data['data'] = implode(' ', $slide_data['data']);
				// set slide captions
				$slide_data['captions'] = array();
				// set layer items
				if (isset($slide['captions'])) {
					$this->sort($slide['captions']);
					foreach ($slide['captions'] as $caption) {
						if (isset($caption['animationfrom']) && $caption['animationfrom'] === '_none') {
							$caption['animationfrom'] = '';
							unset($caption['data']['start']);
							unset($caption['data']['speed']);
							unset($caption['data']['easing']);
						}
						if (isset($caption['animationto']) && $caption['animationto'] === '_none') {
							$caption['animationto'] = '';
							unset($caption['data']['end']);
							unset($caption['data']['endspeed']);
							unset($caption['data']['endeasing']);
						}
						$cpt = array(
							'cls'			=> array('caption tp-caption', $caption['animationfrom'], $caption['animationto']),
							'data'			=> array(),
							'img'			=> 'image/' . $caption['image'],
							'caption_type'	=> $caption['caption_type'],
							'video_type'	=> isset($caption['video_type']) ? $caption['video_type'] : null,
							'text'			=> isset($caption['text']) ? $caption['text'] : null,
							'url'			=> isset($caption['url']) ? $caption['url'] : null,
							'caption_url'	=> isset($caption['caption_url']) ? $caption['caption_url'] : null,
							'caption_url_new_tab'	=> isset($caption['caption_url_new_tab']) ? $caption['caption_url_new_tab'] : null,
						);
						if (isset($caption['fullscreen_video']) && $caption['fullscreen_video']) {
							$cpt['cls'][] = 'fullscreenvideo';
							$caption['data']['x'] = 0;
							$caption['data']['y'] = 0;
							$cpt['video_width'] = '100%';
							$cpt['video_height'] = '100%';
						} else {
							$cpt['video_width'] = isset($caption['video_width']) ? $caption['video_width'] : 400;
							$cpt['video_height'] = isset($caption['video_height']) ? $caption['video_height'] : 250;	
						}
						if ($caption['caption_type'] === 'text') {
							$font_info = $this->model_journal_cp->getFontInfo($caption['font_name']);
							$v = $font_info['font_family'];
							if ($font_info['group'] == 'google') {
								$this->document->addStyle('//fonts.googleapis.com/css?family=' . $font_info['css_name'] . '&amp;subset=latin,latin-ext,cyrillic', 'stylesheet prefetch');
								$v = '"' . $v . '"';
							}
							$cpt['css'] = "style='font-family: {$v}; color: #{$caption['text_color']}; font-size: {$caption['font_size']}; font-weight: {$caption['font_weight']}; text-transform: {$caption['font_transform']}'";
							$cpt['mouseover'] = $caption['text_color'] ? 'onmouseout="this.style.color=\'#' . $caption['text_color'] . '\'"' : '';
							$cpt['mouseout'] = isset($caption['caption_url_hover']) && $caption['caption_url_hover'] ? 'onmouseover="this.style.color=\'#' . $caption['caption_url_hover'] . '\'"' : '';
							$cpt['mouseevents'] = $cpt['mouseover'] . ' ' . $cpt['mouseout'];
						} else {
							$cpt['css'] = '';
							$cpt['mouseevents'] = '';
						}

						if (isset($caption['data']['position']) && $caption['data']['position']) {
							$caption['data']['x'] = isset($caption['data']['xx']) ? $caption['data']['xx'] : 0;
							$caption['data']['y'] = isset($caption['data']['yy']) ? $caption['data']['yy'] : 0;
							unset($caption['data']['voffset']);
							unset($caption['data']['hoffset']);
						} else {
							$caption['data']['x'] = 'center';
							$caption['data']['y'] = 'center';
						}
						unset($caption['data']['position']);
						unset($caption['data']['xx']);
						unset($caption['data']['yy']);
						

						// if (isset($caption['data']['positioning']) && $caption['data']['positioning']) {
						// 	$caption['data']['x'] = isset($caption['data']['xx']) ? $caption['data']['xx'] : 0;
						// 	$caption['data']['y'] = isset($caption['data']['yy']) ? $caption['data']['yy'] : 0;
						// 	unset($caption['data']['voffset']);
						// 	unset($caption['data']['hoffset']);
						// } else {
						// 	$caption['data']['y'] = 'center';
						// 	$caption['data']['y'] = 'center';
						// }
						// unset($caption['data']['xx']);
						// unset($caption['data']['yy']);
						// unset($caption['data']['positioning']);

						// $caption['data']['autoplay'] = 'true';
						// $caption['data']['nextslideatend'] = 'true';
						// if ($caption['data']['x'] === 'absolute') {
						// 	$caption['data']['x'] = isset($caption['data']['xx']) ? $caption['data']['xx'] : 0;
						// 	unset($caption['data']['xx']);
						// 	unset($caption['data']['voffset']);
						// }
						// if ($caption['data']['y'] === 'absolute') {
						// 	$caption['data']['y'] = isset($caption['data']['yy']) ? $caption['data']['yy'] : 0;
						// 	unset($caption['data']['yy']);
						// 	unset($caption['data']['hoffset']);
						// }

						// echo "<pre>" . print_r($caption['data'], true) . "</pre>";

						foreach ($caption['data'] as $k => $v) {
							if ($v || $v == '0') {
								$cpt['data'][] = "data-{$k}=\"{$v}\"";
							}
						}

						$cpt['cls'] = implode(' ', $cpt['cls']);
						$cpt['data'] = implode(' ', $cpt['data']);
						$slide_data['captions'][] = $cpt;
					}
				}
				// add items to the slide
				$slider_data['slides'][] = $slide_data;
			}
		}

		// get site width based on wide on/off
		$site_width = isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes' ? '1220' : '980';
		$this->data['rev_slider_class'] = isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes' ? 'rev-slider-wide' : 'rev-slider-normal';
		if ($full_width) $this->data['rev_slider_class'] = '';
		// set tpl vars
		$this->data['module'] = $module++;
		$this->data['slider'] = $slider_data;
		$this->data['sliderclass'] = $full_width ? 'fullwidthslider' : 'slider';
		// $this->data['width'] = $this->data['slider']['options']['fullWidth'] == 'on' ? '100% !important' : $site_width . 'px';
		$this->data['height'] = $slider['height'] . 'px';

		// echo "<pre>" . print_r($slider_data, TRUE) . "</pre>";

		// import necessary assets
		$this->document->addStyle('catalog/view/javascript/journal/rs-plugin/css/settings.css', 'stylesheet');
		// $this->document->addScript('catalog/view/javascript/journal/rs-plugin/pluginsources/jquery.themepunch.plugins.min.js');
		// $this->document->addScript('catalog/view/javascript/journal/rs-plugin/pluginsources/jquery.themepunch.revolution.js');
		$this->document->addScript('catalog/view/javascript/journal/rs-plugin/js/jquery.themepunch.revolution.min.js');

		// load and render template
		$this->template = $this->config->get('config_template') . '/template/module/journal_rev_slider.tpl';

		$this->render();
	}

	private function sort(&$array, $desc = FALSE) {
		$tmp_array = array();

		foreach ($array as $k => $v) {
			if (isset($v['sort_order']) && $v['sort_order']) {
				$tmp_array[] = $v;
			}
		}

		usort($tmp_array, array("Controllermodulejournalrevslider", $desc ? 'sort_desc' : 'sort_asc'));

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