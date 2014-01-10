<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
<div id="warning-messages"></div>
<div id="success-messages"></div>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  
  <!-- Start -->
  <?php if ($mobile_stylesheet) { ?>
  <link rel="stylesheet" media="screen and (min-width: 701px) and (max-width: 99999px)" href="<?php echo $stylesheet; ?>" />
  <link rel="stylesheet" media="screen and (min-width: 1px) and (max-width: 700px)" href="<?php echo $mobile_stylesheet; ?>" />
  <?php } else { ?>
  <link rel="stylesheet" href="<?php echo $stylesheet; ?>" />
  <?php } ?>
  
  <?php if ($html_header) { ?>
  <?php echo $html_header; ?>
  <?php } ?>
  
  <div id="quickcheckout-countdown"></div>
  
  <div id="quickcheckoutconfirm">
  
  <?php if (!$logged && $this->config->get('quickcheckout_login')) { ?>
  <div class="quickcheckoutmid" id="login-box">
    <div id="checkout">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_option; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
	<div class="or"><?php echo $text_or; ?></div>
  </div>
  <?php } ?>
  <div class="quickcheckoutleft">
    <?php if (!$logged) { ?>
    <div id="payment-address">
	  <div class="quickcheckout-heading"><span><?php echo $text_checkout_account; ?></span></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } else { ?>
    <div id="payment-address">
	  <div class="quickcheckout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } ?>
    <?php if ($shipping_required) { ?>
    <div id="shipping-address">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_shipping_address; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
	<?php } ?>
  </div>
  <div class="quickcheckoutright">
    <?php if ($shipping_required) { ?>
    <div id="shipping-method">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_shipping_method; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } ?>
    <div id="payment-method">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_payment_method; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
  </div>
  
  <?php if ($this->config->get('quickcheckout_layout') == '2') { ?>
  <div style="clear: both;"></div>
  <?php } ?>
  
  <div class="quickcheckoutmid" style="display:none;">
	<div class="quickcheckout-heading"><?php echo $text_checkout_confirm; ?></div>
    <div id="confirm">
      <div class="quickcheckout-content"></div>
    </div>
  </div>
  
  <?php if ($this->config->get('quickcheckout_layout') == '2') { ?>
  <div style="clear: both;"></div>
  <?php } ?>
  
  <?php if ($this->config->get('quickcheckout_voucher') || $this->config->get('quickcheckout_coupon') || $this->config->get('quickcheckout_reward')) { ?>
  <div class="quickcheckoutleft">
    <?php if ($this->config->get('quickcheckout_cart')) { ?>
	<div id="cart1">
	  <div class="quickcheckout-content" style="border:none; padding: 0px;"></div>
	</div>
	<?php } ?>
	<?php if ($this->config->get('quickcheckout_layout') == '3') { ?>
	<div id="voucher">
	  <div class="quickcheckout-content" style="border:none; padding: 0px;overflow: hidden;"></div>
	</div>
    <?php } ?>
  </div>
  <?php if ($this->config->get('quickcheckout_layout') != '3') { ?>
  <div class="quickcheckoutright">
	<div id="voucher">
	  <div class="quickcheckout-content" style="border:none; padding: 0px;overflow: hidden;"></div>
	</div>
  </div>
  <?php } ?>
  <?php } elseif($this->config->get('quickcheckout_cart')) { ?>
  <div class="quickcheckoutmid">
	<div id="cart1">
	  <div class="quickcheckout-content" style="border:none; padding: 0px;"></div>
	</div>
  </div>
  <?php } ?>
  
  <div style="clear: both;"></div>
  
  <div class="quickcheckoutmid">
	<div id="terms">
	  <div class="quickcheckout-content" style="padding:10px; text-align:right;"></div>
	</div>
  </div>
	
  </div>
  
  <?php if ($html_footer) { ?>
  <?php echo $html_footer; ?>
  <?php } ?>
  <!-- End -->
  
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
<?php if ($this->config->get('quickcheckout_countdown') && $countdown_end) { ?>
$('#quickcheckout-countdown').countdown({
	until: new Date('<?php echo $countdown_end; ?>'),
    layout: '<?php echo addslashes($countdown_before); ?><b><?php echo $countdown_timer; ?></b> {desc}', 
    description: '<?php echo addslashes($countdown_after); ?>'
});
<?php } ?>
<?php if ($this->config->get('quickcheckout_load_screen')) { ?>
$(window).load(function() {
    $.blockUI({
	message: '<h1><?php echo $text_please_wait; ?></h1>',
	css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
		'-khtml-border-radius': '10px',
		'border-radius': '10px',
        opacity: .8, 
        color: '#fff' 
    } }); 
 
    setTimeout($.unblockUI, 2000); 
}); 
<?php } ?>

