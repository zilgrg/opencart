<?php 
class ControllerFeedBlog extends Controller {
	public function index() {
		$this->load->model('blog/setting');
        $this->load->language('blog/blog');
		$blogSetting 	= $this->model_blog_setting->getSettings();
		$blogHome 		= unserialize($blogSetting['blogHomeDescription']);
		$language_id 	= $this->config->get('config_language_id');
        if ($blogHome[$language_id]['name']) {
            $titleBlog = $blogHome[$language_id]['name'];
        } else {
            $titleBlog = $this->language->get('text_blog');
        }
      
		$blogDescription   = strip_tags (html_entity_decode($blogHome[$language_id]['description'], ENT_QUOTES, 'UTF-8'),'&lt;b&gt;&lt;i&gt;&lt;em&gt;&lt;u&gt;&lt;a&gt;&lt;strong&gt;&lt;p&gt;&lt;strike&gt;&lt;div&gt;&lt;span&gt;&lt;ul&gt;&lt;ol&gt;&lt;li&gt;&lt;br&gt;');
		if ($blogSetting['blogFeed']) {
			$output  = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">';
			$output .= '<channel>';
			$output .= '<atom:link href="' . HTTP_SERVER . 'index.php?route=feed/blog" rel="self" type="application/rss+xml" />';
			$output .= '<title>' . $titleBlog . '</title>';
			$output .= '<link>' . $this->config->get('config_url') . '</link>';
			$output .= '<description>' . $blogDescription . '</description>';
			$output .= '<image>';
			$output .= '<title>' . $titleBlog . '</title>';
			$output .= '<url>' . $this->config->get('config_url') . 'image/' . $this->config->get('config_logo') . '</url>';
			$output .= '<link>' . $this->config->get('config_url') . '</link>';
			$output .= '</image>'; 
		
			$this->load->model('tool/image');
			$this->load->model('blog/article');
			$this->load->model('blog/helper');
            $this->language->load('blog/blog');
			
			$data = array(
				'article_order'	=> 'dateDesc',
            'date'            => date('Y-m-d H:i:s'),
				'start'				=> 0,
				'limit'				=> $blogSetting['feedLimit']
			);
		
			$results = $this->model_blog_article->getArticles($data);
			
			foreach ($results as $result) {
				$catArticle = array();
				$catDatas = $this->model_blog_article->getCategoriesByArticle($result['article_id']);
				
				if ($result['description']) {
					$separator = '&lt;!--more--&gt;';
					$short_desc = explode($separator, $result['description']);
					if(isset($short_desc[1])) {
						$description = $short_desc[0];
					} else {
						$description = $this->model_blog_helper->truncate($result['description'], $blogSetting['articleDesc']);
					}
					
					$output .= '<item>';
					$output .= '<title>' . $result['title'] . '</title>';
					//$output .= '<author>' . $result['author'] . '</author>';
					foreach ($catDatas as $catData) {
						$output .= '<category domain="' . str_replace('&', '&amp;', $this->url->link('blog/category', 'category_id=' . $catData['category_id'])) . '">' . $catData['name'] . '</category>';
					}
					$output .= '<pubDate>' . date(DATE_RSS, strtotime($result['created'])) . '</pubDate>';
					$output .= '<link>' . $this->url->link('blog/article', 'article_id=' . $result['article_id']) . '</link>';
                    $output .= '<guid>' . $this->url->link('blog/article', 'article_id=' . $result['article_id']) . '</guid>';
					$output .= '<description>';
					if ($result['image']) { $output .= '&lt;img src="'.$this->model_tool_image->resize($result['image'], 120, 120).'" alt="" align="left" /&gt;'; }
					$output .= $description . ' ' . '&lt;a href="' . str_replace('&', '&amp;', $this->url->link('blog/article', 'article_id=' . $result['article_id'])) . '"&gt; ' . $this->language->get('read_more') . '&lt;/a&gt; ' . '</description>';
					$output .= '</item>';
				}
			}
			
			$output .= '</channel>'; 
			$output .= '</rss>';	
			
			$this->response->addHeader('Content-Type: application/rss+xml');
			$this->response->setOutput($output);
		}
	}
   
