<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>
<?php 
$exists = false;
foreach ($payment_methods as $payment_method) {
	if ($payment_method['code'] == $code) {
		$exists = true;
		break;
	}
}
?>
<p><?php echo $text_payment_method; ?></p>
<?php if ($this->config->get('quickcheckout_payment')) { ?>
<table class="radio">
  <?php foreach ($payment_methods as $payment_method) { ?>
  <tr class="highlight">
    <td><?php if ($payment_method['code'] == $code || !$code || !$exists) { ?>
      <?php $code = $payment_method['code']; ?>
	  <?php $exists = true; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
	<?php if (($this->config->get('quickcheckout_payment_logo')) && (file_exists(DIR_APPLICATION . 'view/theme/default/image/payment/' . $payment_method['code'] . '.png') || is_file(DIR_APPLICATION . 'view/theme/default/image/payment/' . $payment_method['code'] . '.png'))) { ?>
	<td><img src="<?php echo HTTPS_SERVER . 'catalog/view/theme/default/image/payment/' . $payment_method['code'] . '.png'; ?>" alt="<?php echo $payment_method['title']; ?>" /></td>
	<?php } else { ?>
	<td></td>
	<?php } ?>
  </tr>
  <?php } ?>
</table>
<?php } else { ?>
  <select name="payment_method">
  <?php foreach ($payment_methods as $payment_method) { ?>
	<?php if ($payment_method['code'] == $code || !$code || !$exists) { ?>
      <?php $code = $payment_method['code']; ?>
	  <?php $exists = true; ?>
      <option value="<?php echo $payment_method['code']; ?>" selected="selected">
      <?php } else { ?>
      <option value="<?php echo $payment_method['code']; ?>">
      <?php } ?>
    <?php echo $payment_method['title']; ?></option>
  <?php } ?>
  </select><br />
<?php } ?>
<br />
<?php } ?>
<?php if ($this->config->get('quickcheckout_survey')) { ?>
<strong><?php if ($this->config->get('quickcheckout_survey_required')) { ?><span class="required">*</span> <?php } ?><?php echo $text_survey; ?></strong><br />
  <?php if ($this->config->get('quickcheckout_survey_type')) { ?>
  <select name="survey" style="width:98%;"><?php foreach ($this->config->get('quickcheckout_survey_answers') as $survey_answer) { ?>
    <?php if (!empty($survey_answer[$this->config->get('config_language_id')])) { ?>
	  <?php if ($survey == $survey_answer[$this->config->get('config_language_id')]) { ?>
      <option value="<?php echo $survey_answer[$this->config->get('config_language_id')]; ?>" selected="selected"><?php echo $survey_answer[$this->config->get('config_language_id')]; ?></option>
      <?php } else { ?>
	  <option value="<?php echo $survey_answer[$this->config->get('config_language_id')]; ?>"><?php echo $survey_answer[$this->config->get('config_language_id')]; ?></option>
      <?php } ?>
	<?php } ?>
  <?php } ?></select><br /><br />
  <?php } else { ?>
  <textarea name="survey" style="width: 98%;" rows="1"><?php echo $survey; ?></textarea><br /><br />
  <?php } ?>
<?php } else { ?>
<textarea name="survey" style="display:none;"><?php echo $survey; ?></textarea>
<?php } ?>
<b><?php echo $text_comments; ?></b>
<textarea name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>

<script type="text/javascript"><!--
	$('#payment-method input[name=\'payment_method\'], #payment-method select[name=\'payment_method\']').bind('change', function() {
		<?php if (!$this->customer->isLogged()) { ?>
			var country_id = $('#payment-address select[name=\'country_id\']').val();
			var zone_id = $('#payment-address select[name=\'zone_id\']').val();
			var city = $('#payment-address input[name=\'city\']').val();
			var postcode = $('#payment-address input[name=\'postcode\']').val();
			var survey = encodeURIComponent($('textarea[name=\'survey\'], select[name=\'survey\']').val());
			
			<?php if ($this->config->get('quickcheckout_payment')) { ?>
				var payment_method = $('#payment-method input[type=\'radio\']:checked').val();
			<?php } else { ?>
				var payment_method = $('#payment-method select').val();
			<?php } ?>
			
			$.ajax({
				url: 'index.php?route=quickcheckout/payment_method/set&isset=1&country_id=' + country_id + '&zone_id=' + zone_id + '&city=' + city + '&postcode=' + postcode + '&payment_method=' + payment_method + '&survey=' + survey,
				dataType: 'html',
				cache: false,
				success: function(html) {
					<?php if ($this->config->get('quickcheckout_cart') && $this->config->get('quickcheckout_payment_reload')) { ?>
						loadCart();	
					<?php } ?>
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});	
		<?php } else { ?>
			if ($('#payment-address-new:checked').attr('value')) {
				var country_id = $('#payment-address select[name=\'country_id\']').val();
				var zone_id = $('#payment-address select[name=\'zone_id\']').val();
				var city = $('#payment-address input[name=\'city\']').val();
				var postcode = $('#payment-address input[name=\'postcode\']').val();
				var survey = encodeURIComponent($('textarea[name=\'survey\'], select[name=\'survey\']').val());
				var address_id = '';
				var isset = 0;
			} else {
				var country_id = '';
				var zone_id = '';
				var city = '';
				var postcode = '';
				var survey = encodeURIComponent($('textarea[name=\'survey\'], select[name=\'survey\']').val());
				var address_id = $('#payment-existing select').val();
				var isset = 1;
			}
			
			<?php if ($this->config->get('quickcheckout_payment')) { ?>
				var payment_method = $('#payment-method input[type=\'radio\']:checked').val();
			<?php } else { ?>
				var payment_method = $('#payment-method select').val();
			<?php } ?>
			
			$.ajax({
				url: 'index.php?route=quickcheckout/payment_method/set&address_id=' + address_id + '&isset=' + isset + '&country_id=' + country_id + '&zone_id=' + zone_id + '&city=' + city + '&postcode=' + postcode + '&payment_method=' + payment_method + '&survey=' + survey,
				dataType: 'html',
				cache: false,
				success: function(html) {
					<?php if ($this->config->get('quickcheckout_cart') && $this->config->get('quickcheckout_payment_reload')) { ?>
						loadCart();	
					<?php } ?>
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});	
		<?php } ?>
	});
	
	<?php if ($this->config->get('quickcheckout_payment_reload')) { ?>
		$(document).ready(function() {
			$('#payment-method input[name=\'payment_method\']:checked, #payment-method select[name=\'payment_method\']').trigger('change');
		});
	<?php } ?>
//--></script> 