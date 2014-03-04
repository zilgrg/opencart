<?php class gen_related_prod extends Controller { private $ssb_data;private $gen_helper;private $ssb_helper;private $seo_data=array();private $def_data=array( 'entity_cat' => '','entity_name'=> '','CPBI' => 'all','id_entity' => '','testgenerator'=> false,'pack' => 0 );function __construct(){ global $registry;parent::__construct($registry);require_once DIR_CONFIG.'ssb_library/ssb_helper.php';$this->ssb_helper=ssb_helper::getInstance();require_once DIR_CONFIG.'ssb_library/ssb_data.php';$this->ssb_data=ssb_data::getInstance();require_once DIR_CONFIG.'ssb_library/admin/generators/gen_helper.php';$this->gen_helper=gen_helper::getInstance();} static private $Instance =NULL;static public function getInstance() { if(self::$Instance==NULL){ $class=__CLASS__;self::$Instance=new $class;} return self::$Instance;} public function generate($data){ $time_start=microtime(true);extract(array_merge($this->def_data,$data));$this->doGenerate($id_entity,$testgenerator,$pack);$time_end=microtime(true);$time=$time_end-$time_start;return array('time'=> $time,'count'=> $this->g_count,'seo_data'=> $this->seo_data);} public function doGenerate($id_entity='',$testgenerator,$pack=0){ $this->setVars_Common($testgenerator,$pack);if($id_entity){ $CPBI_item=$this->ssb_data->getCPBI_item('product',$id_entity);$productData=$CPBI_item['data'][$id_entity];$this->genProcess_Related_product( $productData,$id_entity);}else{ $data_product=$this->ssb_data->getCPBI('product','related_prod',$pack);$products=$data_product['data'];foreach($products as $p_id=> $val){ if(!isset($val[$this->defaultLanguage]))continue;$respond=$this->genProcess_Related_product($val,$p_id);if($respond=='break')break;} } if($this->testgenerator){ $this->endSeoData();} } private function setVars_Common($testgenerator,$pack=0){ $this->seo_data =array();$this->g_count =0;$this->pack =$pack;$this->testgenerator=$testgenerator;$setting_entity =$this->ssb_data->getSetting('entity');$this->settings=$setting_entity['related_prod']['product']['data'];$this->defaultLanguage=$this->ssb_helper->getDefaultLanguage();} private function genProcess_Related_product($val,$p_id){ $sql_related ="SELECT related_id FROM ".DB_PREFIX."product_related WHERE product_id=".$p_id.";";$query_related =$this->db->query($sql_related);$r_products =array();$r_total_exist =0;foreach ($query_related->rows as $r_product){ $r_products[]=$r_product['related_id'];$r_total_exist++;} $total_related =$this->settings['total_related'];if(!$this->testgenerator){ $total_related =$total_related-$r_total_exist;} if($total_related < 1 AND !$this->testgenerator){return 'continue';} $product_data=$val[$this->defaultLanguage];$lev_relev =$this->settings['lev_relev'];$zero_fix =0.01;$name =$this->gen_helper->clearString($product_data['pn'],true,false,true,'related_prod');$description=$this->gen_helper->clearString($product_data['pd'],true,false,true,'related_prod');$categories =$product_data['c_id'];$price =$product_data['pp']+$zero_fix;$sql_price="5*IF(p.price>".$price.", ".$price."/p.price+".$zero_fix.", p.price/".$price.")";$sql_categories='';$cat_present='';$i=0;foreach($categories as $c_id){ $sql_categories.="IF(pc.category_id <>'". $c_id ."', 0, 3)";$i++;$cat_present.=$c_id;if(isset($categories[$i]))$sql_categories.=" + ";} if(!$cat_present) {return 'continue';} $sql_name_descrip="MATCH (pd.name, pd.description) AGAINST ('". $name . " " . $description ."')";$sql_not_in='';if(!$this->testgenerator){ $sql_not_in=$r_total_exist ? "AND p.product_id NOT IN (".implode(', ',$r_products).")":"";} $sql="SELECT DISTINCT ROUND(".$sql_price." + ".$sql_categories." + ".$sql_name_descrip.", 0) as kinship,  p.product_id, pd.name FROM ".DB_PREFIX."product_description pd     LEFT JOIN ".DB_PREFIX."product p on pd.product_id = p.product_id    INNER JOIN ".DB_PREFIX."product_to_category pc on pd.product_id = pc.product_id WHERE p.product_id <> ".$p_id." ".$sql_not_in." AND p.status = 1 GROUP BY p.product_id having kinship>".$lev_relev." ORDER BY kinship desc limit 0,".$total_related.";";$query=$this->db->query($sql);if(!$this->testgenerator){ $this->saveRelatedProducts($p_id,$query->rows);}else{ $this->g_count++;$this->fillSeoData($name,$query->rows);if($this->g_count >24){return 'break';} } } private function saveRelatedProducts($p_id,$r_products){ foreach($r_products as $r_product){ $this->g_count++;$sql="INSERT INTO ".DB_PREFIX."product_related (product_id, related_id, auto_gen) VALUES (".$p_id.", ".$r_product['product_id'].", 1)";$this->db->query($sql);} } private function fillSeoData($name,$r_products){ $r_name='';foreach($r_products as $r_product){ $r_name.=$r_product['name'].'; ';} if(!$r_name){ $r_name="<span class=\"colorFC580B\">don't found any related products (you can reduce value of \"Level of relevance\" and then apply testing again)</span>";    }    $this->seo_data[] = "<tr>".          $this->gen_helper->addTD($this->g_count ) .           $this->gen_helper->addTD($name).          $this->gen_helper->addTD($r_name)         ."</tr>";   }   private function endSeoData(){    $header = ' <tr><td class="caption" colspan="3">Example of Related Products</td></tr> <tr> <th></th> <th>Product\'s name</th>       <th>Related Products</th>      </tr>      ';$footer='<tr><th colspan="3">...etc.</th></tr>';array_unshift($this->seo_data,$header);$this->seo_data[]=$footer;} } ?>
