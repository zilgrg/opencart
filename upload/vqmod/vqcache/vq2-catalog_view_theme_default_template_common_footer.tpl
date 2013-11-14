<div id="footer">
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
</div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
<div id="powered"><?php echo $powered; ?></div>
<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->
</div>

			<?php
			if ($this->config->get('config_firebug_analyzer') && !headers_sent()) {
				require_once(DIR_SYSTEM . "library/fb.php");
				$time = microtime();
				$time = explode(' ', $time);
				$time = $time[1] + $time[0];
				$finish = $time;
				$start = explode(' ', $GLOBALS['start']);
				$start = $start[1] + $start[0];
				$GLOBALS['total_time'] = round(($finish - $start), 4);
				FB::log('INCREASE PAGE SPEED V4.1 BY HUNTER BUSINESS MANAGEMENT');
				FB::info('Total Database Queries : ' . $this->db->total_queries);
				FB::info('Time Spent Database Querying : ' . round($this->db->total_query_time,4) . ' seconds.');
				if ($this->db->total_slow_queries) {
					FB::error('Slow Database Queries : ' . round($this->db->total_slow_queries, 4));
				}
				FB::info('Page Generation Time : ' . $GLOBALS['total_time'] . ' seconds.');
			
				if ($this->config->get('config_firebug_queries')) {
					FB::log($this->db->query_data);
				}
			}
			?>
			
</body></html>