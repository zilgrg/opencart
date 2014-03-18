<?php class gen_helper extends Controller { private $ssb_helper;private $ssb_data;private $seo_data=array();function __construct(){ global $registry;parent::__construct($registry);require_once DIR_CONFIG.'ssb_library/ssb_data.php';$this->ssb_data=ssb_data::getInstance();require_once DIR_CONFIG.'ssb_library/ssb_helper.php';$this->ssb_helper=ssb_helper::getInstance();} static private $Instance =NULL;static public function getInstance() { if(self::$Instance==NULL){ $class=__CLASS__;self::$Instance=new $class;} return self::$Instance;} public function parseTemplate($entity_cat,$CPBI,$templates){ $respond =array();if(is_array($templates)){ foreach($templates as $l_code=> $template){ $respond[$l_code]=$this->getTemplateObj($CPBI,$template);} }else{ $respond=$this->getTemplateObj($CPBI,$templates);} return $respond;} private function getTemplateObj($CPBI,$template){ $matches=$this->searchParamInTemplate($CPBI,$template);$templ_obj=array('params'=>array());foreach($matches as $matche){ $param=substr(trim($matche),1,2);$add_val=$this->getAddValueForParam($param,$matche,$CPBI);$templ_obj['params'][]=array( 'param' => $param,'add_val'=> $add_val,'matche'=> $matche );} uasort($templ_obj['params'],'templObjSort');return $templ_obj;} private function searchParamInTemplate($entity,$template){ $pattern_descrip =$this->ssb_data->getPatterns('setting');$regular_cond='';$meta_CPBI=$this->ssb_data->getMatadata('CPBI',array('val' => 'parameters'));$MD_CPBI_parameters=$meta_CPBI[$entity];foreach($MD_CPBI_parameters as $param){ $param_in_templ='!'.$param;$pos=strpos($template,$param_in_templ);if($pos !==false){ if(isset($pattern_descrip[$param]['reg_pattern'])){ if(isset($pattern_descrip[$param]['reg_pattern'][$entity])){ $regular_cond[]=$param_in_templ.$pattern_descrip[$param]['reg_pattern'][$entity];}else{ $regular_cond[]=$param_in_templ.$pattern_descrip[$param]['reg_pattern']['default'];} } $regular_cond[]=$param_in_templ;} } if($regular_cond=='') return array();$regular_cond='('.implode('|',$regular_cond).')';preg_match_all($regular_cond,$template,$matches);return $matches[0];} private function getAddValueForParam($param,$matche,$CPBI){ $pattern_descrip =$this->ssb_data->getPatterns('setting');if(!isset($pattern_descrip[$param]['reg_pattern']))return '';if(isset($pattern_descrip[$param]['additional'][$CPBI])){ $default_add_vals=$pattern_descrip[$param]['additional'][$CPBI];}else{ $default_add_vals=$pattern_descrip[$param]['additional']['default'];} preg_match_all('(\(.*\))',$matche,$add_val);if(isset($add_val[0][0])){ $add_val=substr($add_val[0][0],1,-1);$add_vals=explode ('#',$add_val);}else{ $add_vals=array();} $return_add_vals=array();$i=0;foreach($default_add_vals as $default_add_val){ $type=gettype($default_add_vals[$i]);if(isset($add_vals[$i]) AND $add_vals[$i]!=''){ settype($add_vals[$i],$type);if(gettype($add_vals[$i])=='integer') $add_vals[$i]=$add_vals[$i]>9 ? 9:$add_vals[$i];$return_add_vals[$i]=$add_vals[$i]===0 ? $default_add_vals[$i]:$add_vals[$i];}else{ $return_add_vals[$i]=$default_add_vals[$i];} $i++;} return $return_add_vals;} public function setSeoString($entity_cat,$CPBI,$templ_objs,$templates,$testgenerator,$additionData,$id_entity='',$pack=0){ $this->setVars_Common($entity_cat,$CPBI,$testgenerator,$additionData);if($id_entity){ $CPBI_item=$this->ssb_data->getCPBI_item($CPBI,$id_entity);$CPBI_item_data=$CPBI_item['data'];$CPBI_lang=$CPBI_item['data'][$id_entity];$this->setVars_TDKT($CPBI_lang,$templates,$templ_objs);foreach($CPBI_lang as $l_code=> $val){ if(!isset($this->templates_ToUse[$l_code]))continue;$this->genProcess_TDKT($CPBI_item_data,$id_entity,$l_code,$val);if($this->status)$this->g_count++;} }else{ $data_CPBI=$this->ssb_data->getCPBI($this->CPBI,$entity_cat,$pack);$CPBI_data=$data_CPBI['data'];foreach($CPBI_data as $item_id=> $CPBI_lang){ $this->setVars_TDKT($CPBI_lang,$templates,$templ_objs);foreach($CPBI_lang as $l_code=> $val){ if(!isset($this->templates_ToUse[$l_code]))continue;$this->genProcess_TDKT($CPBI_data,$item_id,$l_code,$val);if($this->status)$this->g_count++;} if($this->testgenerator){ if($this->g_count>10)break;} } if($this->testgenerator){ $this->endSeoData($templates);} } return array('count'=> $this->g_count,'seo_data'=> $this->seo_data);} public function getSeoString($templ_objs,$template,$specialPatterns,$data,$CPBI,$l_code,$entity_cat,$replacinArr=''){ if($replacinArr){ $this->replacinArr=$replacinArr;} $seo_string=$template;$data_clear=$data;foreach($templ_objs['params'] as $val){ if(isset($specialPatterns[$val['param']])){ $specParam=isset($specialPatterns[$val['param']][$l_code]) ? $specialPatterns[$val['param']][$l_code]:$specialPatterns[$val['param']];$data_clear[$val['param']]=$data[$val['param']]=$specParam;} if(count($this->replacinArr) AND isset($this->replacinArr[$val['param']])){ if(is_array($this->replacinArr[$val['param']])){ $data[$val['param']]=$data_clear[$val['param']]=$this->setReplacing($val['param'],$data_clear);} } $shatter_data=$this->shatterParamForTags($entity_cat,$val['param'],$data_clear);if($shatter_data){ $data_clear[$val['param']]=$data[$val['param']]=$shatter_data;} if(is_array($val['add_val']) AND count($val['add_val'])){ $data[$val['param']]=$this->prepareParamWithAddValue($val['param'],$data,$data_clear,$val['add_val'],$CPBI);} $seo_string=str_replace($val['matche'],$data[$val['param']],$seo_string);} if($this->testgenerator){ $seo_string=$this->clearPreviewString($seo_string);}else{ $seo_string=$this->clearString($seo_string,true,$entity_cat!="descrip");} return $seo_string;} private function saveProcess($l_code,$item_id,$CPBI_data,$seo_string){ $l_id =$this->ssb_helper->getLang_Code_Id($l_code);if($this->condition=='gen_only_for_empty'){ $seo_field=$CPBI_data[$item_id][$l_code]['seo_field'][$this->entity_cat];if($seo_field !=''){ return false;} } $table =$this->MD_EntityInDB["table"];$name_id =$this->MD_EntityInDB["name_id"];$sql_columns='';if(strpos($this->MD_EntityInDB["save"]["column"],',') !==false){ $columns=explode(',',$this->MD_EntityInDB["save"]["column"]);foreach($columns as $column){ if(strpos($column,'=') !==false){ $sql_columns.=$column.',';}else{ $sql_columns.=$column." = '". $seo_string ."',";} } $sql_columns=substr($sql_columns,0,-1).' ';}else{ $sql_columns.=$this->MD_EntityInDB["save"]["column"]." = '". $seo_string ."'";} $version=(int)substr(str_replace('.','',VERSION),0,3);if($version < 154 AND $this->CPBI=='product' AND $this->entity_cat=='tags'){ $tags=explode(',',$seo_string);foreach ($tags as $tag) { $this->db->query("INSERT INTO ".DB_PREFIX."product_tag SET product_id = '" . (int)$item_id . "', language_id = '" . (int)$l_id . "', tag = '" . $this->db->escape(trim($tag)) . "'");} } $sql="UPDATE ".DB_PREFIX.$table." SET ".$sql_columns." WHERE ".$name_id." = ".$item_id." and language_id = ".$l_id.";";$do_save=$this->db->query($sql);$this->status=true;} private function setReplacing($param,$data){ $search =$this->replacinArr[$param]['search'];$replace=$this->replacinArr[$param]['replace'];if(is_array($data[$param])){ foreach($data[$param] as $index=> $name){ $data[$param][$index]=str_replace($search,$replace,$data[$param][$index]);} }else{ $data[$param]=str_replace($search,$replace,$data[$param]);} return $data[$param];} private function shatterParamForTags($entity_cat,$param,$data){ $shatter_param=array('pn','cn','bn','in','ep');if($entity_cat=='tags' AND in_array($param,$shatter_param)){ if(is_array($data[$param])){ foreach($data[$param] as $index=> $name){ $data[$param][$index]=$this->getShatterString($name).$name;} }else{ $data[$param]=$this->getShatterString($data[$param]).$data[$param];} return $data[$param];}else{ return false;} } private function getShatterString($data_param){ $shatter_name_array=explode(' ',$data_param);$shatterString='';foreach($shatter_name_array as $shatter_name){ $shatter_name=$this->clearString($shatter_name,true,true);if(strlen($shatter_name) > 2 AND strtolower($shatter_name) !='and'){ if($data_param !=$shatter_name){ $shatterString.=$shatter_name.', ';} } } return $shatterString;} private function setVars_Common($entity_cat,$CPBI,$testgenerator,$additionData){ $this->seo_data =array();$this->g_count =0;$this->status =false;$this->entity_cat=$entity_cat;$this->CPBI =$CPBI;$this->replacinArr=$this->ssb_data->getReplacingArr($entity_cat,$CPBI);$meta_alias=$this->ssb_data->getMatadata('CPBI',array('val'=> 'alias'));$this->CPBI_alias =$meta_alias[$CPBI];$this->specialPatterns=$this->ssb_data->getPatterns('special');$param=array($entity_cat,$CPBI);$meta_EntitiesInDB=$this->ssb_data->getMatadata('EntitiesInDB',$param);$this->MD_EntityInDB=$meta_EntitiesInDB[$entity_cat];$this->testgenerator=$testgenerator;$this->condition=isset($additionData['condition']) ? $additionData['condition']:'';} private function setVars_TDKT($language,$templates,$templ_objs){ $this->category_data=false;$this->templates_ToUse =$templates['data'];$this->templ_objs_ToUse=$templ_objs['data'];if($this->entity_cat=='descrip' AND $this->CPBI=='product'){ $lang_values=array_values($language);$cat_ids=$lang_values[0]['c_id'];foreach($templates['category_data'] as $cat_id=> $cat_val){ if(is_array($cat_ids) AND in_array($cat_id,$cat_ids)){ $this->templ_objs_ToUse =$templ_objs['category_data'][$cat_id];$this->category_data =true;$this->templates_ToUse =$templates['category_data'][$cat_id];break;} } } } private function genProcess_TDKT($CPBI_data,$item_id,$l_code,$data){ $seo_string=$this->getSeoString( $this->templ_objs_ToUse[$l_code],$this->templates_ToUse[$l_code],$this->specialPatterns,$data,$this->CPBI,$l_code,$this->entity_cat );if($this->condition=='gen_append_to_end'){ $seo_field=$CPBI_data[$item_id][$l_code]['seo_field'][$this->entity_cat];$seo_string=$seo_field.' '.$seo_string;} if(!$this->testgenerator){ $this->saveProcess($l_code,$item_id,$CPBI_data,$seo_string);}else{ $meta_alias=$this->ssb_data->getMatadata('CPBI',array('val'=>'alias'));$name=$meta_alias[$this->CPBI]['name'];$this->status=true;$this->fillSeoData($data[$name],$l_code,$seo_string);} } private function getEntityFieldData($CPBI_data,$item_id,$l_code){ if($this->entity_cat=='descrip'){ $fieldData=$CPBI_data[$item_id][$l_code][$this->CPBI_alias['description']];}else{ $fieldData=$CPBI_data[$item_id][$l_code]['fieldData'][$this->entity_cat];} return trim($fieldData);} public function fillSeoData($name,$l_code,$seo_string){ $active_lang_code =$this->ssb_helper->getDefaultLanguage();$hide=$active_lang_code <> $l_code ? 'style="display:none;"':'';$specTemplate='';if($this->category_data){ $specTemplate='<span style="color:#FC580B"> special*:'.$l_code.'('.$this->templates_ToUse[$l_code].'); </span>';} $this->seo_data[]='<tr '.$hide.' class= "lang-'. $l_code .'">'.$this->addTD($name.$specTemplate).$this->addTD($seo_string) .'</tr>';} public function endSeoData($templates){ $active_lang_code =$this->ssb_helper->getDefaultLanguage();$language_text=$this->language->load('module/superseobox');$templates_text='';$l_code_info='';foreach($templates['data'] as $l_code=> $val){ $hide=$active_lang_code !=$l_code ? 'style="display:none;"':'';if($val){ $templates_text.='<span class="label label-warning lang-'. $l_code .'" '.$hide.'>'.$val.'</span>';}else{ $templates_text.='<span class="label lang-'. $l_code .'" '.$hide.'>no template</span>';} $l_code_info.='<span class="label label-info lang-'. $l_code .'" '.$hide.'>'.$l_code.'</span>';} $header='      <tr class="tr-static"><td class="caption" colspan="4">Template for '.$language_text['text_entity_name_'.$this->CPBI].': '.$templates_text.'</td></tr>      <tr class="tr-static">       <th>Name</th>       <th>SEO TEXT '.$l_code_info.'</th>      </tr>      ';array_unshift($this->seo_data,$header);$this->seo_data[]='<tr class="tr-static"><th colspan="4">...etc.</th></tr>';} public function clearString($text,$full=false,$html_ch=false,$mode_decode=false,$target=false){ $clear_char=array( 'from' => array("\r\n","\n","\r","\\","\"", "_"),     'to' => array("", "", "", " ", "", " ")    );    if($target){     switch ($target) {      case 'related_prod':       $from = array("%","'","#");       $to   = array("", "", "");       break;      case '':       break;      case '':       break;     }     $clear_char = array(      'from'  => array_merge ($clear_char['from'], $from),      "to" => array_merge ($clear_char['to'], $to)     );    }    if($full){     if($mode_decode){      $text = html_entity_decode($text, ENT_QUOTES, "UTF-8");     }else{      $text = html_entity_decode($text, ENT_COMPAT, "UTF-8");     }    }    if($html_ch){     $text = strip_tags($text);    }    $text = trim(str_replace($clear_char['from'], $clear_char['to'], $text));    if(!$this->testgenerator){     $text = $this->db->escape($text);    }    $text = preg_replace("/(\s){2,}/",' ',$text);     return $text;   }   public function clearPreviewString($text){    $clear_char = array(     'from'  => array("\r\n", "\n", "\r", "\\", "\"", "_", "&nbsp;", "&amp;"),     'to' => array("", "", "", " ", "", " ", " ", "&")    );    $text = trim(str_replace($clear_char['from'], $clear_char['to'], $text));    $text = htmlentities($text, ENT_QUOTES, "UTF-8");    $text = preg_replace("/(\s){2,}/",' ',$text);    $text = strip_tags($text);    return $text;   }   public function prepareParamWithAddValue($param, $data, $data_clear, $add_val, $entity){    switch ($param)    {    case 'wc':     $delimiter = trim($add_val[0]) . ' ' . trim($add_val[1]) . ' ';      $data['wc'] = $add_val[1]. ' ' . implode($delimiter, $data_clear['wc']);     break;    case 'wt':     $delimiter = trim($add_val[0]) . ' ' . trim($add_val[1]) . ' ';      $data['wt'] = $add_val[1]. ' ' . implode($delimiter, $data_clear['wt']);     break;    case 'ep':     if(count($data_clear['ep']) > $add_val[0]){      $data['ep'] = array_splice($data_clear['ep'], 0, $add_val[0]);     }else{      $data['ep'] = $data_clear['ep'];     }     $delimiter = trim($add_val[1]) . ' ' . trim($add_val[2]) . ' ';      $data['ep'] = $add_val[2]. ' ' . implode($delimiter, $data['ep']);     break;    case 'cn':     if(count($data_clear['cn']) > $add_val[0]){      $data['cn'] = array_splice($data_clear['cn'], 0, $add_val[0]);     }else{      $data['cn'] = $data_clear['cn'];     }     $delimiter = trim($add_val[1]) . ' ' . trim($add_val[2]) . ' ';      $data['cn'] = $add_val[2]. ' ' . implode($delimiter, $data['cn']);     break;    case 'cd':     if($entity == 'category'){      $data['cd'] = $this->getSentences($data_clear['cd'] , $add_val[0]);     }else{      if(count($data_clear['cd']) > $add_val[0]){       $data['cd'] = array_splice($data_clear['cd'], 0, $add_val[0]);       }else{       $data['cd'] = $data_clear['cd'];      }      $data_ = array();      foreach($data['cd'] as $cd){       $data_[] = $this->getSentences($cd , $add_val[1]);       }      $data['cd'] = implode(' ', $data_);     }     break;     default:      $data[$param] =$this->getSentences($data_clear[$param] , $add_val[0]);    }    return $data[$param];   }   private function getSentences($text , $count) {    $text = strip_tags(html_entity_decode($text));    $pos = 0;    $found = false;    for ($x=0; $x<$count; $x++)    {      $pos = strpos($text, '.', $pos);     if($pos !== false){      $pos++;      $found = true;     }else{      break;     }    }    if(!$found OR $pos === false){     $respond = $text;    }else{     $respond = substr($text, 0, $pos);    }    return $respond;   }   public function addTD($text , $attr = ''){    return "<td ".$attr.">". $text ."</td>";   }  }  function templObjSort($a, $b) {   $a_len = strlen($a['matche']);   $b_len = strlen($b['matche']);   if ($a_len === $b_len) return 0;   return $a_len < $b_len ? 1 : -1;  }  ?>
