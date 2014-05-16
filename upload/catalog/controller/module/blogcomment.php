<?php
class ControllerModuleBlogcomment extends Controller {
	protected function index($setting) {
		$this->load->model('tool/image');
		$this->load->model('blog/article');
		$this->load->model('blog/helper');
		$this->language->load('module/blogcomment');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_module.css')) {
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_module.css');
		} else {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_module.css');
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/blog_module_custom.css')) { // use for customize
			$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/blog_module_custom.css');
		} elseif (file_exists(DIR_TEMPLATE . 'default/stylesheet/blog_module_custom.css')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/blog_module_custom.css');
		}
		
		$this->data['heading_title']	   = $this->language->get('heading_title');
      $this->data['text_comment_on']   = $this->language->get('text_comment_on');
		$this->data['classSuffix']		   = $setting['suffix'];

		if ($setting['exclude']) {
         $exclude = explode(',', $setting['exclude']);
      } else {
         $exclude = array();
      }
		
		$data = array(
			'exclude_category'	=> $exclude,
			'limit'					=> $setting['limit']
		);
		
		$this->load->model('blog/setting');
		$blogSetting = $this->model_blog_setting->getSettings();
		//get no follow setting
		$comment_nofollow_link = $blogSetting['commentNofollowLink'];
		
		
      $this->load->model('blog/helper');
		$this->data['comments'] = array();
		$results = $this->model_blog_article->getComments($data);

		foreach ($results as $result) {
			$replyDataName = $this->model_blog_article->getReplyAdminName($result['comment_id']);
         if (isset($replyDataName['adminName'])) {
            $replyName = $replyDataName['adminName'];
         } else {
            $replyName = $result['name'];
         }
         
			if ($result['website']) {
				if ($comment_nofollow_link){
					$author = '<a href="'.$result['website'].'" title="'.$result['website'].'" target="_blank" rel="nofollow">'.$replyName.'</a>';
				}else{
					$author = '<a href="'.$result['website'].'" title="'.$result['website'].'" target="_blank">'.$replyName.'</a>';
				}
			} else {
				$author = $replyName;
			}
			
			$this->data['comments'][] = array(
				'comment_id'	=> $result['comment_id'],
				'avatar'			=> $this->model_blog_helper->getGravatar($result['email'], $setting['image_width'], $setting['image_height']),
				'author'			=> $author,
				'name'			=> $replyName,
				'article'		=> $result['title'],
				'created'		=> $this->model_blog_helper->date_format($result['created'], 'dfs'),
				'link'			=> $this->url->link('blog/article', 'article_id=' . $result['article_id'])
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/blogcomment.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/blogcomment.tpl';
		} else {
			$this->template = 'default/template/module/blogcomment.tpl';
		}

		$this->render();
	}
}
?>