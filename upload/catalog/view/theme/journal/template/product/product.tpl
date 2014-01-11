<?php  $detect = new Mobile_Detect(); ?>
<?php 
function iever($compare=false, $to=NULL){
    if(!preg_match('/MSIE (.*?);/', $_SERVER['HTTP_USER_AGENT'], $m)
     || preg_match('#Opera#', $_SERVER['HTTP_USER_AGENT']))
        return false === $compare ? false : NULL;
 
    if(false !== $compare
        && in_array($compare, array('<', '>', '<=', '>=', '==', '!='))
        && in_array((int)$to, array(5,6,7,8,9,10))){
        return eval('return ('.$m[1].$compare.$to.');');
    }
    else{
        return (int)$m[1];
    }
}
?>
<?php if (isset($this->request->get['boxer'])): ?>
<?php require_once DIR_TEMPLATE . '/journal/template/product/product_quick_view.tpl'; ?>
<?php else: ?>
<?php echo $header; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>
  <div class="product-info">
    <script src="catalog/view/javascript/journal/jquery.elevateZoom.js"></script>
    <script src="catalog/view/javascript/journal/swipebox/lib/ios-orientationchange-fix.js"></script>
    <script src="catalog/view/javascript/journal/swipebox/source/jquery.swipebox.js"></script>

    <?php if (isset($this->document->journal_product_gallery) && $this->document->journal_product_gallery === 'no'): ?>
    <style>
      #swipebox-overlay, .gallery_text{
        display: none !important;
      }
    </style>
    <?php endif; ?>

   <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><a id="first-a" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" ><img src="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if (isset($this->document->journal_click_gallery_text2)): ?>
      <div class="gallery_text"><span><?php echo $this->document->journal_click_gallery_text2; ?></span><img src="catalog/view/theme/journal/images/product_zoom.png" alt="" /></div>
      <?php endif; ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php if ($thumb) { ?>
        <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image_2" /></a>
        <?php } ?>
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>"><img src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
      <!-- swipebox gallery -->
        <div style="display: none;" id="swipebox">
        <?php if ($thumb) { ?>
        <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" rel="product-gallery" class="swipebox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" rel="product-gallery" class="swipebox"><img src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
        </div>
      <!-- end gallery -->
    </div>
    <?php } ?>
    <div class="right">
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
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
      <?php if (isset($profiles)): ?>
      <?php if ($profiles): ?>
      <div class="option">
          <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
          <br />
          <select name="profile_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($profiles as $profile): ?>
              <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
              <?php endforeach; ?>
          </select>
          <br />
          <br />
          <span id="profile-description"></span>
          <br />
          <br />
      </div>
      <?php endif; ?>
      <?php endif; ?>
      <?php if ($options) { ?>
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
        <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { ?>

        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <table class="option-image">
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <tr>
              <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                  <?php } ?>
                </label></td>
            </tr>
            <?php } ?>
          </table>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
      <div class="cart"><div>

        <!-- Quantity Button Select List -->
        <?php if(isset($this->document->journal_push_select) && $this->document->journal_push_select === 'yes'):?>
        <style>
          ul.product-option li {
            float: left;
            min-width: 35px;
            height: 35px;
            display: inline-block;
            margin-right: 7px;
            margin-top: 7px;
            cursor: pointer;
            text-align: center;
            display:table;
          }

          ul.product-option li span{
            display:table-cell;
            vertical-align: middle;
            padding: 10px !important;
          }

        </style>
        <script>
        $(function(){
          $('.options select').each(function(){
            var $sel = $(this);
            var $parent = $sel.parent();
            var $input = $('<input type="hidden" value="">').attr('name', $sel.attr('name')).appendTo($parent);
            var $ul = $('<ul class="product-option">');
            $sel.find('option').each(function(){
              if (!$(this).val()) return;
              $('<li>')
                .attr('data-value', $(this).val())
                .click(function(){
                  var $old = $parent.find('ul.product-option li.selected').removeClass('selected');
                  if (!$old.is($(this))) {
                    $(this).addClass('selected');
                    $input.val($(this).attr('data-value'));
                  } else {
                    $input.val('');
                  }
                })
                .html('<span>' + $(this).text() + '</span>')
                .appendTo($ul);
            });
            $sel.replaceWith($ul);
          });
        });
        </script>
        <?php unset($this->document->journal_push_select); endif; ?>
        <!-- END Button Select List -->

        <!-- Quantity Input Buttons NO -->
        <?php if(isset($this->document->journal_stepper_input) && $this->document->journal_stepper_input === 'no' || iever('<=', 10)):?>
            <?php echo $text_qty; ?>
        <?php unset($this->document->journal_stepper_input); endif; ?>
        <!-- END Quantity Input Buttons NO -->

        <!-- Cloud Zoom On/Off -->
        <?php if((isset($this->document->journal_cloud_zoom) && $this->document->journal_cloud_zoom === 'no') || $detect->isMobile()):?>
            <style>
              .zoomContainer{
                display:none !important;
              }
            </style>
        <?php unset($this->document->journal_cloud_zoom); endif; ?>
        <!-- END Cloud Zoom On/Off -->


        <!-- Cloud Zoom Type -->

        <?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'): ?>
            <style>
              .zoomContainer, .zoomWindowContainer div {
                width: 370px !important;
                height: 350px !important;
              }
            </style>
        <?php endif;?>

        <?php if(isset($this->document->journal_cloud_zoom_inner) && $this->document->journal_cloud_zoom_inner === 'yes'):?>
            <style>
                .zoomContainer, .zoomWindowContainer div {
                  width: 420px !important;
                  height: 420px !important;
                }
                @media only screen and (max-width: 1220px) {
                  .zoomContainer, .zoomWindowContainer div {
                    width: 350px !important;
                    height: 350px !important;
                  }
                }
            </style>
         <?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'): ?>
            <style>
              .zoomContainer, .zoomWindowContainer div {
                width: 350px !important;
                height: 350px !important;
              }
            </style>
        <?php endif;?>

        <?php unset($this->document->journal_cloud_zoom_inner); endif; ?>

        <?php if(isset($this->document->journal_cloud_zoom_inner) && $this->document->journal_cloud_zoom_inner === 'no'):?>
            <style>
                .zoomWindowContainer div {
                  margin-left: 20px;
                  max-width: 450px;
                }
                @media only screen and (max-width: 1220px) {
                  .zoomContainer, .zoomWindowContainer div {
                    max-width: 370px;
                    max-height: 350px;
                  }
                }
            </style>
        <?php unset($this->document->journal_cloud_zoom_inner); endif; ?>
        <!-- END Cloud Zoom Type -->


        <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
        
        <!-- Quantity Input Buttons YES -->
        <?php if(isset($this->document->journal_stepper_input) && $this->document->journal_stepper_input === 'yes'):?>
          <script>
            if (!$('html').hasClass('ie')) {
              $('input[name="quantity"]').attr('min', '0').stepper();
            }
          </script>
          <style>
          @media only screen and (max-width: 470px){
            .product-info .cart input.button{
              width: 192px;
            }
          }
         </style>

        <?php unset($this->document->journal_stepper_input); endif; ?>
        <!-- END Quantity Input Buttons NO-->

        <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;
        <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
        </div>
        <div class='or-text'><span>&nbsp;&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;&nbsp;</span></div>
        <div><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
          <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></div>
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/journal/images/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>

        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script src="//s7.addthis.com/js/250/addthis_widget.js"></script>
          <!-- AddThis Button END -->
        </div>

      </div>
      <?php } ?>
      
       
        <?php if(isset($this->document->journal_share_plugin) && $this->document->journal_share_plugin === 'add'):?>
          <div class="social add-this">
             <!-- Add This -->
              <div class="addthis_toolbox addthis_default_style ">
                <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
                <a class="addthis_button_tweet"></a>
                <a class="addthis_button_google_plusone" g:plusone:size="medium"></a>
                <a class="addthis_button_pinterest_pinit"></a>
              </div>
              <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5156d710568736a0"></script>
              <!-- END Add This -->
          </div>
        <?php unset($this->document->journal_share_plugin); endif; ?>
      

       
        <?php if(isset($this->document->journal_share_plugin) && $this->document->journal_share_plugin === 'share'):?>
          <div class="social share-this">
            <!-- Share This -->
              <script src="http://w.sharethis.com/button/buttons.js"></script>
              <script>stLight.options({publisher: "c2346c4f-2838-44e0-a0df-cbbf95574ed0"});</script>
              <span class="st_facebook_hcount" displayText="Facebook"></span>
              <span class="st_twitter_hcount" displayText="Tweet"></span>
              <span class="st_pinterest_hcount" displayText="Pinterest"></span>
              <span class="st_email_hcount" displayText="Email"></span>
              <!-- END Share This -->
          </div>
        <?php unset($this->document->journal_share_plugin); endif; ?>
      

      <!-- No Share plugin -->
        <?php if(isset($this->document->journal_share_plugin) && $this->document->journal_share_plugin === 'none'):?>
          <style>
            .product-info .review{
              border-bottom-width: 1px;
              border-bottom-style: solid;
              padding-bottom: 20px;
            }
          </style>
        <?php unset($this->document->journal_share_plugin); endif; ?>
      <!-- END No Share plugin -->
    </div>

  </div>
  <div id="tabs" class="htabs">
    <?php if(isset($this->document->journal_custom_product_tabs)): $index=0; foreach ($this->document->journal_custom_product_tabs[1] as $tab): $index++; ?>
      <a href="#journal-1-<?php echo $index; ?>"><?php echo $tab['title']; ?></a>
    <?php endforeach; endif; ?>
    <a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if(isset($this->document->journal_custom_product_tabs)): $index=0; foreach ($this->document->journal_custom_product_tabs[2] as $tab): $index++; ?>
      <a href="#journal-2-<?php echo $index; ?>"><?php echo $tab['title']; ?></a>
    <?php endforeach; endif; ?>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if(isset($this->document->journal_custom_product_tabs)): $index=0; foreach ($this->document->journal_custom_product_tabs[3] as $tab): $index++; ?>
      <a href="#journal-3-<?php echo $index; ?>"><?php echo $tab['title']; ?></a>
    <?php endforeach; endif; ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if(isset($this->document->journal_custom_product_tabs)): $index=0; foreach ($this->document->journal_custom_product_tabs[4] as $tab): $index++; ?>
      <a href="#journal-4-<?php echo $index; ?>"><?php echo $tab['title']; ?></a>
    <?php endforeach; endif; ?>
  </div>

  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>

    <?php if(isset($this->document->journal_custom_product_tabs)): for ($i=1; $i<=4; $i++): ?>
    <?php $index = 0; foreach ($this->document->journal_custom_product_tabs[$i] as $tab): $index++; ?>
      <div class="tab-content" id="<?php echo "journal-{$i}-{$index}"; ?>"><?php echo $tab['content']; ?></div>
    <?php endforeach; ?>
  <?php endfor; endif; ?>

  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
    <div id="tab-related">
     <div class="related-tab box-heading"><?php echo $tab_related; ?></div>

      <div class="box-product">
        <?php foreach ($products as $product) { ?>
        <div>
          <?php if ($product['thumb']) { ?>
          <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
          <?php } ?>
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
          <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
          <?php if ($product['rating']) { ?>
          <div class="rating"><img src="catalog/view/theme/journal/images/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
          <?php } ?>
          <div class="cart">
          <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a>
          </div>
        </div>
        <?php } ?>
      </div>
    </div>
    <?php } ?>
  <?php echo $content_bottom; ?>

