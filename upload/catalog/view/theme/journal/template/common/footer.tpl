<?php
  require_once DIR_TEMPLATE . '/journal/template/common/Mobile_Detect.php' ;
  $detect = new Mobile_Detect();
?>
</div>
<footer>
<!-- Smaller Grid - 5 Products per row -->
<?php if (isset($this->document->journal_smaller_product_grid) && $this->document->journal_smaller_product_grid === 'yes'
       && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'
       && isset($this->document->journal_extended_filter) && $this->document->journal_extended_filter === 'no'): ?>
      <link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/smaller.css" />
<?php endif; ?>
<?php if (isset($this->document->journal_smaller_product_grid) && $this->document->journal_smaller_product_grid === 'yes'
       && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'
       && isset($this->document->journal_extended_filter) && $this->document->journal_extended_filter === 'no'): ?>

      <link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/smaller_wide.css" />
<?php endif; ?>
<?php if (isset($this->document->journal_smaller_product_grid) && $this->document->journal_smaller_product_grid === 'yes'
       && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'
       && isset($this->document->journal_extended_filter) && $this->document->journal_extended_filter === 'yes'): ?>

      <link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/smaller_extended.css" />
<?php endif; ?>
<?php if (isset($this->document->journal_smaller_product_grid) && $this->document->journal_smaller_product_grid === 'yes'
       && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'
       && isset($this->document->journal_extended_filter) && $this->document->journal_extended_filter === 'yes'): ?>

      <link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/smaller_wide_extended.css" />
<?php endif; ?>
<!-- End - Smaller Grid - 5 Products per row -->
<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
<script>$(document).ready(function(){$('html').addClass('wide-layout');}); </script>
<?php endif; ?>

<div id="footer">
<div class="top-row">

  <?php if ($informations) { ?>
  <div class="column">
    <h3><?php echo $text_information; ?></h3>
    <ul>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
  <?php } ?>

  <div class="column">
    <h3><?php echo $text_service; ?></h3>
    <ul>
      <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
    </ul>
  </div>


<div class="column">
    <h3><?php echo $text_extra; ?></h3>
    <ul>
      <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
      <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
      <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
    </ul>
  </div>


  <div class="column">
    <h3><?php echo $text_account; ?></h3>
    <ul>
      <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>

<?php if (isset($this->document->journal_facebook_likebox)) : // facebook likebox // ?>
    <div class="column fb-box">
      <h3>Facebook</h3>
      <div class="fb">
          <iframe src="//www.facebook.com/plugins/likebox.php?href=<?php echo urlencode($this->document->journal_facebook_likebox);?>&amp;width=292&amp;height=185&amp;show_faces=true&amp;colorscheme=light&amp;stream=false&amp;border_color&amp;header=false&amp;appId=117935585037426" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:292px; height:185px;" allowTransparency="true"></iframe>
      </div>
    </div>
<?php endif; // end facebook like box // ?>
</div>



<?php $connect_visible = false; $contact_profile = false; ?>
<div class="connect">
  <section class="contact-methods">
    <?php if (isset($this->document->journal_contact_methods) && count($this->document->journal_contact_methods) > 0): $connect_visible = true; ?>
    <?php foreach ($this->document->journal_contact_methods as $contact_method): ?>
    <?php $contact_text = $contact_method['href'] ? '<a href="' . $contact_method['href'] . '" ' . ( $contact_method['new_window'] ? 'target="_blank"' : '' ). '>' . $contact_method['name'] . '</a>' : $contact_method['name']; ?>
    <div class="contact-method"><?php if ($contact_method['img']): ?><span class="contact-img" style="background-image: url('<?php echo $contact_method['img'];?>')"></span><?php endif; ?><?php echo $contact_text;?></div>
    <?php endforeach; ?>
    <?php else: ?>
    <style type="text/css">
      .connect .contact-profiles{ float:none; }
    </style>
    <?php endif; ?>
  </section>

  <section class="contact-profiles">
    <?php if (isset($this->document->journal_social_icons)) { foreach ($this->document->journal_social_icons as $img): $contact_profile = true; ?>
      <?php
        $href = $img['href'];
        $target = $img['new_window'] ? 'target="_blank"' : '' ;
      ?>
      <a href="<?php echo $href; ?>" <?php echo $target; ?> style="background-image: url('<?php echo $img['img']; ?>');"></a>
    <?php endforeach; }?>
  </section>
