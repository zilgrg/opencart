<div style="margin-bottom: 20px;">
	<?php echo $content['pagination']; ?>
</div>

<div class="pull-right input-append">
	<input type="text" name="filter_name" value="" class="span2">
	<a data-type="<?php echo $type ?>" class="btn btn-success seo-edit-list-search" type="button">
		Search
	</a>
	<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]=' . $type; ?>" class="btn seo-edit-list-all" type="button">
		Reset
	</a>
</div>

<!-- multilanguage for standard urls !-->
<div>
<ul class="nav nav-pills change_lang" style="margin-bottom: -10px;">
<li style="margin-top: 10px;">Choose language:&nbsp;</li>
<?php foreach ($languages_array as $lang_id => $language){ if(!$language['status'])continue; ?>
	
	<li <?php if($lang_default == $language['code']) echo  "class=\"active\"";?>>
		<a data-code-class="lang-<?php echo $language['code'] ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> - <?php echo $language['name']; ?></a>
	</li>
<?php } ?>
</ul>
</div>
<!-- multilanguage for standard urls !-->

<table class="table table-condensed table-hover table-bordered">
	<thead>
		<tr>
		  <?php foreach ($th_name as $th) { ?> 
		  <th><?php echo $th; ?></th>
		  <?php } ?>
		</tr>
	</thead>
	<tbody>
	<?php $i_tr = 1; foreach ($content['content'] as $item_id => $cont_data) { ?> 
		<tr>
		<?php if($type != 'info' AND $type != 'standardPage'){ ?>
		  <td class="seo_edit-id">
			<?php $i_tp = 1; foreach ($cont_data['data'] as $lang_id => $data) { ?>	
				<div class="<?php if($lang_default != $languages_array[$lang_id]['code']) echo  "hide";?> lang_container lang-<?php echo $languages_array[$lang_id]['code']; ?>">
					<img src="<?php echo $cont_data['image']; ?>" />
				</div>
			<?php $i_tp++;} ?>
		  </td>
		<?php } ?>
		  <?php 
			foreach($seo_edit_metadata as $sei) { 
				$data_type = isset($sei['type']) ? $sei['type'] : 'textarea';
				$wysihtml5 = $data_type == 'wysihtml5' ? ' data-inputclass="span8"' : '';
				$placement = isset($sei['placement']) ? $sei['placement'] : 'top';
		  ?>
			<td>
				<?php $i_tp = 1; foreach ($cont_data['data'] as $lang_id => $data) { 
					$l_code = $languages_array[$lang_id]['code'];?>	
					<div class="<?php if($lang_default != $l_code) echo  "hide"; ?> lang_container lang-<?php echo $l_code; ?>">
						<a <?php echo $wysihtml5; ?> data-placement="<?php echo $placement; ?>" class="editable" data-type="<?php echo $data_type; ?>" data-pk="{id:<?php echo $item_id; ?>, lang_id: '<?php echo $lang_id; ?>', col:'<?php echo $sei['col']; ?>', type:'<?php echo $type; ?>'}" data-html="true" data-name="<?php echo $sei['table']; ?>" data-value="<?php echo $data[$sei['data_name']]; ?>"><?php echo $data[$sei['data_name']]; ?></a>
					</div>
				<?php $i_tp++;} ?>
			</td>
		  <?php } ?>
		  
			<?php if($type == 'product'){ ?>
			<td>
			<?php if(count($cont_data['related_onlyId'])){ ?>
			<a data-type="select2" data-pk="1" data-value="<?php echo json_encode($cont_data['related_onlyId']); ?>" data-title="Click for remove" class="editable-select2 editable-click"></a>
			<script>
				$('.editable-select2').editable({
					url: '<?php echo htmlspecialchars_decode($urls['seo_edit_save']); ?>',
					mode: 'popup',
					emptyclass:'customEmptyClass',
					placement: 'left',
					source: <?php echo json_encode($cont_data['related']); ?>,
					emptytext: '',
					select2: {
						multiple: true,
						width: 200,
						placeholder: 'Select products',
						allowClear: true
					}
					//showbuttons: false
				});
			</script>
			<?php } ?>
			</td>
			<?php } ?>
		</tr>
	<?php $i_tr++; } ?>	
	</tbody>
</table>
<div style="margin-bottom: 20px;">
	<?php echo $content['pagination']; ?>
</div>