</div>

<script type="text/javascript"><!--

<?php if (isset($profiles)): ?>
$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
    dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
            
      if (json['success']) {
                $('#profile-description').html(json['success']);
      } 
    }
  });
});
<?php endif; ?>
    
$('#button-cart').bind('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
    dataType: 'json',
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      
      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
          }
        }
                <?php if (isset($profiles)): ?>
                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
                <?php endif; ?>
      } 
      
      if (json['success']) {
        if (typeof(custom_notifier) == "function") {
          custom_notifier(json['success']);
        } else {
          $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
          $('.success').fadeIn('slow');
          $('html, body').animate({ scrollTop: 0 }, 'slow');
        }

        $('#cart-total').html(json['total']);
      }
    }
  });
});
//--></script>
<?php if ($options) { ?>
<script src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
  action: 'index.php?route=product/product/upload',
  name: 'file',
  autoSubmit: true,
  responseType: 'json',
  onSubmit: function(file, extension) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/journal/images/loading.gif" class="loading" style="padding-left: 5px;" />');
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
  },
  onComplete: function(file, json) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

    $('.error').remove();

    if (json['success']) {
      alert(json['success']);

      $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
    }

    if (json['error']) {
      $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
    }

    $('.loading').remove();
  }
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script><!--
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');

  $('#review').load(this.href);

  $('#review').fadeIn('slow');

  return false;
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-review').attr('disabled', true);
      $('#review-title').after('<div class="attention"><img src="catalog/view/theme/journal/images/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-review').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(data) {
      if (data['error']) {
        $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
      }

      if (data['success']) {
        $('#review-title').after('<div class="success">' + data['success'] + '</div>');

        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});
//--></script>
<script><!--
$('#tabs a').tabs();
//--></script>
<script src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script>
<script><!--
if ($.browser.msie && $.browser.version == 6) {
  $('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
  dateFormat: 'yy-mm-dd',
  timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script>

<?php echo $footer; ?>
<?php endif; ?>