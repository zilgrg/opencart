<div id="support">
	<table class="form">
		<input type="hidden" name="type" value="SUPPORT" />
		<tr>
			<td colspan="2"><div class="icon-support pull-left" style="margin-right: 12px;"></div><h3>Need support? Fill up the form below to email us (English only).</h3></td>
		</tr>
		<tr>
			<td>Your Name:<br><span class="help">How do we address you?</span></td>
			<td><input type="text" name="mail_name" value="<?php echo $clientData['name']; ?>" /></td>
		</tr>
		<tr>
			<td>Email Address:<br><span class="help">Which email do you want us to reply to?</span></td>
			<td><input type="text" name="mail_email" value="<?php echo $clientData['e_mail']; ?>" /></td>
		</tr>
		<tr>
			<td>Order ID:<br><span class="help">Your Order ID when you purchased this extension.</span></td>
			<td><input type="text" name="mail_order_id" value="<?php echo $clientData['id_order']; ?>" /></td>
		</tr>
		<tr>
			<td>Message:<br><span class="help">What would you like to tell us?<br>Please attached store URL, store admin login, and FTP login if you require theme integration support.</span></td>
			<td><textarea name="mail_message" style="width:300px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<a class="btn" target="_blank" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=14855">
					<span>Rate <?php echo $module_name ?></span>
				</a>
				<a class="btn" href="https://www.opencart.com/index.php?route=extension/purchase&extension_id=14855" target="_blank">
				<span>Purchase <?php echo $module_name ?></span>
				</a>
				<a data-afterAction="afterSupport" data-action="newSupport" data-scope=".closest('.form').find('textarea, input')" class="btn ajax_action btn-success" type="button">Contact Support</a>
			</td>
		</tr>
	</table>
</div>