<?php if(!$shipping_required){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="permanent-warning" style="display: block;">No shipping required with these product(s).<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                <?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods && $shipping_required) { ?>
<table class="radio">
    <?php foreach ($shipping_methods as $shipping_method) { ?>
    <?php if (!$shipping_method['error']) { ?>
    <?php foreach ($shipping_method['quote'] as $quote) { ?>
    <?php if($settings['step']['shipping_method']['display_title']){ ?>
    <tr>
        <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
    </tr>
    <?php } ?>
    <tr class="highlight">
        <td><?php if ($quote['code'] == $code || !$code) { ?>
            <?php $code = $quote['code']; ?>
            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
            <?php } ?></td>
        <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
        <td style="text-align: right;" class="price"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
        <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
    </tr>
    <?php } ?>
    <?php } ?>
</table>
<br />
<?php } ?>
<script>
$("input[name='shipping_method']").change(function(){    
    $.ajax({
        url: 'index.php?route=supercheckout/shipping_method/validate', 
        type: 'post',
        data: $('#shipping-method input[type=\'radio\']:checked'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-shipping-method').attr('disabled', true);
            $('#button-shipping-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-shipping-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .error').remove();
			
            if (json['redirect']) {
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                    $('.warning').fadeIn('slow');
                }			
            } else {
                $.ajax({
                    url: 'index.php?route=supercheckout/confirm',
                    dataType: 'html',
                    success: function(html) {
                        $('#confirmCheckout').html(html);
                        $('#paymentDisable').html("");
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                $.ajax({
                    url: 'index.php?route=supercheckout/payment_display',
                    dataType: 'html',
                    success: function(html) {
                        $('#display_payment').html(html);
                        validatePaymentMethodRefresh();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });	
									
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});  
</script>
