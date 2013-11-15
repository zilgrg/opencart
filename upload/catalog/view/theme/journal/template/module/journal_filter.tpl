<div class="box">
<div id="journal-filter-<?php echo $module; ?>" class="journal-filter">
	<ul class="ul">
		<?php foreach ($filters as $filter): ?>
			<li>
        <?php $default_filter_class = $default_filter == $filter['key'] ? 'class="default-filter"' : ''; ?>
        <span <?php echo $default_filter_class; ?>>
          <a href="#" data-filter=".<?php echo $filter['key']; ?>"><?php echo $filter['name'];?></a>
        </span>
      </li>
		<?php endforeach; ?>
	</ul>
	<div class="filter-container">
	<div class="product-grid filter-grid">

	<?php foreach ($products as $prod) { $product = $prod['details']; ?>
    <div class="<?php echo $prod['custom_filters']; ?>">
      <?php if (isset($product['thumb'])) { ?>
      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
      <?php } ?>
      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
      <div class="description"><?php echo $product['description']; ?></div>
      <?php if ($product['price']) { ?>
      <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <div class="sale"></div>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
        <?php if ($product['tax']) { ?>
        <br />
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/journal/images/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      <div class="cart">
        <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
      </div>
      <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
      <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
    </div>
    <?php } ?>
  </div>

	</div>
</div>
<script>
$(document).ready(function(){
  var ignore_scroll = $('.default-filter').length > 0;
  var container = $('#journal-filter-<?php echo $module; ?> .filter-container .product-grid');
  container.imagesLoaded(function(){
    container.isotope();
    if (ignore_scroll) {
      $('#journal-filter-<?php echo $module; ?> .default-filter a').click();
    };
  });
  $('#journal-filter-<?php echo $module; ?> ul li a').click(function(){

    $('#journal-filter-<?php echo $module; ?> ul li a').removeClass("selected");
    $('#journal-filter-<?php echo $module; ?> ul li').removeClass("active-filter");
    $(this).addClass("selected");
    $(this).parent().addClass("active-filter");



    <?php if(isset($this->document->journal_fixed_header) && $this->document->journal_fixed_header === 'yes'):?>
    <?php if(isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'yes'):?>
    <?php if ($scrolltop): ?>
    if(!ignore_scroll) {
      $('html, body').animate({scrollTop: $('#journal-filter-<?php echo $module; ?>').offset().top -140}, 900,'easeInOutQuart');
    }
    ignore_scroll = false;
    <?php endif; ?>
    <?php endif; ?>

    <?php if(isset($this->document->journal_larger_logo) && $this->document->journal_larger_logo === 'no'):?>
    <?php if ($scrolltop): ?>
    if(!ignore_scroll) {
      $('html, body').animate({scrollTop: $('#journal-filter-<?php echo $module; ?>').offset().top -120}, 900,'easeInOutQuart');
    }
    ignore_scroll = false;
    <?php endif; ?>
    <?php endif; ?>

    <?php endif; ?>

    <?php if(isset($this->document->journal_fixed_header) && $this->document->journal_fixed_header === 'no'):?>
    <?php if ($scrolltop): ?>
    if(!ignore_scroll) {
      $('html, body').animate({scrollTop: $('#journal-filter-<?php echo $module; ?>').offset().top}, 900,'easeInOutQuart');
    }
    ignore_scroll = false;
    <?php endif; ?>
    <?php endif; ?>

    var selector = $(this).attr('data-filter');
    container.isotope({ filter: selector, animationEngine : 'best-available' });
    return false;
  });

});
</script>
</div>