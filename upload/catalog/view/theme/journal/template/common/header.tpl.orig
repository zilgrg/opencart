<?php
  if(!isset($this->document->journal_install)) die('Journal not installed - Read full installation instructions http://journal.digital-atelier.com/docs/#!/installation ');
  require_once DIR_TEMPLATE . '/journal/template/common/Mobile_Detect.php' ;
  $detect = new Mobile_Detect();
  function print_menu($data, $child = false, $mobile_menu, $is_mobile) {
    $res = "";
    foreach ($data as $categ) {
      $sub = print_menu($categ['subcategs'], true, $mobile_menu, $is_mobile);
      $res .= $is_mobile && !$child ? '<li class="menu-hide">' : "<li>";
      $href = $categ['href'] ? 'href="' . $categ['href'] . '"' : '';
      if ($sub) {
        $res .= '<a ' . $href . '>' . $categ['name'] . "<span></span></a>";
        $res .= $sub;
      } else {
        $res .= '<a ' . $href . '>' . $categ['name'] . "</a>";
      }
      $res .= "</li>";
    }
    if ($res) {
      if ($child) return $is_mobile ? '<ul class="menu-hide">' . $res . '</ul>' : "<ul>" . $res . "</ul>";
      return '
        <ul class="sf-menu">
          <li class="open">
           <span class="menu-icon">
              <span></span>
              <span></span>
              <span></span>
            </span>' . $mobile_menu . '</li>
          ' . $res . '
        </ul>
      ';
    }
    return '';
  }
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="theme_<?php echo $this->document->journal_active_theme; ?> <?php echo $this->document->journal_custom_blocks_count; ?>">
<head>
<?php if (isset($this->document->journal_responsive_design) && $this->document->journal_responsive_design === 'yes'): ?>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<?php endif; ?>
<?php $is_responsive = isset($this->document->journal_responsive_design) && $this->document->journal_responsive_design === 'yes'; ?>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
  <meta name="description" content="<?php echo $description; ?>"/>
<?php } ?>
<?php if ($keywords) { ?>
  <meta name="keywords" content="<?php echo $keywords; ?>"/>
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
<?php if ($icon) { ?>
  <link href="<?php echo $icon; ?>" rel="icon"/>
<?php } ?>

<?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($styles as $style) { ?>
  <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/style.css">
<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
<script type="text/javascript">var WIDE_LAYOUT = true;</script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/wide.css">
<?php else: ?>
  <script type="text/javascript">var WIDE_LAYOUT = false; </script>
<?php endif; ?>

<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/superfish.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/blog_journal.css">

<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
<script src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>


<!-- Quantity Input Buttons YES -->
<?php if(isset($this->document->journal_stepper_input) && $this->document->journal_stepper_input === 'yes'):?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/jquery.fs.stepper.css">
<script type="text/javascript" src="catalog/view/javascript/journal/jquery.fs.stepper.min.js"></script>
<?php endif; ?>
<!-- END Quantity Input Buttons YES-->

<?php if (isset($this->document->journal_responsive_design) && $this->document->journal_responsive_design === 'yes'): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/responsive.css">
<script>
var responsive_design = true;
</script>
<?php else: ?>
<script>
var responsive_design = false;
</script>
<?php endif; ?>
<?php if (isset($this->document->journal_custom_css_file)) echo $this->document->journal_custom_css_file . "\n"; ?>

<?php if (isset($this->document->journal_header_type) && $this->document->journal_header_type === 'yes'): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/header_ii.css">

<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'): ?>
<style>
  #journal-header .welcome, .top-links{
    width: 480px;
  }
  #journal-header .menu{
    width: 980px;
  }
  .safari #journal-header .welcome, .safari .top-links{
    width: 478px;
  }
  @media only screen and (max-width: 980px) {
  #journal-header .welcome, .top-links{
    width: 549px;
  }
}
</style>
<?php endif; ?>
<?php endif; ?>
<script>
  var CLOUD_ZOOM_TYPE = '<?php echo isset($this->document->journal_cloud_zoom_inner) && $this->document->journal_cloud_zoom_inner === "yes" ? "inner" : ""; ?>';
</script>

