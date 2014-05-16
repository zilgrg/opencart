<?php
class ModelBlogBlog extends Model {
	public function install() {
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article` ( `article_id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY, `author_id` int(11) NOT NULL DEFAULT '0', `image` varchar(255) COLLATE utf8_bin DEFAULT NULL, `sort_order` int(11) NOT NULL DEFAULT '0', `comment` int(11) NOT NULL DEFAULT '2', `robots` varchar(128) COLLATE utf8_bin NOT NULL, `status` int(11) NOT NULL DEFAULT '0', `available` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', `created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', `modified` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', `viewed` int(11) NOT NULL DEFAULT '0' ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_description` ( `article_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `title` varchar(128) COLLATE utf8_bin NOT NULL, `meta_title` varchar(128) COLLATE utf8_bin NOT NULL, `meta_keyword` varchar(255) COLLATE utf8_bin NOT NULL, `meta_description` varchar(255) COLLATE utf8_bin NOT NULL, `description` longtext COLLATE utf8_bin NOT NULL, PRIMARY KEY (`article_id`,`language_id`), KEY `name` (`title`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_related` ( `article_id` int(11) NOT NULL, `related_id` int(11) NOT NULL, PRIMARY KEY (`article_id`,`related_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_tag` ( `tag_id` int(11) NOT NULL AUTO_INCREMENT, `article_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `tag` varchar(128) COLLATE utf8_bin NOT NULL, PRIMARY KEY (`tag_id`), KEY `article_id` (`article_id`), KEY `language_id` (`language_id`), KEY `tag` (`tag`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_to_category` ( `article_id` int(11) NOT NULL, `category_id` int(11) NOT NULL, PRIMARY KEY (`article_id`,`category_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_to_layout` ( `article_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `layout_id` int(11) NOT NULL, PRIMARY KEY (`article_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_to_store` ( `article_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, PRIMARY KEY (`article_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
      $this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_article_to_template` ( `article_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `template` varchar(128) NOT NULL, PRIMARY KEY (`article_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_author` ( `author_id` int(11) NOT NULL AUTO_INCREMENT, `author_group_id` int(11) NOT NULL DEFAULT '0', `user_id` int(11) NOT NULL DEFAULT '0', `name` varchar(128) COLLATE utf8_bin NOT NULL, PRIMARY KEY (`author_id`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_author_group` ( `author_group_id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(64) COLLATE utf8_bin NOT NULL, `permission` text COLLATE utf8_bin NOT NULL, PRIMARY KEY (`author_group_id`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4;");
		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_author_group` ( `author_group_id`, `name`, `permission`) VALUES (3, 'Author', '" . $this->db->escape('a:2:{i:0;s:10:"addArticle";i:1;s:14:"editOwnArticle";}') . "'),  (2, 'Editor', '" . $this->db->escape('a:14:{i:0;s:10:"addArticle";i:1;s:11:"copyArticle";i:2;s:14:"editOwnArticle";i:3;s:16:"editOtherArticle";i:4;s:12:"changeAuthor";i:5;s:13:"removeArticle";i:6;s:11:"editComment";i:7;s:12:"replyComment";i:8;s:13:"removeComment";i:9;s:11:"addCategory";i:10;s:12:"copyCategory";i:11;s:12:"editCategory";i:12;s:14:"removeCategory";i:13;s:9:"addAuthor";}') . "'), (1, 'Admin', '" . $this->db->escape('a:18:{i:0;s:10:"addArticle";i:1;s:11:"copyArticle";i:2;s:14:"editOwnArticle";i:3;s:16:"editOtherArticle";i:4;s:12:"changeAuthor";i:5;s:13:"removeArticle";i:6;s:11:"editComment";i:7;s:12:"replyComment";i:8;s:13:"removeComment";i:9;s:11:"addCategory";i:10;s:12:"copyCategory";i:11;s:12:"editCategory";i:12;s:14:"removeCategory";i:13;s:9:"addAuthor";i:14;s:10:"editAuthor";i:15;s:12:"removeAuthor";i:16;s:14:"editPermission";i:17;s:11:"editSetting";}') . "');");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_category` ( `category_id` int(11) NOT NULL AUTO_INCREMENT, `parent_id` int(11) NOT NULL DEFAULT '0', `robots` varchar(128) COLLATE utf8_bin NOT NULL, `image` varchar(255) COLLATE utf8_bin DEFAULT NULL, `sort_order` int(11) NOT NULL DEFAULT '0', `article_order` varchar(64) COLLATE utf8_bin NOT NULL, `width` int(11) NOT NULL, `height` int(11) NOT NULL, `desc_limit` int(11) NOT NULL, `status` int(11) NOT NULL DEFAULT '0', `suffix` varchar(128) COLLATE utf8_bin NOT NULL, `category_col` varchar(128) COLLATE utf8_bin NOT NULL, `created` date NOT NULL, `modified` date NOT NULL, PRIMARY KEY (`category_id`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_category_description` ( `category_id` int(11) NOT NULL, `language_id` int(11) NOT NULL, `name` varchar(128) COLLATE utf8_bin NOT NULL, `meta_title` varchar(128) COLLATE utf8_bin NOT NULL, `meta_keyword` varchar(255) COLLATE utf8_bin NOT NULL, `meta_description` varchar(255) COLLATE utf8_bin NOT NULL, `description` text COLLATE utf8_bin NOT NULL, PRIMARY KEY (`category_id`,`language_id`), KEY `name` (`name`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_category_to_layout` ( `category_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `layout_id` int(11) NOT NULL, PRIMARY KEY (`category_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_category_to_store` ( `category_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, UNIQUE KEY `category_id` (`category_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
      $this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_category_to_template` ( `category_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `template` varchar(128) NOT NULL, PRIMARY KEY (`category_id`,`store_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_comment` ( `comment_id` int(11) NOT NULL AUTO_INCREMENT, `parent_id` int(11) NOT NULL, `customer_id` int(11) NOT NULL, `article_id` int(11) NOT NULL, `name` varchar(64) COLLATE utf8_bin NOT NULL, `email` varchar(96) COLLATE utf8_bin NOT NULL, `website` varchar(128) COLLATE utf8_bin NOT NULL, `content` text COLLATE utf8_bin NOT NULL, `status` tinyint(1) NOT NULL, `staff_id` int(11) NOT NULL, `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', UNIQUE KEY `comment_id` (`comment_id`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_product_related` ( `article_id` int(11) NOT NULL, `product_id` int(11) NOT NULL, PRIMARY KEY (`article_id`,`product_id`) ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
		$this->db->query("CREATE TABLE `" . DB_PREFIX . "blog_setting` ( `setting_id` int(11) NOT NULL AUTO_INCREMENT, `key` varchar(64) COLLATE utf8_bin NOT NULL, `value` text COLLATE utf8_bin NOT NULL, PRIMARY KEY (`setting_id`) ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=30;");
      
      //== Insert default Setting value
      $this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
      $blogHomesDesc = array();
      foreach ($languages as $language) {
         $blogHomesDesc[$language['language_id']] = array(
            'name'               => 'Blog',
            'description'        => '',
            'meta_title'         => '',
            'meta_description'   => '',
            'meta_keyword'       => ''
         );
      }
      $blogDatas = serialize($blogHomesDesc);
		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'blogHomeDescription', '" . $this->db->escape($blogDatas) . "'), (NULL, 'blogExclude', 'a:0:{}'), (NULL, 'blogSuffix', ''), (NULL, 'articleCat', '8'), (NULL, 'articleDesc', '650'), (NULL, 'articleFeatWidth', '150'), (NULL, 'articleFeatHeight', '150'), (NULL, 'relProduct', '5'), (NULL, 'relProductWidth', '100'), (NULL, 'relProductHeight', '100'), (NULL, 'socMedia', '1'), (NULL, 'pubID', ''), (NULL, 'socMedCode', ''), (NULL, 'commentStatus', '1'), (NULL, 'commentDisableCat', 'a:0:{}'), (NULL, 'commentLimit', '6'), (NULL, 'commentAvatar', '54'), (NULL, 'commentDefApprove', '0'), (NULL, 'commentApproveGroup', 'a:0:{}'), (NULL, 'commentBadgeGroup', 'a:0:{}'), (NULL, 'commentCaptha', 'disabled'), (NULL, 'searchStatus', '1'), (NULL, 'searchLimit', '6'), (NULL, 'searchDisplay', 'compact'), (NULL, 'searchGrid', '6'), (NULL, 'blogFeed', '1'), (NULL, 'blogSitemap', '1'), (NULL, 'articleAdmin', '40'), (NULL, 'artInfoName', 'on'), (NULL, 'artInfoCategory', 'on'), (NULL, 'artInfoDate', 'on'), (NULL, 'artInfoComment', 'on'), (NULL, 'artInfoUpdate', 'on'), (NULL, 'commentMin', '25'), (NULL, 'commentMax', '1500'), (NULL, 'seoSuffix', '.html'), (NULL, 'virDir', '1'), (NULL, 'virDirName', 'blog'), (NULL, 'virDirExclude', 'a:0:{}'), (NULL, 'guestComment', '1'), (NULL, 'blogCol', ''), (NULL, 'artOrder', 'dataDesc'), (NULL, 'commentOrder', 'DESC'), (NULL, 'emailNotify', ''), (NULL, 'relProductArticle', '0'), (NULL, 'relProductRelated', '1'), (NULL, 'feedLimit', '500'), (NULL, 'sitemapLimit', '1000'), (NULL, 'commentAdminBadgeGroup', 'a:0:{}'), (NULL, 'adminBlogColors', 'a:0:{}'), (NULL, 'commentBadgeColor', 'a:0:{}'), (NULL, 'srchInfoName', 'on'), (NULL, 'srchInfoDate', 'on'), (NULL, 'blogHomeTemplate', 'a:0:{}'), (NULL, 'blogCatTemplate', 'a:0:{}'), (NULL, 'blogArtTemplate', 'a:0:{}'), (NULL, 'categoryRobots', 'index, follow'), (NULL, 'articleRobots', 'index, follow'), (NULL, 'commentNofollowLink', '1'), (NULL, 'autoCatKeyword', '1'), (NULL, 'autoArtKeyword', '1');");
		
		//== Automatically insert Layout Route
		$layout_route = array();
		$layout_route[] = array( 'store_id' => 0, 'route' => 'blog/article' );
		$layout_route[] = array( 'store_id' => 0, 'route' => 'blog/category' );
		$data = array ( 'name' => 'Blog', 'layout_route' => $layout_route );
		
		$this->load->model('design/layout');
		$this->model_design_layout->addLayout($data);

		//== Automatically insert Virtual Directory to config
		$blogConfig = array(
			'blogSetting_virDir'			 		=> '1',
			'blogSetting_virDirName'			=> 'blog',
			'blogSetting_virDirExclude'		=> array(),
			'blogSetting_relProductArticle'  => '0'
		);
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('blogSetting', $blogConfig);
	}

	public function uninstall() {
		$this->db->query("DROP TABLE `" . DB_PREFIX . "blog_article`, `" . DB_PREFIX . "blog_article_description`, `" . DB_PREFIX . "blog_article_related`, `" . DB_PREFIX . "blog_article_tag`, `" . DB_PREFIX . "blog_article_to_category`, `" . DB_PREFIX . "blog_article_to_layout`, `" . DB_PREFIX . "blog_article_to_store`, `" . DB_PREFIX . "blog_article_to_template`, `" . DB_PREFIX . "blog_author`, `" . DB_PREFIX . "blog_author_group`, `" . DB_PREFIX . "blog_category`, `" . DB_PREFIX . "blog_category_description`, `" . DB_PREFIX . "blog_category_to_layout`, `" . DB_PREFIX . "blog_category_to_store`, `" . DB_PREFIX . "blog_category_to_template`, `" . DB_PREFIX . "blog_comment`, `" . DB_PREFIX . "blog_product_related`, `" . DB_PREFIX . "blog_setting`;");
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE `query` LIKE 'blog_%'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "layout WHERE `name` LIKE 'Blog'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "layout_route WHERE `route` LIKE 'blog/%'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `group` LIKE 'blog%'");
    
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting('blogSetting');
	}

	public function getTotalArticles() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_article");
		return $query->row['total'];
	}
	
	public function getTotalComments() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_comment");
		return $query->row['total'];
	}
	
	public function getTotalCategories() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_category");
		return $query->row['total'];
	}
	
	public function getTotalAuthors() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "blog_author");
		return $query->row['total'];
	}
   
   //======= UPDATE SECTION
	
	public function update11to12x() {
		// Important! Make sure your Blog Manager version is v.1.1 before update to v.1.2
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_category` ADD `image` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_bin NULL AFTER `parent_id`");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article` CHANGE `created` `created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article` CHANGE `modified` `modified` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'");
		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'artInfoName', 'on'), (NULL, 'artInfoCategory', 'on'), (NULL, 'artInfoDate', 'on'), (NULL, 'artInfoComment', 'on'), (NULL, 'artInfoUpdate', 'on'), (NULL, 'commentMin', '25'), (NULL, 'commentMax', '1500'), (NULL, 'seoSuffix', '');");
	}
	
	public function update12xto13($data = array()) {
		$serBlogExclude			= 'a:0:{}';
		$serCommentDisableCat	= 'a:0:{}';
		$serCommentApproveGroup	= 'a:0:{}';
		$serCommentBadgeGroup	= 'a:0:{}';
		$serVirDirExclude			= 'a:0:{}';
      $virDirExcludes         = array();
		$setBlogCol					= '';
		$setBlogSuffix				= '';
		
		if ($data['blogExclude']) {
			$excludes		   = explode(',', $data['blogExclude']);
			foreach ($excludes as $exclude) { $blogExclude[] = $exclude; }

			$serBlogExclude   = serialize($blogExclude);
		}
		if ($data['commentDisableCat']) {
			$excludes		   = explode(',', $data['commentDisableCat']);
			foreach ($excludes as $exclude) { $commentDisableCat[] = $exclude; }

			$serCommentDisableCat = serialize($commentDisableCat);
		}
		if ($data['commentApproveGroup']) {
			$excludes		   = explode(',', $data['commentApproveGroup']);
			foreach ($excludes as $exclude) { $commentApproveGroup[] = $exclude; }

			$serCommentApproveGroup = serialize($commentApproveGroup);
		}
		if ($data['commentBadgeGroup']) {
			$excludes		   = explode(',', $data['commentBadgeGroup']);
			foreach ($excludes as $exclude) { $commentBadgeGroup[] = $exclude; }

			$serCommentBadgeGroup = serialize($commentBadgeGroup);
		}
      if ($data['blogVirDir']) {
			$blogVirDir       = $data['blogVirDir'];
		} else {
         $blogVirDir       = '1';
      }
		if ($data['blogVirDirName']) {
			$blogVirDirName   = $data['blogVirDirName'];
		} else {
         $blogVirDirName   = 'blog';
      }
		if ($data['virDirExclude']) {
			$excludes         = explode(',', $data['virDirExclude']);
         $virDirExcludes   = $excludes;
			foreach ($excludes as $exclude) { $virDirExclude[] = $exclude; }

			$serVirDirExclude = serialize($virDirExclude);
		}
		
		if ($data['blogCol']) { 
			if (strpos($data['blogCol'], 'blogCol2') !== false) { $setBlogCol = 'blogCol2 imageBlock equalHeight'; }
			if (strpos($data['blogCol'], 'blogCol3') !== false) { $setBlogCol = 'blogCol3 imageBlock equalHeight'; }
			if (strpos($data['blogCol'], 'blogCol4') !== false) { $setBlogCol = 'blogCol4 imageBlock equalHeight'; }
			
			$blogSuffix = array('blogCol2','blogCol3','blogCol4','imageBlock'); // alter the suffix data contain this array
			$setBlogSuffix = str_replace($blogSuffix, '', $data['blogCol']);
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'blogExclude'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'commentDisableGroup'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'commentApproveGroup'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'commentBadgeGroup'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'virDirExclude'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "blog_setting WHERE `key` = 'blogCol'");
		$this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'blogExclude', '" . $serBlogExclude . "'), (NULL, 'guestComment', '1'), (NULL, 'blogCol', '" . $this->db->escape($setBlogCol) . "'), (NULL, 'blogSuffix', '" . $this->db->escape($setBlogSuffix) . "'), (NULL, 'artOrder', 'dateDesc'), (NULL, 'commentOrder', 'DESC'), (NULL, 'emailNotify', ''), (NULL, 'commentDisableCat', '" . $this->db->escape($serCommentDisableCat) . "'), (NULL, 'commentApproveGroup', '" . $this->db->escape($serCommentApproveGroup) . "'), (NULL, 'commentBadgeGroup', '" . $this->db->escape($serCommentBadgeGroup) . "'), (NULL, 'virDirExclude', '" . $this->db->escape($serVirDirExclude) . "'), (NULL, 'relProductArticle', '0'), (NULL, 'relProductRelated', '1');");
		
		// Blog categories
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_category` ADD `category_col` VARCHAR( 128 ) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL AFTER `suffix`");
		if ($data['catBlogCols']) { // update all categories
			$blogSuffix = array('blogCol2','blogCol3','blogCol4','imageBlock');
			
			foreach ($data['catBlogCols'] as $category){
				$setCatCol	= '';
				if (strpos($category['cat_col'], 'blogCol2') !== false) { $setCatCol = 'blogCol2 imageBlock equalHeight'; }
				if (strpos($category['cat_col'], 'blogCol3') !== false) { $setCatCol = 'blogCol3 imageBlock equalHeight'; }
				if (strpos($category['cat_col'], 'blogCol4') !== false) { $setCatCol = 'blogCol4 imageBlock equalHeight'; }
				
				$setCatSuffix = str_replace($blogSuffix, '', $category['cat_col']);
				
				$this->db->query("UPDATE " . DB_PREFIX . "blog_category SET suffix = '" . $this->db->escape($setCatSuffix) . "', category_col = '" . $this->db->escape($setCatCol) . "' WHERE category_id = '" . (int)$category['cat_id'] . "'");
			}
		}
		
		// update OpenCart blog config
		$blogConfig = array(
			'blogSetting_virDir'			 		=> $blogVirDir,
			'blogSetting_virDirName'			=> $blogVirDirName,
			'blogSetting_virDirExclude'		=> $virDirExcludes,
			'blogSetting_relProductArticle'  => '0'
		);
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('blogSetting', $blogConfig);
	}
   
   public function update131to132() {
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article_description` CHANGE `description` `description` longtext COLLATE utf8_bin NOT NULL");
	}
	
	public function update132to133() {
      $this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'feedLimit', '500'), (NULL, 'sitemapLimit', '1000'), (NULL, 'commentAdminBadgeGroup', 'a:0:{}'), (NULL, 'adminBlogColors', 'a:0:{}'), (NULL, 'commentBadgeColor', 'a:0:{}'), (NULL, 'srchInfoName', 'on'), (NULL, 'srchInfoDate', 'on');");
	}
	
