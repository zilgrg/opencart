<div class="pull-right input-append">
	<input type="text" name="filter_name" value="" class="ui-autocomplete-input" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true">
	<a data-type="category" class="btn seo-edit-list-search" type="button">
		Search
	</a>
	<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]=category'; ?>" class="btn seo-edit-list-all" type="button">
		Show all
	</a>
</div>
<div style="margin-bottom: 20px;">
	<?php echo $content['pagination']; ?>
</div>
<div class="accordion seo_edit-list" id="seo_edit-list-category">
<?php $i_tr = 1; foreach ($content['content'] as $item_id => $cont_data) { ?> 
	<div class="accordion-group">
		<input type="hidden" name="data[item_type]" style="width:90%;" type="text" value="category">
		 <input type="hidden" name="data[item_id]" style="width:90%;" type="text" value="<?php echo $item_id; ?>">
		<div class="accordion-heading">
			<a class="accordion-toggle" data-toggle="collapse" data-parent="#seo_edit-list-category" href="#<?php echo 'collapse-category-'.$i_tr.'-'.$item_id; ?>">
				<span>
					<?php echo $cont_data['data'][$languages[$lang_default]]['name']; ?>
				</span>
				<a data-afteraction="afterAction" data-action="saveGenEditorContent" data-scope=".closest('.accordion-group').find('input, textarea')" class="btn ajax_action" type="button">
					Save
				</a>
				<b class="caret" style="margin-top: 8px;"></b>
			</a>
		</div>
		<div id="<?php echo 'collapse-category-'.$i_tr.'-'.$item_id; ?>" class="accordion-body collapse">
			<div class="accordion-inner">
				<ul class="nav nav-tabs" id="">
				<?php $i_tb = 1; foreach ($cont_data['data'] as $lang_id => $data) { ?>
					<li class="<?php if($i_tb ==1){echo 'active';} ?>">
						<a href="#<?php echo 'seo_edit-category-'.$i_tb.'-'.$lang_id.'-'.$item_id; ?>" data-toggle="tab">
							<img src="view/image/flags/<?php echo $languages_array[$lang_id]['image']; ?>" title="<?php echo $languages_array[$lang_id]['name']; ?>" /> <?php echo $languages_array[$lang_id]['name']; ?>
						</a>
					</li>
				<?php $i_tb++;} ?>
				</ul>
				
				<div class="tab-content">
				<?php $i_tp = 1; foreach ($cont_data['data'] as $lang_id => $data) { ?>	
					<div class="tab-pane <?php if($i_tp ==1){echo 'active';} ?>" id="<?php echo 'seo_edit-category-'.$i_tp.'-'.$lang_id.'-'.$item_id; ?>">
						<form class="form-horizontal">
							<div class="control-group">
								<label class="control-label">Tags</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][tag]" style="width:90%;" type="text" value="<?php echo $data['tags']; ?>">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Meta Descriptions</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][meta_description]" style="width:90%;" type="text" value="<?php echo $data['m_descrip']; ?>">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Meta Keywords</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][meta_keyword]" style="width:90%;" type="text" value="<?php echo $data['m_keywords']; ?>">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Title</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][title]" style="width:90%;" type="text" value="<?php echo $data['titles']; ?>">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">SEO H1</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][seo_h1]" style="width:90%;" type="text" value="<?php echo $data['seo_h1']; ?>">
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">Description</label>
								<div class="controls">
									<textarea name="data[content][<?php echo $lang_id; ?>][description]" style="width:90%;" rows="10" cols="100" >
										<?php echo $data['descrip']; ?>
									</textarea>
								</div>
							</div>
							<div class="control-group">
								<label class="control-label">URL</label>
								<div class="controls">
								  <input name="data[content][<?php echo $lang_id; ?>][keyword]" style="width:90%;" type="text" value="<?php echo $data['urls']; ?>">
								</div>
							</div>
						</form>
					</div>
				<?php $i_tp++;} ?>
				</div>
			</div>
		</div>
	</div>
<?php $i_tr++; } ?>
</div>
