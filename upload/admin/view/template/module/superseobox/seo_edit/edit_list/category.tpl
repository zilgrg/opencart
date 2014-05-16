<?php 
	$type = 'category';
	$seo_edit_metadata = array(
		array('table' => 'category_description','col' => 'name', 'data_name' => 'name', 'type' => 'text'),
		array('table' => 'url_alias','col' => 'url_alias', 'data_name' => 'urls' , 'type' => 'text'),
		array('table' => 'category_description','col' => 'tag', 'data_name' => 'tags'),
		array('table' => 'category_description','col' => 'description', 'data_name' => 'descrip', 'type' => 'wysihtml5'),
		array('table' => 'category_description','col' => 'meta_keyword', 'data_name' => 'm_keywords'),
		array('table' => 'category_description','col' => 'meta_description', 'data_name' => 'm_descrip', 'placement' => 'left'),
		array('table' => 'category_description','col' => 'seo_title', 'data_name' => 'titles',  'placement' => 'left'),
		array('table' => 'category_description','col' => 'seo_h1', 'data_name' => 'seo_h1',  'placement' => 'left')
	);
	$th_name = array('Image', 'Name', 'URL', 'Tags', 'Description', 'Meta Keywords', 'Meta Descriptions', 'Title', 'SEO H1');
?>
<?php require_once 'edit_list.tpl';?>