   public function category() {   
      $this->load->model('blog/setting');
      $this->load->language('blog/blog');
      $this->load->model('tool/image');
      $this->load->model('blog/article');
      $this->load->model('blog/category');
      $this->load->model('blog/helper');
      $this->language->load('blog/blog');
      $blogSetting 	= $this->model_blog_setting->getSettings();
      
      $categoryData = $this->model_blog_category->getCategory($this->request->get['category_id']);
      if ($categoryData) {
         if ($categoryData['name']) {
            $titleBlog = $categoryData['name'];
         } else {
            $titleBlog = '';
         }
         
         if ($categoryData['image']) {
            $image = $this->model_tool_image->resize($categoryData['image'], 45, 45);
         } else {
            $image = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
         }
         
         if ($categoryData['meta_description']) {
            $blogDescription   = strip_tags (html_entity_decode($categoryData['meta_description'], ENT_QUOTES, 'UTF-8'),'&lt;b&gt;&lt;i&gt;&lt;em&gt;&lt;u&gt;&lt;a&gt;&lt;strong&gt;&lt;p&gt;&lt;strike&gt;&lt;div&gt;&lt;span&gt;&lt;ul&gt;&lt;ol&gt;&lt;li&gt;&lt;br&gt;');
         } else {
            $blogDescription   = strip_tags (html_entity_decode($categoryData['description'], ENT_QUOTES, 'UTF-8'),'&lt;b&gt;&lt;i&gt;&lt;em&gt;&lt;u&gt;&lt;a&gt;&lt;strong&gt;&lt;p&gt;&lt;strike&gt;&lt;div&gt;&lt;span&gt;&lt;ul&gt;&lt;ol&gt;&lt;li&gt;&lt;br&gt;');
         }
      }
      
		if ($blogSetting['blogFeed']) {
			$output  = '<?xml version="1.0" encoding="UTF-8" ?>';
			$output .= '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">';
			$output .= '<channel>';
			$output .= '<atom:link href="' . HTTP_SERVER . 'index.php?route=feed/blog/category&amp;category_id&#61;' . $this->request->get['category_id'] . '" rel="self" type="application/rss+xml" />';
			$output .= '<title>' . $titleBlog . '</title>';
			$output .= '<link>' . $this->config->get('config_url') . '</link>';
			$output .= '<description>' . $blogDescription . '</description>';
			$output .= '<image>';
			$output .= '<title>' . $titleBlog . '</title>';
			$output .= '<url>' . $image . '</url>';
			$output .= '<link>' . $this->config->get('config_url') . '</link>';
			$output .= '</image>';			
			$data = array(
            'filter_category_id' => $this->request->get['category_id'],
            'article_order'	   => 'dateDesc',
            'date'               => date('Y-m-d H:i:s'),
            'start'				   => 0,
            'limit'				   => $blogSetting['feedLimit']
         );
         $catID = 'category_id=' . $this->request->get['category_id'];
			$results = $this->model_blog_article->getArticles($data);
			
			foreach ($results as $result) {
				$catArticle = array();
				$catDatas = $this->model_blog_article->getCategoriesByArticle($result['article_id']);
				
				if ($result['description']) {
					$separator = '&lt;!--more--&gt;';
					$short_desc = explode($separator, $result['description']);
					if(isset($short_desc[1])) {
						$description = $short_desc[0];
					} else {
						$description = $this->model_blog_helper->truncate($result['description'], $blogSetting['articleDesc']);
					}
					
					$output .= '<item>';
					$output .= '<title>' . $result['title'] . '</title>';
					//$output .= '<author>' . $result['author'] . '</author>';
					/*foreach ($catDatas as $catData) {
						$output .= '<category domain="' . str_replace('&', '&amp;', $this->url->link('blog/category', 'category_id=' . $catData['category_id'])) . '">' . $catData['name'] . '</category>';
					}*/
					$output .= '<pubDate>' . date(DATE_RSS, strtotime($result['created'])) . '</pubDate>';
					$output .= '<link>' . $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']) . '</link>';
               $output .= '<guid>' . $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id']) . '</guid>';
					$output .= '<description>';
					if ($result['image']) { $output .= '&lt;img src="'.$this->model_tool_image->resize($result['image'], 120, 120).'" alt="" align="left" /&gt;'; }
					$output .= $description . ' ' . '&lt;a href="' . str_replace('&', '&amp;', $this->url->link('blog/article', $catID . '&article_id=' . $result['article_id'])) . '"&gt; ' . $this->language->get('read_more') . '&lt;/a&gt; ' . '</description>';
					$output .= '</item>';
				}
			}
			
			$output .= '</channel>'; 
			$output .= '</rss>';	
			
			$this->response->addHeader('Content-Type: application/rss+xml');
			$this->response->setOutput($output);
		}
   }
}?>