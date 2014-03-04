<?php class ssb_table extends Controller { function __construct(){ global $registry;parent::__construct($registry);} static private $Instance =NULL;static public function getInstance() { if(self::$Instance==NULL){ $class=__CLASS__;self::$Instance=new $class;} return self::$Instance;} public function changeTables($defChangeTable) { foreach($defChangeTable as $key=> $val){ $table =$val['name'];$columns =$val['columns'];$types =$val['types'];$sprints =isset($val['sprints']) ? $val['sprints']:false;if(!$this->isTable($table)){ $prim =isset($val['prim']) ? $val['prim']:false;$end=$val['end'];$this->makeTable($table,$columns,$types,$sprints,$prim,$end);}else{ foreach($columns as $key_c=> $column){ if(!$this->isColumn($table,$column)){ $type =isset($types[$key_c]) ? $types[$key_c]:$types[0];$sprint=false;if($sprints AND isset($sprints[$key_c]) AND $sprints[$key_c] !='') $sprint=$sprints[$key_c];$this->makeColumn($table,$column,$type,$sprint);} } } if(isset($val['autoFillFunc'])){ eval($val['autoFillFunc']);} } } private function isColumn($table,$column) { $issql=" SHOW COLUMNS FROM `".DB_PREFIX.$table."`  LIKE '".$column."'";$is_column=$this->db->query($issql);$length=0;foreach ($is_column->rows as $index) $length++;return $length ? true:false;} private function makeColumn($table,$column,$type,$sprint) { if(isset($sprint) AND $sprint) $type=sprintf($type,eval('return '.$sprint));$this->db->query("ALTER TABLE `".DB_PREFIX.$table."` ADD `".$column."` ".$type.";" );} private function makeTable($name,$columns,$types,$sprints,$prim,$end) { $column_text='';foreach($columns as $key_c=> $column){ $column_text.=" `".$column."` ";$type =isset($types[$key_c]) ? $types[$key_c]:$types[0];$sprint =false;if($sprints AND isset($sprints[$key_c]) AND $sprints[$key_c] !=''){ $sprint=$sprints[$key_c];$type=sprintf($type,eval('return '.$sprint));} $column_text.=$type.", ";} if($prim){ $column_text.=$prim." ";}else{ $column_text=rtrim ($column_text);$column_text=rtrim ($column_text,',');} $query_text="CREATE TABLE IF NOT EXISTS `".DB_PREFIX.$name."` (".$column_text." ) ".$end.";";$query=$this->db->query($query_text);} public function isTable($table) {
	$custom_errno = DB_DRIVER . '_errno';
	if(DB_DRIVER != 'mysql' AND DB_DRIVER != 'mysqli'){
		trigger_error('Error: Not support of DB -> ' . DB_DRIVER . ' in the function "isTable" <br />');
		exit();
	}
	if(DB_DRIVER == 'mysqli'){
		$mysqli = new mysqli(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
		$res = mysqli_query($mysqli, "SELECT * FROM `". DB_PREFIX .$table."` LIMIT 1");
		$err_no = $custom_errno($mysqli);
	}elseif(DB_DRIVER == 'mysql'){
		$res = mysql_query("SELECT * FROM `". DB_PREFIX .$table."` LIMIT 1");
		$err_no = $custom_errno();
	}
	return ($err_no != '1146' && $res = true);
} 
} ?>