<?php if(isset($this->document->journal_product_notification) && $this->document->journal_product_notification === "yes"): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/journal/pnotify/jquery.pnotify.default.css"/>
<script type="text/javascript" src="catalog/view/javascript/journal/pnotify/jquery.pnotify.min.js"></script>
<script type="text/javascript">
    function custom_notifier(message) {
      var $temp = $('<div>' + message + '</div>');
      var $title = $temp.find('a').last().prev();
      var timeout = '<?php echo isset($this->document->journal_product_notification_timeout) && is_numeric($this->document->journal_product_notification_timeout) ? $this->document->journal_product_notification_timeout : 1700; ?>';
      $.pnotify({
        title: $title.html(),
        delay: parseInt(timeout),
        text: message,
        type: 'success',
      });
    }
    window.custom_notifier = custom_notifier;
</script>
<?php endif; ?>

<?php if(isset($this->document->journal_product_notification_shadow) && $this->document->journal_product_notification_shadow === "yes"): ?>
<style>
.ui-pnotify .ui-pnotify-shadow {
  -webkit-box-shadow: 0 0px 4px rgba(0,0,0,0.3);
  -moz-box-shadow: 0 0px 4px rgba(0,0,0,0.3);
  -o-box-shadow: 0 0px 4px rgba(0,0,0,0.3);
  box-shadow: 0 0px 4px rgba(0,0,0,0.3);
}
</style>
<?php endif; ?>

<?php if(isset($this->document->journal_product_notification_radius) && $this->document->journal_product_notification_radius === "yes"): ?>
<style>
.ui-pnotify-container {
  border-radius:8px;
}
</style>
<?php endif; ?>

<script src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<script src="catalog/view/javascript/journal/cookie.js"></script>
<script src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
<script src="catalog/view/javascript/jquery/tabs.js"></script>
<script src="catalog/view/javascript/common.js"></script>
<script src="catalog/view/javascript/journal/plugins.js"></script>
<script src="catalog/view/javascript/journal/superfish/js/hoverIntent.js"></script>
<script src="catalog/view/javascript/journal/superfish/js/superfish.js"></script>

<!--[if lt IE 9]><script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script><![endif]-->
<!--[if IE]><script src="//stringencoders.googlecode.com/svn-history/r230/trunk/javascript/base64.js"></script><![endif]-->
<!--[if IE]><script>if (!window.atob) window.atob = base64.decode;</script><![endif]-->

<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>"></script>
<?php } ?>

<script type="text/javascript">
  var DECIMAL_POINT = '<?php echo $this->document->journal_decimal_point; ?>';
</script>
<script src="catalog/view/javascript/journal/jquery.autocomplete.min.js"></script>
<script src="catalog/view/javascript/journal/journal.js"></script>


<?php echo $google_analytics; ?>
<?php if (isset($this->document->journal_css)): ?>
<style>
/* Control Panel Generated Style */
<?php echo $this->document->journal_css; ?>
</style>
<?php endif; ?>

<?php if(isset($this->document->journal_product_hover) && $this->document->journal_product_hover === 'none'):?>
<style>
  .product-over{
    display:none;
  }
</style>
<?php unset($this->document->journal_product_hover); endif; ?>

<?php if(isset($this->document->journal_product_hover) && $this->document->journal_product_hover === 'hover1'):?>
<style>
  .product-over{
    -webkit-transform: scaleY(1);
    -moz-transform: scaleY(1);
    -o-transform: scaleY(1);
    transform: scaleY(1);
  }
</style>
<?php unset($this->document->journal_product_hover); endif; ?>

<?php if(isset($this->document->journal_product_hover) && $this->document->journal_product_hover === 'hover2'):?>
<style>
  .product-over{
    -webkit-transform: scaleY(0);
    -moz-transform: scaleY(0);
    -o-transform: scaleY(0);
    transform: scaleY(0);
  }
</style>
<?php unset($this->document->journal_product_hover); endif; ?>
<?php if(isset($this->document->journal_product_hover) && $this->document->journal_product_hover === 'hover2'):?>
<style>
  .product-over{
    -webkit-transform: scaleY(0);
    -moz-transform: scaleY(0);
    -o-transform: scaleY(0);
    transform: scaleY(0);
  }
</style>
<?php unset($this->document->journal_product_hover); endif; ?>


