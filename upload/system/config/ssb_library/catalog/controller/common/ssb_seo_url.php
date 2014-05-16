<?php
class ssb_seo_url extends Controller {

	private $ssb_helper;
	private $ssb_data;
	private $ssb_setting;
	private $pathController;
	private $query_data = array();
	
	
	private $seo_pagination = false;
	
	
	function __construct(){ 
		global $registry;
		parent::__construct($registry);
		
		require_once DIR_CONFIG .'ssb_library/catalog/tools/path_controller.php';
		$this->pathController = pathController::getInstance();	
		
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
		if (trim($language) == trim($config_lang)) unset($language);
		$url_data = parse_url($link);
		if (strpos('a'.$url_data['scheme'].'a','https') ) {
			$link = $this->config->get('config_ssl');}
		else {
			$link = $this->config->get('config_url');
		}	
		if (isset($language) ) $link .= $language.'/';
		
		if (isset($url_data['path']) ) {
			$link_array =  explode('/',$link);
			$temp_path = explode('/',$url_data['path']);
			foreach ($temp_path as $key => $value) {
				if(!empty($value)){
					if (in_array($value, $link_array)) unset($temp_path[$key]);
				}
			}
			$url_data['path'] = implode('/',$temp_path);
				if(substr($url_data['path'],0,1) == '/') 
					$url_data['path'] = substr($url_data['path'],1);
		}
		
		$link .= $url_data['path'];

		if (isset($url_data['query']) ) $link .= '?'.$url_data['query'];
		
		$link = rtrim($link,"/");
		return $link;
	}
	
	public function index() {

		$this->curPageURL = $this->curPageURL();	

		$setting = $this->ssb_setting;
		$tools = $setting['tools'];
		if(substr($this->curPageURL,-1) == '/' AND $tools['trailing_slash']['status'] == true) {
			$new_url = rtrim($this->curPageURL,"/");  
			$this->ssb_helper->redirect($new_url, 301); 
		}
		
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		$totalLanguages = $this->ssb_helper->getActiveLang();
		$l_code_session = $this->session->data['language'];
		
		$lang_inURL = $this->getLangFromUrl();
		$this->session->data['ssb_language_id'] = $l_id_session = $this->ssb_helper->getLang_Code_Id($l_code_session);
		
		if (isset($this->request->get['_route_']) AND trim($this->request->get['_route_'], '/') != $lang_inURL['code']){
			
			
			$parts = explode('/', $this->request->get['_route_']);
			
			
			if($tools['seo_pagination']['status']){	
				foreach($parts as $part){
					if(strpos($part, 'page-') !== false){
						$CPBI_urls_ext	= $setting['entity']['urls']['CPBI_urls']['ext'];
					}
				}
			}
			
			$arrayLangCode = array();
			if($totalLanguages > 1){
				$arrayLangCode = $this->ssb_helper->getArrayLangCode();
			}
			
			foreach ($parts as $part) {
				
				$part = trim($part);
				if (empty($part) ) continue;
				
				if (in_array($part, $arrayLangCode)) continue;
				if(strpos($part, 'page-') !== false) {
					if($tools['seo_pagination']['status']){
						$this->seo_pagination = (int)str_replace('page-', '', $part);
					}
					$this->query_data['page'] = $this->request->get['page'] = $this->seo_pagination;
					continue;
				}
				
				
				if(strpos($part, 'change-') !== false){
					$chage_lang = explode('-', $part);
					if(isset($chage_lang[1]) AND in_array($chage_lang[1], $arrayLangCode)){
						
						$chage_lang_code = $chage_lang[1];
						if(isset($_SESSION['last_request_' . $chage_lang_code])){
							
							$this->request->post['redirect'] = $_SESSION['last_request_' . $chage_lang_code];
							$this->request->post['language_code'] = $chage_lang_code;
							return $this->forward('module/language');
						}else{
							continue;
						}
					}
				}
				
				
				if($tools['seo_pagination']['status'] && isset($CPBI_urls_ext) && strpos($CPBI_urls_ext, $part) === false){
					$keyword_condition = "(keyword = '" . $this->db->escape($part) . "' OR keyword = '" . $this->db->escape($part . $CPBI_urls_ext) . "')";
				}else{
					$keyword_condition = "keyword = '" . $this->db->escape($part) . "'";
				}
				
				
				
				$sql = "SELECT auto_gen, language_id, query FROM " . DB_PREFIX . "url_alias WHERE ". $keyword_condition ." AND language_id = '". (int)$l_id_session ."';";
				$query = $this->db->query($sql);
				
				if ($query->num_rows) {
					$result = $query->rows[0];
					$this->parseQuery($result);
				}else{
					$sql = "SELECT auto_gen, language_id, query FROM " . DB_PREFIX . "url_alias WHERE ". $keyword_condition .";";
					$query = $this->db->query($sql);
					if ($query->num_rows) {
						$result = $query->rows[0];
						$this->parseQuery($result);

						if($result['language_id']!==$l_id_session AND $l_code_session==$lang_inURL['code'] ){
							$query_count = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "url_alias WHERE query = '" . $result['query'] . "'");
							if($query_count->row['total'] > 1){
								$urlWasCange = true;
							}
						}
					}else{
						$this->request->get['route'] = 'error/not_found';	
						$this->query_data['path'] = 'error/not_found';
					}
				}
				
			}
			
			$this->setRouteType();

			if(isset($urlWasCange) AND $urlWasCange){
				
				$this->redirectPermanently();
				
			}
		}
		
