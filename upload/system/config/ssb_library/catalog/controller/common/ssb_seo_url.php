<?php
class ssb_seo_url extends Controller {

	private $ssb_helper;
	private $ssb_data;
	private $ssb_setting;
	private $query_data = array();
	
	function __construct(){ 
		global $registry;
		parent::__construct($registry);
				
		require_once DIR_CONFIG .'ssb_library/ssb_helper.php';
		$this->ssb_helper = ssb_helper::getInstance();
		
		require_once DIR_CONFIG .'ssb_library/ssb_data.php';
		$this->ssb_data = ssb_data::getInstance();
		
		$this->ssb_setting = $this->ssb_data->getSetting();
	
	}

	static private $Instance   = NULL;
	
	static public function getInstance() {
	if(self::$Instance==NULL){
		$class = __CLASS__;
		self::$Instance = new $class;
	}
	return self::$Instance;
	}
	
	private function seo_language($link,$language) { 
		$link_orig = $link;
		$config_lang = $this->ssb_helper->getDefaultLanguage();

		//echo ' || $link='. $link . 'config_lang='. $config_lang .'; language='.$language;  
		
		if (trim($language) == trim($config_lang)) unset($language);
		$url_data = parse_url($link);
		if (strpos('a'.$url_data['scheme'].'a','https') ) {
			$link = $this->config->get('config_ssl');}
		else {
			$link = $this->config->get('config_url');
		}	
		if (isset($language) ) $link .= $language.'/';
		if (isset($url_data['path']) ) {
		$temp_path = explode('/',$url_data['path']);
		foreach ($temp_path as $key => $value) {
			if(!empty($value))
			if (strpos($link,$value)) unset($temp_path[$key]);
		}
		$url_data['path'] = implode('/',$temp_path);
			if(substr($url_data['path'],0,1) == '/') 
				$url_data['path'] = substr($url_data['path'],1);
		}
		$link .= $url_data['path'];
		//if(substr($link,-1) == '/') $link = substr($link,0,-1);
		if (isset($url_data['query']) ) $link .= '?'.$url_data['query'];
		
		$link = rtrim($link,"/");
		return $link;
	}
	
	public function index() {
		
		$curPageURL = $this->curPageURL();	
	
		// if last char is /, deleting it and redirect
		$tools = $this->ssb_data->getSetting('tools');
		if(substr($curPageURL,-1) == '/' AND $tools['trailing_slash']['status'] == true) {
			$new_url = rtrim($curPageURL,"/");  
			$this->ssb_helper->redirect($new_url, 301);
		}

		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		
		$lang_inURL = $this->getLangFromUrl();

		if (isset($this->request->get['_route_']) AND $this->request->get['_route_'] != $lang_inURL['code']){
			//echo '_route_ = '; echo $this->request->get['_route_'].'; '; var_dump($lang_inURL);
			$l_code_session = $this->session->data['language'];
			$l_id_session 	= $this->ssb_helper->getLang_Code_Id($l_code_session);
			
			$parts = explode('/', $this->request->get['_route_']);
			
			foreach ($parts as $part) {
				
				$part = trim($part);
				if (empty($part) ) continue;
			
				$sql = "SELECT auto_gen, language_id, query FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'";
				$query = $this->db->query($sql);
				
				if ($query->num_rows) {
					$result = $query->rows[0];
					$this->parseQuery($result);
					
					if($result['language_id'] !== $l_id_session AND $l_code_session == $lang_inURL['code'] AND $query->num_rows == 1){
						$urlWasCange = true;
					}
					
				}else if(!$query->num_rows) {
					$this->request->get['route'] = 'error/not_found';	
				}
			}
			
			$this->setRouteType();
			
			// handing change url(replace keyword)
			if(isset($urlWasCange) AND $urlWasCange){
				$route = $this->request->get['route'];
				if($route == 'product/product' OR $route == 'product/product' OR $route == 'product/category' OR $route == 'product/manufacturer/info' OR $route == 'information/information'){
					$this->redirectPermanently();
				}
			}
		}
		
		if (isset($this->request->get['route'])) {
			return $this->forward($this->request->get['route']);
		}
	}
	
	function redirectPermanently(){
		$query_url 	= http_build_query($this->query_data);
		$route 		= isset($this->request->get['route']) ? $this->request->get['route'] : 'common/home';
		$new_url = $this->url->link($route, $query_url, 'SSL');
		//echo $new_url;
		$this->ssb_helper->redirect($new_url, 301);
	}
	
	function parseQuery($query){
		//var_dump($query);
		$url = explode('=', $query['query']);

		if ($url[0] == 'product_id') {
			$this->query_data['product_id'] = $this->request->get['product_id'] = $url[1];
			
		}
		
		if ($url[0] == 'category_id') {
			if (!isset($this->request->get['path'])) {
				$this->query_data['path'] = $this->request->get['path'] = $url[1];
			} else {
				$this->request->get['path'] .= '_' . $url[1];
				$this->query_data['path'] .= '_' . $url[1];
			}
		}	
		
		//blog_system START (1)
		if ($url[0] == 'blog_category_id') {
			if (!isset($this->request->get['blogpath'])) {
				$this->request->get['blogpath'] = $url[1];
			} else {
				$this->request->get['blogpath'] .= '_' . $url[1];
			}
		}
		
		if ($url[0] == 'blog_id') {
			$this->request->get['blog_id'] = $url[1];
		}
		
		if ($url[0] == 'post_category_id') {
			if (!isset($this->request->get['postpath'])) {
				$this->request->get['postpath'] = $url[1];
			} else {
				$this->request->get['postpath'] .= '_' . $url[1];
			}
		}
		//blog_system END
		
		if ($url[0] == 'manufacturer_id') {
			$this->query_data['manufacturer_id'] = $this->request->get['manufacturer_id'] = $url[1];
		}
		
		if ($url[0] == 'information_id') {
			$this->query_data['information_id'] = $this->request->get['information_id'] = $url[1];
		}
		if (isset($url[0]) AND !isset($url[1])) { 
			$this->query_data['route'] = $this->request->get['route'] = $url[0];
		}
		
		//===========
		if (isset($this->request->get['filter'])) {
			$this->query_data['filter'] = $this->request->get['filter'];
		}
				
		if (isset($this->request->get['sort'])) {
			$this->query_data['sort'] = $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$this->query_data['order'] = $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$this->query_data['page'] = $this->request->get['page'];
		}	
							
		if (isset($this->request->get['limit'])) {
			$this->query_data['limit'] = $this->request->get['limit'];
		}
		//===========
	}
	