<?php if(isset($this->document->journal_text_overflow) && $this->document->journal_text_overflow === 'yes'):?>
<style>
.product-grid .name a,
#content .box-product .name a,
.product-slider .name a {
    white-space: nowrap;
    overflow: hidden;
    -webkit-text-overflow: ellipsis;
    -moz-text-overflow: ellipsis;
    -o-text-overflow: ellipsis;
    text-overflow: ellipsis;
}
</style>
<?php endif; ?>

<?php if(isset($this->document->journal_hide_category_image) && $this->document->journal_hide_category_image === 'yes'):?>
<style>
.category-info .image {
  display:none;
}
</style>
<?php endif; ?>

<?php if(isset($this->document->journal_fixed_header) && $this->document->journal_fixed_header === 'yes'):?>
<style>
header{
    position: fixed;
    top: 0;
  }
  body{
    padding-top: 120px;
  }
  .autocomplete-suggestions{
    position:fixed;
  }
  @media only screen and (max-width: 980px) {
  header{
    position: relative;
    top: 0;
  }
  body{
    padding-top: 0;
  }
  .autocomplete-suggestions{
    position: absolute;
  }
}
<?php if (isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'): ?>
header{
    position: fixed;
    top: 0;
  }
  body{
    padding-top: 140px;
  }
  @media only screen and (max-width: 980px) {
  header{
    position: relative;
    top: 0;
  }
  body{
    padding-top: 0;
  }
}
<?php endif; ?>

.mobile header{
  position: relative;
}
.mobile body{
  padding-top: 0;
}
</style>

<?php endif; ?>

<!-- show/hide wishlist/compare -->

<?php if(isset($this->document->journal_compare_wishlist) && $this->document->journal_compare_wishlist === 'no'):?>
<style>
.product-compare,
.product-grid > div .compare, 
.product-grid > div .wishlist,
.product-list > div .compare, 
.product-list > div .wishlist,
.product-info .cart > div + div{
   display:none;
}
.product-grid > div .cart{
  margin-bottom: 14px;
}
</style>
<?php endif; ?>


<!-- dropdown language & currency -->
<?php if((isset($this->document->journal_currency_language_icons_style) && $this->document->journal_currency_language_icons_style === 'yes')): ?>
<style>
#currency ul, #language ul{
  position: absolute;
  padding-top: 23px;
  top: 1px;
  overflow: hidden;
  background-color: #FFF;
  border: 1px solid #E5E5E5;
  border-radius: 4px;
  z-index: -1;
  display:none;
}
#currency a{
  margin-left: 4px;
}
#currency ul li a{
  margin-left: 2px;
}
#language ul{
  top: -3px;
  min-width: 30px;
}
#language a{
  display:block;
}
#language img{
  margin-right: 0;
  margin-left: 7px;
}
#language ul li img{
  margin: 3px 0;
}
#language ul li img{
  margin: 4px 0;
}
#language ul li:last-child img{
  margin-bottom:5px;
}
#journal-header .welcome form{
  max-width: 35px;
  position: relative;
  z-index: 99;
}
.ie #language ul,
.ie #currency a{
  margin-left: 7px;
}

<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
#journal-header .welcome form{
  max-width: 25px;
}

@media only screen and (max-width: 470px) {
  #journal-header .welcome form{
    max-width: 100%;
  }
}

<?php if (isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'): ?>
#language img{
  margin-left: -3px;
}
.ie #language img{
  margin-left: 3px;
}
#language a.first-item{
  width: 33px;
}
@media only screen and (max-width: 980px) {
   #language a.first-item{
  width: 25px;
}
}
@media only screen and (max-width: 470px) {
  #journal-header .welcome form{
    max-width: 100% !important;
  }
   #language a.first-item{
  width: auto;
}
#language > a img{
  margin-left: 8px;
}
}
<?php endif; ?>
<?php endif; ?>

@media only screen and (max-width: 1220px) {
  #journal-header .welcome form{
    max-width: 35px;
  }
}

@media only screen and (max-width: 980px) {
  #language img{
    margin-left: 5px;
  }
}

@media only screen and (max-width: 760px) {
  #journal-header .welcome form #currency a{
    margin-left: 4px;
  }
  #journal-header .welcome form #currency ul li a{
    margin: 3px;
  }
  #currency ul{
    top: -3px;
  }
  #language img{
    margin-left: 7px;
  }
}

@media only screen and (max-width: 470px) {
  #journal-header .welcome form{
    max-width: 100%;
  }
  #language ul{
    left:46%;
  }
  #language img{
    margin-left: 7px;
  }
}
</style>

