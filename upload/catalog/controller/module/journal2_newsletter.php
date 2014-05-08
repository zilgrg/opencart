<?php
require_once DIR_SYSTEM . 'journal2/classes/journal2_newsletter.php';

class ControllerModuleJournal2Newsletter extends Controller {

    private static $CACHEABLE = null;

    public function __construct($registry) {
        parent::__construct($registry);
        if (!defined('JOURNAL_INSTALLED')) {
            return;
        }
        $this->load->model('journal2/module');

        if (self::$CACHEABLE === null) {
            self::$CACHEABLE = (bool)$this->journal2->settings->get('config_system_settings.newsletter_cache');
        }
    }

    public function index($setting) {
        if (!defined('JOURNAL_INSTALLED')) {
            return;
        }

        Journal2::startTimer(get_class($this));

        /* get module data from db */
        $module_data = $this->model_journal2_module->getModule($setting['module_id']);
        if (!$module_data || !isset($module_data['module_data']) || !$module_data['module_data']) return;
        $module_data = $module_data['module_data'];

        /* hide on mobile */
        if (Journal2Utils::getProperty($module_data, 'disable_mobile') && ($this->journal2->mobile_detect->isMobile() && !$this->journal2->mobile_detect->isTablet()) && $this->journal2->settings->get('responsive_design')) {
            return;
        }

        $this->data['css'] = '';

        /* css for top / bottom positions */
        if (in_array($setting['position'], array('top', 'bottom'))) {
            $padding = $this->journal2->settings->get('module_margins', 20) . 'px';
            /* outer */
            $css = Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'background'));
            $css[] = 'padding-top: ' . Journal2Utils::getProperty($module_data, 'margin_top', 0) . 'px';
            $css[] = 'padding-bottom: ' . Journal2Utils::getProperty($module_data, 'margin_bottom', 0) . 'px';
            $this->journal2->settings->set('module_journal2_newsletter_' . $setting['module_id'], implode('; ', $css));