</div>

<?php if ($contact_profile === false): ?>
  <style type="text/css">
  .connect section {
    float: none;
  }
  section.contact-profiles {
    display: none !important;
  }
  </style>
<?php endif; ?>

<?php if ($connect_visible === false && $contact_profile === false): ?>
  <style type="text/css">
  .connect {
    display: none;
  }
  </style>
<?php endif; ?>

<?php if (isset($this->document->journal_custom_footer_text)): // custom text // ?>
<div class="custom-text">
<?php echo html_entity_decode($this->document->journal_custom_footer_text, ENT_QUOTES, 'UTF-8'); ?>
</div>
<?php endif; // custom text // ?>

</div>

<?php if (!isset($this->document->journal_payment_images) || count($this->document->journal_payment_images) === 0): ?>
  <style type="text/css">
  #powered p {
    float: none;
  }
  </style>
<?php endif; ?>

<div id="powered">
  <div>
    <?php if (isset($this->document->journal_copyright)): ?>
    <?php echo html_entity_decode($this->document->journal_copyright, ENT_QUOTES, 'UTF-8'); ?>
    <?php else: ?>
    <style type="text/css">
    #powered div img {
      float: none;
    }
    </style>
    <?php endif; ?>

    <?php if (isset($this->document->journal_payment_images)) { foreach ($this->document->journal_payment_images as $img): ?>
      <?php if ($img['href']): ?>
      <?php $target = $img['new_window'] ? 'target="_blank"' : '' ; ?>
        <a href="<?php echo $img['href']; ?>" <?php echo $target; ?>><img src="<?php echo $img['img']; ?>" alt="<?php echo $img['name']; ?>" title="<?php echo $img['name']; ?>" /></a>
      <?php else: ?>
      <img src="<?php echo $img['img']; ?>" alt="<?php echo $img['name']; ?>" title="<?php echo $img['name']; ?>" />
      <?php endif; ?>
    <?php endforeach; }?>

  </div>
</div>
</footer>
<!-- Back to Top -->
<?php
  if (isset($this->document->journal_scroll_top_img_options)) {
    if ($this->document->journal_scroll_top_img_options == 'left') {
      echo '<img src="image/' . $this->document->journal_scroll_top_image . '" class="back-top" style="left:20px;" alt="Back to Top" />';
    }
    if ($this->document->journal_scroll_top_img_options == 'right') {
      echo '<img src="image/' . $this->document->journal_scroll_top_image . '" class="back-top" alt="Back to Top" />';
    }
  }
?>


<?php if (isset($this->document->journal_standard_modules_carousel) && $this->document->journal_standard_modules_carousel === 'yes'): ?>
<script type="text/javascript">
  $(window).load(function() {
    $('.flexslider-module').each(function(){
      $(this).flexslider({
        animation: "slide",
        animationLoop: false,
        itemWidth: 280,
        controlNav: false,
        maxItems: 0,
        slideshow: false,
      });
    });
  });
</script>
<?php endif; ?>

<?php if (isset($this->document->journal_custom_css)): ?>
<style type="text/css">
/* Control Panel Custom CSS */
<?php echo $this->document->journal_custom_css . "\n"; ?>
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_custom_js)): ?>
<script type="text/javascript">
/* Control Panel Custom JS */
<?php echo $this->document->journal_custom_js . "\n"; ?>
</script>
<?php endif; ?>