<script>
$(function(){
  function init($ul, sel) {
    var $current = $ul.find('li[data-value="' + sel + '"]');
    $ul.parent().prepend($current);
    if ($current.find('a').length) {
      $current.replaceWith($current.find('a').addClass('first-item'));
    } else {
      var $img = $current.find('img');
      $current.replaceWith('<a class="first-item"><img src="' + $img.attr('src') + '" title="' + $img.attr('title') + '" alt="' + $img.attr('alt') + '" /></a>');
    }
    $ul.addClass('selector-open');
  }

  init($('#language > ul'), '<?php echo $this->language->get("code"); ?>');
  init($('#currency > ul'), '<?php echo $this->currency->getCode(); ?>');

  $('#language-form').hover( function(){
    $('#language ul').fadeIn(150);
  },  function(){
    $('#language ul').fadeOut(150);
  });

  $('#currency-form').hover( function(){
    $('#currency ul').fadeIn(150);
  },  function(){
    $('#currency ul').fadeOut(150);
  });

  });
</script>
<?php endif; ?>
<!-- end of dropdown language & currency -->

<?php if(isset($this->document->journal_quickview_status) && $this->document->journal_quickview_status === 'yes' && (!$detect->isMobile() || !$is_responsive)): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/journal/boxer/jquery.fs.boxer.css">
<script type="text/javascript" src="catalog/view/javascript/journal/boxer/jquery.fs.boxer.min.js"></script>
<script>
    function init_quickview(){
      $('#content .product-grid > div, #content .product-list > div, #content  .box-product > div, #blogArticle .relProduct').each(function(){
        var $quickview = $('<a class="quickview" data-height="510" data-width="700"><?php echo isset($this->document->journal_quickview_button) && $this->document->journal_quickview_button ? $this->document->journal_quickview_button : "Quickview";?></a>');
        $(this).append($quickview);
        var href = $(this).find('.name a').attr('href');
        if (location.protocol === 'https:') {
          href = href.replace('http:', 'https:');
        }
        $quickview.attr('href', href);
        $quickview.topZIndex();
        $quickview.boxer({
          fixed: true,
          customClass: 'quicklook'
        });
      });
    }
    window.init_quickview = init_quickview;
    $(function(){
      if (!$('html').hasClass('ie8')) {
        init_quickview();
      }
    });
</script>
<?php if(isset($this->document->journal_quickview_button_status) && $this->document->journal_quickview_button_status === 'yes'): ?>
<style>
a.quickview{
  visibility: hidden;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
  opacity: 0;
  transition: all 0.3s;
}

.product-grid > div:hover a.quickview,
.box-product > div:hover a.quickview,
.product-list > div:hover a.quickview,
.product-slider:hover a.quickview{
  visibility: visible;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
  opacity: 1;
}
</style>

<?php endif; ?>
<?php endif; ?>

<?php if (!isset($this->document->journal_auto_suggest) || (isset($this->document->journal_auto_suggest) && $this->document->journal_auto_suggest === 'no')): ?>
<style>
  .autocompletesearch-suggestions{
    display: none !important;
  }
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_header_shadow) && $this->document->journal_header_shadow === 'no'): ?>
<style>
header, header .top-header,
.chrome header, .chrome header .top-header{
box-shadow: none !important;
}
.top-links{
  border-bottom-width: 1px;
}
</style>
<?php endif; ?>


<!-- Larger logo -->
<?php if (isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'
  && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'no'): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/larger_logo.css" />
<script>$(document).ready(function(){$('header').removeClass('header_ii');$('html').addClass('larger-logo');});</script>
<?php endif; ?>

<?php if (isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'
  && isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/journal/stylesheet/larger_logo_wide_layout.css" />
<script>$(document).ready(function(){$('header').removeClass('header_ii');$('html').addClass('larger-logo');});</script>
<?php endif; ?>
<!-- End Larger logo -->


<!-- Catalog Mode -->
<?php if (isset($this->document->journal_header_cart) && $this->document->journal_header_cart === 'no'): ?>
<style>
 #journal-header .cart{
  display: none !important;
 }

 @media only screen and (min-width: 980px) {
  #journal-header .top-links{
  width: 780px;
 }

}
 @media only screen and (max-width: 980px) {
  #journal-header #search{
    width: 569px;
    max-width: 100%;
  }
}