            /* inner css */
            $css = array();
            if (Journal2Utils::getProperty($module_data, 'fullwidth')) {
                $css[] = 'max-width: 100%';
                $css[] = 'padding-left: ' . $padding;
                $css[] = 'padding-right: ' . $padding;
            } else {
                $css[] = 'max-width: ' . $this->journal2->settings->get('site_width', 1024) . 'px';
            }
            $this->data['css'] = implode('; ', $css);
        }

        $cache_property = "module_journal_carousel_{$setting['module_id']}_{$setting['layout_id']}_{$setting['position']}";

        $cache = $this->journal2->cache->get($cache_property);

        if ($cache === null || self::$CACHEABLE !== true) {
            $this->data['module'] = mt_rand();

            $module_split = explode(':', Journal2Utils::getProperty($module_data, 'module_split', '100:100'));

            /* hide on mobile */
            $this->data['hide_on_mobile_class'] = Journal2Utils::getProperty($module_data, 'disable_mobile') ? 'hide-on-mobile' : '';
            /* heading title */
            $this->data['heading_title'] = Journal2Utils::getProperty($module_data, 'module_title.value.' . $this->config->get('config_language_id'));
            /* text */
            $this->data['module_text'] = Journal2Utils::getProperty($module_data, 'module_text.value.' . $this->config->get('config_language_id'));
            $font_css = array();
            if (Journal2Utils::getProperty($module_data, 'module_text_font.value.font_type') === 'google') {
                $this->journal2->google_fonts->add(Journal2Utils::getProperty($module_data, 'module_text_font.value.font_name'), Journal2Utils::getProperty($module_data, 'module_text_font.value.font_subset'), Journal2Utils::getProperty($module_data, 'module_text_font.value.font_weight'));
                $weight = filter_var(Journal2Utils::getProperty($module_data, 'module_text_font.value.font_weight'), FILTER_SANITIZE_NUMBER_INT);
                $font_css[] = 'font-weight: ' . ($weight ? $weight : 400);
                $font_css[] = "font-family: '" . Journal2Utils::getProperty($module_data, 'module_text_font.value.font_name') . "'";
            }
            if (Journal2Utils::getProperty($module_data, 'module_text_font.value.font_type') === 'system') {
                $font_css[] = 'font-weight: ' . Journal2Utils::getProperty($module_data, 'module_text_font.value.font_weight');
                $font_css[] = 'font-family: ' . Journal2Utils::getProperty($module_data, 'module_text_font.value.font_family');
            }
            if (Journal2Utils::getProperty($module_data, 'module_text_font.value.font_type') !== 'none') {
                $font_css[] = 'font-size: ' . Journal2Utils::getProperty($module_data, 'module_text_font.value.font_size');
                $font_css[] = 'font-style: ' . Journal2Utils::getProperty($module_data, 'module_text_font.value.font_style');
                $font_css[] = 'text-transform: ' . Journal2Utils::getProperty($module_data, 'module_text_font.value.text_transform');
            }
            if (Journal2Utils::getProperty($module_data, 'module_text_font.value.color.value.color')) {
                $font_css[] = 'color: ' . Journal2Utils::getColor(Journal2Utils::getProperty($module_data, 'module_text_font.value.color.value.color'));
            }
            $font_css[] = 'width: '. $module_split[0] . '%';

            $this->data['font_css'] = implode('; ', $font_css);

            /* input */
            $this->data['input_placeholder'] = Journal2Utils::getProperty($module_data, 'input_placeholder.value.' . $this->config->get('config_language_id'));
            $input_style = array();
            if (Journal2Utils::getProperty($module_data, 'input_height')) {
                $input_style[] = 'height: ' . Journal2Utils::getProperty($module_data, 'input_height') . 'px';
            }
            if ($this->data['module_text']) {
                $input_style[] = 'width: ' . $module_split[1] . '%';
            } else {
                $input_style[] = 'width: 100%';
            }
            $this->data['input_style'] = implode('; ', $input_style);

            /* submit */
            $this->data['button_text'] = Journal2Utils::getProperty($module_data, 'button_text.value.' . $this->config->get('config_language_id'), $this->language->get('button_continue'));
            $this->data['button_icon'] = Journal2Utils::getIconOptions2(Journal2Utils::getProperty($module_data, 'button_icon'));
            $offset_style = array();
            if (Journal2Utils::getProperty($module_data, 'button_offset_top')) {
                $offset_style[] = 'margin-top: ' . Journal2Utils::getProperty($module_data, 'button_offset_top') . 'px';
            }
            if (Journal2Utils::getProperty($module_data, 'button_offset_left')) {
                $offset_style[] = 'right: ' . Journal2Utils::getProperty($module_data, 'button_offset_left') . 'px';
            }
            $this->data['button_style'] = implode('; ', $offset_style);

            /* background */
            $module_css = Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'module_background'));
            if (Journal2Utils::getProperty($module_data, 'module_padding')) {
                $module_css[] = 'padding: ' . Journal2Utils::getProperty($module_data, 'module_padding') . 'px';
            }
            $this->data['module_css'] = implode('; ', $module_css);

            /* ajax url */
            $this->data['subscribe_url'] = $this->url->link('module/journal2_newsletter/subscribe', '', 'SSL');

            $this->template = 'journal2/template/journal2/module/newsletter.tpl';
            if (self::$CACHEABLE === true) {
                $html = Minify_HTML::minify($this->render(), array(
                    'xhtml' => false,
                    'jsMinifier' => 'j2_js_minify'
                ));
                $this->journal2->cache->set($cache_property, $html);
            } else {
                $this->render();
            }
        } else {
            $this->template = 'journal2/template/journal2/cache/cache.tpl';
            $this->data['cache'] = $cache;
            $this->render();
        }

        Journal2::stopTimer(get_class($this));
    }

    public function subscribe() {
        $response = array();
        if (isset($this->request->post['email']) && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
            $newsletter = new Journal2Newsletter($this->registry, $this->request->post['email']);
            if ($newsletter->isSubscribed()) {
                $response['status'] = 'error';
                $response['message'] = 'Already subscribed.';
            } else {
                $newsletter->subscribe();
                $response['status'] = 'success';
                $response['message'] = 'Subscribed.';
            }
        } else {
            $response['status'] = 'error';
            $response['message'] = 'Invalid E-Mail.';
        }
        $this->response->setOutput(json_encode($response));
    }

    public function unsubscribe() {

    }

}
