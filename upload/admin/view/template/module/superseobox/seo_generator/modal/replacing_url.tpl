<!-- MODAL PARAMETERS DESCRIPTION !-->
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3>String for replacing in the SEO URLs (<?php echo ${'text_entity_name_'.$CPBI} .' '. ${'text_category_name_'.$entity_cat}; ?>)</h3>
  </div>

  <div class="modal-body replacing-tables">
	<td class="info_text">
		<dl>
			<dt>Info about replacing function:</dt>
			<dd class="info-area">
				Here you can easily add char or string for replacing in SEO URLs.</br> For example:</br>
				Every name of products contain string " for ", and you don't want see this string in the URLs. Then you can click here on the tab "pn - Product's name" and enter " for " in field "String for search" and  field "String for replace" leave empty. And then click on the button "Save". After this, you can use generator, and, in this case, all string " for " will be deleted from the SEO URLs.
			</dd>
		</dl>
	</td>
	<input type="hidden" class="exclusion_empty" name="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing]" value=""/>
	<?php 
		$possible_pattern = array(
			'product' 	=> array('pn', 'pm', 'pu','ps', 'sn'),
			'category' 	=> array('cn', 'cp', 'tp', 'sn'),
			'brand'		=> array('bn', 'tp', 'sn'),
			'info'		=> array('in', 'sn')
		); 
	?>
  	<div class="tabbable tabs-left"> 
		<ul class="nav nav-tabs">
			<?php $i_nav_param_descrip = 1; foreach ($possible_pattern[$CPBI] as $parameter) { ?>
				<li <?php if($i_nav_param_descrip ==1) echo  "class=\"active\"";?> ><a href="#replacing-<?php echo $parameter; ?>" data-toggle="tab">!<?php echo $parameter; ?> - <?php echo $pattern_info[$parameter]['name']; ?></a></li>
			<?php $i_nav_param_descrip++; } ?>
		</ul>
		
		<div class="tab-content">
			<?php $i_nav_param_descrip = 1; foreach ($possible_pattern[$CPBI] as $parameter) { ?>
				<div class="tab-pane <?php if($i_nav_param_descrip ==1) echo  "active";?>" id="replacing-<?php echo $parameter; ?>">
					<table class="table table-hover grider">
						<thead>
							<tr class="top_table">
								<th>String for search</th>
								<th>String for replace</th>
							</tr>
						 </thead>
						 <tbody>
						<?php if(count($replacing) AND isset($replacing[$parameter]['search'])){?>
							<?php foreach ($replacing[$parameter]['search'] as $ii => $search) { ?>
							<tr>
								<td> 
								<input data-gride-pattern="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][search][%i1]" class="span2 search" type="text" name="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][search][<?php echo $ii;?>]"  value="<?php echo $search;?>">
								</td>
								<td> 
								<input data-gride-pattern="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][replace][%i1]" type="text" name="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][replace][<?php echo $ii;?>]" class="span2" value="<?php echo $replacing[$parameter]['replace'][$ii];?>">
								</td>
							</tr>
							<?php } ?>
						<?php }else{ ?>
							<tr>
								<td> 
								<input class="span2 search" data-gride-pattern="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][search][%i1]" type="text" name="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][search][0]"  value="">
								</td>
								<td> 
								<input data-gride-pattern="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][replace][%i1]" class="span2" type="text" name="data[entity][<?php echo $entity_cat;?>][CPBI_urls][data][<?php echo $CPBI;?>][replacing][<?php echo $parameter;?>][replace][0]"  value="">
								</td>
							</tr>
						<?php } ?>
						</tbody>
					</table>
				</div>
			<?php $i_nav_param_descrip++; } ?>
		</div>	
	</div>
  </div>
  <div class="modal-footer">
	<input name="additionData[save_replacing_table]" type="hidden" value="1">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	<a data-entity="<?php echo $entity_cat;?>-CPBI_urls-<?php echo $CPBI;?>" data-jsbeforeaction="prepareReplacing();" data-afteraction="afterAction" data-action="save" data-scope=".closest('.ajax_modal').find('input').not('.stamp')" class="btn btn-success ajax_action" data-dismiss="modal" type="button">Save</a>
  </div>
  
  <script>
function prepareReplacing(){
	
	var $input = $('.replacing-tables').find('.grider tbody input.search');
	$input.each(function(){
		var val = $(this).val();
		if(val == ''){
			$(this).closest('tr').remove();
		}
	});
	
	var $panels = $('.replacing-tables').find('.tab-pane');
	$panels.each(function(){
		$input = $(this).find('.grider tbody input.search');
		if($input.length){
			$(this).find('.parameter_empty').remove();
		}
	});
	
	$input = $('.replacing-tables').find('.grider tbody input.search ');
	if($input.length){
		$('.replacing-tables').find('.exclusion_empty').remove();
	}
	
}
setTimeout(function(){
	$('.replacing-tables .delete').live('click', function(){
		$input = $(this).closest('tbody').find('input.search');
		if($input.length == 1){
			$input.closest('tr').find('input').val('');
		}
	});
},500);
</script>
<style>
.modal-absolute.ajax_modal{
	width: 80%!important;
	margin-left: -40%!important;
}
.modal-absolute .replacing-tables{
	height: 500px!important;
	min-height: 500px!important;
}
</style>