@media only screen and (max-width: 760px) {
     header, #journal-header{
      height: 240px;
     }
}

@media only screen and (max-width: 470px) {
     header, #journal-header{
      height: 233px;
     }
}
</style>

<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
<style>
 @media only screen and (min-width: 980px) {
  #journal-header .top-links{
  width: 1000px;
 }
}
  @media only screen and (max-width: 1220px) {
  #journal-header .top-links{
  width: 780px;
 }
}
 @media only screen and (max-width: 980px) {
  #journal-header .top-links{
  width: 569px;
 }
  #journal-header #search{
    width: 569px;
    max-width: 100%;
  }
}

@media only screen and (max-width: 760px) {
     header, #journal-header{
      height: 240px;
     }
}

@media only screen and (max-width: 470px) {
     header, #journal-header{
      height: 233px;
     }
}
</style>

<?php endif; ?>

<?php if (isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'): ?>
<style>
 @media only screen and (min-width: 980px) {
  #journal-header .top-links, .safari #journal-header .top-links{
  width: 630px !important;
 }
}
 @media only screen and (max-width: 980px) {
  #journal-header #search{
    width: 469px;
  }
}
  @media only screen and (max-width: 760px) {
     #journal-header #search{
        width: 480px;
     }
     header, #journal-header{
      height: 280px;
     }
  }

</style>

<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>
<style>
 @media only screen and (min-width: 980px) {
  #journal-header .top-links, .safari #journal-header .top-links{
  width: 870px !important;
 }
}
  @media only screen and (max-width: 1220px) {
  #journal-header .top-links, .safari #journal-header .top-links{
  width: 630px !important;
 }
}
 @media only screen and (max-width: 980px) {
  #journal-header .top-links, .safari #journal-header .top-links{
  width: 469px !important;
 }
  #journal-header #search{
    width: 469px;
    max-width: 100%;
  }
}

@media only screen and (max-width: 760px) {
    #journal-header .top-links, .safari #journal-header .top-links{
  width: 480px !important;
 }
    #journal-header #search{
    width: 480px;
  }
     header, #journal-header{
      height: 280px;
     }
}
@media only screen and (max-width: 470px) {
 #journal-header .top-links, .safari #journal-header .top-links{
  width: 320px !important;
 }
}
</style>
<?php endif; ?>
<?php endif; ?>
<?php endif; ?>
<!-- End Header Cart -->

<?php if (isset($this->document->journal_product_name) && $this->document->journal_product_name === 'no'): ?>
<style>
.product-grid .name,
.product-list .name,
#content .box-product .name{
  display: none;
}
.product-grid .price, #content .box-product .price{
  border-top:none;
}
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_product_price) && $this->document->journal_product_price === 'no'): ?>
<style>
.product-list .price,
.product-grid .price, 
#content .box-product .price{
  display: none;
}
</style>
<?php endif; ?>

<?php if (isset($this->document->journal_add_to_cart) && $this->document->journal_add_to_cart === 'no'): ?>
<style>
.cart{
  display:none;
}
#journal-header .cart,
.product-info .cart{
  display:block;
}
</style>
<script>
$(document).ready(function(){
  $('.product-grid .price').after(' <div class="clearfix"> </div> ');
});
</script>
<?php endif; ?>


<?php if (isset($this->document->journal_product_list_description) && $this->document->journal_product_list_description === 'no'): ?>
<style>
.product-list .description{
  display:none;
}
</style>
<?php endif; ?>

