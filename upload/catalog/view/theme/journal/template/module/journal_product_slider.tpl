<?php
  require_once DIR_TEMPLATE . '/journal/template/common/Mobile_Detect.php' ;
  $detect = new Mobile_Detect();
?>
<div class="box product-slider">
	<div class="box-heading"><?php echo $options['header']; ?></div>
	<div class="box-content">
		<ul class="bxslider" id="journal-product-slider-<?php echo $module; ?>" style="min-height: 200px; min-width: 200px;">
			<?php foreach ($products as $product): ?>
			<li>

				<?php if ($product['thumb']) { ?>
				<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
				<?php } ?>
				<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
				<?php if ($product['price']) { ?>
				<div class="price">
					<?php if (!$product['special']) { ?>
					<?php echo $product['price']; ?>
					<?php } else { ?>
					<div class="sale"></div>
					<span class="price-old"><?php echo $product['price']; ?></span>
					<span class="price-new"><?php echo $product['special']; ?></span>
					<?php } ?>
				</div>
				<?php } ?>
				<?php if ($product['rating']) { ?>
				<div class="rating"><img src="catalog/view/theme/journal/images/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
				<?php } ?>
				<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
				<?php if(isset($this->document->journal_quickview_status) && $this->document->journal_quickview_status === 'yes' && !$detect->isMobile()): ?>
				<a class="quickview" href="<?php echo $product['href']; ?>" data-height="510" data-width="700"><?php echo isset($this->document->journal_quickview_button) && $this->document->journal_quickview_button ? $this->document->journal_quickview_button : "Quickview";?></a>
				<?php endif; ?>

			</li>
			<?php endforeach; ?>
		</ul>
	</div>
	<script type="text/javascript">
		(function(){
			$('#journal-product-slider-<?php echo $module; ?>').bxSlider($.parseJSON('<?php echo json_encode($options);?>'));
			$(function(){
				if (!$('html').hasClass('ie8') && $('#journal-product-slider-<?php echo $module; ?> a.quickview').length) {
					$('#journal-product-slider-<?php echo $module; ?> a.quickview').topZIndex().boxer({
						fixed: true,
						customClass: 'quicklook'
					});
				}
			});
		})(jQuery);
	</script>
</div>