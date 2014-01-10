<table class="quickcheckout-cart">
	<thead>
		<tr>
		  <td class="image"><?php echo $text_image; ?></td>
		  <td class="name"><?php echo $text_name; ?></td>
		  <td class="quantity"><?php echo $text_quantity; ?></td>
		  <td class="price"><?php echo $text_price; ?></td>
		  <td class="total"><?php echo $text_total; ?></td>
		</tr>
	</thead>
    <?php if ($products || $vouchers) { ?>
	<tbody>
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="image"><?php if ($product['thumb']) { ?>
            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
            <?php } ?></td>
          <td class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <div>
              <?php foreach ($product['option'] as $option) { ?>
              - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
              <?php } ?>
            </div></td>
          <td class="quantity"><?php if ($this->config->get('quickcheckout_edit_cart')) { ?>
		    <input type="text" name="quantity[<?php echo $product['key']; ?>]" size="1" value="<?php echo $product['quantity']; ?>" />
			&nbsp;
			<img src="catalog/view/theme/default/image/quickcheckout-update.png" alt="<?php echo $button_update; ?>" title="<?php echo $button_update; ?>" class="button-update" />&nbsp;
			<a href="<?php echo $product['key']; ?>" class="button-remove"><img src="catalog/view/theme/default/image/quickcheckout-remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a>
			<?php } else { ?>
			x&nbsp;<?php echo $product['quantity']; ?>
			<?php } ?></td>
		  <td class="price"><?php echo $product['price']; ?></td>
          <td class="total"><?php echo $product['total']; ?></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          <td class="image"></td>
          <td class="name"><?php echo $voucher['description']; ?></td>
          <td class="quantity">x&nbsp;1</td>
		  <td class="price"><?php echo $voucher['amount']; ?></td>
          <td class="total"><?php echo $voucher['amount']; ?></td>
        </tr>
        <?php } ?>
		<?php foreach ($totals as $total) { ?>
			<tr>
				<td style="text-align:right;" colspan="4"><b><?php echo $total['title']; ?>:</b></td>
				<td style="text-align:right;"><?php echo $total['text']; ?></td>
			</tr>
        <?php } ?>
	</tbody>
    <?php } ?>
</table>