<!-- Product Page -->
<?php if (isset($this->document->journal_product_page_desc) && $this->document->journal_product_page_desc === 'no'): ?>
<style>
.product-info .description{
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
<div class="loader"> </div>
<header <?php echo isset($this->document->journal_header_type) && $this->document->journal_header_type === 'yes' ? 'class="header_ii"' : ''; ?>>
  <div class="top-header"></div>
  <div id="journal-header">
        <?php if ($logo) { ?>
        <div id="logo"><a href="<?php echo $home; ?>">
          <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
        </div>
        <?php } ?>

        <div class="top-links">
          <?php if(isset($this->document->journal_top_menu)): ?>
          <?php foreach ($this->document->journal_top_menu as $menu_item): ?>
          <?php $target = $menu_item['new_window'] ? 'target="_blank"' : ''; ?>
          <?php $img = $menu_item['img'] ? '<img src="' . $menu_item['img'] .'" title="' . $menu_item['name'] .'" alt="' . $menu_item['name'] .'" />' : ''; ?>
          <?php if ($menu_item['href']): ?>
          <a class="link" href="<?php echo $menu_item['href']; ?>" <?php echo $target; ?>><?php echo $img . '<span>' . $menu_item['name'] . '</span>'; ?></a>
          <?php else: ?>
          <a class="no-link"><?php echo $img . '<span>' . $menu_item['name'] . '</span>'; ?></a>
          <?php endif; ?>
          <?php endforeach; ?>
          <?php endif; ?>

          <?php if (!isset($this->document->journal_top_menu) || count($this->document->journal_top_menu) === 0): ?>
          <a class="link" href="<?php echo $home; ?>"><?php echo $text_home; ?></a>
          <a class="link" href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a>
          <a class="link" href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
          <a class="link" href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a>
          <a class="link" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
          <?php endif; ?>
        </div>

        <?php if(!$is_responsive || !$detect->isMobile() || ($detect->isMobile() && $detect->isTablet())): ?>
        <section class="cart">
            <?php echo $cart; ?>
        </section>
        <?php endif; ?>

        <section class="welcome">
            <?php if (strlen($language) > 0): ?>
            <?php echo $language; ?>
            <?php else: ?>
            <style>
              @media only screen and (max-width: 470px) {
                #journal-header .welcome form {
                  text-align: center;
                  width: 100%;
                }
                #journal-header .welcome form div {
                  display: inline-block;
                }
              }
             </style>
            <?php endif; ?>
            <?php echo $currency; ?>
          <div id="welcome">
            <?php if (!$logged) { ?>
            <?php echo $text_welcome; ?>
            <?php } else { ?>
            <?php echo $text_logged; ?>
            <?php } ?>
          </div>
        </section>


        <div id="search">
           <div class="button-search"></div>
          <?php if (isset($filter_name)): ?>

            <?php if ($filter_name) { ?>
            <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
            <?php } else { ?>
            <input type="text" name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
            <?php } ?>

          <?php else: ?>

          <input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />

          <?php endif; ?>
        </div>

        <?php if($is_responsive && $detect->isMobile() && !$detect->isTablet()): ?>
        <section class="cart">
            <?php echo $cart; ?>
        </section>
        <?php endif; ?>

<!-- navigation starts -->

<nav class="menu">

<?php $super_class = $detect->isMobile() && $is_responsive ? "mobile-nav" : ""; ?>
<?php $super_class_hide = $detect->isMobile() && $is_responsive ? "class='menu-hide'" : ""; ?>

