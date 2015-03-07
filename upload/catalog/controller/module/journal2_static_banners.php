<?php
/* @property ModelCatalogManufacturer model_catalog_manufacturer */
/* @property ModelCatalogCategory model_catalog_category */
class ControllerModuleJournal2StaticBanners extends Controller {

    private static $CACHEABLE = null;

    protected $data = array();

    protected function render() {
        return Front::$IS_OC2 ? $this->load->view($this->template, $this->data) : parent::render();
    }

    public function __construct($registry) {
        parent::__construct($registry);
        if (!defined('JOURNAL_INSTALLED')) {
            return;
        }
        $this->load->model('journal2/module');
        $this->load->model('journal2/menu');
        $this->load->model('tool/image');

        if (self::$CACHEABLE === null) {
            self::$CACHEABLE = (bool)$this->journal2->settings->get('config_system_settings.static_banners_cache');
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
        if (Journal2Utils::getProperty($module_data, 'disable_mobile') && (Journal2Cache::$mobile_detect->isMobile() && !Journal2Cache::$mobile_detect->isTablet()) && $this->journal2->settings->get('responsive_design')) {
            return;
        }

        /* css for top / bottom positions */
        if (in_array($setting['position'], array('top', 'bottom'))) {
            $padding = $this->journal2->settings->get('module_margins', 20) . 'px';
            /* outer */
            $css = Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'background'));
            $css[] = 'padding-top: ' . Journal2Utils::getProperty($module_data, 'margin_top', 0) . 'px';
            $css[] = 'padding-bottom: ' . Journal2Utils::getProperty($module_data, 'margin_bottom', 0) . 'px';
            $this->journal2->settings->set('module_journal2_static_banners_' . $setting['module_id'], implode('; ', $css));

            /* inner css */
            $css = array();
            if (Journal2Utils::getProperty($module_data, 'fullwidth')) {
                $css[] = 'max-width: 100%';
                $css[] = 'padding-left: ' . $padding;
                $css[] = 'padding-right: ' . $padding;
            } else {
                $css[] = 'max-width: ' . $this->journal2->settings->get('site_width', 1024) . 'px';
                $css = array_merge($css, Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'module_background')));
                if (Journal2Utils::getProperty($module_data, 'module_padding')) {
                    $this->data['gutter_on_class'] = 'gutter-on';
                    $css[] = 'padding: 20px';
                }
            }
            $this->data['css'] = implode('; ', $css);
        }

        $cache_property = "module_journal_static_banners_{$setting['module_id']}_{$setting['layout_id']}_{$setting['position']}";

        $cache = $this->journal2->cache->get($cache_property);

        if ($cache === null || self::$CACHEABLE !== true) {
            $module = mt_rand();

            $this->data['hide_on_mobile_class'] = Journal2Utils::getProperty($module_data, 'disable_mobile') ? 'hide-on-mobile' : '';

            /* set global module properties */
            $this->data['module'] = $module;
            $this->data['title'] = Journal2Utils::getProperty($module_data, 'module_title.value.' . $this->config->get('config_language_id'), '');

            /* icon */
            $this->data['icon'] = Journal2Utils::getIconOptions2(Journal2Utils::getProperty($module_data, 'icon'));

            /* bgcolor*/
            $this->data['bgcolor'] = Journal2Utils::getProperty($module_data, 'bgcolor.value.color');

            /* image border */
            $this->data['image_border'] = implode('; ', Journal2Utils::getBorderCssProperties(Journal2Utils::getProperty($module_data, 'image_border')));

            /* sort sections */
            $sections = Journal2Utils::getProperty($module_data, 'sections', array());
            $sections = Journal2Utils::sortArray($sections);

            /* generate sections */
            $this->data['sections'] = array();
            foreach ($sections as $section) {
                if (!$section['status']) continue;
                $image = Journal2Utils::getProperty($section, 'image');
                if (is_array($image)) {
                    $image = Journal2Utils::getProperty($image, $this->config->get('config_language_id'));
                }
                if (!$image || !file_exists(DIR_IMAGE . $image)) {
                    $image = Front::$IS_OC2 ? 'no_image.png' : 'no_image.jpg';
                }
                list($width, $height) = getimagesize(DIR_IMAGE . $image);
                $this->data['sections'][] = array(
                    'type'          => 'image',
                    'link'          => $this->model_journal2_menu->getLink(Journal2Utils::getProperty($section, 'link')),
                    'target'        => Journal2Utils::getProperty($section, 'link_new_window') ? 'target="_blank"' : '',
                    'image'         => Journal2Utils::resizeImage($this->model_tool_image, $image),
                    'image_width'   => $width,
                    'image_height'  => $height
                );
            }

            /* grid classes */
            if (in_array($setting['position'], array('column_left', 'column_right'))) {
                $this->data['grid_classes'] = 'xs-100 sm-100 md-100 lg-100 xl-100';
            } else {
                $columns = in_array($setting['position'], array('top', 'bottom')) ? 0 : $this->journal2->settings->get('config_columns_count', 0);
                $this->data['grid_classes'] = Journal2Utils::getProductGridClasses(Journal2Utils::getProperty($module_data, 'items_per_row.value'), $this->journal2->settings->get('site_width', 1024), $columns);
            }

            $this->template = $this->config->get('config_template') . '/template/journal2/module/static_banners.tpl';

            if (self::$CACHEABLE === true) {
                $html = Minify_HTML::minify($this->render(), array(
                    'xhtml' => false,
                    'jsMinifier' => 'j2_js_minify'
                ));
                $this->journal2->cache->set($cache_property, $html);
            }
        } else {
            $this->template = $this->config->get('config_template') . '/template/journal2/cache/cache.tpl';
            $this->data['cache'] = $cache;
        }

        $output = $this->render();

        Journal2::stopTimer(get_class($this));

        return $output;
    }

}
