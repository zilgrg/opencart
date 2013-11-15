<?php
  $url = "//".$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];
  $url = str_replace(array('&amp;boxer=true', '?boxer=true'), array('',''), $url);
  if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
    $server = $this->config->get('config_ssl');
  } else {
    $server = $this->config->get('config_url');
  }
?>
<!doctype html>
<html>
<head>
  <title>Journal QuickView</title>
  <base href="<?php echo $server; ?>" />
  <link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/style.css">
  <?php foreach ($this->document->getStyles() as $style): ?>
    <?php if(strpos($style['href'], 'fonts.googleapis.com') !== FALSE): ?>
    <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php endif; ?>
  <?php endforeach; ?>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
  <script type="text/javascript">
  $(function(){
    $('.image-additional a').click(function(){
      $("#image").attr('src', $(this).attr('href'));
      return false;
    });
  });
  </script>
  <?php if (isset($this->document->journal_css)): ?>
  <style>
  /* Control Panel Generated Style */
  <?php echo $this->document->journal_css; ?>
  </style>
  <?php endif; ?>

  <?php if (isset($this->document->journal_quickview_zoom) && $this->document->journal_quickview_zoom === 'yes'): ?>
  <script src="catalog/view/javascript/journal/jquery.elevateZoom.js"></script>
  <script type="text/javascript">
  $(function(){
    $("#quickview-image").elevateZoom({
      zoomType: "inner"
    });
    $('.product-info .image-additional a').click(function(e){
        var $img = $('#quickview-image');
        if (!$img.length) return false;
        /* change big thumb */
        $img.attr('src', $(this).attr('href'));
        $img.parent().attr('href', $(this).attr('href'));
        /* change zoom image */
        if (!$('html').hasClass('mobile')){
          $img.data('elevateZoom').swaptheimage($(this).attr('href'), $(this).attr('href'));
        }
        return false;
      });
  })
  </script>
  <?php endif; ?>

<!-- Product Page -->
<?php if (isset($this->document->journal_product_page_desc) && $this->document->journal_product_page_desc === 'no'): ?>
<style>
.product-info .description,
.quickview .tab-content{
  display:none;
}
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_product_page_price) && $this->document->journal_product_page_price === 'no'): ?>
<style>
.product-info .price{
  display:none;
}
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_product_page_options) && $this->document->journal_product_page_options === 'no'): ?>
<style>
.product-info .options{
  display:none;
}
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_product_page_cart) && $this->document->journal_product_page_cart === 'no'): ?>
<style>
.product-info .cart{
  display:none;
}
</style>
<?php endif; ?>
<!-- End Product Page -->
<?php if (isset($this->document->journal_product_page_desc) && $this->document->journal_product_page_desc === 'no'
       && isset($this->document->journal_product_page_price) && $this->document->journal_product_page_price === 'no'
       && isset($this->document->journal_product_page_options) && $this->document->journal_product_page_options === 'no'
       && isset($this->document->journal_product_page_cart) && $this->document->journal_product_page_cart === 'no'): ?>

<style>
.product-info .right{
  display: none;
}
.product-info .image a img{
  display: block;
  margin: 0 auto;
}
.gallery_text{
  max-width: 100%;
}
.product-info .image-additional{
  text-align: center;
}
</style>
<?php endif; ?>
<!-- End Catalog Mode -->
</head>
<body>
  <div id="content" class="quickview">
    <h1><?php echo $heading_title; ?></h1>
    <div class="product-info">

      <?php if ($thumb || $images) { ?>
      <div class="left" style="width: 100px !important;">

        <?php if ($thumb) { ?>
        <div class="image"><a id="quickviw-first-a" href="<?php echo $url; ?>" target="_top" title="<?php echo $heading_title; ?>" ><img src="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="quickview-image" /></a></div>
        <?php } ?>

        <?php if ($images) { ?>
        <div class="image-additional">
          <?php if ($thumb) { ?>
          <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image_2" /></a>
          <?php } ?>

          <?php foreach ($images as $image) { ?>
          <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
          <?php } ?>
        </div>
        <?php } ?>

      </div>
      <?php } ?>

      <div class="right">
        <div class="description">
          <?php if ($manufacturer) { ?>
          <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>" target="_top"><?php echo $manufacturer; ?></a><br />
          <?php } ?>
          <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
          <?php if ($reward) { ?>
          <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
          <?php } ?>
          <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
          <?php if ($price) { ?>
          <div class="price">
            <?php if (!$special) { ?>
            <?php echo $price; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $price; ?></span> <br /><span class="price-new"><?php echo $special; ?></span>
            <?php } ?>
            <br />
            <?php if ($tax) { ?>
            <div class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></div>
            <?php } ?>
            <?php if ($points) { ?>
            <span class="reward"><?php echo $text_points; ?> <?php echo $points; ?></span>
            <?php } ?>
            <?php if ($discounts) { ?>
            <div class="discount">
              <?php foreach ($discounts as $discount) { ?>
              <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
              <?php } ?>
            </div>
            <?php } ?>
          </div>
          <?php } ?>

          <?php if ($review_status) { ?>
          <div class="review">
            <div><img src="catalog/view/theme/journal/images/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" /></div>
          </div>
          <?php } ?>

          <div class="cart">
            <div>
              <a href="#" id="add_btn" class="button"><?php echo $button_cart; ?></a>
              <a href="<?php echo $url; ?>" target="_top" class="button"><?php echo isset($this->document->journal_quickview_view_product) && $this->document->journal_quickview_view_product ? $this->document->journal_quickview_view_product : 'More details'; ?></a>
            </div>
          </div>
          <?php if(isset($this->document->journal_quickview_desc_limit) && is_numeric($this->document->journal_quickview_desc_limit) && $this->document->journal_quickview_desc_limit > 0): ?>
          <div class="tab-content"><?php echo substr(strip_tags($description), 0, $this->document->journal_quickview_desc_limit) . "..."; ?></div>
          <?php else: ?>
          <div class="tab-content"><?php echo $description; ?></div>
          <?php endif;?>
      </div>
    </div>

  </div>
  <script type="text/javascript">
  $(function(){
    $('.image-additional a').click(function(){
      $('#quickview-image').attr('src', $(this).attr('href'));
      return false;
    });
    $('#add_btn').click(function(){
      parent.window.addToCart('<?php echo $product_id; ?>');
      return false;
    });

    var x = $('.quickview .tab-content').position();

    $('.quickview .tab-content').height(440 - x.top - 30);

  });
  </script>

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

</body>
</html>