<?php if(isset($this->document->journal_mega_menu)): ?>
  <div id="super-menu">
  <ul class='super-menu <?php echo $super_class; ?>'>

       <li class="open">
       <span class="menu-icon">
          <span></span>
          <span></span>
          <span></span>
        </span>
        <?php echo isset($this->document->journal_mobile_menu_title2) && $this->document->journal_mobile_menu_title2 ? $this->document->journal_mobile_menu_title2 : 'Menu'; ?>
      </li>

  <?php foreach ($this->document->journal_mega_menu as $menu_item): ?>
    <li <?php echo $super_class_hide; ?> >
      <?php if (isset($menu_item['link']) && $menu_item['link']): ?>
        <a href="<?php echo $menu_item['link']; ?>" <?php echo $menu_item['new_window']; ?> ><?php echo $menu_item['name']; ?><span></span></a>
      <?php else: ?>
        <a href="javascript:;"><?php echo $menu_item['name']; ?><span></span></a>
      <?php endif; ?>
      <?php if ($menu_item['type'] === 'megamenu' && count($menu_item['items'])): ?>
      <div class="mega-menu">
        <?php foreach ($menu_item['items'] as $item): ?>
          <?php $no_image_class = $menu_item['show_images'] ? '' : 'item-no-image'; ?>
          <div class="mega-menu-item <?php echo $no_image_class; ?>">
            <a class="mega-menu-top" data-img="<?php echo $item['image']; ?>" href="<?php echo $item['link']; ?>"><?php echo $item['name']; ?></a>
            <ul class='mega-menu-ul'>
              <?php $index = 0; ?>
              <?php foreach ($item['subcategs'] as $subcateg): ?>
                <?php if (is_numeric($menu_item['maxSubItems']) && $menu_item['maxSubItems'] > 0 && $index >= $menu_item['maxSubItems']) break; ?>
                <li><span></span><a class="mega-menu-sub" data-img="<?php echo $subcateg['image']; ?>" href="<?php echo $subcateg['link']; ?>"><?php echo $subcateg['name']; ?></a></li>
              <?php $index++; endforeach; ?>
              <?php if(is_numeric($menu_item['maxSubItems']) && $menu_item['maxSubItems'] > 0 && count($item['subcategs']) > $index): ?>
                <li class="show-more"><span></span><a class="mega-menu-sub" href="<?php echo $item['link']; ?>"><?php echo $menu_item['moreText']; ?></a></li>
              <?php endif; ?>
            </ul>
            <?php if($menu_item['show_images']): ?>
            <img src="<?php echo $item['image']; ?>" alt="" />
            <?php endif; ?>

          </div>
        <?php endforeach; ?>
      </div>
      <?php endif; ?>

      <?php if ($menu_item['type'] === 'brands' && count($menu_item['items'])): ?>
      <div class="brands-menu">
        <?php foreach ($menu_item['items'] as $item): ?>
          <?php $no_image_class = $menu_item['show_images'] ? '' : 'item-no-image'; ?>
          <div class="brands-menu-item <?php echo $no_image_class; ?>">
            <a class="brands-menu-top" href="<?php echo $item['link']; ?>"><?php echo $item['name']; ?></a>
            <?php if($menu_item['show_images']): ?>
            <img src="<?php echo $item['image']; ?>" onclick="location='<?php echo $item['link']; ?>';" />
            <?php endif; ?>
          </div>
        <?php endforeach; ?>
        <div class="clearfix"> </div>
      </div>
      <?php endif; ?>

      <?php if ($menu_item['type'] === 'customblock'): ?>
        <ul class="custom-block-menu">
          <li><?php echo $menu_item['text']; ?></li>
        </ul>
      <?php endif; ?>

      <?php if ($menu_item['type'] === 'simplemenu' && count($menu_item['items'])): ?>
        <ul class="dropdown-menu">
          <?php foreach ($menu_item['items'] as $item): ?>
            <?php if($item['link']): ?>
            <li><a href="<?php echo $item['link']; ?>" <?php echo $item['new_window']; ?>><?php echo $item['name']; ?></a></li>
            <?php else: ?>
            <li><a href="javascript:;" <?php echo $item['new_window']; ?>><?php echo $item['name']; ?></a></li>
            <?php endif; ?>
          <?php endforeach; ?>
        </ul>
      <?php endif; ?>

      <?php if ($menu_item['type'] === 'products' && count($menu_item['items'])): ?>
        <div class="product-menu">
          <?php foreach ($menu_item['items'] as $item): ?>
            <div class="product-menu-item">
              <img src="<?php echo $item['image']; ?>" onclick="location='<?php echo $item['link']; ?>';" />
              <a class="product-menu-name" href="<?php echo $item['link']; ?>" title="<?php echo $item['name']; ?>"><?php echo $item['name']; ?></a>
              <div class="price">
                <?php if (!$item['special']) { ?>
                <?php echo $item['price']; ?>
                <?php } else { ?>
                <div class="sale"></div>
                <span class="price-old"><?php echo $item['price']; ?></span> <span class="price-new"><?php echo $item['special']; ?></span>
                <?php } ?>
              </div>
              <input type="button" class="button" value="<?php echo $item['add_to_cart']; ?>" onclick="addToCart('<?php echo $item['product_id']; ?>')" />
            </div>
          <?php endforeach; ?>
          <div class="clearfix"> </div>
        </div>
      <?php endif; ?>
    </li>
  <?php endforeach; ?>
  </ul>

  <?php if (isset($this->document->journal_mega_menu_animation)): ?>
  <?php if($this->document->journal_mega_menu_animation == '0'): ?>
      <script>
          $(document).ready(function(){
            $('.super-menu > li').hoverIntent( function(){
              console.log('xx');
              if($('.super-menu').hasClass('mobile-nav')) return;
              $('> div, > ul', this).css({'visibility': 'visible','opacity' : '1'});
            }, function(){
              if($('.super-menu').hasClass('mobile-nav')) return;
              $('> div, > ul', this).css({'visibility': 'hidden','opacity' : '0'});
            });
      });
    </script>
  <?php endif;?>
  <?php if($this->document->journal_mega_menu_animation == '1'): ?>
    <script>
        $(document).ready(function(){
          $('.super-menu > li').hoverIntent(function(){
            if($('.super-menu').hasClass('mobile-nav')) return;
            $('> div, > ul', this).hide();
            $('> div, > ul', this).css({'visibility': 'visible','opacity' : '1'});
            $('> div, > ul', this).stop(true, true).slideDown(250);
          }, function(){
            if($('.super-menu').hasClass('mobile-nav')) return;
            $('> div, > ul', this).stop(true, true).slideUp(150);
          });
        });
    </script>
  <?php endif;?>

