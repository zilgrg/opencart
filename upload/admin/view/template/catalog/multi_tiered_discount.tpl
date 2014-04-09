<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<div class="box">
		<div class="heading">
			<h1><img src="view/image/setting.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="form">
					<tr>
						<td><span class="required">* </span><?php echo $entry_customer_group; ?></td>
						<td>
							<select name="customer_group_id">
								<option value="" selected="selected"><?php echo $text_select; ?></option>
								<?php if (!empty($customer_groups)) { ?>
									<?php foreach ($customer_groups as $customer_group) { ?>
										<option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
									<?php } ?>
								<?php } ?>
							</select>
							<?php if ($error_customer_group) { ?>
								<br /><span class="error"><?php echo $error_customer_group; ?></span>
							<?php } ?>
						</td>
					</tr>
					<tr>
						<td><span class="required">* </span><?php echo $entry_discount_code; ?></td>
						<td>
							<input style="text-align: center;" type="text" name="discount_code" value="" size="2" maxlength="2" />
							<?php if ($error_discount_code) { ?>
								<br /><span class="error"><?php echo $error_discount_code; ?></span>
							<?php } ?>
						</td>
					</tr>
					<tr>
						<td><span class="required">* </span><?php echo $entry_discount_amount; ?></td>
						<td>
							<input style="margin-right: 8px; text-align: center;" type="text" name="discount_amount" value="" size="5" />
							<select name="discount_type">
								<option value="percent" selected="selected"><?php echo $text_percent; ?></option>
								<option value="amount"><?php echo $text_amount; ?></option>
							</select>
							<?php if ($error_discount_amount) { ?>
								<br /><span class="error"><?php echo $error_discount_amount; ?></span>
							<?php } ?>
						</td>
					</tr>
					<tr>
						<td><span class="required">* </span><?php echo $entry_status; ?></td>
						<td>
							<select name="status">
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							</select>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_override_special; ?></td>
						<td><input type="checkbox" name="override_special" value="1" /></td>
					</tr>
				</table>
			</form>
			<table class="list">
				<thead>
					<tr>
						<td class="center"><?php echo $column_discount_code; ?></td>
						<td class="center"><?php echo $column_customer_group; ?></td>
						<td class="center"><?php echo $column_discount_amount; ?></td>
						<td class="center"><?php echo $column_override_special; ?></td>
						<td class="center"><?php echo $column_status; ?></td>
						<td class="center"><?php echo $column_action; ?></td>
					</tr>
				</thead>
				<tbody>
					<?php if (!empty($discounts)) { ?>
						<?php foreach ($discounts as $discount) { ?>
							<tr>
								<td class="center"><?php echo $discount['discount_code']; ?></td>
								<td class="center"><?php echo $discount['customer_group']; ?></td>
								<td class="center">
									<span id="span-<?php echo $discount['multi_tier_id']; ?>" class="required" style="margin-right: 15px;"><?php echo $discount['formated_amount']; ?></span>
									<input style="margin-right: 8px; text-align: center;" class="input_box" type="text" title="<?php echo $discount['multi_tier_id']; ?>" id="discount_amount-<?php echo $discount['multi_tier_id']; ?>" value="<?php echo $discount['discount_amount']; ?>" size="5" />
									<select id="discount_type-<?php echo $discount['multi_tier_id']; ?>" class="input_box2" title="<?php echo $discount['multi_tier_id']; ?>">
										<?php if ($discount['discount_type'] == "percent") { ?>
											<option value="percent" selected="selected"><?php echo $text_percent; ?></option>
											<option value="amount"><?php echo $text_amount; ?></option>
										<?php } else { ?>
											<option value="percent"><?php echo $text_percent; ?></option>
											<option value="amount" selected="selected"><?php echo $text_amount; ?></option>
										<?php } ?>
									</select>
								</td>
								<td class="center">
									<?php if ($discount['override_special']) { ?>
										<input id="override_special-<?php echo $discount['multi_tier_id']; ?>" class="override_special" type="checkbox" title="<?php echo $discount['multi_tier_id']; ?>" value="1" checked="checked" />
									<?php } else { ?>
										<input id="override_special-<?php echo $discount['multi_tier_id']; ?>" class="override_special" type="checkbox" title="<?php echo $discount['multi_tier_id']; ?>" value="1" />
									<?php } ?>
								</td>
								<td class="center">
									<select class="status" title="<?php echo $discount['multi_tier_id']; ?>" id="status-<?php echo $discount['multi_tier_id']; ?>">
										<?php if ($discount['status'] == 1) { ?>
											<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
											<option value="0"><?php echo $text_disabled; ?></option>
										<?php } else { ?>
											<option value="1"><?php echo $text_enabled; ?></option>
											<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
										<?php } ?>
									</select>
								</td>
								<td class="center">
									<a class="button" href="<?php echo $discount['delete_href']; ?>"><?php echo $button_delete; ?></a>
								</td>
							</tr>
						<?php } ?>
					<?php } else { ?>
						<tr>
							<td class="center" colspan="6"><?php echo $text_no_results; ?></td>
						</tr>
					<?php } ?>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script type="text/javascript"><!--

	$(document).ready(function() {
	
		$('input[name=\'discount_code\']').on('keyup', function() {
			$('input[name=\'discount_code\']').val($('input[name=\'discount_code\']').val().toUpperCase());
		});
		
		$('input[name=\'discount_code\']').on('focus', function() {
			$('input[name=\'discount_code\']').select();
		});
		
		$('input[name=\'discount_amount\']').on('focus', function() {
			$('input[name=\'discount_amount\']').select();
		});
		
		$('.input_box').on('focus', function() {
			$(this).select();
		});

		$('.input_box').on('input', function() {
			var row = $(this).attr('title');
			if ($('#discount_amount-' + row).val() > 100) {
				$('#discount_amount-' + row).val('100');
			}
			$.ajax({
				url: 'index.php?route=catalog/multi_tiered_discount/updateDiscountAmount&token=<?php echo $token; ?>',
				type: 'POST',
				dataType: 'json',
				data: 'multi_tier_id=' + row + '&amount=' + $('#discount_amount-' + row).val(),
				success: function(json) {
					$('#span-' + row).html(json.html);
					$('#discount_amount-' + row).val(json.value);
				},
				error: function(xhr,j,i) {
					alert(i);
				}
			});
		});

		$('.input_box2').on('change', function() {
			var row = $(this).attr('title');
			$.ajax({
				url: 'index.php?route=catalog/multi_tiered_discount/updateDiscountType&token=<?php echo $token; ?>',
				type: 'POST',
				dataType: 'json',
				data: 'multi_tier_id=' + row + '&type=' + $('#discount_type-' + row).val(),
				success: function(json) {
					$('#span-' + row).html(json.html);
				},
				error: function(xhr,j,i) {
					alert(i);
				}
			});
		});

		$('.override_special').on('click', function() {
			var row = $(this).attr('title');
			var override_special = 0;
			if ($('#override_special-' + row).attr('checked')) {
				override_special = 1;
			}
			$.ajax({
				url: 'index.php?route=catalog/multi_tiered_discount/updateOverrideSpecial&token=<?php echo $token; ?>',
				type: 'POST',
				dataType: 'json',
				data: 'multi_tier_id=' + row + '&override_special=' + override_special,
				error: function(xhr,j,i) {
					alert(i);
				}
			});
		});

		$('.status').on('change', function() {
			var row = $(this).attr('title');
			$.ajax({
				url: 'index.php?route=catalog/multi_tiered_discount/updateStatus&token=<?php echo $token; ?>',
				type: 'POST',
				dataType: 'json',
				data: 'multi_tier_id=' + row + '&status=' + $('#status-' + row).val(),
				error: function(xhr,j,i) {
					alert(i);
				}
			});
		});

	});

//--></script>

<?php echo $footer; ?>
