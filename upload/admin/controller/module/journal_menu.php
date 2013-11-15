<?php
class ControllerModuleJournalMenu extends Controller {

    public function __construct($reg){
        parent::__construct($reg);
    }

	public function index() {
        // import styles
        $this->document->addStyle('//fonts.googleapis.com/css?family=Oswald', 'stylesheet prefetch');
        $this->document->addStyle('view/javascript/journal/bootstrap/css/bootstrap.css');
        $this->document->addStyle('view/javascript/journal/jquery.switch/jquery.switch.css');
        $this->document->addStyle('view/stylesheet/journal/journal.css');

        // import scripts
        $this->document->addScript('view/javascript/journal/ckeditor/ckeditor.js');
        $this->document->addScript('view/javascript/journal/underscore-min.js');
        $this->document->addScript('view/javascript/journal/underscore.string.js');
        $this->document->addScript('view/javascript/journal/angular/angular.min.js');
        $this->document->addScript('view/javascript/journal/angular/ui-bootstrap-0.4.0.js');
        $this->document->addScript('view/javascript/journal/angular/directives.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/prettyCheckable.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/jquery.switch.min.js');
        $this->document->addScript('view/javascript/journal/journal_menu.js');

        // load stuff
        $this->load->model('localisation/language');
        $this->load->language('module/journal_menu');

        // multistore
        $this->load->model('setting/store');
        $stores = $this->model_setting_store->getStores();
        array_unshift($stores, array(
            'store_id' => 0,
            'name'     => $this->config->get('config_name'),
        ));

        // js consts
        $this->data['js_consts'] = array(
            'languages' => $this->model_localisation_language->getLanguages(),
            'stores'    => $stores,
            'lang_id'   => $this->config->get('config_language_id'),
            'token'     => $this->session->data['token']
        );

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        // load language vars
        $this->loadLanguageVars(array(
            'button_cancel',
            'button_save',
            'button_view_banners',

            'doc_title',
        ));

        // set template
        $this->document->setTitle($this->language->get('doc_title'));
        $this->template = 'module/journal_menu.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        // render template
        $this->response->setOutput($this->render());
    }

    private function loadLanguageVars($vars = array()) {
        foreach ($vars as $var) {
            $this->data[$var] = $this->language->get($var);
        }
    }

    public function categories() {
        $filter = isset($this->request->get['filter']) ? $this->request->get['filter'] : null;

        $res = array();

        if ($filter !== null) {
            $this->load->model('catalog/category');
            $this->load->model('journal/cp');

            $data = array(
                'filter_name' => $filter,
                'start'       => 0,
                'limit'       => 20
            );

            $results = $this->model_journal_cp->getProductCategories($data);

            foreach ($results as $result) {
                $res[] = array(
                    'category_id' => $result['category_id'],
                    'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->setOutput(json_encode(array(
            'status'    => 'success',
            'result'    => $res
        )));
    }

    public function brands() {
        $filter = isset($this->request->get['filter']) ? $this->request->get['filter'] : null;

        $res = array();

        if ($filter !== null) {
            $this->load->model('journal/cp');

            $data = array(
                'filter_name' => $filter,
                'start'       => 0,
                'limit'       => 20
            );

            $results = $this->model_journal_cp->getManufacturers($data);

            foreach ($results as $result) {
                $res[] = array(
                    'manufacturer_id' => $result['manufacturer_id'],
                    'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $this->response->setOutput(json_encode(array(
            'status'    => 'success',
            'result'    => $res
        )));
    }

    public function save() {
        $this->load->language('module/journal_menu');
        if ($this->user->hasPermission('modify', 'module/journal_menu')) {
            $this->session->data['success'] = $this->language->get('text_success');
            $res = array();
            $this->load->model('setting/setting');
            $data = isset($this->request->post['data']) ? $this->request->post['data'] : array();
            $store_id = isset($this->request->post['store_id']) ? $this->request->post['store_id'] : 0;
            $this->model_setting_setting->editSetting('journal_menu', array('journal_menu' => $data), $store_id);
            $status = 'success';
            $message = null;
        } else {
            $status = 'error';
            $message = $this->language->get('error_permission');
        }
        $this->response->setOutput(json_encode(array(
            'status'    => $status,
            'message'   => $message
        )));
    }

    public function load() {
        $res = array();

        $this->load->model('setting/setting');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/manufacturer');
        $store_id = isset($this->request->get['store_id']) ? $this->request->get['store_id'] : 0;
        $config = $this->model_setting_setting->getSetting('journal_menu', $store_id);

        if (isset($config['journal_menu']['tabs'])) {
            foreach ($config['journal_menu']['tabs'] as &$tab) {
                if (isset($tab['megamenu']) && isset($tab['megamenu']['categories'])) {
                    foreach ($tab['megamenu']['categories'] as &$categ) {
                        $result = $this->model_catalog_category->getCategory($categ['data']['category_id']);
                        $categ['data']['name'] = $result['name'];
                    }
                }
                if (isset($tab['products']) && isset($tab['products']['products'])) {
                    foreach ($tab['products']['products'] as &$product) {
                        $result = $this->model_catalog_product->getProduct($product['data']['product_id']);
                        $product['data']['name'] = $result['name'];
                    }
                }
                if (isset($tab['brands']) && isset($tab['brands']['brands'])) {
                    foreach ($tab['brands']['brands'] as &$brand) {
                        $result = $this->model_catalog_manufacturer->getManufacturer($brand['data']['manufacturer_id']);
                        $brand['data']['name'] = $result['name'];
                    }
                }
            }
        }

        $this->response->setOutput(json_encode(array(
            'status'    => 'success',
            'result'    => isset($config['journal_menu']) ? $config['journal_menu'] : array()
        )));
    }

}
?>