<?php endif; ?>

</div>
<?php else: ?>
<?php if(
              isset($this->document->journal_categories_menu_extended)
              && $this->document->journal_categories_menu_extended
              && isset($this->document->journal_categories_menu_extended_status)
              && $this->document->journal_categories_menu_extended_status === 'yes'): ?>
      <div id="menu">
      <?php echo print_menu($this->document->journal_categories_menu_extended, false, isset($this->document->journal_mobile_menu_title2) && $this->document->journal_mobile_menu_title2 ? $this->document->journal_mobile_menu_title2 : 'Menu', $is_responsive && $detect->isMobile() && !$detect->isTablet()) ?>
      </div>
      <?php else: ?>
        <?php if ($categories) { ?>
        <div id="menu">
          <ul <?php echo $detect->isMobile() && $is_responsive ? 'class="mobile-nav"' : ''; ?>>
            <li class="open">
             <span class="menu-icon">
                <span></span>
                <span></span>
                <span></span>
              </span>
              <?php echo isset($this->document->journal_mobile_menu_title2) && $this->document->journal_mobile_menu_title2 ? $this->document->journal_mobile_menu_title2 : 'Menu'; ?>
            </li>
            <?php foreach ($categories as $category) { ?>
            <li <?php echo $super_class_hide; ?>>
              <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
              <?php if ($category['children']) { ?>
              <div>
                <?php for ($i = 0; $i < count($category['children']);) { ?>
                <ul>
                  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
                  <?php for (; $i < $j; $i++) { ?>
                  <?php if (isset($category['children'][$i])) { ?>
                  <li>
                    <a href="<?php echo $category['children'][$i]['href']; ?>">
                      <?php echo $category['children'][$i]['name']; ?>
                    </a>
                  </li>
                  <?php } ?>
                  <?php } ?>
                </ul>
                <?php } ?>
              </div>
              <?php } ?>

            </li>
            <?php } ?>
            <?php if(isset($this->document->journal_categories_menu)): ?>
            <?php foreach ($this->document->journal_categories_menu as $menu_item): ?>
            <li>
            <?php $target = $menu_item['new_window'] ? 'target="_blank"' : ''; ?>
            <?php if ($menu_item['href']): ?>
            <a href="<?php echo $menu_item['href']; ?>" <?php echo $target; ?>><?php echo $menu_item['name']; ?></a>
            <?php else: ?>
            <a><?php echo $menu_item['name']; ?></a>
            <?php endif; ?>

            <?php if (count($menu_item['subcategs'])): ?>
            <div>
              <ul>
              <?php foreach ($menu_item['subcategs'] as $submenu_item): ?>
                <li>
                <?php $target = $submenu_item['new_window'] ? 'target="_blank"' : ''; ?>
                <?php if ($submenu_item['href']): ?>
                <a href="<?php echo $submenu_item['href']; ?>" <?php echo $target; ?>> <?php echo $submenu_item['name']; ?></a>
                <?php else: ?>
                <a> <?php echo $submenu_item['name']; ?></a>
                <?php endif; ?>
              </li>
              <?php endforeach; ?>
              </ul>
            </div>
            <?php endif; ?>

            </li>
            <?php endforeach; ?>
            <?php endif; ?>
          </ul>
        </div>
        <?php } ?>
      <?php endif; ?>
<?php endif; ?>



</nav>
</div> <!-- End #journal-header -->

</header>
<div id="container">
  <?php if (isset($error)): ?>
<?php if ($error) { ?>
  <div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php endif; ?>
<div id="notification"></div>