<?php if (!$logged) { ?> 
	<?php if ($this->config->get('quickcheckout_login')) { ?>
	// Login box
	$(document).ready(function() {
		$.ajax({
			url: 'index.php?route=quickcheckout/login',
			dataType: 'html',
			cache: false,
			beforeSend: function() {
				$('#checkout .quickcheckout-content').html('<div class="wait" style="text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
			},	
			success: function(html) {
				$('#checkout .quickcheckout-content').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	});	

	// Login Form Clicked
	$('#button-login').live('click', function() {
		$.ajax({
			url: 'index.php?route=quickcheckout/login/validate',
			type: 'post',
			data: $('#checkout #login :input'),
			dataType: 'json',
			cache: false,
			beforeSend: function() {
				$('#button-login').attr('disabled', true);
				$('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			complete: function() {
				$('#button-login').attr('disabled', false);
				$('.wait').remove();
			},				
			success: function(json) {
				$('.warning, .error').remove();
				
				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
					$('.warning').fadeIn('slow');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	});	
	<?php } ?>

// Validate Register
function validateRegister() {
	$.ajax({
		url: 'index.php?route=quickcheckout/register/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
		dataType: 'json',
		cache: false,		
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},
		success: function(json) {
			$('.warning, .error').remove();
						
			if (json['redirect']) {
				location = json['redirect'];				
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}
				
				<?php if ($this->config->get('quickcheckout_text_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
					}	
					
					if (json['error']['email']) {
						$('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
					}
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
					}	
						
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
					}	
																			
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
					}
					
					if (json['error']['password']) {
						$('#payment-address input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
					}	
					
					if (json['error']['confirm']) {
						$('#payment-address input[name=\'confirm\'] + br').after('<span class="error">' + json['error']['confirm'] + '</span>');
					}	
				<?php } ?>
				<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['email']) {
						$('#payment-address input[name=\'email\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
						
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
																			
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['password']) {
						$('#payment-address input[name=\'password\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['confirm']) {
						$('#payment-address input[name=\'confirm\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
				<?php } ?>
			} else {
				<?php if ($shipping_required) { ?>
					var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
					
					if (shipping_address) {
						validateShippingMethod();
					} else {
						validateGuestShippingAddress();					
					}
				<?php } else {?>
					validatePaymentMethod();
				<?php } ?>
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load Guest Payment Form
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/guest',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#payment-address .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#payment-address .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Validate Guest Payment Address
function validateGuestAddress() {
$.ajax({
		url: 'index.php?route=quickcheckout/guest/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},	
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
					$('.warning').fadeIn('slow');
				}
						
				<?php if ($this->config->get('quickcheckout_text_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
					}	
					
					if (json['error']['email']) {
						$('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
					}
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
					}	
						
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
					}	
																			
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
					}
				<?php } ?>
				<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['email']) {
						$('#payment-address input[name=\'email\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
						
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
																			
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
				<?php } ?>
			} else {
				var create_acc = $('#payment-address input[name=\'create_account\']:checked').attr('value');
				
				<?php if ($shipping_required) { ?>	
					var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
					
					if (create_acc) {
						validateRegister();
					} else {
						if (shipping_address) {
							validateShippingMethod();
						} else {
							validateGuestShippingAddress();					
						}
					}
				<?php } else { ?>
					if (create_acc) {
						validateRegister();
					} else {
						validatePaymentMethod();
					}
				<?php } ?>				
			}	 
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Validate Guest Shipping Address
function validateGuestShippingAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/guest_shipping/validate',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},		
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
					$('.warning').fadeIn('slow');
				}
				
				<?php if ($this->config->get('quickcheckout_text_error')) { ?>
					if (json['error']['firstname']) {
						$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
					}
					
					if (json['error']['lastname']) {
						$('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
					}	
															
					if (json['error']['address_1']) {
						$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
					}	
					
					if (json['error']['city']) {
						$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
					}	
					
					if (json['error']['postcode']) {
						$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
					}	
					
					if (json['error']['country']) {
						$('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
					}	
					
					if (json['error']['zone']) {
						$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
					}
				<?php } ?>
				<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
					if (json['error']['firstname']) {
						$('#shipping-address input[name=\'firstname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['lastname']) {
						$('#shipping-address input[name=\'lastname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['address_1']) {
						$('#shipping-address input[name=\'address_1\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['city']) {
						$('#shipping-address input[name=\'city\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['postcode']) {
						$('#shipping-address input[name=\'postcode\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['country']) {
						$('#shipping-address select[name=\'country_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['zone']) {
						$('#shipping-address select[name=\'zone_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
				<?php } ?>
			} else {
				validateShippingMethod();
			}	 
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Confirm Payment
$('#button-payment-method').live('click', function() {
	validateGuestAddress();	
});
<?php } else { ?>
// Load payment addresses
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_address',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#payment-address .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},
		success: function(html) {
			$('#payment-address .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

<?php if ($shipping_required) { ?>
// Load shipping addresses
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/shipping_address',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#shipping-address .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},
		success: function(html) {
			$('#shipping-address .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});
<?php } ?>

// Validate Payment Address
function validatePaymentAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_address/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},		
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}
							
				<?php if ($this->config->get('quickcheckout_text_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
					}	
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
					}		
					
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
					}	
															
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
					}
				<?php } ?>
				<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
					if (json['error']['firstname']) {
						$('#payment-address input[name=\'firstname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['lastname']) {
						$('#payment-address input[name=\'lastname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['telephone']) {
						$('#payment-address input[name=\'telephone\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
						
					if (json['error']['company_id']) {
						$('#payment-address input[name=\'company_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['tax_id']) {
						$('#payment-address input[name=\'tax_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
																			
					if (json['error']['address_1']) {
						$('#payment-address input[name=\'address_1\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['city']) {
						$('#payment-address input[name=\'city\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['postcode']) {
						$('#payment-address input[name=\'postcode\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['country']) {
						$('#payment-address select[name=\'country_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['zone']) {
						$('#payment-address select[name=\'zone_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
				<?php } ?>
			} else {
				<?php if ($shipping_required) { ?>
					validateShippingAddress();
				<?php } else { ?>
					validatePaymentMethod();
				<?php } ?>	
			}	  
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

<?php if ($shipping_required) { ?>
// Validate Shipping Address
function validateShippingAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/shipping_address/validate',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},		
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}
				
				<?php if ($this->config->get('quickcheckout_text_error')) { ?>
					if (json['error']['firstname']) {
						$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
					}
					
					if (json['error']['lastname']) {
						$('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
					}		
											
					if (json['error']['address_1']) {
						$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
					}	
					
					if (json['error']['city']) {
						$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
					}	
					
					if (json['error']['postcode']) {
						$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
					}	
					
					if (json['error']['country']) {
						$('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
					}	
					
					if (json['error']['zone']) {
						$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
					}
				<?php } ?>
				<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
					if (json['error']['firstname']) {
						$('#shipping-address input[name=\'firstname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
					
					if (json['error']['lastname']) {
						$('#shipping-address input[name=\'lastname\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
																			
					if (json['error']['address_1']) {
						$('#shipping-address input[name=\'address_1\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['city']) {
						$('#shipping-address input[name=\'city\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['postcode']) {
						$('#shipping-address input[name=\'postcode\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['country']) {
						$('#shipping-address select[name=\'country_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}	
					
					if (json['error']['zone']) {
						$('#shipping-address select[name=\'zone_id\']').css('border', '1px solid #f00').css('background', '#F8ACAC');
					}
				<?php } ?>
			} else {
				validateShippingMethod();
			}  
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}
<?php } ?>

// Confirm payment
$('#button-payment-method').live('click', function() {
	validatePaymentAddress();	
});
<?php } ?>

// Payment Method
function reloadPaymentMethod(country_id, zone_id, isset, city, postcode) {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method',
		data: {country_id: country_id, zone_id: zone_id, isset: isset, city: city, postcode: postcode, survey: $('textarea[name=\'survey\'], select[name=\'survey\']').val()},
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#payment-method .quickcheckout-content').html('<div class="wait" style="wdith:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#payment-method .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

function reloadPaymentMethodById(address_id) {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method',
		data: {address_id: address_id, survey: $('textarea[name=\'survey\'], select[name=\'survey\']').val()},
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#payment-method .quickcheckout-content').html('<div class="wait" style="wdith:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#payment-method .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Validate Payment Method
function validatePaymentMethod() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method/validate', 
		type: 'post',
		data: $('#payment-method select, #payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}			
			} else {
				validateTerms();				
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Shipping Method
<?php if ($shipping_required) { ?>
	function reloadShippingMethod(country_id, zone_id, isset, city, postcode) {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method',
			data: {country_id: country_id, zone_id: zone_id, isset: isset, city: city, postcode: postcode, delivery_date: $('input[name=\'delivery_date\']').val(), delivery_time: $('select[name=\'delivery_time\']').val()},
			dataType: 'html',
			cache: false,
			beforeSend: function() {
				$('#shipping-method .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
			},	
			success: function(html) {
				$('#shipping-method .quickcheckout-content').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
	
	function reloadShippingMethodById(address_id) {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method',
			data: {address_id: address_id, delivery_date: $('input[name=\'delivery_date\']').val(), delivery_time: $('select[name=\'delivery_time\']').val()},
			dataType: 'html',
			cache: false,
			beforeSend: function() {
				$('#shipping-method .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
			},	
			success: function(html) {
				$('#shipping-method .quickcheckout-content').html(html);
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
	
	// Validate Shipping Method
	function validateShippingMethod() {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method/validate',
			type: 'post',
			data: $('#shipping-method select, #shipping-method input[type=\'radio\']:checked, #shipping-method textarea, #shipping-method input[type=\'text\']'),
			dataType: 'json',
			cache: false,
			beforeSend: function() {
				$('#button-payment-method').attr('disabled', true);
				$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},
			complete: function() {
				$('#button-payment-method').attr('disabled', false); 
				$('.wait').remove();
			},
			success: function(json) {
				$('.warning, .error').remove();
		
				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) {
					if (json['error']['warning']) {
						$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
						$('html, body').animate({ scrollTop: 0 }, 'slow');
						$('.warning').fadeIn('slow');
					}			
				} else {
					validatePaymentMethod();					
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
<?php } ?>

// Load button
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/terms',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#terms .quickcheckout-content').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#terms .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Validate button
function validateTerms() {
	$.ajax({
		url: 'index.php?route=quickcheckout/terms/validate',
		type: 'post',
		data: $('#terms input[type=\'checkbox\']:checked'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-payment-method').attr('disabled', true);
			$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-payment-method').attr('disabled', false); 
			$('.wait').remove();
		},
		success: function(json) {
			if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}
			} else {
				loadConfirm();
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load confirm
function loadConfirm() {
	$.ajax({
		url: 'index.php?route=quickcheckout/confirm',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			$('#quickcheckoutconfirm').html('<div class="wait" style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			<?php if ($this->config->get('quickcheckout_auto_submit')) { ?>
				$('#quickcheckoutconfirm').css('display', 'none');
				
				$.blockUI({
					message: '<h1><?php echo $text_please_wait; ?></h1>',
					css: { 
						border: 'none', 
						padding: '15px', 
						backgroundColor: '#000000', 
						'-webkit-border-radius': '10px', 
						'-moz-border-radius': '10px', 
						'-khtml-border-radius': '10px',
						'border-radius': '10px',
						opacity: .8, 
						color: '#fff' 
					} 
				}); 
			 
				setTimeout($.unblockUI, 2000); 
			<?php } ?>
			$('#quickcheckoutconfirm').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load cart
<?php if ($this->config->get('quickcheckout_cart')) { ?>
function loadCart() {
	$.ajax({
		url: 'index.php?route=quickcheckout/cart',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#cart1 .quickcheckout-content').html('<div style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#cart1 .quickcheckout-content').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

$(document).ready(function(){
	loadCart();
});
<?php } ?>

// Load Voucher / Coupon / Reward
<?php if ($this->config->get('quickcheckout_voucher') || $this->config->get('quickcheckout_coupon') || $this->config->get('quickcheckout_reward')) { ?>
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/voucher',
		dataType: 'html',
		cache: false,
		beforeSend: function() {
			$('#voucher .quickcheckout-content').html('<div style="text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},	
		success: function(html) {
			$('#voucher .quickcheckout-content').html(html);
				
			$('#voucher .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

$('#coupon-heading').live('click', function() {
    if($('#coupon-content').is(':visible')){
      $('#coupon-content').slideUp('slow');
    } else {
      $('#coupon-content').slideDown('slow');
    };
});

$('#voucher-heading').live('click', function() {
    if($('#voucher-content').is(':visible')){
      $('#voucher-content').slideUp('slow');
    } else {
      $('#voucher-content').slideDown('slow');
    };
});

$('#reward-heading').live('click', function() {
    if($('#reward-content').is(':visible')){
      $('#reward-content').slideUp('slow');
    } else {
      $('#reward-content').slideDown('slow');
    };
});

$('#button-coupon').live('click', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/voucher/validateCoupon',
		type: 'post',
		data: $('#coupon-content :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-coupon').attr('disabled', true);
			$('#button-coupon').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-coupon').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .success').remove();
			
			if (json['success']) {
				$('#success-messages').prepend('<div class="success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.warning').fadeIn('slow');
			}
			
			<?php if ($this->config->get('quickcheckout_cart')) { ?>
				loadCart();
			<?php } ?>
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

$('#button-voucher').live('click', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/voucher/validateVoucher',
		type: 'post',
		data: $('#voucher-content :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-voucher').attr('disabled', true);
			$('#button-voucher').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-voucher').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .success').remove();
			
			if (json['success']) {
				$('#success-messages').prepend('<div class="success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.warning').fadeIn('slow');
			}
			
			<?php if ($this->config->get('quickcheckout_cart')) { ?>
				loadCart();
			<?php } ?>
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

$('#button-reward').live('click', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/voucher/validateReward',
		type: 'post',
		data: $('#reward-content :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#button-reward').attr('disabled', true);
			$('#button-reward').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-reward').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .success').remove();
			
			if (json['success']) {
				$('#success-messages').prepend('<div class="success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.warning').fadeIn('slow');
			}
			
			<?php if ($this->config->get('quickcheckout_cart')) { ?>
				loadCart();
			<?php } ?>
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	
<?php } ?>

<?php if ($shipping_required) { ?>
$('input[name=\'postcode\']').live('focusout', function(){
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		reloadShippingMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
	} else {
		reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());	
	}
});
<?php } ?>

<?php if ($this->config->get('quickcheckout_highlight_error')) { ?>
	$('input').live('keydown', function() {
		$(this).css('background', '').css('border', '');
	});
	$('select').live('change', function() {
		$(this).css('background', '').css('border', '');
	});
<?php } ?>

<?php if ($this->config->get('quickcheckout_edit_cart')) { ?>
$('.button-update').live('click', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/cart/update',
		type: 'post',
		data: $('#cart1 :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#cart1 .quickcheckout-content').html('<div style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},				
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			} else {
				<?php if (!$logged) { ?>
				$('select[name=\'zone_id\']').trigger('change');
				<?php } else { ?>
				$('#shipping-address input[name=\'shipping_address\']:checked').trigger('change');
				$('#payment-address input[name=\'payment_address\']:checked').trigger('change');
				
				<?php if (!$shipping_required) { ?>
				loadCart();
				<?php } ?>
				<?php } ?>
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

$('.button-remove').live('click', function() {
	var remove_id = $(this).attr('href');
	
	$.ajax({
		url: 'index.php?route=quickcheckout/cart/update&remove=' + remove_id,
		type: 'get',
		dataType: 'json',
		cache: false,
		beforeSend: function() {
			$('#cart1 .quickcheckout-content').html('<div style="width:100%;text-align:center;">&nbsp;<img src="catalog/view/theme/default/image/quickcheckout-loading.gif" alt="" /></div>');
		},				
		success: function(json) {
			if (json['redirect']) {
				location = json['redirect'];
			} else {
				<?php if (!$logged) { ?>
				$('select[name=\'zone_id\']').trigger('change');
				<?php } else { ?>
				$('#shipping-address input[name=\'shipping_address\']:checked').trigger('change');
				$('#payment-address input[name=\'payment_address\']:checked').trigger('change');
				<?php } ?>
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
	
	return false;
});		
<?php } ?>

<?php if ($this->config->get('quickcheckout_delivery')) { ?>
$(document).ready(function() {
	<?php if ($this->config->get('quickcheckout_delivery_time') == '1') { ?>
		$(document).on('focus', 'input[name=\'delivery_date\']', function() {
			$(this).datetimepicker({
				dateFormat: 'DD d MM yy',
				minDate: '+<?php echo $this->config->get('quickcheckout_delivery_min'); ?>D',
				maxDate: '+<?php echo $this->config->get('quickcheckout_delivery_max'); ?>D',
				hourMin: <?php echo $this->config->get('quickcheckout_delivery_min_hour'); ?>,
				hourMax: <?php echo $this->config->get('quickcheckout_delivery_max_hour'); ?>,
				beforeShowDay: unavailable
			});
			
			$('.ui-datepicker').css('z-index', '9999');
		});
	<?php } else { ?>
		$(document).on('focus', 'input[name=\'delivery_date\']', function() {
			$(this).datepicker({
				dateFormat: 'DD d MM yy',
				minDate: '+<?php echo $this->config->get('quickcheckout_delivery_min'); ?>D',
				maxDate: '+<?php echo $this->config->get('quickcheckout_delivery_max'); ?>D',
				beforeShowDay: unavailable
			});
			
			$('.ui-datepicker').css('z-index', '9999');
		});
	<?php } ?>
});

function unavailable(date) {
	var unavailableDates = [<?php echo html_entity_decode($this->config->get('quickcheckout_delivery_unavailable')); ?>];

	dmy = date.getDate() + "-" + (date.getMonth()+1) + "-" + date.getFullYear();
	if ($.inArray(dmy, unavailableDates) == -1) {
		return [true, ""];
	} else {
		return [false,"","Not Available"];
	}
}
<?php } ?>
//--></script> 

<?php if ($this->config->get('quickcheckout_delivery_time') == '1') { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<?php } ?>
<?php echo $footer; ?>