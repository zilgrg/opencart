<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	
	<div class="container">
		<div id="et-header">
			<span class="em-header"><img src="view/image/blog/blog_manager.png" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" /></span>
			
			<ul>
				<li><a href="<?php echo $menu_home_href; ?>"><?php echo $text_menu_home; ?></a></li>
				<li><a href="<?php echo $menu_article_href; ?>"><?php echo $text_menu_article; ?></a></li>
				<li><a href="<?php echo $menu_category_href; ?>" class="active"><?php echo $text_menu_category; ?></a></li>
				<li><a href="<?php echo $menu_comment_href; ?>"><?php echo $text_menu_comment; ?></a></li>
				<?php if (isset($haspermission_addAuthor) || isset($haspermission_editAuthor) || isset($haspermission_removeAuthor) || isset($haspermission_editPermission)) { ?>
					<li><a href="<?php echo $menu_author_href; ?>"><?php echo $text_menu_author; ?></a></li>
				<?php } ?>
				<?php if (isset($haspermission_editSetting)) { ?>
					<li><a href="<?php echo $menu_setting_href; ?>"><?php echo $text_menu_setting; ?></a></li>
				<?php } ?>
				<li><a href="<?php echo $menu_about_href; ?>"><?php echo $text_menu_about; ?></a></li>
			</ul>
		</div>
		
		<?php if ($error_warning) { ?>
			<div class="warning">
				<?php echo $error_warning; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		<?php if ($attention) { ?>
			<div class="attention">				
				<?php echo $attention; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		<?php if ($success) { ?>
			<div class="success">
				<?php echo $success; ?>
				<img class="close" alt="" src="view/image/blog/close.png" />
			</div>
		<?php } ?>
		
		<div id="et-content">
			<div class="heading">
				<h2><?php echo $heading_list; ?></h2>
				<div class="buttons">
					<?php if (isset($haspermission_addCategory)) { ?>
						<a onclick="location = '<?php echo $insert; ?>'" class="button"><?php echo $button_insert; ?></a>
					<?php } ?>
					<?php if (isset($haspermission_copyCategory)) { ?>
						<a onclick="$('#form').attr('action', '<?php echo $copy; ?>'); $('#form').submit();" class="button"><?php echo $button_copy; ?></a>
					<?php } ?>
					<?php if (isset($haspermission_removeCategory)) { ?>
						<a onclick="$('#form').submit();" class="button"><?php echo $button_delete; ?></a>
					<?php } ?>
                    <a class="button btn-orange" onclick="window.open('<?php echo $online_help_url;?>', 'online-help', 'resizable=1, width=<?php echo $help_width; ?>, height=<?php echo $help_height; ?>');"><?php echo $text_help; ?></a>
				</div>
			</div>
			
			<div class="articleFilter">
				<h3><?php echo $text_filter; ?></h3>
				
				<table class="filter">
					<tr>
					  <td class="title"><?php echo $text_date_start; ?></td>
						 <td class="input_100">
							<input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" />
						 </td>
					  <td class="title"><?php echo $text_date_end; ?></td>
						 <td class="input_100">
							<input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" />
						 </td>
					</tr>
					<tr>
						<td class="title"><?php echo $text_status; ?></td>
						<td class="select_90">								
							<select name="filter_status">
								<option value="all"><?php echo $text_all; ?></option>
								<?php if ($filter_status) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
								<?php } ?>
								<?php if (!is_null($filter_status) && !$filter_status) { ?>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="0"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>								
						</td>
						<td class="title"><?php echo $text_store; ?></td>
						  <td class="select_min90" colspan="3">                  
							 <select name="filter_store">
								<option value="all"><?php echo $text_all; ?></option>                        
								<?php if ($filter_store === '0') { ?>
								   <option value="0" selected="selected"><?php echo $text_default; ?></option>
								<?php } else { ?>
								   <option value="0"><?php echo $text_default; ?></option>
								<?php } ?>
								<?php foreach ($stores as $store) { ?>
								   <?php if ($store['store_id']==$filter_store) { ?>
									  <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
								   <?php } else {?>
									  <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
								   <?php } ?>
								<?php } ?>
							 </select>
						  </td>
					</tr>
				</table>
				<div class="buttons right">
					<a onclick="filter();" class="button"><?php echo $text_apply_filter; ?></a>
				</div>
			</div>			
			<span id="filterOptions">[ <a href="<?php echo $action; ?>"><?php echo $text_reset; ?></a> -  <span><?php echo $text_show_filter; ?></span> ]</span>
			
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="blogList">
					<thead>
						<tr>
							<?php if (isset($haspermission_removeCategory) || isset($haspermission_copyCategory)) { ?>
								<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<?php } ?>
							
							<?php if ($sort == 'c.category_id') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:50px;"><a href="<?php echo $sort_catid; ?>"><?php echo $column_cat_id; ?></a></td>
							<?php } else { ?>
								<td class="center"><a href="<?php echo $sort_catid; ?>" style="width:50px;"><?php echo $column_cat_id; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'cd.name') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:200px;"><a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:200px;"><a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'keyword') { ?>
								<td class="center <?php echo strtolower($order); ?>" ><a href="<?php echo $sort_seo; ?>"><?php echo $column_seo; ?></a></td>
							<?php } else { ?>
								<td class="center" ><a href="<?php echo $sort_seo; ?>"><?php echo $column_seo; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'created') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:100px;"><a href="<?php echo $sort_created; ?>"><?php echo $column_created; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:100px;"><a href="<?php echo $sort_created; ?>"><?php echo $column_created; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'c2s.store_id') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:100px;"><a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:100px;"><a href="<?php echo $sort_store; ?>"><?php echo $column_store; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'c.status') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:105px;"><a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:105px;"><a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a></td>
							<?php } ?>
							
							<?php if ($sort == 'c.sort_order') { ?>
								<td class="center <?php echo strtolower($order); ?>" style="width:70px;"><a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a></td>
							<?php } else { ?>
								<td class="center" style="width:70px;"><a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a></td>
							<?php } ?>
							
							<?php if (isset($haspermission_editCategory)) { ?>
								<td class="center" style="width:60px;"><?php echo $column_action; ?></td>
							<?php } ?>
						</tr>
					</thead>
					<tbody>
						<?php if ($categories) { ?>
							<?php $class = 'odd'; $i = 0; ?>
							<?php foreach ($categories as $category) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); $i = $i + 1; ?>
								<?php $disabled = ($category['status']) ? '' : ' disabled'; ?>
								<tr id="category-row<?php echo $category['category_id']; ?>" class="<?php echo $class . $disabled; ?>">
									<?php if (isset($haspermission_removeCategory) || isset($haspermission_copyCategory)) { ?>
										<td class="center">
											<?php if ($category['selected']) { ?>
												<input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
											<?php } else { ?>
												<input type="checkbox" name="selected[]" value="<?php echo $category['category_id']; ?>" />
											<?php } ?>
										</td>
									<?php } ?>
									<td class="center"><?php echo $category['category_id']; ?></td>
									<td class="left"><?php echo $category['name']; ?></td>
									<td class="left"><?php echo $category['keyword']; ?></td>
									<td class="center"><?php echo $category['created']; ?></td>
									<td class="left">
										<?php if (in_array(0, $category['store'])) { ?>
											<?php echo $text_default; ?>
										<?php } ?>
										<?php if (!empty($stores)) { ?>
											<?php foreach ($stores as $store1) { ?>
												<?php if (in_array($store1['store_id'], $category['store'])) { ?>
													<br> <?php echo $store1['name'];?>
												<?php } ?>
											<?php } ?>
										<?php } ?>
									</td>
									<td class="center">
										<?php if (isset($haspermission_editCategory)) { ?>
											<select onchange="editStatus(<?php echo $category['category_id']; ?>)" id="artStatus-<?php echo $category['category_id']; ?>" name="status_<?php echo $category['category_id']; ?>">
												<option value="1" <?php echo ($category['status']) ? 'selected="selected"' : ''; ?> ><?php echo $text_enabled; ?></option>
												<option value="0" <?php echo (!$category['status']) ? 'selected="selected"' : ''; ?>><?php echo $text_disabled; ?></option>
											</select>
										<?php } else { ?>
											<?php echo ($category['status']) ? $text_enabled : $text_disabled; ?>
										<?php } ?>
									</td>
									<td class="center input_35_center">
										<?php if (isset($haspermission_editCategory)) { ?>
											<input onchange="editOrder(<?php echo $category['category_id']; ?>)" id="artOrder-<?php echo $category['category_id']; ?>" type="text" name="sort_order_<?php echo $category['category_id']; ?>" value="<?php echo $category['sort_order']; ?>" tabindex="<?php echo $i; ?>" />
										<?php } else { ?>
											<?php echo $category['sort_order']; ?>
										<?php } ?>
									</td>
									<?php if (isset($haspermission_editCategory)) { ?>
										<td class="center"><?php foreach ($category['action'] as $action) { ?>
											<a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a>
											<?php } ?>
										</td>
									<?php } ?>
								</tr>
							<?php } ?>
						<?php } else { ?>
							<tr>
								<?php if (isset($haspermission_removeCategory) && isset($haspermission_editCategory)) { ?>
									<td class="center" colspan="7"><?php echo $text_no_results; ?></td>
								<?php } elseif (isset($haspermission_removeCategory) || isset($haspermission_editCategory)) { ?>
									<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
								<?php } else { ?>
									<td class="center" colspan="5"><?php echo $text_no_results; ?></td>
								<?php } ?>
							</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
			<div class="pagination"><?php echo $pagination; ?></div>
		</div>
		
		<div id="et-footer"><?php echo $link_copyright . $oc_footer; ?></div>
	</div>
</div>

<script type="text/javascript" src="view/javascript/blog/blog.js"></script>
<script type="text/javascript"><!--

$(document).ready(function() {
	$('#filterOptions span').toggle(function(){
		$('.articleFilter').slideToggle();
		$(this).text('<?php echo $text_hide_filter; ?>');
	}, function() {
		$('.articleFilter').slideToggle('fast');
		$(this).text('<?php echo $text_show_filter; ?>');
	});
});


$(document).ready(function() {
	$('#date-start').datepicker({dateFormat: 'yy-mm-dd'});
	
	$('#date-end').datepicker({dateFormat: 'yy-mm-dd'});
});

function filter() {
	url = 'index.php?route=blog/category&token=<?php echo $token; ?>';
	
	var filter_status = $('select[name=\'filter_status\']').attr('value');
	if (filter_status != 'all') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
   
    var filter_store = $('select[name=\'filter_store\']').attr('value');
	if (filter_store != 'all') {
		url += '&filter_store=' + encodeURIComponent(filter_store);
	}

	location = url;
}

function editStatus(category_id) {
	$.ajax({
		url: 'index.php?route=blog/category/editStatus&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: 'status=' + encodeURIComponent($('select[name="status_' + category_id + '"]').val()) + '&category_id=' + category_id,
		beforeSend: function() {
			$('.success-status' + category_id).remove();
			$('.success, .warning, .error, .attention').remove();
			$('#artStatus-' + category_id).after('<img src="view/image/blog/load.gif" class="loading-status' + category_id + '" />');
		},
		complete: function() {
			$('.loading-status' + category_id).remove();
		},				
		success: function(json) {					
			if (json['success']) {
				$('#artStatus-' + category_id).after('<img src="view/image/blog/check.png" class="success-status' + category_id + '" />');
				
				if (json['status'] == 'disabled') {
					$('#category-row' + category_id).addClass('disabled');
				} else {
					$('#category-row' + category_id).removeClass('disabled');
				}
				
				setTimeout(function(){
					$('.success-status' + category_id).fadeOut(400).delay(350).remove();
				},2500);
			}
		}
	});
}

function editOrder(category_id) {
	$.ajax({
		url: 'index.php?route=blog/category/editOrder&token=<?php echo $token; ?>',
		type: 'POST',
		dataType: 'json',
		data: 'sort_order=' + encodeURIComponent($('input[name="sort_order_' + category_id + '"]').val()) + '&category_id=' + category_id,
		beforeSend: function() {
			$('.success-order' + category_id).remove();
			$('.attention-order' + category_id).remove();
			$('.success, .warning, .error, .attention').remove();
			$('#artOrder-' + category_id).after('<img src="view/image/blog/load.gif" class="loading-order' + category_id + '" />');
		},
		complete: function() {
			$('.loading-order' + category_id).remove();
		},				
		success: function(json) {					
			if (json['success']) {
				$('#artOrder-' + category_id).after('<img src="view/image/blog/check.png" class="success-order' + category_id + '" />');
				setTimeout(function(){
					$('.success-order' + category_id).fadeOut(400).delay(350).remove();
				},2500);
			}
			if (json['error']) {
				$('#artOrder-' + category_id).after('<img src="view/image/blog/attention.png" class="attention-order' + category_id + '" />');
			}
		}
	});
}
//--></script>

<div class="hidden">
	<img src="view/image/blog/load.gif" />
	<img src="view/image/blog/check.png" />
	<img src="view/image/blog/attention.png" />
</div>
<?php echo $footer; ?>