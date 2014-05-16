<?php
class ControllerBlogCategory extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->model('blog/category');
		$this->load->model('blog/setting');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/category');

		$this->getInfo();
		$this->getList();
	}
	
	public function insert() {
		$this->load->model('blog/category');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/category');
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_category->addCategory($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL')); 
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function update() {
		$this->load->model('blog/category');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/category');
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_blog_category->editCategory($this->request->get['category_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			if ($this->request->post['buttonClick'] == 'apply') {
				$this->redirect($this->url->link('blog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id']. $url, 'SSL')); 
			} else {
				$this->redirect($this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL'));
			}
		}
		
		if (!isset($this->request->get['category_id'])) {
			$this->redirect($this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL')); 
		}

		$this->getInfo();
		$this->getForm();
	}
	
	public function copy() {
		$this->load->model('blog/category');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/category');
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_blog_category->copyCategory($category_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL'));
		}

		if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_copy');
		}
		
		$this->getInfo();
		$this->getList();
	}
	
	public function delete() {
		$this->load->model('blog/category');
		$this->data = $this->load->language('blog/blog');
		$this->data = $this->load->language('blog/category');
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (isset($this->request->post['selected']) && $this->validateSelectList()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_blog_category->deleteCategory($category_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL'));
		}
		
		if (!isset($this->request->post['selected'])) {
			$this->session->data['attention'] = $this->language->get('error_delete');
		}
		
		$this->getInfo();
		$this->getList();
	}
	
	private function getInfo() {
		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/blog.css');
		
		$this->data['link_author']			 = sprintf($this->data['text_link'], $this->data['dev_url'], $this->data['dev_name'], $this->data['dev_name']);
		$this->data['link_copyright']		 = sprintf($this->data['dev_copyright'], $this->data['heading_title'], '2011 - ' . date('Y'), $this->data['link_author']);
		$this->data['oc_footer']				= sprintf($this->language->get('oc_footer'), VERSION);
		
		$this->load->model('blog/article');
		$isAuthor = $this->model_blog_article->getAuthorByUser($this->user->getId());
		if (!$isAuthor) {
			$this->session->data['warning'] = $this->language->get('error_notauthor');
			$this->redirect($this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->load->model('blog/author');
		$blogPermission = $this->model_blog_author->getPermissionByUser($this->user->getId());
		if (is_array(unserialize($blogPermission))) { foreach (unserialize($blogPermission) as $permission) { $this->data['haspermission_'. $permission] = 1; }; }
		
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('text_home'),
			'href'		=> $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('heading_title'),
			'href'		=> $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' <span class="separator">&#187;</span> '
		);
		$this->data['breadcrumbs'][] = array(
			'text'		=> $this->language->get('head_category'),
			'href'		=> $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' <span class="separator">&#187;</span> '
		);

		//== Menu
		$this->data['menu_home_href']		 = $this->url->link('blog/blog', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_article_href']	 = $this->url->link('blog/article', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_category_href']	 = $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_comment_href']	 = $this->url->link('blog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_author_href']	 = $this->url->link('blog/author', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_setting_href']	 = $this->url->link('blog/setting', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['menu_about_href']		 = $this->url->link('blog/about', 'token=' . $this->session->data['token'], 'SSL');
	}
	
	private function getList() {
		$blogSetting = $this->model_blog_setting->getSettings();
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$filter_date_start = $this->request->get['filter_date_start'];
         $url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		} else {
			$filter_date_start = '';
		}

		if (isset($this->request->get['filter_date_end'])) {
			$filter_date_end = $this->request->get['filter_date_end'];
         $url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		} else {
			$filter_date_end = '';
		}
		
		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		
      if (isset($this->request->get['filter_store'])) {
			$filter_store = $this->request->get['filter_store'];
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		} else {
			$filter_store = 'all';
		}
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
			$url .= '&sort=' . $this->request->get['sort'];
		} else {
			$sort = 'c.category_id';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
			$url .= '&order=' . $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$this->data['insert']	= $this->url->link('blog/category/insert', 'token=' . $this->session->data['token']. $url, 'SSL');
		$this->data['copy']		= $this->url->link('blog/category/copy', 'token=' . $this->session->data['token']. $url, 'SSL');
		$this->data['delete']	= $this->url->link('blog/category/delete', 'token=' . $this->session->data['token']. $url, 'SSL');
		$this->data['token']	= $this->session->data['token'];
		$this->data['action']	= $this->url->link('blog/category', 'token=' . $this->session->data['token'], 'SSL');		
		
		$data = array(
			'sort'               => $sort,
			'filter_status'      => $filter_status,
			'filter_date_start'  => $filter_date_start, 
			'filter_date_end'    => $filter_date_end,
			'filter_store'    	 => $filter_store,
			'order'              => $order,
			'start'              => ($page - 1) * $blogSetting['articleAdmin'],
			'limit'              => $blogSetting['articleAdmin']
		);
		$category_total = $this->model_blog_category->getTotalCategories($data);
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
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
		
		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		$this->data['categories'] = array();
		
		$results = $this->model_blog_category->getCategories(0, $data);
		foreach ($results as $result) {
			$action = array();
			$action[] = array(
				'text'	=> $this->language->get('text_edit'),
				'href'	=> $this->url->link('blog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id']. $url, 'SSL')
			);
			$category_info = $this->model_blog_category->getCategory($result['category_id']);
			$categoryStore = $this->model_blog_category->getCategoryStore($result['category_id']);
			$this->data['categories'][] = array(
				'category_id'	=> $result['category_id'],
				'name'			=> $result['name'],
				'keyword'		=> $category_info['keyword'],
				'created'		=> date($this->language->get('date_format'), strtotime($result['created'])),
				'store'			=> $categoryStore,
				'status'		=> $category_info['status'],
				'sort_order'	=> $category_info['sort_order'],
				'selected'		=> isset($this->request->post['selected']) && in_array($category_info['category_id'], $this->request->post['selected']),
				'action'		=> $action
			);
		}
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_catid'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=c.category_id' . $url, 'SSL');
		$this->data['sort_name'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=cd.name' . $url, 'SSL');
		$this->data['sort_seo'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=keyword' . $url, 'SSL');
		$this->data['sort_created'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=created' . $url, 'SSL');
		$this->data['sort_store'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=c2s.store_id' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . '&sort=c.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		$pagination = new Pagination();
		$pagination->total = $category_total;
		$pagination->page = $page;
		$pagination->limit = $blogSetting['articleAdmin'];
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('blog/category', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		$this->data['filter_date_start'] = $filter_date_start;
		$this->data['filter_date_end'] = $filter_date_end;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_store'] = $filter_store;
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['token'] = $this->session->data['token'];
        
        $help_meta      = $this->language->get('help_meta_list'); // @todo language file
        $help_page      = '11469102';
        $this->data['online_help_url']   = $this->url->link('blog/help', 'meta=' . $help_meta . '&page=' . $help_page . '&token=' . $this->session->data['token'], 'SSL');
		
		$this->template = 'blog/category_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		
		$this->response->setOutput($this->render());
	}
	
	private function getForm() {
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
		 if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
		}
		
		$url = '';
		if (isset($this->request->get['filter_date_start'])) {
			$url .= '&filter_date_start=' . $this->request->get['filter_date_start'];
		}		
		if (isset($this->request->get['filter_date_end'])) {
			$url .= '&filter_date_end=' . $this->request->get['filter_date_end'];
		}
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		/*
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
		*/
		if (isset($this->request->get['filter_store'])) {
			$url .= '&filter_store=' . $this->request->get['filter_store'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (!isset($this->request->get['category_id'])) {
			$this->data['action'] = $this->url->link('blog/category/insert', 'token=' . $this->session->data['token']. $url, 'SSL');
			$this->data['update'] = '';
		} else {
			$this->data['action'] = $this->url->link('blog/category/update', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id']. $url, 'SSL');
			$this->data['update'] = 1;
		}
		$this->data['cancel'] = $this->url->link('blog/category', 'token=' . $this->session->data['token']. $url, 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		if (isset($this->request->get['category_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$category_info = $this->model_blog_category->getCategory($this->request->get['category_id']);
		}
		
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
      $this->load->model('setting/setting');
		$this->data['def_lang'] = $this->config->get('config_language');
      $this->load->model('blog/setting');
      $blogSetting = $this->model_blog_setting->getSettings();
		$this->data['autoCatKeyword'] = $blogSetting['autoCatKeyword'];
		
		if (isset($this->request->post['category_description'])) {
			$this->data['category_description'] = $this->request->post['category_description'];
		} elseif (isset($category_info)) {
			$this->data['category_description'] = $this->model_blog_category->getCategoryDescriptions($this->request->get['category_id']);
		} else {
			$this->data['category_description'] = array();
		}
		
		$categories = $this->model_blog_category->getCategories(0);
		if (isset($category_info)) { // Remove own id from list
			foreach ($categories as $key => $category) {
				if ($category['category_id'] == $category_info['category_id']) {
					unset($categories[$key]);
				}
			}
		}
		$this->data['categories'] = $categories;
		
		if (isset($this->request->post['parent_id'])) {
			$this->data['parent_id'] = $this->request->post['parent_id'];
		} elseif (isset($category_info)) {
			$this->data['parent_id'] = $category_info['parent_id'];
		} else {
			$this->data['parent_id'] = 0;
		}
		
		$this->load->model('setting/store');
		$this->data['stores'] = $this->model_setting_store->getStores();
		if (isset($this->request->post['category_store'])) {
			$this->data['category_store'] = $this->request->post['category_store'];
		} elseif (isset($category_info)) {
			$this->data['category_store'] = $this->model_blog_category->getCategoryStores($this->request->get['category_id']);
		} else {
			$this->data['category_store'] = array(0);
		}
		
		if (isset($this->request->post['article_order'])) {
			$this->data['article_order'] = $this->request->post['article_order'];
		} elseif (isset($category_info)) {
			$this->data['article_order'] = $category_info['article_order'];
		} else {
			$this->data['article_order'] = '';
		}
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (isset($category_info)) {
			$this->data['keyword'] = $category_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		
		if (isset($this->request->post['robots'])) {
			$this->data['robots'] = $this->request->post['robots'];
		} elseif (isset($category_info)) {
			$this->data['robots'] = $category_info['robots'];
		} else {
			$this->data['robots'] = '';
		}
		
		if (isset($this->request->post['width'])) {
			$this->data['width'] = $this->request->post['width'];
		} elseif (isset($category_info)) {
			$this->data['width'] = $category_info['width'];
		} else {
			$this->data['width'] = 0;
		}
		
		if (isset($this->request->post['height'])) {
			$this->data['height'] = $this->request->post['height'];
		} elseif (isset($category_info)) {
			$this->data['height'] = $category_info['height'];
		} else {
			$this->data['height'] = 0;
		}
		
		if (isset($this->request->post['desc_limit'])) {
			$this->data['desc_limit'] = $this->request->post['desc_limit'];
		} elseif (isset($category_info)) {
			$this->data['desc_limit'] = $category_info['desc_limit'];
		} else {
			$this->data['desc_limit'] = 0;
		}
		
		//===
		$this->load->model('tool/image');
		
		if (isset($this->request->post['image'])) {
			$this->data['image'] = $this->request->post['image'];
		} elseif (isset($category_info)) {
			$this->data['image'] = $category_info['image'];
		} else {
			$this->data['image'] = '';			
		}

		if (isset($category_info['image']) && file_exists(DIR_IMAGE . $category_info['image']) && is_file(DIR_IMAGE . $category_info['image'])) {
			$this->data['featuredImage'] = $this->model_tool_image->resize($category_info['image'], 100, 100);		
		} else {
			$this->data['featuredImage'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		//===
		
		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (isset($category_info)) {
			$this->data['sort_order'] = $category_info['sort_order'];
		} else {
			$this->data['sort_order'] = 0;
		}
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (isset($category_info)) {
			$this->data['status'] = $category_info['status'];
		} else {
			$this->data['status'] = 0;
		}
		
		if (isset($this->request->post['suffix'])) {
			$this->data['suffix'] = $this->request->post['suffix'];
		} elseif (isset($category_info)) {
			$this->data['suffix'] = $category_info['suffix'];
		} else {
			$this->data['suffix'] = '';
		}
		
		if (isset($this->request->post['category_col'])) {
			$this->data['category_col'] = $this->request->post['category_col'];
		} elseif (isset($category_info)) {
			$this->data['category_col'] = $category_info['category_col'];
		} else {
			$this->data['category_col'] = '';
		}
		
		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		if (isset($this->request->post['category_layout'])) {
         foreach ($this->request->post['category_layout'] as $store_id => $layout) {
            $this->data['category_layout'][$store_id] = $layout['layout_id'];
			}
		} elseif (isset($category_info)) {
			$this->data['category_layout'] = $this->model_blog_category->getCategoryLayouts($this->request->get['category_id']);
		} else {
			$this->data['category_layout'] = array();
		}
      
      // Specific Template
      $this->data['templates'] = array();
      $storeTemplates = $this->model_blog_category->getStoresTemplate();
      foreach( $storeTemplates as $storeTemplate) {
         $templateData     = '';
         $templateFiles    = glob(DIR_CATALOG . 'view/theme/' . $storeTemplate['value'] . '/template/blog/category_*.tpl');
         
         $templateData[] = array(
            'value'     => 'default',
            'name'      => $this->language->get('text_default')
         );
         $this->data['templates'][$storeTemplate['store_id']] = $templateData;
         
         if ($templateFiles) {
            foreach ($templateFiles as $templateFile) {
               $template   = basename($templateFile, '.tpl');
               $template1  = str_replace('category_', '', $template);
               $template2  = str_replace('_', ' ', $template1);
               
               $templateData[] = array(
                  'value'     => $template1,
                  'name'      => ucwords($template2)
               );
            }
            
            $this->data['templates'][$storeTemplate['store_id']] = $templateData;
         }
      }
      
      if (isset($this->request->post['category_template'])) {
         foreach ($this->request->post['category_template'] as $store_id => $template) {
            $this->data['category_template'][$store_id] = $template['template'];
			}
		} elseif (isset($category_info)) {
			$this->data['category_template'] = $this->model_blog_category->getCategoryTemplates($category_info['category_id']);
		} else {
			$this->data['category_template'] = array();
		}
        
        $help_meta      = $this->language->get('help_meta_list_Insert_Edit'); // @todo language file
        $help_page      = '11469104';
        $this->data['online_help_url']   = $this->url->link('blog/help', 'meta=' . $help_meta . '&page=' . $help_page . '&token=' . $this->session->data['token'], 'SSL');
		
		$this->template = 'blog/category_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function editStatus() {
		$this->load->model('blog/category');
		
		if (isset($this->request->post['category_id']) && isset($this->request->post['status'])) {
			$this->model_blog_category->updateCategoryStatus($this->request->post['category_id'], $this->request->post['status']);
			$json['success']	= 1;
			$json['status']	= ($this->request->post['status']) ? 'enabled' : 'disabled';
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	public function editOrder() {
		$this->load->model('blog/category');
		
		if (isset($this->request->post['category_id']) && isset($this->request->post['sort_order'])) {
			if (preg_match('/^[0-9]+$/', $this->request->post['sort_order'])) {
				$this->model_blog_category->updateCategoryOrder($this->request->post['category_id'], $this->request->post['sort_order']);
				$json['success']	= 1;
			} else {
				$json['error']		= 1;
			}
		}
		
		if (file_exists(DIR_SYSTEM.'library/json.php')) { // v1.5.1.2 or earlier
			$this->load->library('json');
			$this->response->setOutput(Json::encode($json));
		} else {
			$this->response->setOutput(json_encode($json));
		}
	}
	
	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'blog/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['category_description'] as $language_id => $value) {
			if ((strlen(utf8_decode($value['name'])) < 2) || (strlen(utf8_decode($value['name'])) > 128)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}
		
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	
	private function validateSelectList() {
		if (!$this->user->hasPermission('modify', 'blog/category')) {
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