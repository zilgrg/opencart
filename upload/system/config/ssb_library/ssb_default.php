<?php class ssb_default extends Controller { function __construct(){ global $registry;parent::__construct($registry);} static private $Instance =NULL;static public function getInstance() { if(self::$Instance==NULL){ $class=__CLASS__;self::$Instance=new $class;} return self::$Instance;} public function get_default(){ $data=array( 'version' => '2.5.0','entity' => $this->get_Entites(),'categoryEntity'=> $this->get_CategoryEntites(),'patternsSettings'=> $this->get_patternsSetting(),'tools' => $this->get_Tools(),'clientData' => $this->get_ClientData(),'commonSetting' => $this->get_CommonSetting() );return $data;} private function get_CommonSetting(){ $commonSetting=array();return $commonSetting;} private function get_ClientData(){ $clientData=array( 'name' => '','id_order' =>'','e_mail'=> '' );return $clientData;} private function get_Entites(){ $entities=array( 'tags' => array( 'product' => array('data'=> array(),'pattern'=> '!cn, !pn !wt(,# buy in)','status'=>0),'category'=> array('data'=> array(),'pattern'=> '!cp !cn - !ep','status'=>0),'brand' => array('data'=> array(),'pattern'=> '!bn !ep','status'=>0),'info' => array('data'=> array(),'pattern'=> '!sn !in','status'=>0) ),'m_descrip'=> array( 'product' => array('data'=> array(),'pattern'=> 'Buy !pn. !cn - !pn. !pd','status'=>0),'category'=> array('data'=> array(),'pattern'=> '!cp !cn !cd Find more  !tp items of products in !cn (!ep and many other).','status'=>0),'brand' => array('data'=> array(),'pattern'=> '!bn - !ep. !bd','status'=>0),'info' => array('data'=> array(),'pattern'=> '!sn !in. !id','status'=>0) ),'m_keywords'=> array( 'product' => array('data'=> array(),'pattern'=> '!cn, !pn, !pm, buy !pn. Buy !bn','status'=>0),'category'=> array('data'=> array(),'pattern'=> '!cp Buy  !cn. !cn, !ep(7#,#buy)','status'=>0),'brand' => array('data'=> array(),'pattern'=> 'Buy !bn, !ep(3#,#buy)','status'=>0),'info' => array('data'=> array(),'pattern'=> '!sn, !in','status'=>0) ),'titles'=> array( 'product' => array('data'=> array(),'pattern'=> '!pn - from category !cn (!sn)','status'=>0),'category'=> array('data'=> array(),'pattern'=> '!cn - find here more than  !tp items of products from  !sn','status'=>0),'brand' => array('data'=> array(),'pattern'=> 'More than  !tp from !bn','status'=>0),'info' => array('data'=> array(),'pattern'=> '!in (!sn)','status'=>0) ),'seo_h1'=> array( 'product' => array('data'=> array(),'pattern'=> '!cn - !pn ','status'=>0),'category'=> array('data'=> array(),'pattern'=> '!cn','status'=>0),'brand' => array('data'=> array(),'pattern'=> '!bn','status'=>0) ),'descrip'=> array( 'product' => array( 'data' => array(),'status'=> 0,'pattern' => '!pn is a premium product from !bn(!bd). !pn you find in  !cn(!cd).','category_data'=> array()),'category'=> array( 'data' => array(),'status'=> 0,'pattern' => 'In the category "!cn" you can buy more than !tp products, such as !ep.'),'brand' => array( 'data' => array(),'status'=> 0,'pattern' => '!bn - developer products such, as !ep') ),'images'=> array( 'product' => array('data'=>'!pn','national_lang'=>false,'status'=>0) ),'urls' => array( 'CPBI_urls'=>array('data'=> array( 'product' => array( 'data'=> array(),'pattern'=> '!pn','status'=>0),'category' => array( 'data'=> array(),'pattern'=> '!cn','status'=>0),'brand' => array( 'data'=> array(),'pattern'=> '!bn','status'=>0),'info' => array( 'data'=> array(),'pattern'=> '!in','status'=>0) ),'national_lang'=>false,'ext'=>'.html','status'=>0),'STAN_urls'=>array('data'=>$this->get_STAN_urls(),'ext'=>'.html','status'=>0) ),'related_prod' => array( 'product'=> array('data'=>array('total_related'=> 5,'lev_relev'=> 13),'status'=>0) ),'reviews'=> array( 'product' => array('data'=>array(),'setting'=> array( 'interval'=> 360,'per_prod'=> 80,'l_code_for_text'=> 'all','l_code_for_name'=> 'all','rev_min'=> 1,'rev_max'=> 2,'rat_min'=> 4,'rat_max'=> 5 ),'status'=>0 ) ) );return $entities;} private function get_Tools(){ $tools=array( 'seo_store' => array('type'=>'','data'=>array(),'status'=>0),'sitemap' => array('type'=>'','data'=>array( 'only_canonical'=> 0,'all_language'=> 0,'freq' => 'weekly','priorOther'=> 5,'priorProduct'=> 10 ),'status'=>0),'lang_dir_link'=> array('type'=>'','data'=>'','status'=>0),'trailing_slash'=> array('type'=>'','data'=>'','status'=>0),'canonical' => array('type'=>'','data'=>'','status'=>0),'micro_data' => array('type'=>'snippet','data'=>array( 'custom_reviews' => 1,'aggregateRating' => 1,'description' => 1,'total_num_sentence'=> 3),'status'=>0),'soc_buttons'=> array('type'=>'panel_bar','data'=>array( 'Facebook' => array('data'=>array('sort'=>0),'status'=>0),'Google' => array('data'=>array('sort'=>0),'status'=>0),'Twitter' => array('data'=>array('sort'=>0),'status'=>0),'Pinterest'=> array('data'=>array('sort'=>0),'status'=>0),'Linkedin' => array('data'=>array('sort'=>0),'status'=>0),'Odnoklassniki'=> array('data'=>array('sort'=>0),'status'=>0) ),'status'=>0 ),'qr_code' => array('type'=>'panel_bar','data'=>array('sort'=>0),'status'=>0),'open_graph'=> array('type'=>'snippet','data'=>array( 'description'=> 1,'total_num_sentence'=> 3),'status'=>0),'webm_tool' => array('type'=>'','data'=>array( 'google'=> '','bing'=> '','alexa'=> '' ),'status'=>0),'twiter_card'=> array('type'=>'snippet','data'=>array('description'=> 1,'nick'=> ''),'status'=>0),'panel_box' => array('type'=>'','mode'=> 'panel','css'=> array( 'background'=> '#777777','bg_status'=> true,'opacity'=> 1,'border_r' => 0,'margin'=> 0 ),'animate'=> true,'position'=> array( 'targetLeft' => true,'targetTop' => true,'targetRight' => false,'targetBottom' => false,'centerX' => false,'centerY' => true,'combination'=> 'lty','direction' => 'vertical' ),'behavior'=> array( 'width_less'=> '800px','move_to' => 'bottom','hide' => 0 ),'status'=> 0 ) );return $tools;} private function get_CategoryEntites(){ $entities=array( 'tags' => array('auto'=> false,'status'=>false),'m_descrip' => array('auto'=> false,'status'=>false),'m_keywords' => array('auto'=> false,'status'=>false),'titles' => array('auto'=> false,'status'=>false),'seo_h1' => array('auto'=> false,'status'=>false),'descrip' => array('auto'=> false,'status'=>false),'images' => array('auto'=> false,'status'=>false),'urls' => array('auto'=> false,'status'=>false),'related_prod' => array('auto'=> false,'status'=>false),'reviews' => array('auto'=> false,'status'=>false) );return $entities;} public function get_patternsSetting(){ $reg_patern_all='\([^()]+\)';$reg_patern_int='/\(\d?\)/g';$patterns=array( 'sn'=> array(),'st'=> array(),'wc'=> array( 'additional'=> array('default'=> array(',','')),'add_metaData'=> array('default'=> array('Pn','Tb')),'reg_pattern'=> array('default'=> $reg_patern_all),'continent' => '','data' => array() ),'wt'=> array( 'additional'=> array('default'=> array(',','')),'add_metaData'=> array('default'=> array('Pn','Tb')),'reg_pattern'=> array('default'=> $reg_patern_all),'country' => '','featureCode'=> '','region' => '','data' => array() ),'ep'=> array( 'additional'=> array('default'=> array(3,',','')),'add_metaData'=> array('default'=> array('Nt','Pn','Tb')),'reg_pattern'=> array('default'=> $reg_patern_all) ),'tp'=> array(),'pn'=> array(),'ps'=> array(),'pu'=> array(),'pp'=> array(),'pd'=> array( 'additional'=> array('default'=> array(1)),'add_metaData'=> array('default'=> array('Ns')),'reg_pattern'=> array('default'=> $reg_patern_all) ),'pm'=> array(),'cn'=> array( 'additional'=> array('default'=> array(),'product'=> array(1,',','')),'add_metaData'=> array('default'=> array(),'product'=> array('Nt','Pn','Tb')),'reg_pattern'=> array('default'=> '','product'=> $reg_patern_all) ),'cp'=> array(),'cd'=> array( 'additional'=> array('default'=> array(1),'product'=> array(1,1)),'add_metaData'=> array('default'=> array('Ns'),'product'=> array('Nt','Ns')),'reg_pattern'=> array('default'=> $reg_patern_all,'product'=> $reg_patern_all) ),'bn'=> array(),'bd'=> array( 'additional'=> array('default'=> array(1)),'add_metaData'=> array('default'=> array('Ns')),'reg_pattern'=> array('default'=> $reg_patern_all) ),'in'=> array(),'id'=> array( 'additional'=> array('default'=> array(1)),'add_metaData'=> array('default'=> array('Ns')),'reg_pattern'=> array('default'=> $reg_patern_all) ) );ksort($patterns);return $patterns;} public function get_MD_PatternAddVal(){ $patternAddVal=array( 'Ns'=> array('text'=> 'Total number of sentences from ','type'=> 'int','range'=> array(1,9)),'Nt'=> array('text'=> 'Total number of ','type'=> 'int','range'=> array(1,9)),'Pn'=> array('text'=> 'Punctuation between names of ','type'=> 'str','range'=> array(0,1)),'Tb'=> array('text'=> 'Text before every ','type'=> 'str','range'=> array(0,128)) );return $patternAddVal;} public function get_patternsInfo($param=array()){ $patterns=array( 'sn'=> array( 'special'=> true,'name'=> 'Site\'s name',       'descrip' => 'This parameter inserts name of the site into any templates.</br> You can use this parameter into any templates.This is name which you entered in "home"-> "settings"-> "general"-> "Store Name"'),     'st' => array(      'special' => true,      'name' => 'Site\'s title','descrip'=> 'This parameter inserts title of the site into any templates. </br> You can use this parameter into any templates. This is title which you entered in "home" -> "settings" -> "store" -> "Title"'),'wc'=> array( 'special'=> true,'name'=> 'World\'s countries',       'images' => array(array('text'=>'This parameter inserts list of the countries from world or any continent into any templates.You can use this parameter into any templates.</br> It give possibility insert list of the countries from world or any continent into templates for SEO promotion in these countries.Our database contain all countries for insert into your tags,meta keywords,meta descriptions or descriptions.</br> To this parameter you can add additional settings,for example write templates:"!wc(,# buy phone in )".This example will be generate text:"buy phone in Country1,  buy phone in Country2,  buy phone in Country3, ..." </br>', 'file'=>'wc.jpg')),      'descrip' => '<p class="colorFC580B">Before use this parameter you must choose which countries you want to show in your SEO text.You can do it in tab "SEO Generators"-> "Setting".</p>',      'settingInfo' => array('all' => '(Pn # Tb)')),      'wt' => array(      'special' => true,      'name' => 'World\'s towns','images'=> array(array('text'=>'This parameter inserts list of the towns, in which you can sell your products. You can use this parameter into any templates.</br>      It give possibility insert list of the towns from your country or region into templates for SEO promotion in your area. Our database contain list of all countries and over eight million towns that are available for insert into your tags, meta keywords, meta descriptions or descriptions. </br>       <span class="colorFC580B">If you have a few languages you get a few lists of countries and cities in every language. If you have one language you get list of countries and cities in this language.</span></br>      To this parameter you can add additional settings, for example write templates: "!wt(,# buy phone in )". This example will be generate text: "buy phone in Town1,  buy phone in Town2,  buy phone in Town3, ..." </br>','file'=>'wt.jpg')),'descrip'=> '<p class="colorFC580B">Before use this parameter you must choose your country for showing all big towns or/and choose region to show towns only from it. You can do it in tab "SEO Generators" -> "Setting".</p>','settingInfo'=> array('all'=> '(Pn # Tb)')),'pn'=> array('name'=> 'Product\'s name',       'descrip' => 'This parameter inserts the name of product into template product.</br> You can use this parameter only in the template of product.'),     'ep' => array('name' => 'Example Products',       'additional' => array(3, ','),      'images' => array(array('text'=>'Random names of the product from the category or brand.</br> You can use this parameter in the templates category and brand.</br> To this parameter you can add additional settings,for example !ep(5#,),where 5-total number of products;#-delimiter between additional settings;,-symbol "comma" is the separator between products.<p class="colorFC580B">You can change default value of total number example of products in tab "SEO Generators"-> "Setting".</p>', 'file'=>'ep.jpg')),      'settingInfo' => array('all' => '(Nt # Pn # Tb)')),     'ps' => array('name' => 'Product\'s SKU','descrip'=> 'This parameter inserts SKU of the product into template of the product. </br> You can use this parameter only in template of the product.'),'pu'=> array('name'=> 'Product\'s UPC',       'descrip' => 'This parameter inserts UPC of the product into template of the product.</br> You can use this parameter only in template of the product.'),     'pp' => array('name' => 'Product\'s price','descrip'=> 'This parameter inserts price of the product into template of the product. </br> You can use this parameter only in template of the product.'),'pd'=> array( 'special'=> true,'name'=> 'Product\'s description',       'additional' => array(1),       'images' => array(array('text'=>'The first few sentences from description product.</br> To this parameter you can add additional settings,for example !pd(5),where 5-total number of sentences from start of description.</br> You can use this parameter only in the template product.<p class="colorFC580B">You can change default value of the total number of the sentences in tab "SEO Generators"-> "Setting".</p>', 'file'=>'pd.jpg')),      'settingInfo' => array('all' => '(Ns)')),     'pm' => array('name' => 'Product\'s model','descrip'=> 'This parameter inserts model of the product into template product. </br> You can use this parameter only in template of the product.'),'cn'=> array('name'=> 'Category name','additional'=> array(1,','),'images'=> array(array('text'=>'Fig 1. Structure of this parameter in template of the product.','file'=>'cn-in-product.jpg')),'descrip'=> 'This parameter inserts name of the category into template. </br> You can use this parameter in templates of the product and category. </br> Look below, if you use this parameter in Product\'s template then it might has additional settings.<p class="colorFC580B">You can change default value of total number of categories in tab "SEO Generators"-> "Setting".</p>',      'settingInfo' => array('all' => '', 'product' => '(Nt # Pn # Tb)')),     'cp' => array('name' => 'Parent Category',      'descrip' => 'If the current category has parent category,then this parameter will be write name of parent category.</br> You can use this parameter only in the template category.'),     'cd' => array('name' => 'Category\'s description ','additional'=> array(1,1),'images'=> array(array('text'=>'Fig 1. Structure of this parameter in template of the category.','file'=>'cd.jpg'),array('text'=>'Fig 2. Structure of this parameter in template of the product.','file'=>'cd-in-product.jpg')),'descrip'=> 'This parameter inserts the first few sentences from description category into template. </br> To this parameter you can add additional settings, for example !cd(5), where 5 - total number of sentences from start of description. </br> You can use this parameter in template of the product and category. Look below, if you use this parameter in Product\'s template then the additional settings might has another structure.<p class="colorFC580B">You can change default value of total number of sentences in tab "SEO Generators"-> "Setting".</p>',      'settingInfo' => array('all' => '', 'product' => '(Nt # Ns)', 'category' => '(Ns)')),     'tp' => array('name' => 'Total products',       'descrip' => 'This parameter inserts total number of the products into template.If you write template for category,then !pt will be equals total number of products from this category.And if you write template for brand,then !pt will be equals total number of products from this brand.</br> You can use this parameter in templates brand and category.'),     'bn' => array('name' => 'Brand name',       'descrip' => 'This parameter inserts name of the brand into template.</br> You can use this parameter in templates product and brand.If you use it in the template product then it will be inserts the name brand of this product into template.'),     'bd' => array('name' => ' Brend\'s description ','additional'=> array(1),'images'=> array(array('text'=>'This parameter inserts the first few sentences from description of the brand into template. </br> To this parameter you can add additional settings, for example !bd(5), where 5 - total number of sentences from start of the description. </br> You can use this parameter in template product and brand. If you use it in the template product then it will be inserts description of the brand from this product into template .       <p class="colorFC580B"> You can change default value total number of sentences in tab "SEO Generators" -> "Setting".</p>','file'=>'bd.jpg')),'settingInfo'=> array('all'=> '(Ns)')),'in'=> array('name'=> 'Information\'s name',       'descrip' => 'This parameter inserts name of the information page into template.</br> You can use this parameter only in the template of information.'),     'id' => array('name' => 'Information\'s description','additional'=> array(1),'images'=> array(array('text'=>'This parameter inserts the first few sentences from information page into template. </br> To this parameter you can add additional settings, for example !id(5), where 5 - total number of sentences from start of description. </br> You can use this parameter only in the template of information.      <p class="colorFC580B">You can change default value of total number of sentences in tab "SEO Generators" -> "Setting".</p>','file'=>'id.jpg')),'settingInfo'=> array('all'=> '(Ns)')) );$param=array( 'keys'=> isset($param['keys']) ? $param['keys']:false,'val' => isset($param['val']) ? $param['val']:false );$respond=array();if($param['keys']){ $respond=array_keys($patterns);}elseif($param['val']){ foreach($patterns as $name=> $val){ if(isset($val[$param['val']])) $respond[$name]=$val;} }else{ $respond=$patterns;} ksort($respond);return $respond;} public function get_MD_Entites(){ $MD_Entites=array( 'tags' => array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description'),'info' => array('table'=> 'information_description') ),'m_descrip'=> array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description'),'info' => array('table'=> 'information_description') ),'m_keywords'=> array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description'),'info' => array('table'=> 'information_description') ),'titles'=> array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description'),'info' => array('table'=> 'information_description') ),'seo_h1'=> array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description') ),'descrip'=> array( 'product' => array('table'=> 'product_description'),'category'=> array('table'=> 'category_description'),'brand' => array('table'=> 'manufacturer_description') ),'urls' => array( 'STAN_urls'=> array( 'table' => 'url_alias','type' => 'array','column'=> '','auto_gen'=> 'STAN_urls' ),'CPBI_urls'=> array( 'table' => 'url_alias','type' => 'autogen','column'=> '','auto_gen'=> 'CPBI_urls' ) ),'related_prod'=> array( 'product'=> array( 'table' => 'product_related','type' => 'autogen','column'=> '','auto_gen'=> 1 ) ),'images'=> array( 'product' => array('table'=> '') ),'reviews'=> array( 'product' => array('table'=> 'review') ) );return $MD_Entites;} public function get_MD_CategoryEntites(){ $MD_CategoryEntites=array( 'urls' => array( 'type' => 'generator','icon' => 'random','clear' => array('all') ),'tags' => array( 'type' => 'generator','icon' => 'tags','data_type' => 'pattern','column' => 'tag','clear' => array('all'),'adm_templ' => 'template_TDKT','gen_file' => 'gen_TDKT' ),'m_descrip'=> array( 'type' => 'generator','icon' => 'tasks','data_type' => 'pattern','column' => 'meta_description','clear' => array('all'),'adm_templ' => 'template_TDKT','gen_file' => 'gen_TDKT' ),'m_keywords'=> array( 'type' => 'generator','icon' => 'tasks','data_type' => 'pattern','column' => 'meta_keyword','clear' => array('all'),'adm_templ' => 'template_TDKT','gen_file' => 'gen_TDKT' ),'titles'=> array( 'type' => 'generator','icon' => 'bookmark','data_type' => 'pattern','column' => 'seo_title','clear' => array('all'),'adm_templ' => 'template_TDKT','gen_file' => 'gen_TDKT' ),'seo_h1'=> array( 'type' => 'generator','icon' => 'book','data_type' => 'pattern','column' => 'seo_h1','clear' => array('all'),'adm_templ' => 'template_TDKT','gen_file' => 'gen_TDKT' ),'descrip'=> array( 'type' => 'generator','icon' => 'pencil','data_type' => 'pattern','column' => 'description','clear' => array('all','auto_gen'),'gen_file' => 'gen_TDKT' ),'images'=> array( 'type' => 'generator','icon' => 'picture','data_type' => 'pattern','column' => '' ),'related_prod'=> array( 'type' => 'generator','icon' => 'retweet','clear' => array('all') ),'reviews'=> array( 'type' => 'generator','icon' => 'heart','column' => '','clear' => array('all','auto_gen') ) );return $MD_CategoryEntites;} public function get_MD_CPBI($param=array()){ $CPBI=array( 'product' => array( 'db_name'=> 'product','parameters'=> array( 'pn','pm','ps','pu','pd','pp','cn','cd','bn','bd','sn','st','wc','wt'),'alias'=> array('name'=> 'pn','description'=> 'pd') ),'category' => array( 'db_name'=> 'category','parameters'=> array( 'cn','cp','cd','tp','ep','sn','st','wc','wt'),'alias'=> array('name'=> 'cn','description'=> 'cd') ),'brand' => array( 'db_name'=> 'manufacturer','parameters'=> array( 'bn','bd','ep','tp','sn','st','wc','wt'),'alias'=> array('name'=> 'bn','description'=> 'bd') ),'info' => array( 'db_name'=> 'information','parameters'=> array( 'in','id','sn','st','wc','wt'),'alias'=> array('name'=> 'in','description'=> 'id')) );$param=array( 'keys'=> isset($param['keys']) ? $param['keys']:false,'val' => isset($param['val']) ? $param['val']:false );$respond=array();if($param['keys']){ $respond=array_keys($CPBI);}elseif($param['val']){ foreach($CPBI as $name=> $val){ $respond[$name]=$val[$param['val']];} }else{ $respond=$CPBI;} return $respond;} public function get_MD_EntitiesInDB($param=array()){ $MD_EntitiesInDB=array( 'tags' => array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'tag','condition'=> '' ),'save' => array( 'column' => 'tag' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'tag','condition'=> '' ),'save' => array( 'column' => 'tag' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'tag','condition'=> '' ),'save' => array( 'column' => 'tag' ) ),'info' => array('table'=> 'information_description','name_id'=> 'information_id','clear'=> array( 'column' => 'tag','condition'=> '' ),'save' => array( 'column' => 'tag' ) ) ),'m_descrip'=> array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'meta_description','condition'=> '' ),'save' => array( 'column' => 'meta_description' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'meta_description','condition'=> '' ),'save' => array( 'column' => 'meta_description' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'meta_description','condition'=> '' ),'save' => array( 'column' => 'meta_description' ) ),'info' => array('table'=> 'information_description','name_id'=> 'information_id','clear'=> array( 'column' => 'meta_description','condition'=> '' ),'save' => array( 'column' => 'meta_description' ) ) ),'m_keywords'=> array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'meta_keyword','condition'=> '' ),'save' => array( 'column' => 'meta_keyword' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'meta_keyword','condition'=> '' ),'save' => array( 'column' => 'meta_keyword' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'meta_keyword','condition'=> '' ),'save' => array( 'column' => 'meta_keyword' ) ),'info' => array('table'=> 'information_description','name_id'=> 'information_id','clear'=> array( 'column' => 'meta_keyword','condition'=> '' ),'save' => array( 'column' => 'meta_keyword' ) ) ),'titles'=> array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'seo_title','condition'=> '' ),'save' => array( 'column' => 'seo_title' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'seo_title','condition'=> '' ),'save' => array( 'column' => 'seo_title' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'seo_title','condition'=> '' ),'save' => array( 'column' => 'seo_title' ) ),'info' => array('table'=> 'information_description','name_id'=> 'information_id','clear'=> array( 'column' => 'seo_title','condition'=> '' ),'save' => array( 'column' => 'seo_title' ) ) ),'seo_h1'=> array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'seo_h1','condition'=> '' ),'save' => array( 'column' => 'seo_h1' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'seo_h1','condition'=> '' ),'save' => array( 'column' => 'seo_h1' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'seo_h1','condition'=> '' ),'save' => array( 'column' => 'seo_h1' ) ) ),'descrip'=> array( 'product' => array('table'=> 'product_description','name_id'=> 'product_id','clear'=> array( 'column' => 'description, auto_gen = 0','condition'=> "auto_gen = 1" ),'save' => array( 'column' => 'description, auto_gen = 1' ) ),'category'=> array('table'=> 'category_description','name_id'=> 'category_id','clear'=> array( 'column' => 'description, auto_gen = 0','condition'=> "auto_gen = 1" ),'save' => array( 'column' => 'description, auto_gen = 1' ) ),'brand' => array('table'=> 'manufacturer_description','name_id'=> 'manufacturer_id','clear'=> array( 'column' => 'description, auto_gen = 0','condition'=> "auto_gen = 1" ),'save' => array( 'column' => 'description, auto_gen = 1' ) ) ),'images'=> array( 'product' => array('table'=> 'product_image','save' => array( 'action'=> 'update','table'=> array( 'product','category','manufacturer','language','product_image','option_value','voucher_theme','banner_image'),'column'=> 'image' ) ) ),'related_prod'=> array( 'product' => array( 'table'=> 'product_related','name_id'=> 'product_id','clear'=> array( 'column' => 'all','condition' => "auto_gen = 1" ) ),),'urls' => array( 'STAN_urls'=> array( 'table' => 'url_alias','clear' => array( 'column' => 'all','condition'=> "auto_gen = 'STAN_urls'" ) ),'CPBI_urls'=> array( 'table' => 'url_alias','clear' => array( 'column' => 'all','condition'=> "auto_gen <> 'STAN_urls'" ) ) ),'reviews'=> array( 'product' => array( 'table'=> 'review','name_id'=> 'review_id','clear'=> array( 'column' => 'all','condition' => "auto_gen = 1" ) ),) );$entityCategory=$entityName='all';if(count($param)){list($entityCategory,$entityName)=$param;} $respond=array();if($entityCategory=='all'){ $respond=$MD_EntitiesInDB;}else{ if($entityName=='all'){ $respond=$MD_EntitiesInDB[$entityCategory];}else{ $MD_EntityInDB=$MD_EntitiesInDB[$entityCategory][$entityName];$respond=array($entityCategory=> $MD_EntityInDB);} } return $respond;} public function get_DB_change(){ $DB_change=array( array( 'name'=> 'information_description','columns'=> array('seo_title','meta_description','meta_keyword','tag'),'types'=> array('varchar(255) NULL DEFAULT \'\'','text NULL','text NULL','text NULL') ),array( 'name'=> 'category_description','columns'=> array('seo_title','seo_h1','auto_gen','meta_description','meta_keyword','tag'),'types'=> array('varchar(255) NULL DEFAULT \'\'','varchar(255) NULL DEFAULT \'\'','tinyint(1) NOT NULL DEFAULT 0','text NULL','text NULL','text NULL'),'autoFillFunc'=> $this->fillTables('relatedProductsIndex') ),array( 'name'=> 'product_description','columns'=> array('seo_title','seo_h1','auto_gen','meta_description','meta_keyword','tag'),'types'=> array('varchar(255) NULL DEFAULT \'\'','varchar(255) NULL DEFAULT \'\'','tinyint(1) NOT NULL DEFAULT 0','text NULL','text NULL','text NULL') ),array( 'name'=> 'url_alias','columns'=> array('language_id','auto_gen'),'types'=> array('int(11) NOT NULL DEFAULT \'%s\'','varchar(24) NULL DEFAULT \'\''),'sprints'=> array('$this->config->get(\'config_language_id\');') ),array( 'name'=> 'product_related','columns'=> array('auto_gen'),'types'=> array('tinyint(1) NOT NULL DEFAULT 0') ),array( 'name'=> 'manufacturer_description','columns'=> array( 'manufacturer_id','language_id','description','auto_gen','meta_description','meta_keyword','seo_title','seo_h1','tag' ),'types'=> array( 'int(11) NOT NULL','int(11) NOT NULL','text NOT NULL','tinyint(1) NOT NULL DEFAULT 0','text NULL','text NULL','varchar(255) NOT NULL DEFAULT \'\'','varchar(255) NOT NULL DEFAULT \'\'','text NULL' ),'prim'=> 'PRIMARY KEY (`manufacturer_id`,`language_id`)','end'=> 'ENGINE=MyISAM DEFAULT CHARSET=utf8  COLLATE=utf8_general_ci','autoFillFunc'=> $this->fillTables('brandFillDescrip') ),array( 'name'=> 'wc_countries','columns'=> array( 'code','name','iso3','number','continent_code' ),'types'=> array( 'CHAR(2) NOT NULL','VARCHAR(255) NOT NULL','CHAR(3) NOT NULL','SMALLINT(3) ZEROFILL NOT NULL','CHAR(2) NOT NULL' ),'prim'=> 'PRIMARY KEY (`code`)','end'=> 'ENGINE=MyISAM DEFAULT CHARSET=utf8','autoFillFunc'=> $this->fillTables('countryFill') ),array( 'name'=> 'wc_continents','columns'=> array( 'code','name','geonameId' ),'types'=> array( 'CHAR(2) NOT NULL','VARCHAR(255)','CHAR(7) NOT NULL' ),'prim'=> 'PRIMARY KEY (`code`)','end'=> 'ENGINE=MyISAM DEFAULT CHARSET=utf8','autoFillFunc'=> $this->fillTables('continentFill') ),array( 'name'=> 'review','columns'=> array('auto_gen'),'types'=> array('tinyint(1) NOT NULL DEFAULT 0') ),array( 'name'=> 'review_template','columns'=> array( 'review_template_id','l_code','text'),'types'=> array( 'int(11) NOT NULL AUTO_INCREMENT','varchar(5)','text NOT NULL'),'prim'=> 'PRIMARY KEY (`review_template_id`)','end'=> 'ENGINE=MyISAM DEFAULT CHARSET=utf8','autoFillFunc'=> $this->fillTables('reviewTemplateFill') ),array( 'name'=> 'review_name','columns'=> array( 'review_name_id','l_code','text'),'types'=> array( 'int(11) NOT NULL AUTO_INCREMENT','varchar(5)','text NOT NULL'),'prim'=> 'PRIMARY KEY (`review_name_id`)','end'=> 'ENGINE=MyISAM DEFAULT CHARSET=utf8','autoFillFunc'=> $this->fillTables('reviewNameFill') ) );return $DB_change;} private function fillTables($case){ $result_text='';switch ($case){ case 'relatedProductsIndex':$result_text="       \$sql = \"SHOW INDEX FROM \" . DB_PREFIX . \"product_description WHERE Key_name='relatedProducts'\";       \$query = \$this->db->query(\$sql);       if(!count(\$query->rows)){        \$this->db->query(\"CREATE FULLTEXT INDEX relatedProducts ON " . DB_PREFIX . "product_description (name,description);\");       }";break;case 'brandFillDescrip':$result_text="       include_once DIR_CONFIG .'ssb_library/ssb_helper.php';       \$this->ssb_helper = ssb_helper::getInstance();       \$languages = \$this->ssb_helper->getLanguages();       \$this->load->model('catalog/manufacturer');       \$brands = \$this->model_catalog_manufacturer->getManufacturers();       foreach (\$brands as \$brand) {        \$this->model_catalog_manufacturer->setDescripManufacturer(\$brand['manufacturer_id'], array(), true);       }      ";break;case 'countryFill':include_once DIR_CONFIG.'ssb_library/admin/sql/countries.php';$result_text="       \$exist_query =  \$this->db->query(\"SELECT * FROM \" . DB_PREFIX . \"wc_countries\");       if(!\$exist_query->num_rows){        \$this->load->model('superseobox/index');        \$this->db->query(\"" . $countries_sql . "\");       }";break;case 'continentFill':include_once DIR_CONFIG.'ssb_library/admin/sql/continents.php';$result_text="       \$exist_query =  \$this->db->query(\"SELECT * FROM \" . DB_PREFIX . \"wc_continents\");       if(!\$exist_query->num_rows){        \$this->load->model('superseobox/index');        \$this->db->query(\"" . $continents_sql . "\");       }";break;case 'reviewNameFill':require_once DIR_CONFIG.'ssb_library/admin/generators/ssb_review.php';$ssb_review=ssb_review::getInstance();$result_text="       \$sql = \"DELETE FROM " . DB_PREFIX . "review_name WHERE 1;\";       \$query = \$this->db->query(\$sql);       \$sql = \"". $ssb_review->getSQlReviews('review_name') ."\";       \$query = \$this->db->query(\$sql);";break;case 'reviewTemplateFill':require_once DIR_CONFIG.'ssb_library/admin/generators/ssb_review.php';$ssb_review=ssb_review::getInstance();$result_text="       \$sql = \"DELETE FROM " . DB_PREFIX . "review_template WHERE 1;\";       \$query = \$this->db->query(\$sql);       \$sql = \"". $ssb_review->getSQlReviews('review_template') ."\";       \$query = \$this->db->query(\$sql);";break;} return $result_text;} private function get_STAN_urls (){ $STAN_urls=array( array('account/voucher','voucher'),array('account/wishlist','wish-list'),array('account/account','account'),array('account/login','login'),array('account/logout','logout'),array('account/order','order-history'),array('account/newsletter','newsletter'),array('account/return/insert','return'),array('account/forgotten','forgot-password'),array('account/download','downloads'),array('account/return','returns'),array('account/transaction','transactions'),array('account/register','create-account'),array('account/edit','edit-account'),array('account/password','change-password'),array('account/address','address-book'),array('account/reward','reward'),array('affiliate/account','affiliate'),array('affiliate/register','create-affiliate'),array('affiliate/edit','edit-affiliate'),array('affiliate/password','affiliate-password'),array('affiliate/payment','affiliate-payment'),array('affiliate/tracking','affiliate-tracking'),array('affiliate/transaction','affiliate-transactions'),array('affiliate/logout','affiliate-logout'),array('affiliate/forgotten','affiliate-forgotten'),array('affiliate/login','affiliate-login'),array('common/home',''),array('module/language','change-language'),array('quickcheckout/checkout','quick-checkout'),array('checkout/voucher','vouchers'),array('checkout/cart','cart'),array('checkout/checkout','checkout'),array('checkout/success','success'),array('information/sitemap','site-map'),array('information/contact','contact'),array('product/search','search'),array('product/compare','compare-products'),array('product/manufacturer','brands'),array('product/special','specials') );return $STAN_urls;} public function get_Power_of_Entities(){ $power=array( 'tags' => array( 'product' => 3,'category'=> 3,'brand' => 2,'info' => 2 ),'m_descrip'=> array( 'product' => 3,'category'=> 3,'brand' => 2,'info' => 2 ),'m_keywords'=> array( 'product' => 3,'category'=> 3,'brand' => 2,'info' => 2 ),'titles'=> array( 'product' => 3,'category'=> 3,'brand' => 2,'info' => 2 ),'seo_h1'=> array( 'product' => 3,'category'=> 2,'brand' => 1 ),'descrip'=> array( 'product' => 1,'category'=> 1,'brand' => 1 ),'urls' => array( 'STAN_urls'=>5,'CPBI_urls'=>array( 'product' => 6,'category'=> 6,'brand' => 5,'info' => 3 ) ),'tools' => array( 'seo_store' => 2,'sitemap' => 2,'canonical' => 2,'micro_data' => 2,'qr_code' => 2,'soc_buttons'=> 2,'open_graph'=> 3,'webm_tool' => 0,'twiter_card'=> 2,'lang_dir_link'=> 2,'trailing_slash'=> 2,'panel_box' => 0 ),'images'=> array( 'product' => 1 ),'related_prod'=> array( 'product'=> 2 ),'reviews'=> array( 'product'=> 2 ) );return $power;} } ?>
