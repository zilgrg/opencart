<?php
//==============================================================================
// Smart Search v156.4
//
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo $header; ?>
<style type="text/css">
	.buttons {
		background: url('view/image/box.png') repeat-x;
		border: 1px solid #DDD;
		border-radius: 7px;
		margin: -1px 0 0 !important;
		padding: 6px;
		position: fixed;
		right: 30px;
	}
	.buttons, .ui-dialog {
		box-shadow: 0 3px 6px #999;
	}
	.help {
		font-style: italic;
		margin-top: 5px;
	}
	.settings-header {
		background: #E4EEF7;
		font-weight: bold;
	}
	.form ul {
		line-height: 1.5;
		margin: 0;
		padding-left: 20px;
	}
	.fields-block {
		display: inline-block;
		width: 180px;
	}
	input[type="text"] {
		width: 40px;
	}
	.ajax-block {
		display: inline-block;
		font-size: 11px;
		text-align: center;
		width: 75px;
	}
	.color {
		padding: 5px !important;
		width: 55px !important;
	}
	.sub-table td {
		border: none;
		font-size: 11px;
	}
	.list {
		width: 500px;
	}
	.list img {
		vertical-align: middle;
	}
	.list input {
		width: 200px;
	}
	.ui-dialog {
		padding: 0;
		position: fixed;
	}
	#progressbar {
		padding: 0;
		height: 24px !important;
	}
	.ui-progressbar-value {
		background-image: url('data:image/gif;base64,R0lGODlhMAAWAPMPAO+cSvfOlPfFlO/FjP+9c/+1c/e1a/+tUu+ta++tY/+lSvelQvelSu+cQv/WnAAAACH/C05FVFNDQVBFMi4wAwEAAAAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh/wtYTVAgRGF0YVhNUIAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/PgAh+QQFBwAPACwAAAAAMAAWAAAErHDISauVwenNu9cCIo5kaSIGoa5s66rGKZ/pa78xkux87/u1mxD2KxoTweHNcGzykkqc0wmNtpjTY9W6wmaLhoJ4TC6bxd4v8Mxmp9XPtpz89gHu+Pydcej7/4CBfQx6hYZ5fIKKgoSHjoiLkX+Nj48MCpiZmpucmJSVh5edo52flQ2oqQ2ipK2eqrCxsqyupAuyuLO1rre5vqi0u5y9v7kLwrbFvsfIncTKsBEAIfkEBQcADwAsAAAAADAA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');
	}
