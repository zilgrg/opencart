<?php if ($this->config->get('quickcheckout_coupon')) { ?>
<div id="coupon-heading"><?php echo $entry_coupon; ?></div>
<div id="coupon-content">
<input type="text" name="coupon" value="" /><br />
<a id="button-coupon" class="button"><span><?php echo $text_use_coupon; ?></span></a>
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_voucher')) { ?>
<div id="voucher-heading"><?php echo $entry_voucher; ?></div>
<div id="voucher-content">
<input type="text" name="voucher" value="" /><br />
<a id="button-voucher" class="button"><span><?php echo $text_use_voucher; ?></span></a>
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_reward') && $reward) { ?>
<div id="reward-heading"><?php echo $entry_reward; ?></div>
<div id="reward-content">
<input type="text" name="reward" value="" /><br />
<a id="button-reward" class="button"><span><?php echo $text_use_reward; ?></span></a>
</div>
<?php } ?>