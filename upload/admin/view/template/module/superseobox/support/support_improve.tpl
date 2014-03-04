<h3>Improving our module with your help</h3>

<div class="idea pull-left" style="margin-right: 12px;"></div>
<h4>
We are continually working to improve the module we provide to our clients. We ask our clients what they think of the module we provide and how we can improve it through clients satisfaction surveys and independent customer research.
</h4>

<table id="support-idea" class="form">
		<input type="hidden" name="type" value="IMPROVE" />
		<tr>
			<td colspan="2">Do you have idea to improve our module? Fill up the form below (English only).</td>
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
			<td>Idea:<br><span class="help">What would you like to tell us?<br></span></td>
			<td><textarea name="mail_message" style="width:300px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<a data-afterAction="afterSupport" data-action="newSupport" data-scope=".closest('.form').find('textarea, input')" class="btn ajax_action btn-success" type="button">Send Idea</a>
			</td>
		</tr>
	</table>