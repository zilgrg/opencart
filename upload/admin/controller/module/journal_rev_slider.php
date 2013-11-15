<?php
class ControllerModuleJournalRevSlider extends Controller {

    public function __construct($reg){
        parent::__construct($reg);
        $this->language->load('module/journal_rev_slider');
        $this->load->model('journal/rev_slider');
        $this->load->model('journal/cp');

        // language vars
        $this->loadLanguageVars(array(
            'button_cancel',
            'button_delete',
            'button_edit',
            'button_save',

            'column_category',
            'column_action',

            'doc_title',

            'entry_slider',
            'entry_layout',
            'entry_position',
            'entry_status',
            'entry_sort_order',

            'tab_active',
            'tab_list',

            'text_image_manager',
            'text_no_results',
            'text_enabled',
            'text_disabled',
            'text_column_left',
            'text_column_right',
            'text_content_top',
            'text_content_bottom'
        ));

        // image folder
        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $image_folder = HTTPS_CATALOG . 'image/';
        } else {
            $image_folder = HTTP_CATALOG . 'image/';
        }

        // js consts
        $this->data['consts'] = array(
            'token'                     => $this->session->data['token'],

            'image_url'                 => $image_folder,

            'extensions_url'            => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'active_url'                => $this->url->link('module/journal_rev_slider', 'token=' . $this->session->data['token'], 'SSL'),
            'list_url'                  => $this->url->link('module/journal_rev_slider/sliders', 'token=' . $this->session->data['token'], 'SSL'),
            'edit_url'                  => $this->url->link('module/journal_rev_slider/slider', 'token=' . $this->session->data['token'], 'SSL'),

            'save_slider_url'           => $this->url->link('module/journal_rev_slider/save_slider', 'token=' . $this->session->data['token'], 'SSL'),
            'get_slider_url'            => $this->url->link('module/journal_rev_slider/get_slider', 'token=' . $this->session->data['token'], 'SSL'),

            'delete_sliders_url'        => $this->url->link('module/journal_rev_slider/delete_sliders', 'token=' . $this->session->data['token'], 'SSL'),
            'get_sliders_url'           => $this->url->link('module/journal_rev_slider/get_sliders', 'token=' . $this->session->data['token'], 'SSL'),

            'save_modules_url'          => $this->url->link('module/journal_rev_slider/save_modules', 'token=' . $this->session->data['token'], 'SSL'),
            'get_modules_url'           => $this->url->link('module/journal_rev_slider/get_modules', 'token=' . $this->session->data['token'], 'SSL'),
            'get_fonts_url'           => $this->url->link('module/journal_rev_slider/get_fonts', 'token=' . $this->session->data['token'], 'SSL'),
        );
    }

    /* show all active sliders */
	public function index() {
        $this->loadAssets();
        $this->loadTemplate($this->language->get('doc_title'), 'module/journal_rev_slider_index.tpl');
    }

    /* show created sliders */
    public function sliders() {
        $this->loadAssets();
        $this->loadTemplate($this->language->get('doc_title'), 'module/journal_rev_slider_sliders.tpl');
    }

    /* get all sliders json */
    public function get_sliders() {
        $this->response->setOutput(json_encode(array(
            'sliders'   => $this->model_journal_rev_slider->getSliders(),
        )));
    }

    /* delete sliders by ids */
    public function delete_sliders() {
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', 'module/journal_rev_slider')) {
            $ids = explode(',', $this->request->post['slider_ids']);
            foreach ($ids as $id) {
                $this->model_journal_rev_slider->deleteSlider($id);
            }
            $this->response->setOutput(json_encode(array(
                'status' => 'ok'
            )));
        } else {
            $this->response->setOutput(json_encode(array(
                'error' => true
            )));
        }
    }

    /* get active modules json */
    public function get_modules() {
        $this->load->model('design/layout');
        $this->response->setOutput(json_encode(array(
            'layouts'   => $this->model_design_layout->getLayouts(),
            'sliders'   => $this->model_journal_rev_slider->getSliders(),
            'modules'   => $this->config->get('journal_rev_slider_module')
        )));
    }

    /* save active modules */
    public function save_modules() {
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', 'module/journal_rev_slider')) {
            $this->load->model('setting/setting');
            $this->model_setting_setting->editSetting('journal_rev_slider', array('journal_rev_slider_module' => $this->request->post['data']));
            $this->response->setOutput(json_encode(array(
                'data' => $this->request->post['data']
            )));
        } else {
            $this->response->setOutput(json_encode(array(
                'error' => true
            )));
        }
    }

    public function slider() {
        if(isset($this->request->get['slider_id'])) {
            $id = $this->request->get['slider_id'];
            $this->data['consts']['get_slider_url'] .= '&slider_id=' . $id;
            $this->data['consts']['save_slider_url'] .= '&slider_id=' . $id;
        } else {
            $this->data['consts']['get_slider_url'] = null;
        }

        $this->loadAssets();
        $this->loadTemplate($this->language->get('doc_title'), 'module/journal_rev_slider_form.tpl');
    }

    public function save_slider(){
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->user->hasPermission('modify', 'module/journal_rev_slider')) {
            $data = $this->request->post['data'];
            if(isset($this->request->get['slider_id'])) {
                $id = $this->request->get['slider_id'];
                $this->model_journal_rev_slider->editSlider($id, $data);
            } else {
                $id = $this->model_journal_rev_slider->addSlider($data);
            }
            $this->response->setOutput(json_encode(array(
                'id'   => $id
            )));
        } else {
            $this->response->setOutput(json_encode(array(
                'error' => true
            )));
        }
    }

    public function get_slider() {
        if(isset($this->request->get['slider_id'])) {
            $data = $this->model_journal_rev_slider->getSlider($this->request->get['slider_id']);
            $this->response->setOutput(json_encode($data));
        }
    }

    public function get_fonts() {
        $sql = "SELECT * FROM " . DB_PREFIX . "journal_cp_fonts ORDER BY `group` desc, font_name ASC";
        $query = $this->db->query($sql);
        $this->response->setOutput(json_encode($query->rows));
    }

    public function install() {
        $this->model_journal_rev_slider->install();
    }

    public function uninstall() {
        $this->model_journal_rev_slider->uninstall();
    }

    private function loadTemplate($title, $template) {
        // generate json consts
        $this->data['js_consts'] = '
        <script>
            var JS_CONSTS = $.parseJSON(\'' . htmlspecialchars_decode(json_encode($this->data['consts'])) . '\');
            for (var p in JS_CONSTS) { JRev.consts[p.toUpperCase()] = JS_CONSTS[p]; }
            delete JS_CONSTS;
        </script>
        ';

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
        $this->document->addScript('view/javascript/journal/angular/angular.min.js');
        $this->document->addScript('view/javascript/journal/underscore-min.js');
        $this->document->addScript('view/javascript/journal/underscore.string.js');
        $this->document->addScript('view/javascript/journal/angular/ui-bootstrap-0.4.0.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/prettyCheckable.js');
        $this->document->addScript('view/javascript/journal/jquery.switch/jquery.switch.min.js');
        $this->document->addScript('view/javascript/journal/jscolor.js');
        $this->document->addScript('view/javascript/journal/journal_rev.js');
    }

    private function loadLanguageVars($vars = array()) {
        foreach ($vars as $var) {
            $this->data[$var] = $this->language->get($var);
        }
    }
}
?>