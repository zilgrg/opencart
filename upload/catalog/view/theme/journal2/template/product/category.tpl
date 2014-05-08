<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php echo $column_left; ?><?php echo $column_right; ?>
    <div id="content"><h1 class="heading-title"><?php echo $heading_title; ?></h1><?php echo $content_top; ?>
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
  <?php if($this->journal2->settings->get('refine_category') === 'grid'): ?>
  <div class="refine-images">
      <?php foreach ($this->journal2->settings->get('refine_category_images', array()) as $category): ?>
      <div class="refine-image <?php echo Journal2Utils::getProductGridClasses($this->journal2->settings->get('refine_category_images_per_row'), $this->journal2->settings->get('site_width', 1024), $this->journal2->settings->get('config_columns_count')); ?>">
          <a href="<?php echo $category['href']; ?>"><img style="display: block" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/><span class="refine-category-name"><?php echo $category['name']; ?></span></a>
      </div>
      <?php endforeach; ?>
      <script>
          Journal.equalHeight($(".refine-images .refine-image"), '.refine-category-name');
      </script>
  </div>
  <?php endif; ?>
    <?php if($this->journal2->settings->get('refine_category') === 'carousel'): ?>
    <div id="refine-images" class="owl-carousel">
        <?php foreach ($this->journal2->settings->get('refine_category_images', array()) as $category): ?>
        <div class="refine-image">
            <a href="<?php echo $category['href']; ?>"><img style="display: block" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/><span class="refine-category-name"><?php echo $category['name']; ?></span></a>
        </div>
        <?php endforeach; ?>
    </div>
    <?php
        $grid = Journal2Utils::getItemGrid($this->journal2->settings->get('refine_category_images_per_row'), $this->journal2->settings->get('site_width', 1024), $this->journal2->settings->get('config_columns_count'));
        $grid = array(
            array(0, (int)$grid['xs']),
            array(470, (int)$grid['sm']),
            array(760, (int)$grid['md']),
            array(980, (int)$grid['lg']),
            array(1100, (int)$grid['xl'])
        );
    ?>
    <script>
        (function () {
            var opts = $.parseJSON('<?php echo json_encode($grid); ?>');
            jQuery110("#refine-images").owlCarousel({
                itemsCustom:opts,
                autoPlay:4000,
                navigation:true,
                scrollPerPage:true,
                navigationText : false,
                slideSpeed:400,
                margin:13
            });
            Journal.equalHeight($("#refine-images .refine-image"), '.refine-category-name');
        })();
    </script>
    <?php endif; ?>
  <?php if($this->journal2->settings->get('refine_category') === 'text'): ?>
      <?php if ($categories) { ?>
      <h2 class="refine"><?php echo $text_refine; ?></h2>
      <div class="category-list">
        <ul>
          <?php foreach ($categories as $category) { ?>
          <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
  <?php endif; ?>
  <?php if ($products) { ?>
  <div class="product-filter">
    <div class="display"><b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display('grid');"><?php echo $text_grid; ?></a></div>
    <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
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
  </div>
  <div class="main-products product-list">
    <?php foreach ($products as $product) { ?>
    <div>
      <?php if ($product['thumb']) { ?>
        <div class="image">
            <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
                <img class="first-image" src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
            </a>
            <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
            <?php foreach ($product['labels'] as $label => $name): ?>
            <?php if ($label === 'outofstock'): ?>
            <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
            <?php else: ?>
            <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
            <?php endif; ?>
            <?php endforeach; ?>
            <?php endif; ?>
            <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
            <?php endif; ?>
        </div>
      <?php } else { ?>
        <div class="image">
            <a href="<?php echo $product['href']; ?>">
                <img class="first-image" src="image/data/journal2/no_image_large.jpg" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
            </a>
            <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
            <?php foreach ($product['labels'] as $label => $name): ?>
            <?php if ($label === 'outofstock'): ?>
            <img class="outofstock" style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
            <?php else: ?>
            <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
            <?php endif; ?>
            <?php endforeach; ?>
            <?php endif; ?>
            <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
            <?php endif; ?>
        </div>
      <?php } ?>
      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
      <div class="description"><?php echo $product['description']; ?></div>
      <?php if ($product['price']) { ?>
      <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
        <?php } ?>
        <?php if ($product['tax']) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img width="83" height="15" src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      <div class="cart">
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
      </div>
      <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
      <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
    </div>
    <?php } ?>
  </div>
    <?php if ($this->journal2->settings->get('config_j2sf') === 'on') { ?>
    <script>if ($(location).attr('hash').replace('#/', '').replace('#', '')) { $('.main-products.product-list').html('<div class="sf-loader"><span><?php echo $this->journal2->settings->get('filter_loading_text'); ?></span></div>'); }</script>
    <?php } ?>
  <?php if ($this->journal2->settings->get('product_infinite_scroll') === '1' && $this->journal2->settings->get('product_infinite_scroll_auto_trigger') !== '1'): ?>
  <span id="load-more-btn"><a class="button"><?php echo $this->journal2->settings->get('product_infinite_scroll_button_text'); ?></a></span>
  <?php endif; ?>
  <div class="pagination <?php echo $this->journal2->settings->get('product_infinite_scroll') === '1' ? 'hide' : '' ?>" <?php //echo $this->journal2->settings->get('config_j2sf') === 'on' ? 'style="display: none"' : ''; ?>><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$categories && !$products) { ?>
  <div class="content"><p class="text-empty"><?php echo $text_empty; ?></p></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.main-products.product-grid').attr('class', 'main-products product-list');

		$('.main-products.product-list > div').each(function(index, element) {
            if ($(this).hasClass('sf-loader')) return;
            $(this).attr('class','product-list-item xs-100 sm-100 md-100 lg-100 xl-100').attr('data-respond','start: 150px; end: 300px; interval: 10px;');

            var html = '';

			html += '<div class="left">';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}
            html += '  <div class="name">' + $(element).find('.name').html() + '</div>';

			var price = $(element).find('.price').html();

			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}

			html += '  <div class="description">' + $(element).find('.description').html() + '</div>';

            var rating = $(element).find('.rating').html();

            if (rating != null) {
                html += '<div class="rating">' + rating + '</div>';
            }

            html += '</div>';

            html += '<div class="right">';
            html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
            html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
            html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
            html += '</div>';

			$(element).html(html);
		});

		$('.display').html('<?php echo $this->journal2->settings->get("category_list_view_icon", $text_list); ?> <a onclick="display(\'grid\');"><?php echo $this->journal2->settings->get("category_grid_view_icon", $text_grid); ?></a>');

		$.totalStorage('display', 'list');
	} else {
		$('.main-products.product-list').attr('class', 'main-products product-grid');

		$('.main-products.product-grid > div').each(function(index, element) {
            if ($(this).hasClass('sf-loader')) return;
            $(this).attr('class',"product-grid-item <?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>");

            html = '';

			var image = $(element).find('.image').html();

			if (image != null) {
				html += '<div class="image">' + image + '</div>';
			}

            html += '<div class="product-details">';
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
            html += '<hr>';
			html += '<div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist">' + $(element).find('.cart + .wishlist').html() + '</div>';
			html += '<div class="compare">' + $(element).find('.cart + .wishlist + .compare').html() + '</div>';

            html += '</div>';

            $(element).html('<div class="product-wrapper">'+html+'</div>');
		});

        $('.display').html('<a onclick="display(\'list\');"><?php echo $this->journal2->settings->get("category_list_view_icon", $text_list); ?></a> <?php echo $this->journal2->settings->get("category_grid_view_icon", $text_grid); ?>');

		$.totalStorage('display', 'grid');
	}

    $(window).trigger('list_grid_change');
    Journal.itemsEqualHeight();

    <?php /* enable quickview */ ?>
    <?php if ($this->journal2->settings->get('quickview_status') == '1' && !$this->journal2->mobile_detect->isMobile() && !$this->journal2->mobile_detect->isTablet() && !$this->journal2->html_classes->hasClass("ie8")): ?>
        Journal.enableQuickView();
        Journal.quickViewStatus = true;
    <?php else: ?>
        Journal.quickViewStatus = false;
    <?php endif; ?>
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('<?php echo $this->journal2->settings->get("product_view", "grid"); ?>');
}
//--></script>
<?php echo $footer; ?>