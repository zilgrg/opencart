<?php if ($stores) { ?>
<p>
Before using this function, you must fill all fields below.
</p>
<div class="control-group form-horizontal">
	<label class="control-label">SEO Store</label>
	<div class="controls">
		<input type="hidden" name="data[tools][seo_store][status]" value="">
		<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('#seo_tool_store').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_store']['status']) echo 'checked="checked"'; ?> name="data[tools][seo_store][status]" class="on_off noAlert">

		<a data-afteraction="afterAction" data-action="save" data-scope=".closest('#seo_tool_store').find('input')" class="btn ajax_action btn-success" type="button">Save</a>
	</div>
</div>
<h5>List of stores:</h5>
<div class="tabbable">
  <ul class="nav nav-tabs">
    <?php $i_nav_seostore = 1; foreach ($stores as $store) { ?>
	<li <?php if($i_nav_seostore ==1) echo  "class=\"active\"";?> >
		<a href="#seo_store-<?php echo $store['store_id']; ?>" data-toggle="tab">
			<?php echo $store['name']; ?>
		</a>
	</li>
	<?php $i_nav_seostore++; } ?>
  </ul>
  <div class="tab-content">
	<?php $i_tab_seostore = 1; foreach ($stores as $store) { ?>
		<div class="tab-pane <?php if($i_tab_seostore ==1) echo  "active";?>" id="seo_store-<?php echo $store['store_id']; ?>" >
			<div class="tabbable "> 
				<ul class="nav nav-tabs">
					<?php $i_seo_store_lang_nav = 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
						<li <?php if($i_seo_store_lang_nav ==1) echo  "class=\"active\"";?>>
							<a class="flag-in-tabs" href="#seo_store_lang-<?php echo $store['store_id']; ?>-<?php echo $l_code;?>" data-toggle="tab">
								<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
							</a>
						</li>
					<?php $i_seo_store_lang_nav++; } ?>
				</ul>
				
				<div class="tab-content">
					<?php $i_tab_store_lang_nav = 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
						<div class="tab-pane <?php if($i_tab_store_lang_nav ==1) echo  "active";?>" id="seo_store_lang-<?php echo $store['store_id']; ?>-<?php echo $l_code;?>" >
							<div class="form-horizontal">
								<div class="control-group">
									<label class="control-label">Store name</label>
									<div class="controls">
										<?php
										$name = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_name']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_name'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_name]" value="<?php echo $name; ?>">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Store title</label>
									<div class="controls">
										<?php
										$title = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_title']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_title'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_title]" value="<?php echo $title; ?>">
										<span class="help-inline">for Home page</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">META Description</label>
									<div class="controls">
										<?php
										$m_descrip = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_description']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_description'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_meta_description]" value="<?php echo $m_descrip; ?>">
										<span class="help-inline">for Home page</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">META Keyword</label>
									<div class="controls">
										<?php
										$m_keyword = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_keyword']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_keyword'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_meta_keyword]" value="<?php echo $m_keyword; ?>">
										<span class="help-inline">for Home page</span>
									</div>
								</div>
							</div>
						</div>
					<?php $i_tab_store_lang_nav++; } ?>
				</div>

			</div>
		  
		</div>
    <?php $i_tab_seostore++; } ?>
  </div>
</div>
<?php } else { ?>
	No stores
<?php } ?>

<h4>What is the "SEO store"?</h4>
<p>Here you can easy set  name, title and META tags for every of your stores and for every language. And this data will be displayed on Home page for every of your store. </br>With this function all your stores will be has more unique text, what improves your SEO. </br>Even if you have one store, we recommend fill this fields for display META tags on your home page.</p>