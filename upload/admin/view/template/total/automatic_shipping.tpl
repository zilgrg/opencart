<?php
//==============================================================================
// Automatic Shipping v155.2
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo $header; ?>
<?php if ($version > 149) { ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<?php } ?>
<?php if ($error_warning) { ?><div class="warning"><?php echo $error_warning; ?></div><?php } ?>
<?php if ($success) { ?><div class="success"><?php echo $success; ?></div><?php } ?>
<div class="box">
	<?php if ($version < 150) { ?><div class="left"></div><div class="right"></div><?php } ?>
	<div class="heading">
		<h1 style="padding: 10px 2px 0"><img src="view/image/<?php echo $type; ?>.png" alt="" style="vertical-align: middle" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').attr('action', location + '&exit=true'); $('#form').submit()" class="button"><span><?php echo $button_save_exit; ?></span></a>
			<a onclick="$('#form').submit()" class="button"><span><?php echo $button_save_keep_editing; ?></span></a>
			<a onclick="location = '<?php echo $exit; ?>'" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
		<form action="" method="post" enctype="multipart/form-data" id="form">
			<table class="form">
				<tr>
					<td colspan="2"><span class="help"><?php echo $text_help; ?></span></td>
				</tr>
				<tr>
					<td style="width: 220px"><?php echo $entry_status; ?></td>
					<td><select name="<?php echo $name; ?>_status">
							<option value="1" <?php if (!empty(${$name.'_status'})) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (empty(${$name.'_status'})) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
				<tr>
					<td><?php echo $entry_sort_order; ?></td>
					<td><input type="text" size="1" name="<?php echo $name; ?>_sort_order" value="<?php echo (!empty(${$name.'_sort_order'})) ? ${$name.'_sort_order'} : 4; ?>" /></td>
				</tr>
				<tr>
					<td><?php echo $entry_shipping_methods; ?></td>
					<td><?php foreach ($shipping_methods as $code => $method) { ?>
							<label>
								<input type="checkbox" name="<?php echo $name; ?>_shipping_methods[]" value="<?php echo $code; ?>" <?php if (!empty(${$name.'_shipping_methods'}) && in_array($code, ${$name.'_shipping_methods'})) echo 'checked="checked"'; ?> />
								<?php echo $method; ?><br />
							</label>
						<?php } ?>
					</td>
				</tr>
			</table>
		</form>
		<?php echo $copyright; ?>
	</div>
</div>
<?php if ($version > 149) { ?>
	</div>
<?php } ?>
<?php echo $footer; ?>