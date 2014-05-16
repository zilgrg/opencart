<?php
class ControllerModuleBlogarchive extends Controller {
   private $error = array(); 
   
   public function index() {   
      $this->load->model('setting/setting');
      $this->data = $this->load->language('blog/blog');
      $this->data = $this->load->language('module/blogarchive');

      $this->document->addStyle('view/stylesheet/blog_module.css');
      $this->document->setTitle($this->language->get('heading_module'));
      
      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
         $this->model_setting_setting->editSetting('blogarchive', $this->request->post);      

         $this->session->data['success'] = $this->language->get('text_success');

         if ($this->request->post['buttonClick'] == 'apply') {
            $this->redirect($this->url->link('module/blogarchive', 'token=' . $this->session->data['token'], 'SSL'));
         } else {
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
         }
      }
      
       if (isset($this->error['warning'])) {
         $this->data['error_warning'] = $this->error['warning'];
      } else {
         $this->data['error_warning'] = '';
      }
      if (isset($this->session->data['success'])) {
         $this->data['success'] = $this->session->data['success'];
         unset($this->session->data['success']);
      } else {
         $this->data['success'] = '';
      }

        $this->data['breadcrumbs'] = array();
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
         );
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('text_module'),
         'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' <span class="separator">&#187;</span> '
         );
         $this->data['breadcrumbs'][] = array(
             'text'      => $this->language->get('heading_module'),
         'href'      => $this->url->link('module/blogarchive', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' <span class="separator">&#187;</span> '
         );
      
      $this->data['action'] = $this->url->link('module/blogarchive', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
      
      $this->data['modules'] = array();
      
      if (isset($this->request->post['blogarchive_module'])) {
         $this->data['modules'] = $this->request->post['blogarchive_module'];
      } elseif ($this->config->get('blogarchive_module')) { 
         $this->data['modules'] = $this->config->get('blogarchive_module');
      }   
            
      $this->load->model('design/layout');
      
      $this->data['layouts'] = $this->model_design_layout->getLayouts();

      $help_meta      = 'Module Archive'; // @todo language file
      $help_page      = rawurlencode('12157050#BMModules-Archive');
      $this->data['online_help_url']   = $this->url->link('blog/help', 'meta=' . $help_meta . '&page=' . $help_page . '&token=' . $this->session->data['token'], 'SSL');

      $this->template = 'module/blogarchive.tpl';
      $this->children = array(
         'common/header',
         'common/footer'
      );
            
      $this->response->setOutput($this->render());
   }
   
   private function validate() {
      if (!$this->user->hasPermission('modify', 'module/blogarchive')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      if (!$this->error) {
         return true;
      } else {
         return false;
      }   
   }
}
?>