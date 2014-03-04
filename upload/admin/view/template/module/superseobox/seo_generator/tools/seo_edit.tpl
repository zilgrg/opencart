<h3>Edit SEO Items</h3>

<div class="tabbable">
	<ul class="nav nav-tabs ajax-tabs-content">
		<?php $i_tab = 1; foreach ($CPBI_keys as $index => $key) { ?>
			<li <?php if($i_tab ==1) echo  "class=\"active\"";?> >
				
				<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]='.$key; ?>" href="#seo_edit_<?php echo $key; ?>" data-toggle="tab" ><?php echo ${'text_entity_name_'.$key}; ?></a>
				
			</li>
		<?php $i_tab++; } ?>
	</ul>
	
	<div class="tab-content">
		<?php $i_pan = 1; foreach ($CPBI_keys as $index => $key) { ?>
		<div class="tab-pane <?php if($i_pan ==1) echo  "active";?>" id="seo_edit_<?php echo $key; ?>">
			
		</div>
		<?php $i_pan++; } ?>
	</div>
</div>
