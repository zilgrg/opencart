<!-- header start -->	
	<?php 
		$entity_category_name = 'related_prod';
	?>
<form class="form-horizontal">
<table class="table table-condensed no-border">
	<tbody>
	<tr>
	<td colspan="2">
		<h3><?php echo ${'gen_tab_content_name_'.$entity_category_name}; ?></h3>
			<div class="accordion-group info-area">
				<div class="accordion-heading" <?php if($entity_category_name == 'urls') { ?> data-intro="Click here to see context help and template examples for every tabs" data-step="5" data-position="bottom" <?php } ?> >
				  <a class="accordion-toggle" data-toggle="collapse" href="#example-<?php echo $entity_category_name; ?>">
					<span class="lead">Click here to see info about Generator of related products</span>
				  </a>
				</div>
				<div id="example-<?php echo $entity_category_name; ?>" class="accordion-body collapse out">
					<div class="accordion-inner">
						<button type="button" class="close">x</button>
						<?php echo ${'gen_tab_content_exapmle_'.$entity_category_name}; ?>
					</div>
				</div>
			</div>

	</td>
	</tr>
<!-- header end -->	

<tr>
	
	<td>
		<fieldset>
		<div class="control-group">
			<div class="controls btn-group pull-right" style="margin-left: 0px;">
				<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-product" data-scope=".parents('form').find('input')" class="btn btn-success ajax_action" type="button">Generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for all products!</a>
				<?php if($entity_category_name != 'images') { ?>
					<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-all" class="btn btn-danger ajax_action" type="button">Clear all</a>
				<?php } ?>	
			</div>
		</div>
		</fieldset>
	</td>
	<td class="info_text">
		<dl>
			<dt>Generate <?php echo ${'text_category_name_'.$entity_category_name}; ?>:</dt>
			<dd class="info-area">
				Here you can generate <?php echo ${'text_category_name_'.$entity_category_name}; ?> for all products in one click.
			</dd>
		</dl>
	</td>
</tr>

<tr>
	<td>
		<fieldset>
		<div class="control-group">
		<label class="control-label" for="">
			Total number of related products
		</label>
			<div class="controls">
				<div class="input-append">
					<input min="3" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 3 to 10" name="data[entity][related_prod][product][data][total_related]" value="<?php echo $data['entity']['related_prod']['product']['data']['total_related']; ?>">
					<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button">Save</a>
				</div>
			</div>
		</div>
		</fieldset>
	</td>
	<td class="info_text">
		<dl>
			<dt>
			Total number of related products:</dt>
			<dd class="info-area">
				Here you can set "Total number of related products" (min:3, max:10)
			</dd>
		</dl>
	</td>
</tr>

<tr>
	<td>
		<fieldset>
		<div class="control-group">
		<label class="control-label" for="">
			Level of relevance
		</label>
			<div class="controls">
				<div class="input-append">
					<input min="5" max="30" type="number" data-toggle="tooltip" data-original-title="Must be between 5 to 30" name="data[entity][related_prod][product][data][lev_relev]" class="" value="<?php echo $data['entity']['related_prod']['product']['data']['lev_relev']; ?>">
					<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button">Save</a>
				</div>
			</div>
		</div>
		</fieldset>
	</td>
	<td class="info_text">
		<dl>
			<dt>
			Level of relevance:</dt>
			<dd class="info-area">
				Here you can set "Level of relevance" (min:8, max:30).
				If you have many identical products, please set this value more less (maybe 10-12).
				And, if module don't generate related products, please, set this value more large (maybe 20-30) and then click generate button.
			</dd>
		</dl>
	</td>
</tr>

	</tbody>
</table>
</form>