<div class="overlay"> </div>

<?php if (!$detect->isMobile()): ?>
  <!-- left custom blocks -->
  <?php if (isset($this->document->journal_custom_blocks['left']) && count($this->document->journal_custom_blocks['left'])): ?>
  <?php foreach ($this->document->journal_custom_blocks['left'] as $custom_block): ?>
    <div class="custom-block-left" style="top: <?php echo $custom_block['offset']; ?>px; position: <?php echo $custom_block['position']; ?>; width: <?php echo $custom_block['content_width']; ?>px; left: -<?php echo $custom_block['content_width']; ?>px;" data-width="<?php echo $custom_block['content_width']; ?>">
      <div class="custom-block-icon" style="background-color: <?php echo $custom_block['icon_bgcolor']; ?>; background-image: url('<?php echo $custom_block['img']; ?>');"></div>
      <div class="custom-block-content" style="min-height: 50px; background-color: <?php echo $custom_block['content_bgcolor']; ?>; width: <?php echo $custom_block['content_width']; ?>px; padding: <?php echo $custom_block['content_padding']; ?>px;" data-text="<?php echo base64_encode($custom_block['text']); ?>">Loading...</div>
    </div>
  <?php endforeach; ?>
  <?php endif; ?>
  <!-- end left custom blocks -->

  <!-- right custom blocks -->
  <?php if (isset($this->document->journal_custom_blocks['right']) && count($this->document->journal_custom_blocks['right'])): ?>
  <?php foreach ($this->document->journal_custom_blocks['right'] as $custom_block): ?>
    <div class="custom-block-right"  style="top: <?php echo $custom_block['offset']; ?>px; position: <?php echo $custom_block['position']; ?>; width: <?php echo $custom_block['content_width']; ?>px; right: -<?php echo $custom_block['content_width']; ?>px;" data-width="<?php echo $custom_block['content_width']; ?>">
      <div class="custom-block-icon" style="background-color: <?php echo $custom_block['icon_bgcolor']; ?>; background-image: url('<?php echo $custom_block['img']; ?>');"></div>
      <div class="custom-block-content" style="min-height: 50px; background-color: <?php echo $custom_block['content_bgcolor']; ?>; width: <?php echo $custom_block['content_width']; ?>px; padding: <?php echo $custom_block['content_padding']; ?>px;" data-text="<?php echo base64_encode($custom_block['text']); ?>">Loading...</div>
    </div>
  <?php endforeach; ?>
  <?php endif; ?>
  <!-- end right custom blocks -->
<?php endif; ?>


<!-- Fullscreen Slider -->
<?php if (isset($this->document->journal_bgslider)): ?>
<div id="bgslider" class="mc-cycle">
  <?php foreach ($this->document->journal_bgslider['images'] as $img): ?>
  <img src="<?php echo $img; ?>" alt="" />
  <?php endforeach; ?>
</div>
<?php if ($this->document->journal_bgslider['disabled']): ?>
<style> 
.mobile #bgslider{display: none !important;}
</style>
<?php endif; ?>
<script src="catalog/view/javascript/journal/jquery.maximage.min.js"></script>
<script type="text/javascript">
  var bgslider = $.parseJSON('<?php echo json_encode($this->document->journal_bgslider["options"]); ?>');
  bgslider.cssTransitions = false;
  bgslider.cycleOptions.easing = 'easeInOutQuart';
  bgslider.cycleOptions.prev = '#bgslider_left';
  bgslider.cycleOptions.next = '#bgslider_right';
  $('#bgslider').maximage(bgslider);
</script>
<?php endif; ?>
<!-- End Fullscreen Slider -->

<script type="text/javascript">
  
$(function(){
  $('.custom-block-content').each(function(){
    var $this = $(this);
    setTimeout(function(){
      $this.html(window.atob($this.attr('data-text')));
    }, 2000);
  })
});

</script>

</body>
</html>
