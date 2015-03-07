<?php  
class ControllerModuleJournal2SuperFilter extends Controller {

    private $filters;
    private static $IMG_WIDTH = 69;
    private static $IMG_HEIGHT = 69;

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
        $this->load->model('journal2/product');
        $this->load->model('journal2/super_filter');
        $this->load->model('tool/image');
        $this->language->load('product/category');
    }

    public function index($setting) {
        if (!defined('JOURNAL_INSTALLED')) {
            return;
        }

        Journal2::startTimer(get_class($this));
        
        if (!isset($this->request->get['route'])) {
            return;
        }

         switch ($this->request->get['route']) {
            case 'product/category':
                if(!isset($this->request->get['path'])) return;
                $path = explode('_', $this->request->get['path']);
                $data = array('filter_category_id' => end($path));
                $this->load->model('catalog/product');
                if($this->model_catalog_product->getTotalProducts($data) == 0) return;
                break;
            case 'product/manufacturer/info':
                if(!isset($this->request->get['manufacturer_id'])) return;
                break;
            case 'product/search':
                if(!isset($this->request->get['search']) && !isset($this->request->get['tag'])) return;
                break;
            case 'product/special':
                $this->load->model('catalog/product');
                if($this->model_catalog_product->getTotalProductSpecials() == 0) return;
                break;
            default:
                return;
        }

        if (Journal2Cache::$mobile_detect->isMobile() && !Journal2Cache::$mobile_detect->isTablet() && $this->journal2->settings->get('responsive_design')) return;
        if (!isset($setting['module_id'])) return;
        $this->journal2->settings->set('config_j2sf', 'on');
        $output = $this->getFilters((int)$setting['module_id']);
        $this->document->addScript('catalog/view/theme/journal2/lib/jquery.address/jquery.address.js');

        Journal2::stopTimer(get_class($this));

        return $output;
    }

    public function filters() {
        if (!isset($this->request->get['module_id'])) return;
        $this->getFilters((int)$this->request->get['module_id'], TRUE);
    }

    protected function getFilters($module_id, $ajax = FALSE) {
        /* get module data from db */
        $module_data = $this->model_journal2_module->getModule($module_id);
        if (!$module_data || !isset($module_data['module_data']) || !$module_data['module_data']) return;
        $module_data = $module_data['module_data'];
        $this->filters = $module_data;

        /* set global variables */
        $this->data['ajax'] = $ajax;
        $this->data['filter_action_url'] = 'index.php?route=module/journal2_super_filter/filters&amp;module_id=' . $module_id;
        $this->data['products_action_url'] = 'index.php?route=module/journal2_super_filter/products&amp;module_id=' . $module_id;
        $this->data['module_id'] = $module_id;

        /* quick error fix */
        $this->data['manufacturer_id'] = '';
        $this->data['search'] = '';
        $this->data['tag'] = '';

        /* reset button */
        $this->data['reset'] = Journal2Utils::getProperty($module_data, 'reset');
        $this->data['reset_btn_text'] = $this->journal2->settings->get('filter_reset_text');
        $this->data['loading_text'] = $this->journal2->settings->get('filter_loading_text');

        /* current currency */
        $this->data['currency_left'] = $this->currency->getSymbolLeft();
        $this->data['currency_right'] = $this->currency->getSymbolRight();
        $this->data['currency_decimal'] = $this->language->get('decimal_point');
        $this->data['currency_thousand'] = $this->language->get('thousand_point');

        /* price filter */
        $this->data['price_filter'] = Journal2Utils::getProperty($module_data, 'price');

        /* labels */
        $this->load->language('common/footer');
        $this->load->language('module/category');
        $this->data['text_manufacturers'] = trim($this->language->get('text_manufacturer'), ': ');
        $this->data['text_categories'] = trim($this->language->get('heading_title'), ': ');
        $this->data['text_price'] = trim($this->language->get('text_price'), ': ');
        $this->data['text_tags']  = trim($this->language->get('text_tags'), ': ');

        /* image width / height */
        $this->data['image_width'] = self::$IMG_WIDTH;
        $this->data['image_height'] = self::$IMG_HEIGHT;

        $data = array();

        if ($ajax) {
            $this->data['route'] = $this->request->post['route'];
            $this->data['path'] = $this->request->post['path'];
            $data = $this->parseUrl();
        }else{
            if (isset($this->request->get['path'])) {
                $parts = explode('_', (string)$this->request->get['path']);
            } else {
                $parts = array();
            }
            $category_id = end($parts);

            if ($category_id) {
                $this->data['path'] = $category_id;
                $data['path'] = $category_id;
            }else{
                $this->data['path'] = "";
            }

            if (isset($this->request->get['category_id'])) {
                $data['path'] = $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category']) && $this->request->get['sub_category'] == 'true') {
                $data['filter_sub_category'] = 1;
            }  

            if (isset($this->request->get['manufacturer_id'])) {
                $this->data['manufacturer_id'] = $this->request->get['manufacturer_id'];
                $data['manufacturers'][] = $this->request->get['manufacturer_id'];
            }else{
                $this->data['manufacturer_id'] = "";
            }

            if (isset($this->request->get['search'])) {
                $this->data['search'] = $this->request->get['search'];
                $data['search'] = $this->request->get['search'];
            }else{
                $this->data['search'] = "";
            }

            $data['description'] = (isset($this->request->get['description']) && $this->request->get['description'] == true) ? 1 : 0;

            if (isset($this->request->get['tag'])) {
                $this->data['tag'] = $this->request->get['tag'];
                $data['tags'][] = $this->request->get['tag'];
            }else{
                $this->data['tag'] = "";
            }

            $this->data['route'] = $this->request->get['route'];
            $data['route'] = $this->data['route'];

            if ($this->data['route'] == 'product/special') {
                $data['special'] = 1;
            }
        }

        $show_product_count = (int)Journal2Utils::getProperty($module_data, 'product_count', 1);

        /* filter groups */
        $filter_groups = array();

        /* categories */
        $this->data['category_display_mode'] = $module_data['category'];
        $this->data['category_type'] = $module_data['category_type'];
        $this->data['categories'] = array();

        if ($module_data['category'] != 'off') {
            $results = $this->model_journal2_super_filter->getCategories($data);
            foreach ($results as $result) {
                $this->data['categories'][] = array(
                    'category_id'	=> $result['category_id'],
                    'name'		    => trim($result['name']) . ( $show_product_count ? ' (' . $result['total'] . ')' : ''),
                    'image'         => $this->model_tool_image->resize($result['image'] ? $result['image'] : (Front::$IS_OC2 ? 'placeholder.png' : 'no_image.jpg'), self::$IMG_WIDTH, self::$IMG_HEIGHT),
                    'keyword'		=> $this->keyword($result['name'])
                );
            }
            if ($this->data['categories']) {
                $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_categories.tpl';
                $filter_groups[] = array(
                    'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.c'),
                    'html'          => $this->render()
                );
            }
        }

        /* manufacturers */
        $this->data['manufacturer_display_mode'] = $module_data['manufacturer'];
        $this->data['manufacturer_type'] = $module_data['manufacturer_type'];
        $this->data['manufacturers'] = array();

        if ($module_data['manufacturer'] !== 'off' && $data['route'] !== 'product/manufacturer/info') {
            $results = $this->model_journal2_super_filter->getManufacturers($data);
            foreach ($results as $result) {
                $this->data['manufacturers'][] = array(
                    'manufacturer_id'	=> $result['manufacturer_id'],
                    'name'			    => trim($result['name']) . ( $show_product_count ? ' (' . $result['total'] . ')' : ''),
                    'image'             => $this->model_tool_image->resize($result['image'] ? $result['image'] : (Front::$IS_OC2 ? 'placeholder.png' : 'no_image.jpg'), self::$IMG_WIDTH, self::$IMG_HEIGHT),
                    'keyword'			=> $this->keyword($result['name'])
                );
            }
            if ($this->data['manufacturers']) {
                $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_manufacturers.tpl';
                $filter_groups[] = array(
                    'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.m'),
                    'html'          => $this->render()
                );
            }
        }

        /* attributes */
        $results = $this->model_journal2_super_filter->getAttributes($data);
        foreach ($results as $key => $result) {
            $display_mode = Journal2Utils::getProperty($module_data, 'attributes.' . $key, 'on');
            if ($display_mode === 'off') {
                continue;
            }
            $values = array();
            foreach ($result['values'] as $value) {
                $values[] = array(
                    'text'		=> rawurlencode(trim($value['text'])),
                    'name'		=> trim($value['text']) . ( $show_product_count ? ' (' . $value['total'] . ')' : ''),
                    'keyword'	=> $this->keyword($result['attribute_name'] . " " . $value['text'])
                );
            }
            $this->data['attribute'] = array(
                'attribute_id'		=> $result['attribute_id'],
                'attribute_name'	=> $result['attribute_name'],
                'display_mode'		=> $display_mode,
                'type'              => Journal2Utils::getProperty($module_data, 'attributes_type.' . $key, 'single'),
                'values'			=> $values,
            );
            $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_attributes.tpl';
            $filter_groups[] = array(
                'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.a_' . $result['attribute_id']),
                'html'          => $this->render()
            );
        }

        /* options */
        $results = $this->model_journal2_super_filter->getOptions($data);
        $this->data['options'] = array();
        foreach ($results as $key => $result) {
            $display_mode = Journal2Utils::getProperty($module_data, 'options.' . $key, 'list');
            if ($display_mode === 'off') {
                continue;
            }
            $values = array();
            foreach ($result['values'] as $value) {
                $values[] = array(
                    'option_value_id'	=> $value['option_value_id'],
                    'option_value_name'	=> trim($value['option_value_name']) . ( $show_product_count ? ' (' . $value['total'] . ')' : ''),
                    'image'				=> $this->model_tool_image->resize($value['image'] ? $value['image'] : (Front::$IS_OC2 ? 'placeholder.png' : 'no_image.jpg'), self::$IMG_WIDTH, self::$IMG_HEIGHT),
                    'keyword'			=> $this->keyword($result['option_name'] . " " .$value['option_value_name'])
                );
            }
            $this->data['option'] = array(
                'option_id'		=> $result['option_id'],
                'option_name'	=> $result['option_name'],
                'display_mode'	=> $display_mode,
                'type'          => Journal2Utils::getProperty($module_data, 'options_type.' . $key, 'single'),
                'values'		=> $values,
            );
            $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_options.tpl';
            $filter_groups[] = array(
                'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.o_' . $result['option_id']),
                'html'          => $this->render()
            );
        }

        if (Journal2Utils::getProperty($module_data, 'tags') && !isset($this->request->get['tag'])) {
            $results = $this->model_journal2_super_filter->getTags($data);
            foreach ($results as $result) {
                $this->data['tags'][] = array(
                    'text'      => trim($result['name']),
                    'name'      => trim($result['name']) . ( $show_product_count ? ' (' . $result['total'] . ')' : ''),
                    'keyword'   => $this->keyword($result['name'])
                );
            }
            if (isset($this->data['tags'])) {
                $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_tags.tpl';
                $filter_groups[] = array(
                    'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.t'),
                    'html'          => $this->render()
                );
            }
        }

        // Availability
        if (Journal2Utils::getProperty($module_data, 'availability')) {
            $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_availability.tpl';
            $this->data['availability_yes'] = false;
            $this->data['availability_no'] = false;
            $filter_groups[] = array(
                'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.a'),
                'html'          => $this->render()
            );
        }

        // Price
        $results = $this->model_journal2_super_filter->getPrice($data);

        if ($results) {
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $this->data['min_price'] = floor($this->tax->calculate($results['min'], $module_data['tax_class_id'], $this->config->get('config_tax')) * $this->currency->getValue());
                $this->data['max_price'] =  ceil($this->tax->calculate($results['max'], $module_data['tax_class_id'], $this->config->get('config_tax')) * $this->currency->getValue());
            } else {
                $this->data['price_filter'] = false;
                $this->data['min_price'] = false;
                $this->data['max_price'] = false;
            }
        }

        if($this->data['min_price'] == $this->data['max_price']){
            $this->data['price_filter'] = false;
        }

        if ($this->data['price_filter']) {
            $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_price.tpl';
            $filter_groups[] = array(
                'sort_order'    => Journal2Utils::getProperty($module_data, 'sort_orders.p'),
                'html'          => $this->render()
            );
        }

        if (!count($filter_groups) && $this->data['price_filter'] === false) {
            return;
        }

        $this->data['filter_groups'] = Journal2Utils::sortArray($filter_groups);

        $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter.tpl';

        if ($ajax) {
            $this->response->setOutput($this->render());
        }else{
            return $this->render();
        }
    }

    private function parseUrl(){
        $categories = array();
        $manufacturers = array();
        $options = array();
        $attributes = array();
        $tags = array();
        $availability = array();

        $filters = $this->filters;

        foreach (explode("/", $this->request->post['filters']) as $fragment) {
            // $fragment = rawurldecode($fragment);

            $pattern = '/-c(((\d+)(,*))+)/';
            if (preg_match($pattern, $fragment)) {
                preg_match($pattern, $fragment, $values);
                foreach (explode(",", $values[1]) as $value) {
                    $categories[] = $value;
                }
                continue;
            }

            $pattern = '/-m(((\d+)(,*))+)/';
            if (preg_match($pattern, $fragment)) {
                preg_match($pattern, $fragment, $values);
                foreach (explode(",", $values[1]) as $value) {
                    $manufacturers[] = $value;
                }
            }

            $pattern = '/-a(\d+)-v/';
            if (preg_match($pattern, $fragment)) {
                $text = preg_split($pattern, $fragment);
                $text = $text[1];
                preg_match($pattern , $fragment, $attribute_id);
                $attribute_id = $attribute_id[1];
                $attributes[$attribute_id] = array();
                foreach (explode(",", $text) as $a) {
                	$attributes[$attribute_id][] = rawurldecode($a);
                }
            }

            $pattern = '/-o(\d+)-v/';
            if (preg_match($pattern, $fragment)) {
                $option_value_id = preg_split($pattern, $fragment);
                $option_value_id = $option_value_id[1];
                preg_match($pattern , $fragment, $option_id);
                $option_id = $option_id[1];
                $options[$option_id][] = array('option_id' => $option_id, 'option_value_id' => $option_value_id);
            }

            $pattern = '/(.+)-tags/';
            if (preg_match($pattern, $fragment)) {
                preg_match($pattern, $fragment, $values);
                foreach (explode(",", $values[1]) as $value) {
                    $tags[] = $value;
                }
            }

            $pattern = '/availability=(.+)/';
            if (preg_match($pattern, $fragment)) {
                preg_match($pattern, $fragment, $values);
                foreach (explode(",", $values[1]) as $value) {
                    $availability[$value] = $value;
                }
                $availability = array_values($availability);
            }

            if (preg_match("/sort=/", $fragment)) {
                $sort = str_replace("sort=", "", $fragment);
                continue;
            }

            if (preg_match("/limit=/", $fragment)) {
                $limit = str_replace("limit=", "", $fragment);
                continue;
            }

            if (preg_match("/page=/", $fragment)) {
                $page = str_replace("page=", "", $fragment);
                continue;
            }

            if (preg_match("/order=/", $fragment)) {
                $order = str_replace("order=", "", $fragment)	;
                continue;
            }

            if (preg_match("/minPrice=/", $fragment)) {
                $minPrice = str_replace("minPrice=", "", $fragment)	;
                continue;
            }

            if (preg_match("/maxPrice=/", $fragment)) {
                $maxPrice = str_replace("maxPrice=", "", $fragment)	;
                continue;
            }
        }

        if (!isset($sort)) {
            $sort = 'p.sort_order';
        }

        if (!isset($order)) {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        }

        if (!isset($page)) {
            $page = '1';
        }

        if (!isset($limit)) {
            $limit = $this->config->get('config_catalog_limit');
        }

        if (!isset($limit)) {
            $limit = $this->config->get('config_catalog_limit');
        }

        $minPrice = isset($minPrice) ? $this->undoTax($minPrice / $this->currency->getValue(), $filters['tax_class_id']) : -1;
        $maxPrice = isset($maxPrice) ? $this->undoTax($maxPrice / $this->currency->getValue(), $filters['tax_class_id']) : -1;

        $data = array(
            'categories' 		=> $categories,
            'manufacturers' 	=> $manufacturers,
            'attributes'		=> $attributes,
            'options'			=> $options,
            'tags'              => $tags,
            'availability'      => $availability,
            'minPrice'			=> $minPrice,
            'maxPrice'			=> $maxPrice,
            'sort' 				=> $sort,
            'limit' 			=> $limit,
            'order'				=> $order,
            'page'				=> $page,
            'start'             => ($page - 1) * $limit,
            'route' 			=> $this->request->post['route'],
        );
        if (isset($this->request->post['manufacturer_id']) && strlen($this->request->post['manufacturer_id']) > 0) {
            $data['manufacturers'][] = $this->request->post['manufacturer_id'];
            $data['manufacturer_id'] = $this->request->post['manufacturer_id'];
        }

        if (isset($this->request->post['path']) && strlen($this->request->post['path'] > 0)) {
            $data['path'] = $this->request->post['path'];
        }

        if (isset($this->request->post['category_id'])) {
            $data['path'] = $this->request->post['category_id'];
        }

        if (isset($this->request->get['sub_category']) && $this->request->get['sub_category'] == 'true') {
            $data['filter_sub_category'] = 1;
        }        

        if ($data['route'] == 'product/special') {
            $data['special'] = 1;
        }

        if (isset($this->request->post['search']) && strlen($this->request->post['search']) > 0) {
            $data['search'] = $this->request->post['search'];
        }

        if (isset($this->request->post['description'])) {
            $data['description'] = $this->request->post['description'];
        }

        if (isset($this->request->post['tag']) && strlen($this->request->post['tag']) > 0) {
            $data['tags'][] = $this->request->post['tag'];
        }

        return $data;
    }

    private function keyword($str, $delimiter = '-'){
        $str = preg_replace('/[^\p{L}\p{Nd}]+/u', $delimiter, $str);
        $str = preg_replace('/(' . preg_quote($delimiter, '/') . '){2,}/', '$1', $str);
        $str = trim($str, $delimiter);
        $str = mb_strtolower($str, 'UTF-8');
        return $str;
    }

    private function undoTax($value, $tax_class_id) {
        if (!$tax_class_id) {
            return $value;
        }
        return $this->model_journal2_super_filter->getRates($value, $tax_class_id);
    }

    public function products() {
        if (!isset($this->request->get['module_id'])) return;
        /* get module data from db */
        $module_data = $this->model_journal2_module->getModule((int)$this->request->get['module_id']);
        if (!$module_data || !isset($module_data['module_data']) || !$module_data['module_data']) return;
        $module_data = $module_data['module_data'];
        $this->filters = $module_data;

        $this->data['text_refine'] = $this->language->get('text_refine');
        $this->data['text_empty'] = $this->language->get('text_empty');
        $this->data['text_quantity'] = $this->language->get('text_quantity');
        $this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $this->data['text_model'] = $this->language->get('text_model');
        $this->data['text_price'] = $this->language->get('text_price');
        $this->data['text_tax'] = $this->language->get('text_tax');
        $this->data['text_points'] = $this->language->get('text_points');

        $this->data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['text_display'] = $this->language->get('text_display');
        $this->data['text_list'] = $this->language->get('text_list');
        $this->data['text_grid'] = $this->language->get('text_grid');
        $this->data['text_sort'] = $this->language->get('text_sort');
        $this->data['text_limit'] = $this->language->get('text_limit');


        $this->data['button_cart'] = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare'] = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['compare'] = $this->url->link('product/compare');

        $this->data['products'] = array();

        $data = $this->parseUrl();

        $product_total = $this->model_journal2_super_filter->getTotalProducts($data);

        $results = $this->model_journal2_super_filter->getProductsWithData($data);

        $url = '';

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
            } else {
                $image = $this->model_tool_image->resize(Front::$IS_OC2 ? 'placeholder.png' : 'no_image.jpg', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
            }

            $image2 = false;

            $results = $this->model_catalog_product->getProductImages($result['product_id']);
            if (count($results) > 0) {
                $image2 = $this->model_tool_image->resize($results[0]['image'] ? $results[0]['image'] : (Front::$IS_OC2 ? 'placeholder.png' : 'no_image.jpg'), $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
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

            switch ($data['route']) {
                case 'product/category':
                    $href = $this->url->link('product/product', 'path=' . $data['path'] . '&product_id=' . $result['product_id'] . $url);
                    break;
                case 'product/manufacturer':
                    $href = $this->url->link('product/product', '&manufacturer_id=' . $data['manufacturer_id'] . '&product_id=' . $result['product_id'] . $url);
                    break;
                default :
                    $href = $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url);
                    break;
            }

            $date_end = false;
            if ($special && $this->journal2->settings->get('show_countdown', 'never') !== 'never') {
                $this->load->model('journal2/product');
                $date_end = $this->model_journal2_product->getSpecialCountdown($result['product_id']);
                if ($date_end === '0000-00-00') {
                    $date_end = false;
                }
            }

            $this->data['products'][] = array(
                'product_id'  => $result['product_id'],
                'thumb'       => $image,
                'thumb2'      => $image2,
                'name'        => $result['name'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                'price'       => $price,
                'special'     => $special,
                'date_end'    => $date_end,
                'tax'         => $tax,
                'rating'      => $result['rating'],
                'reviews'     => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                'href'        => $href,
                'labels'      => $this->model_journal2_product->getLabels($result['product_id'])
            );
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page = $data['page'];
        $pagination->limit = $data['limit'];
        $pagination->text = $this->language->get('text_pagination');

        switch ($data['route']) {
            case 'product/category':
                $route = 'product/category';
                $pagination->url = $this->url->link('product/category', 'path=' . $data['path'] . $url . '&page={page}');
                break;
            case 'product/manufacturer/info':
                $route = 'product/manufacturer/info';
                $pagination->url = $this->url->link('product/manufacturer/info','manufacturer_id=' . $data['manufacturer_id'] .  $url . '&page={page}');
                break;
            case 'product/search':
                $route = 'product/search';
                $pagination->url = $this->url->link('product/search', $url . '&page={page}');
                break;
            case 'product/special':
                $route = 'product/special';
                $pagination->url = $this->url->link('product/special', $url . '&page={page}');
                break;
        }

        $this->data['pagination'] = $pagination->render();

        if (Front::$IS_OC2) {
            $this->data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($data['page'] - 1) * $data['limit']) + 1 : 0, ((($data['page'] - 1) * $data['limit']) > ($product_total - $data['limit'])) ? $product_total : ((($data['page'] - 1) * $data['limit']) + $data['limit']), $product_total, ceil($product_total / $data['limit']));
        }


        $this->data['order'] = $data['order'];

        $this->data['sort'] = $data['sort'];

        $this->data['sorts'] = array();

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_default'),
            'value' => 'p.sort_order-ASC',
            'href'  => $this->url->link($route, 'sort=p.sort_order&order=ASC' . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_name_asc'),
            'value' => 'pd.name-ASC',
            'href'  => $this->url->link($route, 'sort=pd.name&order=ASC' . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_name_desc'),
            'value' => 'pd.name-DESC',
            'href'  => $this->url->link($route, 'sort=pd.name&order=DESC' . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_price_asc'),
            'value' => 'p.price-ASC',
            'href'  => $this->url->link($route, 'sort=p.price&order=ASC' . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_price_desc'),
            'value' => 'p.price-DESC',
            'href'  => $this->url->link($route, 'sort=p.price&order=DESC' . $url)
        );

        if ($this->config->get('config_review_status')) {
            $this->data['sorts'][] = array(
                'text'  => $this->language->get('text_rating_desc'),
                'value' => 'rating-DESC',
                'href'  => $this->url->link($route, 'sort=rating&order=DESC' . $url)
            );

            $this->data['sorts'][] = array(
                'text'  => $this->language->get('text_rating_asc'),
                'value' => 'rating-ASC',
                'href'  => $this->url->link($route, 'sort=rating&order=ASC' . $url)
            );
        }

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_model_asc'),
            'value' => 'p.model-ASC',
            'href'  => $this->url->link($route, 'sort=p.model&order=ASC' . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_model_desc'),
            'value' => 'p.model-DESC',
            'href'  => $this->url->link($route, 'sort=p.model&order=DESC' . $url)
        );

        $this->data['limit'] = $data['limit'];

        $this->data['limits'] = array();

        $limits = array_unique(array($this->config->get('config_catalog_limit'), 25, 50, 75, 100));

        sort($limits);

        foreach($limits as $limit){
            $this->data['limits'][] = array(
                'text'  => $limit,
                'value' => $limit,
                'href'  => $this->url->link($route, $url . '&limit=' . $limit)
            );
        }

        $this->data['continue'] = $this->url->link('common/home');

        $this->template = $this->config->get('config_template') . '/template/journal2/module/super_filter_product.tpl';

        $this->response->setOutput($this->render());
    }
}
