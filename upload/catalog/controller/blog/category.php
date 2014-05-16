<?php  
class ControllerBlogCategory extends Controller {
   public function index() {
      $this->load->model('blog/helper');
      
      // Redirect page if Blog Manager is not installed
      if (!$this->model_blog_helper->checkDbTable('blog_setting')) { $this->redirect($this->url->link('common/home')); }
      
      $this->load->model('blog/setting');
      $this->load->model('blog/article');
      $this->load->model('blog/category');
      $this->data = $this->language->load('blog/blog');
      
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog.css')) {
         $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog.css');
      } else {
         $this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
      }
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_custom.css')) { // use for customize
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_custom.css');
		} elseif (file_exists(DIR_TEMPLATE . 'default/stylesheet/blog_custom.css')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_custom.css');
		}
      
      $blogSetting = $this->model_blog_setting->getSettings();
      $date = date('Y-m-d H:i:s');
      
      if (isset($this->request->get['page'])) {
         $page = $this->request->get['page'];
      } else { 
         $page = 1;
      }
      $limit = $blogSetting['articleCat'];

      $this->data['breadcrumbs'] = array();
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home'),
         'separator' => false
      );
      
      if (isset($this->request->get['category_id'])) {   
         $parts      = explode('_', (string)$this->request->get['category_id']);

         if (!isset($blogSetting['virDir']) || $blogSetting['virDir']) {
            if (isset($blogSetting['virDirExclude']) && $blogSetting['virDirExclude']) {
               $excludeCat = unserialize($blogSetting['virDirExclude']);
            } else {
               $excludeCat = array();
            }
            
            if (!in_array($parts[0], $excludeCat)) {
               $this->data['breadcrumbs'][] = array(
                  'text'      => ucfirst($blogSetting['virDirName']),
                  'href'      => $this->url->link('blog/category/home'),
                  'separator' => $this->language->get('text_separator')
               );
            }
         }
         
         if (!$blogSetting['virDir']) {
               $this->data['breadcrumbs'][] = array(            
                  'text'      => $this->language->get('text_blog'),
                  'href'      => $this->url->link('blog/category/home'),
                  'separator' => $this->language->get('text_separator')
               );
            }
      
         $path       = '';
         foreach ($parts as $path_id) {
            if (!$path) {
               $path = $path_id;
            } else {
               $path .= '_' . $path_id;
            }
            
            $categoryData = $this->model_blog_category->getCategory($path_id);
            if ($categoryData) {
               $this->data['breadcrumbs'][] = array(
                  'text'      => $categoryData['name'],
                  'href'      => $this->url->link('blog/category', 'category_id=' . $path),
                  'separator' => $this->language->get('text_separator')
               );
            }
         }     
      
         $category_id = array_pop($parts);
      } else {
         $this->redirect($this->url->link('blog/category/home'));
      }

      $categoryData = $this->model_blog_category->getCategory($category_id);
      
      if ($categoryData) {
         $this->load->model('tool/image');
         
         if ($categoryData['meta_title']) {
            $this->document->setTitle($categoryData['meta_title']);
         } else {
            $this->document->setTitle($categoryData['name']);
         }
         $this->document->setKeywords($categoryData['meta_keyword']);
         $this->document->setDescription($categoryData['meta_description']);
         
         $this->data['suffix']            = $categoryData['suffix'];
         $this->data['column']            = $categoryData['category_col'];
         $this->data['heading_title']     = $categoryData['name'];
         $this->data['catImage']          = $this->model_tool_image->resize($categoryData['image'], $blogSetting['articleFeatWidth'], $blogSetting['articleFeatHeight']);
         $this->data['catDescription']    = html_entity_decode($categoryData['description'], ENT_QUOTES, 'UTF-8');
         $this->data['blogHomeDesc']      = false;
         $this->data['feedLink']          = $this->url->link('feed/blog');
         
         if ($categoryData['desc_limit']) {
            $characterLimit = $categoryData['desc_limit'];
         } else {
            $characterLimit = $blogSetting['articleDesc'];
         }
         
         if ($categoryData['width'] && $categoryData['height']) {
            $imageWidth    = $categoryData['width'];
            $imageHeight   = $categoryData['height'];
         } else {
            $imageWidth    = $blogSetting['articleFeatWidth'];
            $imageHeight   = $blogSetting['articleFeatHeight'];
         }
         
         //== Child Category
         $this->data['categories'] = array();
         $results = $this->model_blog_category->getCategories($category_id);
         
         foreach ($results as $result) {
            $this->data['categories'][] = array(
               'name'  => $result['name'],
               'href'  => $this->url->link('blog/category', 'category_id=' . $this->request->get['category_id'] . '_' . $result['category_id'])
            );
         }
         
         $data = array(
            'filter_category_id'    => $category_id,
            'article_order'         => $categoryData['article_order'],
            'date'                  => date('Y-m-d H:i:s'),
            'start'                 => ($page - 1) * $limit,
            'limit'                 => $limit
         );
         
         $catID = 'category_id=' . $this->request->get['category_id'];
         
         //== Article
         $article_total = $this->model_blog_article->getTotalArticles($data);
         $this->data['articles']			= array();
         $this->data['blog_articles']	= array();
         $results = $this->model_blog_article->getArticles($data);
         
         if ($results) {
            foreach ($results as $result) {
               $catArticle = array();
               $catDisabled = array();
               $catDatas = $this->model_blog_article->getCategoriesByArticle($result['article_id']);
               foreach ($catDatas as $catData) {
                  $catArticle[]     = '<a href="' . $this->url->link('blog/category', 'category_id=' . $catData['category_id']) . '">'. $catData['name'] . '</a>';
                  $catDisabled[]    = $catData['category_id'];
               }
               
               if (isset($blogSetting['artInfoName'])) {
                  $art_infoName = sprintf($this->language->get('text_art_infoName'), $result['author']);
               } else {
                  $art_infoName = '';
               }
               if (isset($blogSetting['artInfoCategory'])) {
                  $art_infoCategory = sprintf($this->language->get('text_art_infoCategory'), implode(", ", $catArticle));
               } else {
                  $art_infoCategory = '';
               }
               if (isset($blogSetting['artInfoDate'])) {
                  $art_InfoDate = sprintf($this->language->get('text_art_InfoDate'), $this->model_blog_helper->date_format($result['created'], 'dfl'));
               } else {
                  $art_InfoDate = '';
               }
               
               if ($result['comment'] == '1') {
                  $comments = sprintf($this->language->get('text_comments'), $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date));
               } elseif ($blogSetting['commentStatus']) {
                  $commentCatDisabled = unserialize($blogSetting['commentDisableCat']);
                     if (in_array($this->request->get['category_id'], $commentCatDisabled)) {
                        $artComment = $this->model_blog_article->getCommentByArticleToCategory($this->request->get['category_id']);
                     } else {
                        $artComment = '';
                     }
                  if ((array_intersect($catDisabled, $commentCatDisabled) && $result['comment'] == '0') || $blogSetting['guestComment'] == '0' || $result['comment'] == '0' || $artComment == '2') {
                     $comments = '';                  
                  } else {
                     $comments = sprintf($this->language->get('text_comments'), $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date));
                  }
               } else { 
                  $comments = ''; 
               }
               
               $separator = '<!--more-->';
               $short_desc = explode($separator, html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));
               if(isset($short_desc[1])) {
                  $description = $short_desc[0];
               } else {
                  $description = $this->model_blog_helper->truncate(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), $characterLimit);
               }
               
               $this->data['articles'][] = array(
                  'articlet_id'        => $result['article_id'],
                  'title'              => $result['title'],
                  'modified'           => $this->model_blog_helper->date_format($result['modified'], 'dfs'),
                  'description'        => strip_tags($description,'<b><i><em><u><a><strong><p><strike><div><span><ul><ol><li><br>'),
                  'image'              => $this->model_tool_image->resize($result['image'], $imageWidth, $imageHeight),
						'image_width'			=> $imageWidth,
                  'image_height'			=> $imageHeight,
                  'comments'           => $comments,
                  'comments_href'      => $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']),
                  'readmore'           => $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']),
                  'art_infoName'       => $art_infoName,
                  'art_infoCategory'   => $art_infoCategory,
                  'art_infoDate'       => $art_InfoDate,
                  'art_infoComment'    => isset($blogSetting['artInfoComment']) ? $blogSetting['artInfoComment'] : false
               );
					
					// Push "as is" all Blog data to template. This will make any dev easy to create custom blog template.
					$this->data['blog_articles'][] = array(
                  'articlet_id'        => $result['article_id'],
                  'title'              => $result['title'],
                  'author'       		=> $result['author'],
                  'created'				=> $result['created'],
                  'modified'           => $result['modified'],
                  'description'        => $result['description'],
                  'desc_char_limit'    => $characterLimit,
                  'desc_truncate'		=> $this->model_blog_helper->truncate(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), $characterLimit),
						'desc_striptags'     => strip_tags($description,'<b><i><em><u><a><strong><p><strike><div><span><ul><ol><li><br>'),
                  'image'              => $result['image'],
                  'image_width'			=> $imageWidth,
                  'image_height'			=> $imageHeight,
						'image_resized'		=> $this->model_tool_image->resize($result['image'], $imageWidth, $imageHeight),
						'categories'         => implode(', ', $catArticle),
                  'comments'           => $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date),
                  'comments_href'      => $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']),
                  'readmore'           => $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']),
						
						'art_infoName'       => $art_infoName,
                  'art_infoCategory'   => $art_infoCategory,
                  'art_infoDate'       => $art_InfoDate,
                  'art_infoComment'    => isset($blogSetting['artInfoComment']) ? $blogSetting['artInfoComment'] : false
               );
            }
            
            $pagination          = new Pagination();
            $pagination->total   = $article_total;
            $pagination->page    = $page;
            $pagination->limit   = $limit;
            $pagination->text    = $this->language->get('text_pagination');
            $pagination->url     = $this->url->link('blog/category', $catID . '&page={page}', 'SSL');
               
            $this->data['pagination'] = $pagination->render();
            
            // Category Multi-template
            $blogCatTemplate    = '';
            if(isset($blogSetting['blogCatTemplate'])) {
               $blogCatTemp      = unserialize($blogSetting['blogCatTemplate']);
               if (isset($blogCatTemp[$this->config->get('config_store_id')])) {
                  $blogCatTemplate  = $blogCatTemp[$this->config->get('config_store_id')];
               }
            }
            
            $categoryTemplate    = $this->model_blog_category->getCategoryTemplate($category_id);
            $templateFolder      = $this->config->get('config_template') . '/template/blog/';
            
            if (file_exists(DIR_TEMPLATE . $templateFolder . 'category.tpl')) {
               $this->template = $templateFolder . 'category.tpl';
            } else {
               $this->template = 'default/template/blog/category.tpl';
            }
            
            if ($categoryTemplate != 'default') {
               // If there is no specific template, or the file is not exist and simply fallback to template above
               if (file_exists(DIR_TEMPLATE . $templateFolder . 'category_' . $categoryTemplate . '.tpl')) {
                  $this->template = $templateFolder . 'category_' . $categoryTemplate . '.tpl';
               } elseif (file_exists(DIR_TEMPLATE . $templateFolder . 'category_' . $blogCatTemplate . '.tpl')) {
                  $this->template = $templateFolder . 'category_' . $blogCatTemplate . '.tpl';
               }
            }
            
            $this->children = array(
               'common/column_left',
               'common/column_right',
               'common/content_top',
               'common/content_bottom',
               'common/footer',
               'common/header'
            );
         
            $this->response->setOutput($this->render());
         } else {
            $this->data['breadcrumbs'][] = array(
               'text'      => $this->language->get('text_error_art'),
               'href'      => $this->url->link('blog/category', 'category_id=' . $category_id),
               'separator' => $this->language->get('text_separator')
            );
            
            $this->document->setTitle($this->language->get('text_error_art'));
            $this->data['heading_title'] = $this->language->get('text_error_art');
            $this->data['text_error'] = $this->language->get('text_error_art');

            $this->data['button_continue'] = $this->language->get('button_continue');

            $this->data['continue'] = $this->url->link('common/home');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
               $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
            } else {
               $this->template = 'default/template/error/not_found.tpl';
            }
            
            $this->children = array(
               'common/column_left',
               'common/column_right',
               'common/content_top',
               'common/content_bottom',
               'common/footer',
               'common/header'
            );
                  
            $this->response->setOutput($this->render());
         }
       } else {
         $this->data['breadcrumbs'][] = array(
            'text'         => $this->language->get('text_error_cat'),
            'href'         => $this->url->link('blog/category', 'category_id=' . $category_id),
            'separator'    => $this->language->get('text_separator')
         );
         
         $this->document->setTitle($this->language->get('text_error_cat'));
         $this->data['heading_title'] = $this->language->get('text_error_cat');
         $this->data['text_error'] = $this->language->get('text_error_cat');

         $this->data['button_continue'] = $this->language->get('button_continue');

         $this->data['continue'] = $this->url->link('common/home');

         if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
         } else {
            $this->template = 'default/template/error/not_found.tpl';
         }
         
         $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
         );
         
         $this->response->setOutput($this->render());
       }
   }
   
   public function home() {
      $this->load->model('blog/helper');
      
      // Redirect page if Blog Manager is not installed
      if (!$this->model_blog_helper->checkDbTable('blog_setting')) { $this->redirect($this->url->link('common/home')); }
      
      $this->load->model('blog/setting');
      $this->load->model('blog/article');
      $this->load->model('blog/category');
      $this->load->model('tool/image');
      $this->data = $this->language->load('blog/blog');
      
      if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog.css')) {
         $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog.css');
      } else {
         $this->document->addStyle('catalog/view/theme/default/stylesheet/blog.css');
      }
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_custom.css')) { // use for customize
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_custom.css');
		} elseif (file_exists(DIR_TEMPLATE . 'default/stylesheet/blog_custom.css')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_custom.css');
		}
      
      $blogSetting = $this->model_blog_setting->getSettings();
      $date = date('Y-m-d H:i:s');
      
      if (isset($this->request->get['page'])) {
         $page = $this->request->get['page'];
      } else { 
         $page = 1;
      }
      $limit = $blogSetting['articleCat'];
      
      $this->data['breadcrumbs'] = array();
      $this->data['breadcrumbs'][] = array(
         'text'      => $this->language->get('text_home'),
         'href'      => $this->url->link('common/home'),
         'separator' => false
      );
      if (!$blogSetting['virDir']) {
			$this->data['breadcrumbs'][] = array(            
				'text'      => $this->language->get('text_blog'),
				'href'      => $this->url->link('blog/category/home'),
				'separator' => $this->language->get('text_separator')
			);
      } else {
			$this->data['breadcrumbs'][] = array(
				'text'      => ucfirst($blogSetting['virDirName']),
				'href'      => $this->url->link('blog/category/home'),
				'separator' => $this->language->get('text_separator')
			);
      }
      
      if (isset($blogSetting['blogHomeDescription'])) {
         $blogHomes	= unserialize($blogSetting['blogHomeDescription']);
         $language_id = $this->config->get('config_language_id');
         
         if ($blogHomes[$language_id]['meta_title']) {
            $this->document->setTitle($blogHomes[$language_id]['meta_title']);
         } else {
            $this->document->setTitle($blogHomes[$language_id]['name']);
         }
         $this->document->setKeywords($blogHomes[$language_id]['meta_keyword']);
         $this->document->setDescription($blogHomes[$language_id]['meta_description']);
      
         $this->data['heading_title']  = $blogHomes[$language_id]['name'];
         $this->data['blogHomeDesc']   = html_entity_decode($blogHomes[$language_id]['description'], ENT_QUOTES, 'UTF-8');
      } else {
         $this->document->setTitle($blogSetting['blogName']);
         $this->document->setKeywords($blogSetting['blogKeyword']);
         $this->document->setDescription($blogSetting['blogDescription']);
      
         $this->data['heading_title']  = $blogSetting['blogName'];
         $this->data['blogHomeDesc']   = false;
      }
      
      $this->data['catDescription']    = false;
      $this->data['categories']        = array();
      $this->data['suffix']            = $blogSetting['blogSuffix'];
      $this->data['column']            = $blogSetting['blogCol'];
      $this->data['feedLink']          = $this->url->link('feed/blog');
      
      $data = array(
         'article_order'         => $blogSetting['artOrder'],
         'exclude_category'      => unserialize($blogSetting['blogExclude']),
         'date'                  => date('Y-m-d H:i:s'),
         'start'                 => ($page - 1) * $limit,
         'limit'                 => $limit
      );
      
      $imageWidth = $blogSetting['articleFeatWidth'];
      $imageHeight = $blogSetting['articleFeatHeight'];
      
      //== Article
      $article_total = $this->model_blog_article->getTotalArticles($data);
      $this->data['articles']			= array();
      $this->data['blog_articles']	= array();
      $results = $this->model_blog_article->getArticles($data);
      
      if ($results) {         
         foreach ($results as $result) {
            $catArticle    = array();
            $catDisabled   = array();
            $catDatas      = $this->model_blog_article->getCategoriesByArticle($result['article_id']);
            foreach ($catDatas as $catData) {
               $catArticle[]     = '<a href="' . $this->url->link('blog/category', 'category_id=' . $catData['category_id']) . '">'. $catData['name'] . '</a>';
               $catDisabled[]    = $catData['category_id'];
            }
            
            if (isset($blogSetting['artInfoName'])) {
               $art_infoName     = sprintf($this->language->get('text_art_infoName'), $result['author']);
            } else {
               $art_infoName     = '';
            }
            if (isset($blogSetting['artInfoCategory']) && count($catDatas) >= '1') {
               $art_infoCategory    = sprintf($this->language->get('text_art_infoCategory'), implode(", ", $catArticle));
            } else {
               $art_infoCategory    = '';
            }
            if (isset($blogSetting['artInfoDate'])) {
               $art_InfoDate     = sprintf($this->language->get('text_art_InfoDate'), $this->model_blog_helper->date_format($result['created'], 'dfs'));
            } else {
               $art_InfoDate     = '';
            }
            
            if ($result['comment'] == '1') {
               $comments = sprintf($this->language->get('text_comments'), $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date));
            } elseif ($blogSetting['commentStatus']) {
               $commentCatDisabled = unserialize($blogSetting['commentDisableCat']);
                  if ($catDatas) {
                     $commCatIdDatas = $this->model_blog_article->getCategoriesId($result['article_id']);
                     $artCommByCatId = in_array($commCatIdDatas, $commentCatDisabled);
                     if ($artCommByCatId) {
                        $artComment = $this->model_blog_article->getCommentByArticleToCategory($commCatIdDatas);
                     } else {
                        $artComment = '';
                     }
                  } else {
                     $artComment = '';
                  }
               if ((array_intersect($catDisabled, $commentCatDisabled) && $result['comment'] == '0') || $blogSetting['guestComment'] == '0' || $result['comment'] == '0' || $artComment == '2') {
                  $comments = '';                  
               } else {
                  $comments = sprintf($this->language->get('text_comments'), $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date));
               }
            } else { 
               $comments = ''; 
            }
            
            $separator = '<!--more-->';
            $short_desc = explode($separator, html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'));
            if(isset($short_desc[1])) {
               $description = $short_desc[0];
            } else {
               $description = $this->model_blog_helper->truncate(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), $blogSetting['articleDesc']);
            }

            $this->data['articles'][] = array(
               'articlet_id'        => $result['article_id'],
               'title'              => $result['title'],
               'category'           => implode(", ", $catArticle),
               'modified'           => $this->model_blog_helper->date_format($result['modified'], 'dfs'),
               'description'        => strip_tags($description,'<b><i><em><u><a><strong><p><strike><div><span><ul><ol><li><br>'),
               'image'              => $this->model_tool_image->resize($result['image'], $imageWidth, $imageHeight),
					'image_width'			=> $imageWidth,
					'image_height'			=> $imageHeight,
               'comments'           => $comments,
               'comments_href'      => $this->url->link('blog/article', 'article_id=' . $result['article_id']),
               'readmore'           => $this->url->link('blog/article', 'article_id=' . $result['article_id']),
               'art_infoName'       => $art_infoName,
               'art_infoCategory'   => $art_infoCategory,
               'art_infoDate'       => $art_InfoDate,
               'art_infoComment'    => isset($blogSetting['artInfoComment']) ? $blogSetting['artInfoComment'] : false
            );
				
				// Push "as is" all Blog data to template. This will make any dev easy to create custom blog template.
				$this->data['blog_articles'][] = array(
					'articlet_id'        => $result['article_id'],
					'title'              => $result['title'],
					'author'       		=> $result['author'],
					'created'				=> $result['created'],
					'modified'           => $result['modified'],
					'description'        => $result['description'],
					'desc_char_limit'    => $blogSetting['articleDesc'],
					'desc_truncate'		=> $this->model_blog_helper->truncate(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'), $blogSetting['articleDesc']),
					'desc_striptags'		=> strip_tags($description,'<b><i><em><u><a><strong><p><strike><div><span><ul><ol><li><br>'),
					'image'              => $result['image'],
					'image_width'			=> $imageWidth,
					'image_height'			=> $imageHeight,
					'image_resized'		=> $this->model_tool_image->resize($result['image'], $imageWidth, $imageHeight),
					'categories'         => implode(', ', $catArticle),
					'comments'           => $this->model_blog_article->getTotalCommentsByArticleId($result['article_id'], $date),
					'comments_href'      => $this->url->link('blog/article', '&article_id=' . $result['article_id']),
					'readmore'           => $this->url->link('blog/article', '&article_id=' . $result['article_id']),
					
					'art_infoName'       => $art_infoName,
					'art_infoCategory'   => $art_infoCategory,
					'art_infoDate'       => $art_InfoDate,
					'art_infoComment'    => isset($blogSetting['artInfoComment']) ? $blogSetting['artInfoComment'] : false
				);
         }
         
         $pagination          = new Pagination();
         $pagination->total   = $article_total;
         $pagination->page    = $page;
         $pagination->limit   = $limit;
         $pagination->text    = $this->language->get('text_pagination');
         $pagination->url     = $this->url->link('blog/category/home', 'page={page}', 'SSL');
            
         $this->data['pagination'] = $pagination->render();
         
         // Blog Home Multi-template
         $blogHomeTemplate    = '';
         if(isset($blogSetting['blogHomeTemplate'])) {
            $blogHomeTemp     = unserialize($blogSetting['blogHomeTemplate']);
            if (isset($blogHomeTemp[$this->config->get('config_store_id')])) {
               $blogHomeTemplate = $blogHomeTemp[$this->config->get('config_store_id')];
            }
         }
         $templateFolder      = $this->config->get('config_template') . '/template/blog/';
         
         if (file_exists(DIR_TEMPLATE . $templateFolder . 'category_' . $blogHomeTemplate . '.tpl')) {
            $this->template = $templateFolder . 'category_' . $blogHomeTemplate . '.tpl';
         } elseif (file_exists(DIR_TEMPLATE . $templateFolder . 'category.tpl')) {
            $this->template = $templateFolder . 'category.tpl';
         } else {
            $this->template = 'default/template/blog/category.tpl';
         }
         
         $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
         );
      
         $this->response->setOutput($this->render());
      } else {
         $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_error_art'),
            'href'      => $this->url->link('blog/category/home'),
            'separator' => $this->language->get('text_separator')
         );
         
         $this->document->setTitle($this->language->get('text_error_art'));
         $this->data['heading_title'] = $this->language->get('text_error_art');
         $this->data['text_error'] = $this->language->get('text_error_art');

         $this->data['button_continue'] = $this->language->get('button_continue');

         $this->data['continue'] = $this->url->link('common/home');

         if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
         } else {
            $this->template = 'default/template/error/not_found.tpl';
         }
         
         $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
         );
         
         $this->response->setOutput($this->render());
      }
   }
}
?>