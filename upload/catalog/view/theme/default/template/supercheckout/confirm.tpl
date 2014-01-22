<script type="text/javascript" src="catalog/view/javascript/supercheckout/common.js"></script>
<script type="text/javascript" src="catalog/view/javascript/supercheckout/bootstrap.js"></script>
<script>
var a= $('#supercheckout-columnleft').height();
$('#columnleft-1').css('min-height', a+'px');
$('#columnleft-3').css('min-height', a+'px');
//$('#columnleft-1').height(a);
</script>
<div class="checkout-content">
</div>
<?php if (!isset($redirect)) { ?>

<table class="supercheckout-summary">
    <thead>
        <tr>
            <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name"><?php echo $column_name; ?></th>
            <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_model; ?></th>
            <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_quantity; ?></th>
            <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total" style="text-align:center;"><?php echo $column_price; ?></th>
            <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $column_total; ?></th>
            <th class="supercheckout-qty"><?php echo "Action"; ?></th>

        </tr>
    </thead>
    <tbody>
        <?php foreach ($products as $product) { ?>
        <tr>
            <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name">
                <div ><a <?php if($logged){ if($settings['option']['logged']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';} }else{ if($settings['option']['guest']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';}} ?> data-title="<?php echo $product['name']; ?>" data-content="<img src='<?php echo $product['thumb']; ?>' />" data-placement="left" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <?php foreach ($product['option'] as $option) { ?>
                    <br />
                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                    <?php } ?></div></td>         
                    <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $product['model']; ?></td>
            <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty">
                <input class="quantitybox" type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" ><br>
                <a href="javascript://" id="<?php echo $product['key']; ?>" onclick="updateQuantity(this.id);" ><small><?php echo "Update" ?></small></a>    
            </td>

            </td>
            <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['price']; ?></td>
            <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['total']; ?></td>
            <td class="supercheckout-qty"><a href="javascript://" id="<?php echo $product['key']; ?>" onclick="removeProduct(this.id);" class="removeProduct"><div id="<?php echo $product['key']; ?>"  title="Delete"></div></a></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
            <td class="supercheckout-name"><?php echo $voucher['description']; ?></td>
            <td class="supercheckout-qty">1</td>
            <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
            <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
        </tr>
        <?php } ?>
    </tbody>                    
</table>
<table class="supercheckout-totals">
    <tbody>
        <?php foreach ($totals as $total) { ?>
        <tr>
            <td class="title"><b><?php echo $total['title']; if($total['code']=='voucher' || $total['code']=='coupon'){echo'<a href="javascript://" id="'.$total['code'].'"  onclick="redeem(this.id);" ><div title="Redeem" class="removeProduct"></div></a></td>';} ?></b></td>
            <td class="value"><span class="price"><?php echo $total['text']; ?></span> </td>
        </tr>
        <?php } ?>
        <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';}} ?>;">
            <td class="title"><b>Coupon code:</b></td>
            <td class="value"><input  id="coupon_code" name="coupon" type="text" class="voucherText">
                <input type="hidden" value="coupon" name="next">
                <input id="button-coupon" type="button" class="buttonVoucher" onclick="callCoupon();">
            </td>
        </tr>
        <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';}} ?>;">
            <td class="title"><b>Voucher code:</b></td>
            <td class="value"><input  id="voucher_code" name="voucher" type="text" class="voucherText">
                <input type="hidden" value="voucher" name="next">
                <input id="button-voucher" type="button" class="buttonVoucher" onclick="callVoucher();">
            </td>
        </tr>
        </tr>
    </tbody>

</table>     
            <script>
var a= $('#supercheckout-columnleft').height();
var b= $('#column-1-inside').height();
var c= $('#column-2-inside').height();
$('#columnleft-1').css('min-height', a+'px');
$('#columnleft-3').css('min-height', a+'px');
if(c>b){
    $('#column-1-inside').css('min-height', c+'px');
}else{
    $('#column-2-inside').css('min-height', b+'px');
}
//$('#columnleft-1').height(a);
</script>
<?php } else { ?>
<script type="text/javascript"><!--
    location = '<?php echo $redirect; ?>';
    //--></script> 
<?php } ?>
</form>