		if (isset($this->request->get['route'])) {
			
			if($this->request->get['route'] == 'error/not_found'){
				require_once DIR_CONFIG .'ssb_library/ssb_custom_404.php';
				$this->ssb_custom_404 = ssb_custom_404::getInstance();
				$url_404 = $this->ssb_custom_404->getUrl404(array('url_404' => $this->curPageURL));
				if($url_404){
					
					$this->ssb_custom_404->addHit($url_404['custom_url_404_id']);
					if($url_404['url_redirect']){
						$this->ssb_helper->redirect($url_404['url_redirect'], 301);
					}
				}else{
					
					$this->ssb_custom_404->insertUrl(array('url_404' => $this->curPageURL));
				}
				
			}

			if($totalLanguages > 1){
				$arrayLangCode = array();
				$arrayLangCode = $this->ssb_helper->getArrayLangCode();
				foreach($arrayLangCode as $l_code){
					if($l_code_session == $l_code)continue;
					$this->session->data['language'] = $l_code;
					$href = $this->url->link($this->request->get['route'], http_build_query($this->query_data), 'SSL');
					$this->document->addCustomLink($href, 'alternate', array(array('hreflang' => $l_code)));
				}
				$this->session->data['language'] = $l_code_session;
			}
			
			return $this->forward($this->request->get['route']);
		}else{
			if($totalLanguages > 1){
				$arrayLangCode = array();
				$arrayLangCode = $this->ssb_helper->getArrayLangCode();
				foreach($arrayLangCode as $l_code){
					if($l_code_session == $l_code)continue;
					$this->session->data['language'] = $l_code;
					$href = $this->url->link('common/home', http_build_query($this->query_data), 'SSL');
					$this->document->addCustomLink($href, 'alternate', array(array('hreflang' => $l_code)));
				}
				$this->session->data['language'] = $l_code_session;
			}
			return $this->forward('common/home'); 
		}
	}
	
	function redirectPermanently(){
		$query_url 	= http_build_query($this->query_data);
		$route 		= isset($this->request->get['route']) ? $this->request->get['route'] : 'common/home';
		$new_url = $this->url->link($route, $query_url, 'SSL');
		$this->ssb_helper->redirect($new_url, 301);
	}
	
	function parseQuery($query){
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
		
		if ($url[0] == 'manufacturer_id') {
			$this->query_data['manufacturer_id'] = $this->request->get['manufacturer_id'] = $url[1];
		}
		
		if ($url[0] == 'information_id') {
			$this->query_data['information_id'] = $this->request->get['information_id'] = $url[1];
		}
		if (isset($url[0]) AND !isset($url[1])) { 
			$this->query_data['route'] = $this->request->get['route'] = $url[0];
		}
		
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
	}
	
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
	
	public function rewrite($link, $query_filter = '', $l_code = '') {
		$url_info = parse_url(str_replace('&amp;', '&', $link));
	
		$l_code 		= $l_code ? $l_code : $this->session->data['language'];
		$l_id_session 	= $this->session->data['ssb_language_id'];	
		
		$url = ''; 
		
		$data = array();
		
		parse_str($url_info['query'], $data);
		
		
		$page_type = '';
		$path_mode = 'default';
		if(isset($data['product_id'])){
			$path_mode = $this->ssb_setting['tools']['path_manager']['data']['product']['mode'];
			$page_type = 'product';
			$product_id = $data['product_id'];
		}else if(isset($data['path'])){
			$path_mode = $this->ssb_setting['tools']['path_manager']['data']['category']['mode'];
			$page_type = 'category';
		}
		
		if($path_mode == 'direct'){
			switch ($page_type) {
				case 'product':
					unset($data['path']);
					break;
				case 'category':
					$categories = explode('_', $data['path']);
					$category_id = $categories[count($categories)-1];
					if(isset($data['path'])){
						$data['path'] = $category_id;
					}else{
						$data = array('path' => $category_id) + $data;
					}
					break;
			}
		}else if($path_mode != 'default'){
			switch ($page_type) {
				case 'product':
					$new_path = $this->pathController->getProductPath($product_id, $path_mode);
					if(isset($data['path'])){
						$data['path'] = $new_path[count($new_path)-1]['path'];
					}else{
						$data = array('path' => $new_path[count($new_path)-1]['path']) + $data;
					}
					break;
				case 'category':
					$categories = explode('_', $data['path']);
					$category_id = $categories[count($categories)-1];
					$new_path = $this->pathController->getCaregoryPath($category_id, $path_mode);
					if(isset($data['path'])){
						$data['path'] = $new_path[count($new_path)-1]['path'];
					}else{
						$data = array('path' => $new_path[count($new_path)-1]['path']) + $data;
					}
					break;
			}
		}
		
		
		
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "' AND language_id = '". $l_id_session ."'");
				
					if ($query->num_rows) {
						$url .= '/' . $query->rows[0]['keyword'];
						
						unset($data[$key]);
					}

				} elseif ($key == 'route') { 
					$sql = "SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($value) . "'";
					$query = $this->db->query($sql);
					if ($query->num_rows) {
						foreach($query->rows as $row){
							if($row['language_id'] == (int)$l_id_session){
								$url .= '/' . $row['keyword'];
							}
						}
						
					}
				} elseif ($key == 'path') {
					$categories = explode('_', $value);

					foreach ($categories as $category) {

						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "' AND language_id = '". (int)$l_id_session ."'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->rows[0]['keyword'];
							unset($data[$key]); 
						}
					}
			
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
			
			$link = $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		}elseif (strpos($link,"index.php") ) {
			$link = str_replace('index.php', '', $link);
		}
		
		
		$setting = $this->ssb_setting;
		$tools = $setting['tools'];
		if($tools['seo_pagination']['status']){	
			$query = ''; $page = '';
			$url_info = parse_url(str_replace('&amp;', '&', $link));
			
			if(isset($url_info['query'])){
				$parts = explode('&', $url_info['query']);
				foreach($parts as $part){
					if(strpos($part, 'page') !== false){
						$page = preg_replace("/[^0-9]/", '', $part);
					}
				}
				$query = '?' . preg_replace("/&*page=[0-9]/i","", $url_info['query']);
			}
			if($page != ''){
				$setting		= $this->ssb_setting;
				$CPBI_urls_ext	= $setting['entity']['urls']['CPBI_urls']['ext'];
				$STAN_urls_ext	= $setting['entity']['urls']['STAN_urls']['ext'];
				
				$url_info['path'] = preg_replace("/\/page-[0-9]+". $STAN_urls_ext ."/i","", $url_info['path']);
				$url_info['path'] = preg_replace("/". $CPBI_urls_ext ."$/i","", $url_info['path']);
				
				$page_part = '/page-' . $page . $STAN_urls_ext;
				
				$seo_link = $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . $url_info['path'] . $page_part . $query;
				$link = $seo_link;
				
			}
		}
		
		
		
		if(true){
			$link = $this->seo_language($link,$this->session->data['language']);
		}
		
		$link = rtrim($link,"/");
		
		return $link; 
	}	
}

?>