	public function update133to134($data) {
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article` ADD `comment` int(11) NOT NULL DEFAULT '2' AFTER `sort_order`");
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article_description` ADD `meta_title` VARCHAR(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL AFTER `title`");
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_category_description` ADD `meta_title` VARCHAR(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL AFTER `name`");
      
      $this->db->query("CREATE TABLE IF NOT EXISTS `". DB_PREFIX ."blog_article_to_template` (`article_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `template` varchar(128) NOT NULL, PRIMARY KEY (`article_id`,`store_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");
      $this->db->query("CREATE TABLE IF NOT EXISTS `". DB_PREFIX ."blog_category_to_template` (`category_id` int(11) NOT NULL, `store_id` int(11) NOT NULL, `template` varchar(128) NOT NULL, PRIMARY KEY (`category_id`,`store_id`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

      $this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'blogHomeTemplate', 'a:0:{}'), (NULL, 'blogCatTemplate', 'a:0:{}'), (NULL, 'blogArtTemplate', 'a:0:{}');");

      // update Blog Home with meta title
      if ($data['blogHomeDesc']) {
         foreach ($data['languages'] as $language) {
            $blogHomeDesc[$language['language_id']] = array(
               'name'            => $data['blogHomeDesc'][$language['language_id']]['name'],
               'description'     => $data['blogHomeDesc'][$language['language_id']]['description'],
               'meta_title'      => '',
               'meta_description'=> $data['blogHomeDesc'][$language['language_id']]['meta_description'],
               'meta_keyword'    => $data['blogHomeDesc'][$language['language_id']]['meta_keyword']
            );
         }
      }
      
      $this->load->model('blog/setting');
		$this->model_blog_setting->updateSettingKey('blogHomeDescription', serialize($blogHomeDesc));
	}
   public function update135to136() {
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article` ADD `robots` VARCHAR(128) NOT NULL AFTER `comment`");
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_article` CHANGE `available` `available` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00'");
      $this->db->query("ALTER TABLE `" . DB_PREFIX . "blog_category` ADD `robots` VARCHAR(128) NOT NULL AFTER `parent_id`");
      $this->db->query("INSERT INTO `" . DB_PREFIX . "blog_setting` (`setting_id`, `key`, `value`) VALUES (NULL, 'categoryRobots', 'index, follow'), (NULL, 'articleRobots', 'index, follow'), (NULL, 'commentNofollowLink', '1'), (NULL, 'autoCatKeyword', '1'), (NULL, 'autoArtKeyword', '1');");
	}
}
?>