</style>
<?php if ($version > 149) { ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<?php } ?>
<div class="box">
	<?php if ($version < 150) { ?><div class="left"></div><div class="right"></div><?php } ?>
	<div class="heading">
		<h1 style="padding: 10px 2px 0"><img src="view/image/<?php echo $type; ?>.png" alt="" style="vertical-align: middle" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a class="button" onclick="saveSettings(true)"><span><?php echo $button_save_exit; ?></span></a>
			<a class="button" onclick="saveSettings(false)"><span><?php echo $button_save_keep_editing; ?></span></a>
			<a class="button" onclick="location = '<?php echo $exit; ?>'"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
		<form action="" method="post" enctype="multipart/form-data" id="form">
			<table class="form">
				<tr class="settings-header">
					<td colspan="2"><span style="font: normal 11px / 1.5 Verdana, Geneva, sans-serif; color: #333"><?php echo $entry_smartsearch_explanation; ?></span></td>
				</tr>
				<tr>
					<td style="width: 320px"><?php echo $entry_status; ?></td>
					<td><a class="button" style="float: right" href="<?php echo HTTPS_SERVER . 'index.php?route=report/' . $name . '&token=' . $token; ?>"><span><?php echo $button_view_report; ?></span></a>
						<select name="<?php echo $name; ?>_status">
							<?php $status = (isset(${$name.'_status'})) ? ${$name.'_status'} : 1; ?>
							<option value="1" <?php if ($status) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (!$status) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
				<tr><td><?php echo $entry_testing_mode; ?></td>
					<td><select name="<?php echo $name; ?>_data[testing_mode]">
							<?php $testing_mode = (isset(${$name.'_data'}['testing_mode'])) ? ${$name.'_data'}['testing_mode'] : 0; ?>
							<option value="0" <?php if ($testing_mode == 0) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
							<option value="1" <?php if ($testing_mode == 1) echo 'selected="selected"'; ?>><?php echo $text_enabled_run_as_normal; ?></option>
							<option value="2" <?php if ($testing_mode == 2) echo 'selected="selected"'; ?>><?php echo $text_enabled_assume_no; ?></option>
						</select>
					</td>
				</tr>
				<tr class="settings-header">
					<td colspan="2"><?php echo $entry_fields_searched; ?></td>
				</tr>
				<tr>
					<td colspan="2"><span class="help" style="margin-top: 0"><?php echo $help_fields_searched; ?></span></td>
				</tr>
				<tr>
					<td><?php foreach (array('name', 'description', 'description_misspelled', 'meta_description', 'meta_keyword', 'tag', 'model', 'sku', 'ean', 'jan') as $field) { ?>
							<?php if ($version < 154 && ($field == 'ean' || $field == 'jan')) continue; ?>
							<div class="fields-block">
								<label><input type="checkbox" name="<?php echo $name; ?>_data[<?php echo $field; ?>]" value="1" <?php if (!empty(${$name.'_data'}[$field]) || (empty(${$name.'_data'}) && $field == 'name')) echo 'checked="checked"'; ?> />
								<?php echo ${'text_'.$field}; ?></label>
							</div>
							<input type="text" name="<?php echo $name; ?>_data[relevance][<?php echo $field; ?>]" value="<?php if (!empty(${$name.'_data'}['relevance'][$field])) echo ${$name.'_data'}['relevance'][$field]; ?>" />
							<br />
						<?php } ?>
					</td>
					<td>
						<?php foreach (array('isbn', 'mpn', 'upc', 'location', 'manufacturer', 'attribute_group', 'attribute_name', 'attribute_value', 'option_name', 'option_value') as $field) { ?>
							<?php if ($version < 150 && ($field == 'attribute_group' || $field == 'attribute_name' || $field == 'attribute_value')) continue; ?>
							<?php if ($version < 154 && ($field == 'isbn' || $field == 'mpn')) continue; ?>
							<div class="fields-block">
								<label><input type="checkbox" name="<?php echo $name; ?>_data[<?php echo $field; ?>]" value="1" <?php if (!empty(${$name.'_data'}[$field])) echo 'checked="checked"'; ?> />
								<?php echo ${'text_'.$field}; ?></label>
							</div>
							<input type="text" name="<?php echo $name; ?>_data[relevance][<?php echo $field; ?>]" value="<?php if (!empty(${$name.'_data'}['relevance'][$field])) echo ${$name.'_data'}['relevance'][$field]; ?>" />
							<br />
						<?php } ?>
					</td>
				</tr>
				<tr class="settings-header">
					<td colspan="2"><?php echo $entry_search_options; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_default_sorting; ?></td>
					<td><select name="<?php echo $name; ?>_data[default_sort]">
							<?php $default_sort = (isset(${$name.'_data'}['default_sort'])) ? ${$name.'_data'}['default_sort'] : 'sort_order'; ?>
							<?php foreach(array('date_added', 'date_available', 'date_modified', 'model', 'name', 'price', 'quantity', 'rating', 'sort_order', 'times_purchased', 'times_viewed') as $sort) { ?>
								<option value="<?php echo $sort; ?>" <?php if ($default_sort == $sort) echo 'selected="selected"'; ?>><?php echo ${'text_'.$sort}; ?></option>
							<?php } ?>
						</select>
						<select name="<?php echo $name; ?>_data[default_order]">
							<?php $default_order = (isset(${$name.'_data'}['default_order'])) ? ${$name.'_data'}['default_order'] : 'ASC'; ?>
							<option value="ASC" <?php if ($default_order == 'ASC') echo 'selected="selected"'; ?>><?php echo $text_ascending; ?></option>
							<option value="DESC" <?php if ($default_order == 'DESC') echo 'selected="selected"'; ?>><?php echo $text_descending; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_autorefresh_individual; ?></td>
					<td><select name="<?php echo $name; ?>_data[cache_individual]">
							<?php $cache_individual = (isset(${$name.'_data'}['cache_individual'])) ? ${$name.'_data'}['cache_individual'] : 86400; ?>
							<option value="3600" <?php if ($cache_individual == '3600') echo 'selected="selected"'; ?>><?php echo $text_hourly; ?></option>
							<option value="86400" <?php if ($cache_individual == '86400') echo 'selected="selected"'; ?>><?php echo $text_daily; ?></option>
							<option value="604800" <?php if ($cache_individual == '604800') echo 'selected="selected"'; ?>><?php echo $text_weekly; ?></option>
							<option value="2592000" <?php if ($cache_individual == '2592000') echo 'selected="selected"'; ?>><?php echo $text_monthly; ?></option>
							<option value="31536000" <?php if ($cache_individual == '31536000') echo 'selected="selected"'; ?>><?php echo $text_yearly; ?></option>
							<option value="0" <?php if ($cache_individual == '0') echo 'selected="selected"'; ?>><?php echo $text_dont_use_cache; ?></option>
						</select>
						&nbsp;
						<a id="individual" class="button" onclick="clearCache($(this))"><span><?php echo $button_clear_cache; ?></span></a>
						<img src="view/image/loading.gif" style="display: none" />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_account_for_plurals; ?></td>
					<td><select name="<?php echo $name; ?>_data[plurals]">
							<?php $plurals = (isset(${$name.'_data'}['plurals'])) ? ${$name.'_data'}['plurals'] : 1; ?>
							<option value="1" <?php if ($plurals) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
							<option value="0" <?php if (!$plurals) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_include_partial_word; ?></td>
					<td><select name="<?php echo $name; ?>_data[partials]">
							<?php $partials = (isset(${$name.'_data'}['partials'])) ? ${$name.'_data'}['partials'] : 1; ?>
							<option value="1" <?php if ($partials) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
							<option value="0" <?php if (!$partials) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_minimum_number; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[min_results]" value="<?php echo (isset(${$name.'_data'}['min_results'])) ? ${$name.'_data'}['min_results'] : 1; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_search_in_subcategories; ?></td>
					<td><select name="<?php echo $name; ?>_data[subcategories]">
							<?php $subcategories = (isset(${$name.'_data'}['subcategories'])) ? ${$name.'_data'}['subcategories'] : 1; ?>
							<option value="1" <?php if ($subcategories) echo 'selected="selected"'; ?>><?php echo $text_yes; ?></option>
							<option value="0" <?php if (!$subcategories) echo 'selected="selected"'; ?>><?php echo $text_no; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_index_database_tables . ':' . $help_index_database_tables; ?></td>
					<td><a onclick="indexTables($(this))" class="button"><span><?php echo $entry_index_database_tables; ?></span></a> <img src="view/image/loading.gif" style="display: none" /></td>
				</tr>
				<tr class="settings-header">
					<td colspan="2"><?php echo $entry_misspelling_settings; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_misspelling_tolerance; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[tolerance]" value="<?php echo (isset(${$name.'_data'}['tolerance'])) ? ${$name.'_data'}['tolerance'] : 75; ?>" /> %</td>
				</tr>
				<tr>
					<td><?php echo $entry_autorefresh_misspelling; ?></td>
					<td><select name="<?php echo $name; ?>_data[cache_misspelling]">
							<?php $cache_misspelling = (isset(${$name.'_data'}['cache_misspelling'])) ? ${$name.'_data'}['cache_misspelling'] : 86400; ?>
							<option value="3600" <?php if ($cache_misspelling == '3600') echo 'selected="selected"'; ?>><?php echo $text_hourly; ?></option>
							<option value="86400" <?php if ($cache_misspelling == '86400') echo 'selected="selected"'; ?>><?php echo $text_daily; ?></option>
							<option value="604800" <?php if ($cache_misspelling == '604800') echo 'selected="selected"'; ?>><?php echo $text_weekly; ?></option>
							<option value="2592000" <?php if ($cache_misspelling == '2592000') echo 'selected="selected"'; ?>><?php echo $text_monthly; ?></option>
							<option value="31536000" <?php if ($cache_misspelling == '31536000') echo 'selected="selected"'; ?>><?php echo $text_yearly; ?></option>
							<option value="0" <?php if ($cache_misspelling == '0') echo 'selected="selected"'; ?>><?php echo $text_dont_use_cache; ?></option>
						</select>
						<a id="misspelling" class="button" onclick="clearCache($(this))"><span><?php echo $button_clear_cache; ?></span></a>
						<img src="view/image/loading.gif" style="display: none" />
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_min_word_length; ?></td>
					<td><input type="text" name="<?php echo $name; ?>_data[word_length]" value="<?php echo (isset(${$name.'_data'}['word_length'])) ? ${$name.'_data'}['word_length'] : 3; ?>" /></td>
				</tr>
				<tr class="settings-header">
					<td colspan="2"><?php echo $entry_ajax_search_settings; ?></td>
				</tr>
				<tr>
					<td><?php echo $entry_ajax_search; ?></td>
					<td><select name="<?php echo $name; ?>_data[ajax_search]">
							<?php $ajax_search = (isset(${$name.'_data'}['ajax_search'])) ? ${$name.'_data'}['ajax_search'] : 1; ?>
							<option value="1" <?php if ($ajax_search) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (!$ajax_search) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_selector; ?></td>
					<td><input type="text" style="width: 450px; margin-left: 3px; font-family: monospace" name="<?php echo $name; ?>_data[ajax_selector]" value="<?php echo (isset(${$name.'_data'}['ajax_selector'])) ? ${$name.'_data'}['ajax_selector'] : '#search input'; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_colors; ?></td>
					<td><?php $color_class = "color {required: false, hash: true, pickerPosition: 'bottom', pickerFaceColor: '#444', pickerBorderColor:'#000'}"; ?>
						<div class="ajax-block"><?php echo $text_background; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_background_color]" value="<?php echo (isset(${$name.'_data'}['ajax_background_color'])) ? ${$name.'_data'}['ajax_background_color'] : '#FFFFFF'; ?>" /></div>
						<div class="ajax-block"><?php echo $text_borders; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_borders_color]" value="<?php echo (isset(${$name.'_data'}['ajax_borders_color'])) ? ${$name.'_data'}['ajax_borders_color'] : '#EEEEEE'; ?>" /></div>
						<div class="ajax-block"><?php echo $text_font; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_font_color]" value="<?php echo (isset(${$name.'_data'}['ajax_font_color'])) ? ${$name.'_data'}['ajax_font_color'] : '#000000'; ?>" /></div>
						<div class="ajax-block"><?php echo $text_highlight; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_highlight_color]" value="<?php echo (isset(${$name.'_data'}['ajax_highlight_color'])) ? ${$name.'_data'}['ajax_highlight_color'] : '#EEFFFF'; ?>" /></div>
						<div class="ajax-block"><?php echo $text_price; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_price_color]" value="<?php echo (isset(${$name.'_data'}['ajax_price_color'])) ? ${$name.'_data'}['ajax_price_color'] : '#000000'; ?>" /></div>
						<div class="ajax-block"><?php echo $text_special; ?><br /><input type="text" class="<?php echo $color_class; ?>" name="<?php echo $name; ?>_data[ajax_special_color]" value="<?php echo (isset(${$name.'_data'}['ajax_special_color'])) ? ${$name.'_data'}['ajax_special_color'] : '#FF0000'; ?>" /></div>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_display; ?></td>
					<td><div class="ajax-block"><?php echo $text_delay; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_delay]" value="<?php echo (isset(${$name.'_data'}['ajax_delay'])) ? ${$name.'_data'}['ajax_delay'] : 500; ?>" /></div>
						<div class="ajax-block"><?php echo $text_limit; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_limit]" value="<?php echo (isset(${$name.'_data'}['ajax_limit'])) ? ${$name.'_data'}['ajax_limit'] : 5; ?>" /></div>
						<div class="ajax-block">
							<?php echo $text_price; ?><br />
							<select name="<?php echo $name; ?>_data[ajax_price]">
								<?php $ajax_price = (isset(${$name.'_data'}['ajax_price'])) ? ${$name.'_data'}['ajax_price'] : 1; ?>
								<option value="1" <?php if ($ajax_price) echo 'selected="selected"'; ?>><?php echo $text_show; ?></option>
								<option value="0" <?php if (!$ajax_price) echo 'selected="selected"'; ?>><?php echo $text_hide; ?></option>
							</select>
						</div>
						<div class="ajax-block">
							<?php echo $text_model; ?><br />
							<select name="<?php echo $name; ?>_data[ajax_model]">
								<?php $ajax_model = (isset(${$name.'_data'}['ajax_model'])) ? ${$name.'_data'}['ajax_model'] : 0; ?>
								<option value="1" <?php if ($ajax_model) echo 'selected="selected"'; ?>><?php echo $text_show; ?></option>
								<option value="0" <?php if (!$ajax_model) echo 'selected="selected"'; ?>><?php echo $text_hide; ?></option>
							</select>
						</div>
						<div class="ajax-block"><?php echo $text_description_ajax; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_description]" value="<?php echo (isset(${$name.'_data'}['ajax_description'])) ? ${$name.'_data'}['ajax_description'] : 100; ?>" /></div>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_positioning; ?></td>
					<td><div class="ajax-block"><?php echo $text_top; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_top]" value="<?php echo (!empty(${$name.'_data'}['ajax_top'])) ? ${$name.'_data'}['ajax_top'] : ''; ?>" /></div>
						<div class="ajax-block"><?php echo $text_left; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_left]" value="<?php echo (!empty(${$name.'_data'}['ajax_left'])) ? ${$name.'_data'}['ajax_left'] : ''; ?>" /></div>
						<div class="ajax-block"><?php echo $text_right; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_right]" value="<?php echo (!empty(${$name.'_data'}['ajax_right'])) ? ${$name.'_data'}['ajax_right'] : ''; ?>" /></div>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_sizes; ?></td>
					<td><div class="ajax-block"><?php echo $text_dropdown_width; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_width]" value="<?php echo (!empty(${$name.'_data'}['ajax_width'])) ? ${$name.'_data'}['ajax_width'] : 292; ?>" /></div>
						<div class="ajax-block"><?php echo $text_image_width; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_image_width]" value="<?php echo (!empty(${$name.'_data'}['ajax_image_width'])) ? ${$name.'_data'}['ajax_image_width'] : 50; ?>" /></div>
						<div class="ajax-block"><?php echo $text_image_height; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_image_height]" value="<?php echo (!empty(${$name.'_data'}['ajax_image_height'])) ? ${$name.'_data'}['ajax_image_height'] : 50; ?>" /></div>
						<div class="ajax-block"><?php echo $text_product_font_size; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_product_font]" value="<?php echo (!empty(${$name.'_data'}['ajax_product_font'])) ? ${$name.'_data'}['ajax_product_font'] : 13; ?>" /></div>
						<div class="ajax-block"><?php echo $text_description_font_size; ?><br /><input type="text" name="<?php echo $name; ?>_data[ajax_description_font]" value="<?php echo (!empty(${$name.'_data'}['ajax_description_font'])) ? ${$name.'_data'}['ajax_description_font'] : 11; ?>" /></div>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_text; ?></td>
					<td><table class="sub-table">
						<tr>
							<td></td>
							<td>"<?php echo $text_view_all_results; ?>"</td>
							<td>"<?php echo $text_no_results; ?>"</td>
						</tr>
					<?php foreach ($languages as $language) { ?>
						<?php $lcode = $language['code']; ?>
						<tr>
							<td><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></td>
							<td><input type="text" style="width: 90%" name="<?php echo $name; ?>_data[ajax_viewall][<?php echo $lcode; ?>]" value="<?php echo (isset(${$name.'_data'}['ajax_viewall']) && isset(${$name.'_data'}['ajax_viewall'][$lcode])) ? ${$name.'_data'}['ajax_viewall'][$lcode] : $text_view_all_results; ?>" /></td>
							<td><input type="text" style="width: 90%" name="<?php echo $name; ?>_data[ajax_noresults][<?php echo $lcode; ?>]" value="<?php echo (isset(${$name.'_data'}['ajax_noresults']) && isset(${$name.'_data'}['ajax_noresults'][$lcode])) ? ${$name.'_data'}['ajax_noresults'][$lcode] : $text_no_results; ?>" /></td>
						</tr>
					<?php } ?>
						</table>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_additional_css; ?></td>
					<td><textarea name="<?php echo $name; ?>_data[ajax_css]" style="font-family: monospace; width: 300px; height: 100px"><?php echo (!empty(${$name.'_data'}['ajax_css'])) ? ${$name.'_data'}['ajax_css'] : ''; ?></textarea></td>
				</tr>
				<tr class="settings-header">
					<td colspan="2"><?php echo $entry_pre_search_replacements; ?></td>
				</tr>
				<tr>
					<td colspan="2"><span class="help" style="margin-top: 0"><?php echo $help_pre_search_replacements; ?></span></td>
				</tr>
				<tr>
					<td colspan="2" style="border-bottom: none">
						<table class="list">
						<thead>
							<tr>
								<td class="center"><?php echo $text_replace; ?></td>
								<td class="center"><?php echo $text_with; ?></td>
								<td class="center">&nbsp; &nbsp;</td>
							</tr>
						</thead>
						<?php if (isset(${$name.'_data'}['replace_array'])) { ?>
						<?php for ($i = 0; $i < count(${$name.'_data'}['replace_array']); $i++) { ?>
							<tr>
								<td class="center"><input type="text" name="<?php echo $name; ?>_data[replace_array][]" value="<?php echo ${$name.'_data'}['replace_array'][$i]; ?>" /></td>
								<td class="center"><input type="text" name="<?php echo $name; ?>_data[with_array][]" value="<?php echo ${$name.'_data'}['with_array'][$i]; ?>" /></td>
								<td class="center"><a onclick="$(this).parent().parent().remove()"><img src="view/image/delete.png" title="Delete" /></a></td>
							</tr>
						<?php } ?>
						<?php } ?>
							<tr>
								<td class="left" colspan="3" style="background: none"><a onclick="addRow($(this))"><img src="view/image/add.png" title="Add" /></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<?php echo $copyright; ?>
	</div>
