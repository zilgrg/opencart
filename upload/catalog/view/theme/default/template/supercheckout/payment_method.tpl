<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($payment_methods) { ?>                 
<table class="radio">
    <?php foreach ($payment_methods as $payment_method) { ?>
    <tr class="highlight">
        <td><?php if ($payment_method['code'] == $code || !$code) { ?>
            <?php $code = $payment_method['code']; ?>
            <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"   />
            <?php } ?></td>
        <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
    </tr>
    <?php } ?>
</table>
<br />
<?php } ?>
  
<script>
$("input[name='payment_method']").change(function(){    
    $.ajax({
        url: 'index.php?route=supercheckout/payment_method/validate', 
        type: 'post',
        data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
        dataType: 'json',
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
                    $('#display_payment .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                    $('.warning').fadeIn('slow');
                }			
            } else {
                $.ajax({
                    url: 'index.php?route=supercheckout/payment_display',
                    dataType: 'html',
                    success: function(html) {

                        $('#display_payment').html(html);

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