<?php
class ControllerBlogHelp extends Controller {
    public function index()
    {
        $this->data = $this->load->language('blog/blog');
        
        $meta_title = (isset($this->request->get['meta'])) ? $this->request->get['meta'] . ' - ' . $this->language->get('heading_title') : $this->language->get('heading_title') . ' ' . $this->language->get('text_docs');
        
        $this->document->setTitle($meta_title);
        $this->document->addStyle('view/stylesheet/blog.css', 'stylesheet', '');
        
        $docs_toc   = '11468803'; // https://octave.atlassian.net/wiki/display/EXTDOCS/Blog+Manager
        $help_page  = (isset($this->request->get['page'])) ? $this->request->get['page'] : $docs_toc;
        $this->data['help_page']    = 'https://octave.atlassian.net/wiki/pages/viewpage.action?pageId=' . $help_page;
        
        
        $this->data['title'] = $this->document->getTitle(); 
        $this->data['styles'] = $this->document->getStyles();
        
        //=== template
        $this->template = 'blog/help.tpl';
        
        $this->response->setOutput($this->render());
    }
}
?>