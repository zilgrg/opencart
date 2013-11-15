<?php
class ControllerModuleJournalProductTabs extends Controller {

	public function __construct($reg) {
		parent::__construct($reg);
		// load
		$this->load->language('module/journal_product_tabs');
		$this->load->model('journal/product_tabs');
        $this->load->model('localisation/language');

		$this->loadLanguageVars(array(
			'button_cancel',
			'button_create',
			'button_delete',
			'button_save',
			'doc_title',
            'entry_product',
		));

		// js consts
        $this->data['js_consts'] = array(
            'languages' => $this->model_localisation_language->getLanguages(),
            'lang_id'   => $this->config->get('config_language_id'),
            'token'     => $this->session->data['token'],
            'product_id'=> isset($this->request->get['product_id']) ? $this->request->get['product_id'] : null
        );
	}

	public function index() {
        $this->data['create'] = $this->url->link('module/journal_product_tabs/tab', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['delete'] = $this->url->link('module/journal_product_tabs/delete', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['products'] = $this->model_journal_product_tabs->getAll();
		$this->loadAssets();
        $this->document->addScript('view/javascript/journal/journal.js');
		$this->loadTemplate($this->language->get('doc_title'), 'module/journal_product_tabs_index.tpl');
	}

    public function tab() {
        $this->data['cancel'] = $this->url->link('module/journal_product_tabs', 'token=' . $this->session->data['token'], 'SSL');
        $this->loadAssets();
        $this->loadTemplate($this->language->get('doc_title'), 'module/journal_product_tabs_form.tpl');
    }

	public function install() {
        $this->model_journal_product_tabs->install();
    }

    public function uninstall() {
        $this->model_journal_product_tabs->uninstall();
    }

    public function save() {
        $this->load->language('module/journal_product_tabs');
        if ($this->user->hasPermission('modify', 'module/journal_product_tabs')) {
            // $this->session->data['success'] = $this->language->get('text_success');
            $res = array();
            $data = isset($this->request->post['data']) ? $this->request->post['data'] : array();
            $this->model_journal_product_tabs->save($data['product_id'], $data['tabs']);
            $status = 'success';
            $message = false;
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

        $product_id = isset($this->request->get['product_id']) ? $this->request->get['product_id'] : 0;

        $data = $this->model_journal_product_tabs->get($product_id);
        $data['global_tab'] = $product_id ? 0 : 1;

        $this->response->setOutput(json_encode(array(
            'status'    => 'success',
            'result'    => $data
        )));
    }

    public function products() {
        $json = array();

        if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_category_id'])) {
            $this->load->model('catalog/product');
            $this->load->model('catalog/option');

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

            $results = $this->model_journal_product_tabs->getProducts($data);

            foreach ($results as $result) {
                $json[] = array(
                    'product_id' => $result['product_id'],
                    'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                    'model'      => $result['model'],
                    'price'      => $result['price']
                );
            }
        }

        $this->response->setOutput(json_encode($json));
    }

    public function delete() {
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', 'module/journal_product_tabs')) {
            $selected = $this->request->post['selected'];
            foreach ($selected as $sel) {
                $this->model_journal_product_tabs->delete($sel);
            }
        }
        $this->redirect($this->url->link('module/journal_product_tabs', 'token=' . $this->session->data['token'], 'SSL'));
    }

    private function loadTemplate($title, $template) {
        // set template
        $this->document->setTitle($title);
        $this->template = $template;
        $this->children = array(
            'common/header',
            'common/footer'
        );

        // render template
        $this->response->setOutput($this->render());
    }

    private function loadAssets() {
        // import styles
        $this->document->addStyle('//fonts.googleapis.com/css?family=Oswald', 'stylesheet prefetch');
        $this->document->addStyle('view/javascript/journal/bootstrap/css/bootstrap.css');
        $this->document->addStyle('view/javascript/journal/jquery.switch/prettyCheckable.css');
        $this->document->addStyle('view/javascript/journal/jquery.switch/jquery.switch.css');
        $this->document->addStyle('view/stylesheet/journal/journal.css');
        // import scripts
        $this->document->addScript('view/javascript/journal/ckeditor/ckeditor.js');
        $this->document->addScript('view/javascript/journal/angular/angular.min.js');
        $this->document->addScript('view/javascript/journal/underscore-min.js');
        $this->document->addScript('view/javascript/journal/underscore.string.js');
        $this->document->addScript('view/javascript/journal/angular/ui-bootstrap-0.4.0.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/prettyCheckable.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/jquery.switch.min.js');
        $this->document->addScript('view/javascript/journal/journal_prod_tabs.js');
    }

    private function loadLanguageVars($vars = array()) {
        foreach ($vars as $var) {
            $this->data[$var] = $this->language->get($var);
        }
    }

}
?>