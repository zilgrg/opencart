<?php echo $header; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
<?php echo $column_left; ?><?php echo $column_right; ?>
<?php
  $new_css = false;
  if (isset($this->document->journal_refine_subcategories) && $this->document->journal_refine_subcategories === 'yes'
    && isset($this->document->journal_image_subcategories) && is_array($this->document->journal_image_subcategories)
    && count($this->document->journal_image_subcategories) > 0) {
    $categories = $this->document->journal_image_subcategories;
    $new_css = true;
  }
?>
<div id="content"><?php echo $content_top; ?>

  <h1><?php echo $heading_title; ?></h1>
  <?php if ($thumb || $description) { ?>
  <div class="category-info">
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php if ($categories) { ?>
  <h2 class="refine"><?php echo $text_refine; ?></h2>
  <?php if (isset($this->document->journal_refine_subcategories) && $this->document->journal_refine_subcategories === 'yes'
      && isset($this->document->journal_refine_subcategories_carousel) && $this->document->journal_refine_subcategories_carousel === 'yes'): ?>
    <div class="flexslider flexslider-refined">
    <ul class="slides">
      <?php foreach ($categories as $category) { ?>
      <?php if (isset($category['thumb']) && $category['thumb']): ?>
      <li><a href="<?php echo $category['href']; ?>"><img class="subcateg-thumb" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" /><?php echo $category['name']; ?></a></li>
      <?php else: ?>
      <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php endif; ?>
      <?php } ?>

      <?php if(count($categories) == 1): $category = $categories[0]; ?>
      <?php if (isset($category['thumb']) && $category['thumb']): ?>
      <li style="display: none !important;"><a href="<?php echo $category['href']; ?>"><img class="subcateg-thumb" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" /><?php echo $category['name']; ?></a></li>
      <?php else: ?>
      <li style="display: none !important;"><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php endif; ?>
      <?php endif; ?>

    </ul>
  </div>
  <script type="text/javascript">


    $('.flexslider-refined').flexslider({
      animation: "slide",
      animationLoop: false,
      itemWidth: parseInt(<?php echo $this->document->journal_refine_categories_image_width + $this->document->journal_refine_categories_image_margins + 12; ?>),
      controlNav: false,
      maxItems: 0,
      slideshow: false,
    });


  </script>
  <?php else: ?>
  <div class="category-list">
    <span> </span>
    <?php if (count($categories) <= 5) { ?>
    <ul>
      <?php foreach ($categories as $category) { ?>
      <?php if (isset($category['thumb']) && $category['thumb']): ?>
      <li><a href="<?php echo $category['href']; ?>"><img class="subcateg-thumb" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>" title="<?php echo $category['name']; ?>" /><?php echo $category['name']; ?></a></li>
      <?php else: ?>
      <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php endif; ?>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <?php for ($i = 0; $i < count($categories);) { ?>
    <ul>
      <?php $j = $i + ceil(count($categories) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($categories[$i])) { ?>
      <?php if (isset($categories[$i]['thumb']) && $categories[$i]['thumb']): ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><img class="subcateg-thumb" src="<?php echo $categories[$i]['thumb']; ?>" alt="<?php echo $categories[$i]['name']; ?>" title="<?php echo $categories[$i]['name']; ?>" /><?php echo $categories[$i]['name']; ?></a></li>
      <?php else: ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
      <?php endif; ?>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  </div>
  <?php endif; ?>
  <?php } ?>
  <?php if ($products) { ?>
  <div class="product-filter">
    <div class="display"><?php echo $text_list; ?> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
    <div class="limit"><b><?php echo $text_limit; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    <div class="sort"><b><?php echo $text_sort; ?></b>
      <select onchange="location = this.value;">
        <?php foreach ($sorts as $sorts) { ?>
        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
  <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
  </div>

  <div class="product-list">
    <?php foreach ($products as $product) { ?>
    <div>
      <?php if ($product['thumb']) { ?>
      <div class="image">
        <a href="<?php echo $product['href']; ?>">
           <div class="product-over"></div>
          <img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
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
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
  <?php if ($new_css): ?>

<style>
    .category-list, .flex-viewport{
      padding:0;
      background-color: transparent;
      overflow:hidden;
      margin-right: -20px;
    }

    .category-list span{
      background-color: transparent
    }

    .category-list ul li:before{
      content:'';
    }

    .category-list ul{
      margin-left: -6px;
    }

    .flex-viewport .slides > li{
        margin-bottom: 16px;
    }

    .category-list ul li{
      margin-bottom: 16px;
      margin-right:<?php echo $this->document->journal_refine_categories_image_margins; ?>px;
    }

    .category-list ul li a, .flex-viewport .slides > li > a{
      font-weight: bold;
      text-align: center;
      border-width: 1px;
      border-style: solid;
      padding:5px 5px 6px 5px;
      min-height: 115px;
      overflow:hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      max-width: <?php echo $this->document->journal_refine_categories_image_width + 12; ?>px;
    }

    .flex-viewport .slides > li > a{
      display: block;
    }

    .flex-viewport .slides > li > a > img{
      min-height: <?php echo $this->document->journal_refine_categories_image_width ?>px;
    }

    .category-list ul li {
      height: <?php echo $this->document->journal_refine_categories_image_width + 12; ?>px;
    }

    .subcateg-thumb {
      display: block;
      margin: 0 auto;
      margin-bottom: 5px;
      border-bottom-width: 1px;
      border-bottom-style: solid;
    }
}
</style>
<?php endif; ?>

<?php if(isset($this->document->journal_refine_truncate) && $this->document->journal_refine_truncate === "no"): ?>
<style>
    .category-list ul li a, .flex-viewport a{
      white-space: normal !important;
    }
</style>
<?php endif; ?>

<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid:not(.filter-grid)').attr('class', 'product-list');

		$('.product-list:not(.filter-grid) > div').each(function(index, element) {
			html  = '<div class="right">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';

			html += '<div class="left">';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';

			var rating = $(element).find('.rating').html();

			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}

			html += '</div>';


			$(element).html(html);
		});

		$('.display').html('<span class="active2"><?php echo $text_list; ?></span><span onclick="display(\'grid\');"> <a ><?php echo $text_grid; ?></a></span>');


		$.cookie('display', 'list');
	} else {
		$('.product-list:not(.filter-grid)').attr('class', 'product-grid');

		$('.product-grid:not(.filter-grid) > div').each(function(index, element) {

			html = '';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';

			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			var rating = $(element).find('.rating').html();

			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}

			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.compare').html() + '</div>';

			$(element).html(html);
		});

		$('.display').html('<span onclick="display(\'list\');"> <a ><?php echo $text_list; ?></a></span><span class="active2"><?php echo $text_grid; ?></span>');

		$.cookie('display', 'grid');
	}

    if (typeof(init_quickview) === 'function') {
      init_quickview();
    }


}
view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('grid');
}

$(document).ready(function(){
  function grid_470(){
    if( $(window).width() < 470 ){
      if (view) {
        display('grid');
      } else {
        display('grid');
      }
    }
  }
  grid_470();

  $(window).resize(function(){
    grid_470();
  });
});
//--></script>
<?php echo $footer; ?>