		/*
	get current or new language from url
	*/
	private function getLangFromUrl() {
		
		$l_code = $this->ssb_helper->getDefaultLanguage();
		
		$lang_default = array(
			'code' 			=> $l_code,
			'language_id'	=> $this->ssb_helper->getLang_Code_Id($l_code)
		);
		
		if (isset($this->request->get['_route_'])) {
			$parts = explode('/', $this->request->get['_route_']);
		}else{
			return $lang_default;
		}
		
		$lang_inURL = array();
		
		foreach ($parts as $part) {
			$part = trim($part);
			if (empty($part) ) continue;
			$query_lang = $this->db->query("SELECT language_id, code FROM " . DB_PREFIX . "language WHERE code = '" . $this->db->escape($part) . "'");
			
			if($query_lang->num_rows){
				$lang_inURL['code']			= $query_lang->row['code'];
				$lang_inURL['language_id']	= $query_lang->row['language_id'];
			}
		}
		
		if (count($lang_inURL)){
			$respond = $lang_inURL;
		}else{
			$respond = $lang_default;
		}
		return $respond;
	}
	
	private function setRouteType() {
		if (isset($this->request->get['product_id'])) {
			$this->request->get['route'] = 'product/product';
		} elseif (isset($this->request->get['path'])) {
			$this->request->get['route'] = 'product/category';
		} elseif (isset($this->request->get['manufacturer_id'])) {
			$this->request->get['route'] = 'product/manufacturer/info';
			
		//blog_system START (2)
		} elseif (isset($this->request->get['blogpath'])) {
			$this->request->get['route'] = 'extras/blog/getblogcategory';
		} elseif (isset($this->request->get['blog_id'])) {
			$this->request->get['route'] = 'extras/blog/getblog';	
		//blog_system END	
		
		} elseif (isset($this->request->get['information_id'])) {
			$this->request->get['route'] = 'information/information';
		}
	}
	
	public function curPageURL() {
		$pageURL = 'http';
		if (isset($this->request->server['HTTPS']) AND (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {$pageURL .= "s";}
		$pageURL .= "://";
		if ($_SERVER["SERVER_PORT"] != "80") {
		$pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
		} else {
		$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
		}
		return $pageURL;
	}
	
	public function rewrite($link, $query_filter = '') {
		$url_info = parse_url(str_replace('&amp;', '&', $link));
	
		//echo '  </br>  $link='.$link.'; $url_info='.$url_info;
		//echo '  </br>  $link='.$link;
	
		$l_code_session = $this->session->data['language'];
		$l_id_session 	= $this->ssb_helper->getLang_Code_Id($l_code_session);	
		
		//echo '$l_code_session= ' . $l_code_session .'; ';
		
		$url = ''; 
		
		$data = array();
		
		parse_str($url_info['query'], $data);
		
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {

			/*super seo */
			if ($key == 'route') { 
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($value) . "'");
						
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
						}
						continue;
					}
				/*super seo */
			//blog_system:($data['route'] == 'extras/blog/getblog' && $key == 'blog_id')
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id') || ($data['route'] == 'extras/blog/getblog' && $key == 'blog_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "' AND language_id = '". $l_id_session ."'");
				
					if ($query->num_rows) {
						$url .= '/' . $query->row['keyword'];
						
						unset($data[$key]);
					}
					
				//blog_system START (3)
				} elseif ($key == 'blogpath') {
				$blog_categories = explode('_', $value);
				foreach ($blog_categories as $blog_category) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'blog_category_id=" . (int)$blog_category . "'");
			
					if ($query->num_rows) {
						$url .= '/' . $query->row['keyword'];
			
					}							
				}
				unset($data[$key]);	
				//blog_system END
				
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
					
					foreach ($categories as $category) {
						
						/*super seo */
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "' AND language_id = '". $l_id_session ."'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->row['keyword'];
							unset($data[$key]); // added unset must go there do it as after
						}
					}
					/*super seo */
			
				}
			}
		}
	
		if ($url) {
			unset($data['route']);
		
			$query = '';
		
			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . $key . '=' . $value;
				}
				
				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}
			
			if($query){
				$query_filter = '&'.$query_filter;
			}else{
				$query_filter = '?'.$query_filter;
			}
			
			$link = $link . $url . $query . $query_filter;

			
			/*super seo */
			$link = $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
				 }
		if (strpos($link,"index.php") ) {
			$link = explode("index.php",$link);
			$link = implode("",$link);
		}
		$link = $this->seo_language($link,$this->session->data['language']);
		
		//echo '  </br>  $link='.$link;
		//echo '  </br></br>';
		
		$link = rtrim($link,"/");
		
		return $link; //added, all returns removed, one single remains.
	}	
}

?>