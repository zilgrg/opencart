<?php
class ControllerModuleJournal2BlogPosts extends Controller {

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
        $this->load->model('journal2/blog');


        if (self::$CACHEABLE === null) {
            self::$CACHEABLE = (bool)$this->journal2->settings->get('config_system_settings.blog_posts_cache');
        }
    }

    public function index($setting) {
        if (!defined('JOURNAL_INSTALLED')) {
            return;
        }

        if (!$this->model_journal2_blog->isEnabled()) {
            return;
        }

        Journal2::startTimer(get_class($this));

        /* get module data from db */
        $module_data = $this->model_journal2_module->getModule($setting['module_id']);
        if (!$module_data || !isset($module_data['module_data']) || !$module_data['module_data']) return;

        if (Journal2Utils::getProperty($module_data, 'module_data.disable_mobile') && (Journal2Cache::$mobile_detect->isMobile() && !Journal2Cache::$mobile_detect->isTablet()) && $this->journal2->settings->get('responsive_design')) {
            return;
        }

        $hash = isset($this->request->server['REQUEST_URI']) ? md5($this->request->server['REQUEST_URI']) : null;

        if (in_array($setting['position'], array('top', 'bottom'))) {
            $padding = $this->journal2->settings->get('module_margins', 20) . 'px';
            /* outer */
            $css = Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'module_data.background'));
            $css[] = 'padding-top: ' . Journal2Utils::getProperty($module_data, 'module_data.margin_top', 0) . 'px';
            $css[] = 'padding-bottom: ' . Journal2Utils::getProperty($module_data, 'module_data.margin_bottom', 0) . 'px';
            $this->journal2->settings->set('module_journal2_blog_posts_' . $setting['module_id'], implode('; ', $css));

            /* inner css */
            $css = array();
            if (Journal2Utils::getProperty($module_data, 'module_data.fullwidth')) {
                $css[] = 'max-width: 100%';
                $css[] = 'padding-left: ' . $padding;
                $css[] = 'padding-right: ' . $padding;
            } else {
                $css[] = 'max-width: ' . $this->journal2->settings->get('site_width', 1024) . 'px';
                $css = array_merge($css, Journal2Utils::getBackgroundCssProperties(Journal2Utils::getProperty($module_data, 'module_data.module_background')));
                if (Journal2Utils::getProperty($module_data, 'module_data.module_padding')) {
                    $this->data['gutter_on_class'] = 'gutter-on';
                    $css[] = 'padding: 20px';
                }
            }
            $this->data['css'] = implode('; ', $css);
        }

        $cache_property = "module_journal_blog_posts_{$setting['module_id']}_{$setting['layout_id']}_{$setting['position']}_{$hash}";

        $cache = $this->journal2->cache->get($cache_property);

        if ($cache === null || self::$CACHEABLE !== true || $hash === null) {
            $module = mt_rand();

            $this->data['hide_on_mobile_class'] = Journal2Utils::getProperty($module_data, 'module_data.disable_mobile') ? 'hide-on-mobile' : '';

            $this->data['module'] = $module;
            $this->data['heading_title'] = Journal2Utils::getProperty($module_data, 'module_data.title.value.' . $this->config->get('config_language_id'));
            $this->data['display'] = Journal2Utils::getProperty($module_data, 'module_data.display', 'grid');
            $this->data['content_align'] = Journal2Utils::getProperty($module_data, 'module_data.content_align', 'center');
            /* carousel */
            $this->data['carousel'] = Journal2Utils::getProperty($module_data, 'module_data.carousel');
            if ($this->data['carousel']) {
                $columns = in_array($setting['position'], array('top', 'bottom')) ? 0 : $this->journal2->settings->get('config_columns_count', 0);
                if ($this->data['display'] === 'list') {
                    $this->data['grid'] = array(
                        array(0,    1),
                        array(470,  1),
                        array(760,  1),
                        array(980,  1),
                        array(1100, 1)
                    );
                } else {
                    $this->data['grid'] = Journal2Utils::getItemGrid(Journal2Utils::getProperty($module_data, 'module_data.items_per_row.value'), $this->journal2->settings->get('site_width', 1024), $columns);
                    $this->data['grid'] = array(
                        array(0,    (int)$this->data['grid']['xs']),
                        array(470,  (int)$this->data['grid']['sm']),
                        array(760,  (int)$this->data['grid']['md']),
                        array(980,  (int)$this->data['grid']['lg']),
                        array(1100, (int)$this->data['grid']['xl'])
                    );
                }
                $this->data['arrows'] = Journal2Utils::getProperty($module_data, 'module_data.carousel_arrows');
                $this->data['bullets'] = Journal2Utils::getProperty($module_data, 'module_data.carousel_bullets');
                if (Journal2Utils::getProperty($module_data, 'module_data.autoplay')) {
                    $this->data['autoplay'] = Journal2Utils::getProperty($module_data, 'module_data.transition_delay', 3000);
                } else {
                    $this->data['autoplay'] = false;
                }
                $this->data['slide_speed'] = (int)Journal2Utils::getProperty($module_data, 'module_data.transition_speed', 400);
                $this->data['pause_on_hover'] = Journal2Utils::getProperty($module_data, 'module_data.pause_on_hover');
                $this->data['touch_drag'] = Journal2Utils::getProperty($module_data, 'module_data.touch_drag');
            }

            $module_type = Journal2Utils::getProperty($module_data, 'module_data.module_type', 'newest');
            $limit = Journal2Utils::getProperty($module_data, 'module_data.limit', 5);

            $posts = array();

            switch ($module_type) {
                case 'newest':
                case 'comments':
                case 'views':
                    $posts = $this->model_journal2_blog->getPosts(array(
                        'sort'          => $module_type,
                        'start'         => 0,
                        'limit'         => $limit
                    ));
                    break;
                case 'related':
                    if (isset($this->request->get['route']) && $this->request->get['route'] === 'product/product' && isset($this->request->get['product_id'])) {
                        $posts = $this->model_journal2_blog->getRelatedPosts($this->request->get['product_id'], $limit);
                    }
                    break;
                case 'custom':
                    $custom_posts = Journal2Utils::getProperty($module_data, 'module_data.posts', array());
                    $custom_posts_ids = array();
                    foreach ($custom_posts as $custom_post) {
                        $post_id = (int)Journal2Utils::getProperty($custom_post, 'data.id', 0);
                        if ($post_id) {
                            $custom_posts_ids[$post_id] = $post_id;
                        }
                    }
                    if ($custom_posts_ids) {
                        $posts = $this->model_journal2_blog->getPosts(array(
                            'post_ids' => implode(',', $custom_posts_ids)
                        ));
                    }
                    break;
            }

            if (!$posts) return;

            if (in_array($setting['position'], array('column_left', 'column_right'))) {
                $this->data['is_column'] = true;
                $this->data['grid_classes'] = 'xs-100 sm-100 md-100 lg-100 xl-100';
            } else {
                $this->data['is_column'] = false;
                $columns = in_array($setting['position'], array('top', 'bottom')) ? 0 : $this->journal2->settings->get('config_columns_count', 0);
                $this->data['grid_classes'] = Journal2Utils::getProductGridClasses(Journal2Utils::getProperty($module_data, 'module_data.items_per_row.value'), $this->journal2->settings->get('site_width', 1024), $columns);
            }

            $this->data['image_width']  = Journal2Utils::getProperty($module_data, 'module_data.image_width', 50);
            $this->data['image_height'] = Journal2Utils::getProperty($module_data, 'module_data.image_height', 50);
            $this->data['image_resize_type'] = Journal2Utils::getProperty($module_data, 'module_data.image_type', 'fit');

            $char_limit = Journal2Utils::getProperty($module_data, 'module_data.description_limit', 150);
            $show_description = Journal2Utils::getProperty($module_data, 'module_data.description', '1');

            $this->data['posts'] = array();
            foreach ($posts as $post) {
                $this->data['posts'][] = array(
                    'name'          => $post['name'],
                    'author'        => $this->model_journal2_blog->getAuthorName($post),
                    'comments'      => $post['comments'],
                    'description'   => $show_description ? utf8_substr(strip_tags(html_entity_decode($post['description'], ENT_QUOTES, 'UTF-8')), 0, $char_limit) . '...' : false,
                    'date'          => date($this->language->get('date_format_short'), strtotime($post['date'])),
                    'image'         => Journal2Utils::resizeImage($this->model_tool_image, $post['image'] ? $post['image'] : 'data/journal2/no_image_large.jpg', $this->data['image_width'], $this->data['image_height'], $this->data['image_resize_type']),
                    'href'          => $this->url->link('journal2/blog/post', 'journal_blog_post_id=' . $post['post_id'])
                );
            }

            $this->template = $this->config->get('config_template') . '/template/journal2/module/blog_posts.tpl';

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