</div>
<?php if ($version < 150) { ?>
	<script type="text/javascript" src="view/javascript/jquery/ui/ui.dialog.js"></script>
<?php } else { ?>
	</div>
<?php } ?>
<script type="text/javascript" src="view/javascript/jscolor/jscolor.js"></script>
<script type="text/javascript" src="view/javascript/jquery/jquery.tabby.min.js"></script>
<script type="text/javascript"><!--
	$('textarea').tabby();

	function saveSettings(exit) {
		$('<div />').dialog({
			title: '<?php echo $text_saving; ?>',
			closeOnEscape: false,
			draggable: false,
			modal: true,
			resizable: false,
			open: function(event, ui) {
				$('.ui-dialog-content').hide();
				$('.ui-dialog-titlebar-close').hide();
			}
		}).dialog('open');

		$.ajax({
			type: 'POST',
			url: 'index.php?route=<?php echo $type; ?>/<?php echo $name; ?>/saveSettings&token=<?php echo $token; ?>',
			data: $('#form input[type="text"], #form input:checked, #form select, #form textarea'),
			success: function(error) {
				if (error) exit = false;
				$('.ui-dialog-titlebar').css(error ? {'background': '#C00', 'border': '1px solid #A00'} : {'background': '#0C0', 'border': '1px solid #0A0'});
				$('.ui-dialog-content').dialog('option', 'title', error ? error : '<?php echo $text_saved; ?>');
				setTimeout(function(){ $('.ui-dialog-content').dialog('close'); if (exit) location = '<?php echo html_entity_decode($exit, ENT_QUOTES, 'UTF-8'); ?>'; }, error ? 2000 : 1000);
			}
		});
	}

	function clearCache(element) {
		if (element.attr('id') == 'individual' && <?php echo $smartsearch_table; ?>) {
			var precache = prompt('<?php echo $text_clear_cache_individual; ?>', '0');
			if (precache == null) return;
		} else {
			var precache = 0;
			if (!confirm('<?php echo $text_clear_cache_misspelling; ?>')) return;
		}

		if (!precache) element.next().show();
		$.ajax({
			url: 'index.php?route=module/smartsearch/clearCache&type=' + element.attr('id') + '&token=<?php echo $token; ?>',
			success: function(message) {
				if (precache > 0) {
					$.ajax({
						url: 'index.php?route=module/smartsearch/getTopSearches&number=' + precache + '&token=<?php echo $token; ?>',
						dataType: 'json',
						success: function(searches) {
							<?php
							$query_string = 'search';
							if ($version < 150) $query_string = 'keyword';
							if ($version < 155) $query_string = 'filter_name';
							?>

							$('<div id="progressbar" />').dialog({
								closeOnEscape: false,
								draggable: false,
								modal: true,
								resizable: false,
								open: function(event, ui) {
									$('.ui-dialog').height(24);
									$('.ui-dialog-titlebar').hide();
								}
							}).dialog('open');

							$('#progressbar').progressbar({
								value: 1,
								create: function(event, ui) {
									for (i = 0; i < searches.length; i++) {
										$.ajax({
											url: '<?php echo HTTP_CATALOG; ?>index.php?route=product/search&<?php echo $query_string; ?>=' + searches[i]['search'],
											success: function(data) {
												$('#progressbar').progressbar('option', 'value', $('#progressbar').progressbar('option', 'value') + (1 / searches.length * 100));
											}
										});
									}
								},
								complete: function(event, ui) {
									alert(message + "\n\n" + precache + '<?php echo $text_searches_cached; ?>');
									$('.ui-dialog-content').dialog('close');
								}
							});
						}
					});
				} else {
					alert(message);
				}
				element.next().hide();
			}
		});
	}

	function indexTables(element) {
		element.next().show();
		$.ajax({
			url: 'index.php?route=module/smartsearch/indexTables&token=<?php echo $token; ?>',
			success: function(data) {
				alert(data.replace(/(<([^>]+)>)/ig,""));
				element.next().hide();
			}
		});
	}

	function addRow(element) {
		element.parent().parent().before('\
			<tr>\
				<td class="center"><input type="text" name="<?php echo $name; ?>_data[replace_array][]" /></td>\
				<td class="center"><input type="text" name="<?php echo $name; ?>_data[with_array][]" /></td>\
				<td class="center"><a onclick="$(this).parent().parent().remove()"><img src="view/image/delete.png" title="Delete" /></a></td>\
			</tr>\
		');
	}
//--></script>
<?php echo $footer; ?>