<?php if (!isset($is_j2_popup)): ?>
<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="contact-page"><h1 class="heading-title"><?php echo $heading_title; ?></h1><?php echo $content_top; ?>
<?php endif; ?>

  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <?php if (isset($product_id) && $product_id): ?>
    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
    <?php endif; ?>
    <?php if (!isset($is_j2_popup)): ?>
    <h2 class="secondary-title"><?php echo $text_location; ?></h2>
    <div class="contact-info">
      <div class="content"><div class="left"><b><?php echo $text_address; ?></b><br />
        <?php echo $store; ?><br />
        <?php echo $address; ?></div>
      <div class="right">
        <?php if ($telephone) { ?>
        <b><?php echo $text_telephone; ?></b><br />
        <?php echo $telephone; ?><br />
        <br />
        <?php } ?>
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
      </div>
    </div>
    </div>
    <h2 class="secondary-title"><?php echo $text_contact; ?></h2>
    <?php endif; ?>
    <div class="content">
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="<?php echo $name; ?>" />
    <br />
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_email; ?></b><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
    <br />
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_enquiry; ?></b><br />
    <textarea name="enquiry" cols="40" rows="10"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
    <br />
    <img src="index.php?route=information/contact/captcha" alt="" />
    <?php if ($error_captcha) { ?>
    <span class="error"><?php echo $error_captcha; ?></span>
    <?php } ?>
    </div>
    <?php if (!isset($is_j2_popup)): ?>
    <div class="buttons">
        <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
    </div>
    <?php endif; ?>
  </form>
<?php if (!isset($is_j2_popup)): ?>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
<?php endif; ?>