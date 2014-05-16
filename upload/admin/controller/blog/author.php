<?php
class ControllerBlogAuthor extends Controller {
   private $error = array();
 
   public function index() {
      $this->load->model('blog/author');
      $this->load->model('blog/article');
      $this->data = $this->load->language('blog/blog');
      $this->data = $this->load->language('blog/author');

      $this->document->setTitle($this->language->get('heading_title'));
      $this->document->addStyle('view/stylesheet/blog.css');
      
      $this->data['link_author']          = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
      $this->data['link_copyright']       = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
      $this->data['oc_footer']            = sprintf($this->language->get('oc_footer'), VERSION);


      $this->data['breadcrumbs'] = array();
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => false
      );
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('heading_title'),
         'href'      => $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('head_author'),
         'href'      => $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL'),
         'separator' => ' <span class="separator">&#187;</span> '
      );

      if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateAuthor()) {
         // Blog author
         if (isset($this->request->post['addAuthor'])) {
            $this->model_blog_author->addAuthor($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_addAuthor');
         }
         if (isset($this->request->post['renAuthor'])) {
            $this->model_blog_author->editAuthor($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_modifAuthor');
         }
         if (isset($this->request->post['changeAuthor'])) {
            $this->model_blog_author->changeAuthor($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success_modifAuthor');
         }
         if (isset($this->request->post['delAuthor'])) {
            foreach ($this->request->post['delAuthor'] as $author_id) {
               $count_article = array(
                  'filter_store'    => 'all',
                  'filter_author'   => $author_id
               );
               $total_article = $this->model_blog_article->getTotalArticles($count_article);
               
               if ($total_article >= 1) {
                  $this->session->data['warning'] = $this->language->get('error_author_cantdel');
               } else {
                  $this->model_blog_author->delAuthor($author_id);
                  $this->session->data['success'] = $this->language->get('text_success_modifAuthor');
               }
            }

         }
         
         // Blog permission
         if (isset($this->request->post['permBlog'])) {
            $permBlog = array();
            if (isset($this->request->post['permAuthor'])) { $permAuthor = $this->request->post['permAuthor']; } else { $permAuthor = ''; }
               $permBlog[] = array(
                  'name'         => 'Author',
                  'permission'   => $permAuthor
               );
            if (isset($this->request->post['permEditor'])) { $permEditor = $this->request->post['permEditor']; } else { $permEditor = ''; }
            $permBlog[] = array(
               'name'         => 'Editor',
               'permission'   => $permEditor
            );
            if (isset($this->request->post['permAdmin'])) { $permAdmin = $this->request->post['permAdmin']; } else { $permAdmin = ''; }
            if (isset($this->request->post['permAdmin'])) {
               $permBlog[] = array(
                  'name'         => 'Admin',
                  'permission'   => $permAdmin
               );
            }
            
            $this->model_blog_author->editPermissions($permBlog);

            $this->session->data['success'] = $this->language->get('text_success_modifGroup');
         }
         
         $this->redirect($this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL')); 
      }
      
      $adminAvailable = $this->model_blog_author->checkAdminUser();
      $this->data['adminAvailable'] = $adminAvailable;

      $isAuthor = $this->model_blog_article->getAuthorByUser($this->user->getId());
      if (!$isAuthor && $adminAvailable) {
         $this->session->data['warning']     = $this->language->get('error_notauthor');
      } elseif (!$adminAvailable && !isset($this->session->data['after_install'])) {
         $this->session->data['attention']   = $this->language->get('error_noadmin_user');
      } else {
         $blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
         if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; } }
      }
      
      if (isset($this->error['warning'])) {
         $this->data['error_warning'] = $this->error['warning'];
      } elseif (isset($this->session->data['warning'])) {
         $this->data['error_warning'] = $this->session->data['warning'];
         unset($this->session->data['warning']);
      } else {
         $this->data['error_warning'] = '';
      }
      if (isset($this->session->data['attention'])) {
         $this->data['attention'] = $this->session->data['attention'];
         unset($this->session->data['attention']);
      } else {
         $this->data['attention'] = '';
      }
      if (isset($this->session->data['success'])) {
         $this->data['success'] = $this->session->data['success'];
         unset($this->session->data['success']);
      } else {
         $this->data['success'] = '';
      }
      
      //== Menu
      $this->data['menu_home_href']       = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_article_href']    = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_category_href']   = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_comment_href']    = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_author_href']     = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_setting_href']    = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
      $this->data['menu_about_href']      = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
      
      $this->data['action'] = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
      
      //== Author section
      //$this->data['authors']              = $this->model_blog_author->getAuthors();
      $this->data['authors']  = array();
      $authors                = $this->model_blog_author->getAuthors();
      
      foreach ($authors as $author) {
         $count_article = array(
            'filter_store'    => 'all',
            'filter_author'   => $author['author_id'],
            'sort'            => ''
         );
         $total_article = $this->model_blog_article->getTotalArticles($count_article);
         
         $this->data['authors'][] = array(
            'author_id'       => $author['author_id'],
            'name'            => $author['name'],
            'fullname'        => $author['fullname'],
            'user_id'         => $author['user_id'], // user_id at blog_author table
            'oc_user_id'      => $author['oc_user_id'], // user_id at user table:: use this to check if user is exist or not
            'groupname'       => $author['groupname'],
            'total_article'   => sprintf($this->data['text_author_count'], $this->url->link('blog/article', 'filter_author='.$author['author_id'].'&token=' . $this->session->data['token'], 'SSL'), $author['name'], $total_article)
         );
      }
      
      $this->data['users']                      = $this->model_blog_author->getUsers();
      $this->data['authorGroups']               = $this->model_blog_author->getAuthorGroups();
      $this->data['text_user_notavail_help']    = sprintf($this->language->get('text_user_notavail_help'), $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL'));
      
      //== Permissions section
      $this->data['permGroups']           = $this->model_blog_author->getPermissions();
      
      //== Error Handle
      $errorSettings = array(
         'tabAuthors', 'selectUser', 'addAuthor', 'renAuthor', 'delAdmin'
      );
      foreach ($errorSettings as $errorSetting) {
         if (isset($this->error[$errorSetting])) {
            $this->data['error_'.$errorSetting] = $this->error[$errorSetting];
         } else {
            $this->data['error_'.$errorSetting] = '';
         }
      }
      
      $formSettings = array('addAuthor', 'renAuthor');
      foreach ($formSettings as $formSetting) {
         if (isset($this->request->post[$formSetting])) {
            $this->data[$formSetting.'Value'] = $this->request->post[$formSetting];
         } else {
            $this->data[$formSetting.'Value'] = '';
         }
      }
      
        $help_meta      = $this->language->get('help_meta'); // @todo language file
        $help_page      = '11469108';
        $this->data['online_help_url']   = $this->url->link('blog/help', 'meta=' . $help_meta . '&page=' . $help_page . '&token=' . $this->session->data['token'], 'SSL');
        
      $this->template = 'blog/author.tpl';
      $this->children = array(
         'common/header',
         'common/footer',
      );
      
      $this->response->setOutput($this->render());
   }
   
   private function validateAuthor() {
      if (!$this->user->hasPermission('modify', 'blog/author')) {
         $this->error['warning'] = $this->language->get('error_permission');
      }
      
      $authors          = $this->model_blog_author->getAuthors();
      $adminAvailable   = $this->model_blog_author->checkAdminUser();
      $adminUserId      = $this->model_blog_author->checkAdminUserId();
      
      if (isset($this->request->post['addAuthor'])) {
         if (!isset($this->request->post['user_id'])) {
            $this->error['selectUser'] = $this->language->get('error_user');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         }
         
         if ((strlen(utf8_decode($this->request->post['addAuthor'])) < 3) || (strlen(utf8_decode($this->request->post['addAuthor'])) > 28)) {
            $this->error['addAuthor'] = $this->language->get('error_author');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         } else {
            foreach ($authors as $author) {
               if (strtolower($author['name']) == strtolower($this->request->post['addAuthor'])) {
                  $this->error['addAuthor'] = $this->language->get('error_author_exist');
                  $this->error['tabAuthors'] = $this->language->get('error_tab');
               }
            }
         }
      }
      
      if (isset($this->request->post['renAuthor'])) {
         if ((strlen(utf8_decode($this->request->post['renAuthor'])) < 3) || (strlen(utf8_decode($this->request->post['renAuthor'])) > 28)) {
            $this->error['renAuthor'] = $this->language->get('error_author');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         } else {
            foreach ($authors as $author) {
               if (strtolower($author['name']) == strtolower($this->request->post['renAuthor'])) {
                  $this->error['renAuthor'] = $this->language->get('error_author_exist');
                  $this->error['tabAuthors'] = $this->language->get('error_tab');
               }
            }
         }
      }
      
      if (isset($this->request->post['delAuthor'])) {
         if ($adminAvailable == 1 && array_intersect($this->request->post['delAuthor'], $adminUserId)) {
            $this->error['delAdmin']   = $this->language->get('error_lastadmin');
            $this->error['tabAuthors'] = $this->language->get('error_tab');
         }
      }
 
      if (!$this->error) {
         return true; 
      } else {
         return false;
      }
   }
}
?>