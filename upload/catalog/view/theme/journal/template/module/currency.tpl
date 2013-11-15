<?php if(isset($this->document->journal_currency_language_icons_style) && $this->document->journal_currency_language_icons_style === 'yes' && count($currencies) > 1): ?>
<form id="currency-form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div id="currency">
    <ul>
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
    <?php if ($currency['symbol_left']) { ?>
    <li data-value="<?php echo $currency['code']; ?>"><a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left']; ?></b></a></li>
    <?php } else { ?>
    <li data-value="<?php echo $currency['code']; ?>"><a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right']; ?></b></a></li>
    <?php } ?>
    <?php } else { ?>
    <?php if ($currency['symbol_left']) { ?>
    <li data-value="<?php echo $currency['code']; ?>"><a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).closest('form').submit();"><?php echo $currency['symbol_left']; ?></a></li>
    <?php } else { ?>
    <li data-value="<?php echo $currency['code']; ?>"><a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).closest('form').submit();"><?php echo $currency['symbol_right']; ?></a></li>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    </ul>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </div>
</form>
<?php else: ?>
<?php if (count($currencies) > 1) { ?>
<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
  <div id="currency">
   <!--  <?php echo $text_currency; ?>
    <br />-->
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
    <?php if ($currency['symbol_left']) { ?>
    <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left']; ?></b></a>
    <?php } else { ?>
    <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right']; ?></b></a>
    <?php } ?>
    <?php } else { ?>
    <?php if ($currency['symbol_left']) { ?>
    <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_left']; ?></a>
    <?php } else { ?>
    <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_right']; ?></a>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </div>
</form>
<?php } ?>
<?php endif; ?>