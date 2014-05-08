<?php
class ControllerJournal2Modules extends Controller {
    public function index() {
        /* check maintenance mode */
        if ($this->config->get('config_maintenance')) {
            $this->load->library('user');
            $this->user = new User($this->registry);
            if (!$this->user->isLogged()) {
                return;
            }
        }

        $this->load->model('design/layout');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/information');

        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        $layout_id = 0;

        if ($route == 'product/category' && isset($this->request->get['path'])) {
            $path = explode('_', (string)$this->request->get['path']);

            $layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
        }

        if ($route == 'product/product' && isset($this->request->get['product_id'])) {
            $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
        }

        if ($route == 'information/information' && isset($this->request->get['information_id'])) {
            $layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
        }

        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }

        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        $module_data_top = array();
        $module_data_bottom = array();
        $module_data_footer = array();

        $this->load->model('setting/extension');

        $extensions = $this->model_setting_extension->getExtensions('module');

        foreach ($extensions as $extension) {
            $modules = $this->config->get($extension['code'] . '_module');

            if ($modules) {
                foreach ($modules as $module) {
                    if (($module['layout_id'] == $layout_id || $module['layout_id'] == -1) && $module['position'] == 'top' && $module['status']) {
                        $module_data_top[] = array(
                            'module_id'  => $module['module_id'],
                            'code'       => $extension['code'],
                            'setting'    => $module,
                            'sort_order' => $module['sort_order']
                        );
                    }
                    if (($module['layout_id'] == $layout_id || $module['layout_id'] == -1) && $module['position'] == 'bottom' && $module['status']) {
                        $module_data_bottom[] = array(
                            'module_id'  => $module['module_id'],
                            'code'       => $extension['code'],
                            'setting'    => $module,
                            'sort_order' => $module['sort_order']
                        );
                    }
                    if (($module['layout_id'] == $layout_id || $module['layout_id'] == -1) && $module['position'] == 'footer' && $module['status']) {
                        $module_data_footer[] = array(
                            'module_id'  => $module['module_id'],
                            'code'       => $extension['code'],
                            'setting'    => $module,
                            'sort_order' => $module['sort_order']
                        );
                    }
                }
            }
        }

        /* sort top modules */
        $sort_order = array();
        foreach ($module_data_top as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
        array_multisort($sort_order, SORT_ASC, $module_data_top);

        /* sort bottom modules */
        $sort_order = array();
        foreach ($module_data_bottom as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
        array_multisort($sort_order, SORT_ASC, $module_data_bottom);

        /* sort footer modules */
        $sort_order = array();
        foreach ($module_data_footer as $key => $value) {
            $sort_order[$key] = $value['sort_order'];
        }
        array_multisort($sort_order, SORT_ASC, $module_data_footer);

        $this->template = $this->config->get('config_template') . '/template/journal2/common/modules.tpl';

        /* render top modules */
        $this->data['modules'] = array();
        foreach ($module_data_top as $module) {
            $type = $module['code'];
            $id = $module['module_id'];
            $module = $this->getChild('module/' . $module['code'], $module['setting']);
            if ($module) {
                $this->data['modules'][] = array(
                    'module_id' => $id,
                    'type'      => $type,
                    'module'    => $module
                );
            }
        }
        $this->journal2->settings->set('config_top_modules', $this->render());

        /* render bottom modules */
        $this->data['modules'] = array();
        foreach ($module_data_bottom as $module) {
            $type = $module['code'];
            $id = $module['module_id'];
            $module = $this->getChild('module/' . $module['code'], $module['setting']);
            if ($module) {
                $this->data['modules'][] = array(
                    'module_id' => $id,
                    'type'      => $type,
                    'module'    => $module
                );
            }
        }
        $this->journal2->settings->set('config_bottom_modules', $this->render());

        /* render footer modules */
        $this->data['modules'] = array();
        foreach ($module_data_footer as $module) {
            $type = $module['code'];
            $id = $module['module_id'];
            $module = $this->getChild('module/' . $module['code'], $module['setting']);
            if ($module) {
                $this->data['modules'][] = array(
                    'module_id' => $id,
                    'type'      => $type,
                    'module'    => $module
                );
            }
        }
        $this->template = $this->config->get('config_template') . '/template/journal2/common/footer_modules.tpl';
        $this->journal2->settings->set('config_footer_modules', $this->render());
    }
}
?>