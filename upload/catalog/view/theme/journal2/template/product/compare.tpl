<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content" class="compare">
    <h1 class="heading-title"><?php echo $heading_title; ?></h1>

    <?php echo $content_top; ?>
  <?php if ($products) { ?>
  <table class="compare-info">
    <thead>
      <tr>
        <td class="compare-product" colspan="<?php echo count($products) + 1; ?>"><?php echo $text_product; ?></td>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><?php echo $text_name; ?></td>
        <?php foreach ($products as $product) { ?>
        <td class="name"><a href="<?php echo $products[$product['product_id']]['href']; ?>"><?php echo $products[$product['product_id']]['name']; ?></a></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_image; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php if ($products[$product['product_id']]['thumb']) { ?>
          <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" />
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_price; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php if ($products[$product['product_id']]['price']) { ?>
          <?php if (!$products[$product['product_id']]['special']) { ?>
          <?php echo $products[$product['product_id']]['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?></span> <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
          <?php } ?>
          <?php } ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_model; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['model']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_manufacturer; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['manufacturer']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_availability; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['availability']; ?></td>
        <?php } ?>
      </tr>
      <?php if (isset($review_status)): /* v1541 compatibility */ ?>
	  <?php if ($review_status) { ?>
      <tr>
        <td><?php echo $text_rating; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><img width="83" height="15" src="catalog/view/theme/default/image/stars-<?php echo $products[$product['product_id']]['rating']; ?>.png" alt="<?php echo $products[$product['product_id']]['reviews']; ?>" /><br />
          <?php echo $products[$product['product_id']]['reviews']; ?></td>
        <?php } ?>
      </tr>
      <?php } ?>
      <?php endif; /* end v1541 compatibility */ ?>
	  <tr>
        <td><?php echo $text_summary; ?></td>
        <?php foreach ($products as $product) { ?>
        <td class="description"><?php echo $products[$product['product_id']]['description']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_weight; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['weight']; ?></td>
        <?php } ?>
      </tr>
      <tr>
        <td><?php echo $text_dimension; ?></td>
        <?php foreach ($products as $product) { ?>
        <td><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
        <?php } ?>
      </tr>
    </tbody>
    <?php foreach ($attribute_groups as $attribute_group) { ?>
    <thead>
      <tr>
        <td class="compare-attribute" colspan="<?php echo count($products) + 1; ?>"><?php echo $attribute_group['name']; ?></td>
      </tr>
    </thead>
    <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
    <tbody>
      <tr>
        <td><?php echo $attribute['name']; ?></td>
        <?php foreach ($products as $product) { ?>
        <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
        <td><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
        <?php } else { ?>
        <td></td>
        <?php } ?>
        <?php } ?>
      </tr>
    </tbody>
    <?php } ?>
    <?php } ?>
    <tr class="compare-cart">
      <td></td>
      <?php foreach ($products as $product) { ?>
      <td>
        <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
        <div class="cart enquiry-button">
          <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
        </div>
        <?php else: ?>
        <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
          <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
        </div>
        <?php endif; ?>
      </td>
      <?php } ?>
    </tr>
    <tr>
      <td></td>
      <?php foreach ($products as $product) { ?>
      <td class="remove"><a href="<?php echo $product['remove']; ?>" class="button"><?php echo $button_remove; ?></a></td>
      <?php } ?>
    </tr>
  </table>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } else { ?>
  <div class="content"><p class="text-empty"><?php echo $text_empty; ?><p></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>