<?php
//==============================================================================
// Smart Search v156.5
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================

$version = (!defined('VERSION')) ? 140 : (int)substr(str_replace('.', '', VERSION), 0, 3);
$settings = ($version < 151) ? unserialize($this->config->get('smartsearch_data')) : $this->config->get('smartsearch_data');

$this->load->library('user');
$this->user = new User($this->registry);

if (!empty($settings['testing_mode']) && !empty($this->session->data['smartsearch_message']) && $this->user->isLogged()) {
?>
	<script type="text/javascript">
		$(document).ready(function(){
			$('body').prepend('<div style="padding: 10px; text-align: center; font-size: 14px; background: #FF8"><?php echo $this->session->data['smartsearch_message']; ?></div>');
		});
	</script>
<?php
	unset($this->session->data['smartsearch_message']);
}

$query_string = 'search';
if ($version < 155) $query_string = 'filter_name';
if ($version < 150) $query_string = 'keyword';

if ($settings['ajax_search']) {
?>
	<style type="text/css">
		.smartsearch {
			display: none;
			background: <?php echo $settings['ajax_background_color']; ?> !important;
			border: 1px solid <?php echo $settings['ajax_borders_color']; ?> !important;
			border-top: none !important;
			border-radius: 0 0 7px 7px !important;
			box-shadow: 0 2px 2px #DDD !important;
			line-height: 1.2 !important;
			margin: -3px 0 0 2px !important;
			padding: 0 !important;
			position: absolute !important;
			white-space: normal !important;
			width: <?php echo $settings['ajax_width']; ?>px !important;
			z-index: 9999999 !important;
			<?php if ($settings['ajax_top']) { ?>
				top: <?php echo $settings['ajax_top']; ?>px !important;
			<?php } ?>
			<?php if ($settings['ajax_left']) { ?>
				left: <?php echo $settings['ajax_left']; ?>px !important;
			<?php } ?>
			<?php if ($settings['ajax_right']) { ?>
				right: <?php echo $settings['ajax_right']; ?>px !important;
			<?php } ?>
		}
		.smartsearch a {
			white-space: normal !important;
		}
		#search, .searchbox {
			overflow: visible !important;
			z-index: 9999999 !important;
		}
		.smartsearch-product {
			border-bottom: 1px solid <?php echo $settings['ajax_borders_color']; ?> !important;
			color: <?php echo $settings['ajax_font_color']; ?> !important;
			display: block !important;
			font-size: <?php echo $settings['ajax_description_font']; ?>px !important;
			font-weight: normal !important;
			<?php if ($settings['ajax_image_height']) { ?>
				min-height: <?php echo $settings['ajax_image_height']; ?>px !important;
			<?php } ?>
			padding: 5px !important;
			text-decoration: none !important;
		}
		.smartsearch-product img {
			float: left !important;
			margin: 0 10px 0 0 !important;
		}
		.smartsearch-product strong {
			font-size: <?php echo $settings['ajax_product_font']; ?>px !important;
			margin: 5px 5px 5px 0 !important;
		}
		.smartsearch-focus, .smartsearch-product:hover {
			background: <?php echo $settings['ajax_highlight_color']; ?> !important;
			text-decoration: none !important;
		}
		.smartsearch-bottom {
			font-size: 12px !important;
			font-weight: bold !important;
			padding: 10px !important;
			text-align: center !important;
		}
		<?php if ($version < 150) { ?>
			.smartsearch-bottom a {
				color: <?php echo $settings['ajax_font_color']; ?> !important;
			}
		<?php } ?>
		<?php echo $settings['ajax_css']; ?>
	</style>
	<script type="text/javascript">
		var wait;
		var searchinput;
		
		$(document).ready(function(){
			$('<?php echo html_entity_decode($settings['ajax_selector'], ENT_QUOTES, 'UTF-8'); ?>').after('<div class="smartsearch"></div>').blur(function(){
				clearTimeout(wait);
				wait = setTimeout(hideSmartSearch, <?php echo $settings['ajax_delay']; ?>);
			}).keydown(function(e){
				if ($('.smartsearch-product').length && e.which == 38) {
					e.preventDefault();
					return false;
				}
			}).keyup(function(e){
				searchinput = $(this);
				if (!searchinput.val()) {
					clearTimeout(wait);
					wait = setTimeout(hideSmartSearch, <?php echo $settings['ajax_delay']; ?>);
				}
				if (e.which == 13 && $('.smartsearch-focus').length) {
					location = $('.smartsearch-focus').attr('href');
				}
				if (searchinput.val().replace(/^\s+|\s+$/g, '') && (e.which == 8 || (47 < e.which && e.which < 112) || e.which > 185)) {
					clearTimeout(wait);
					wait = setTimeout(showSmartSearch, <?php echo $settings['ajax_delay']; ?>);
				}
				if ($('.smartsearch-product').length && (e.which == 38 || e.which == 40)) {
					if (!$('.smartsearch-focus').length) {
						if (e.which == 38) $('.smartsearch-bottom').prev().addClass('smartsearch-focus');
						if (e.which == 40) $('.smartsearch-product:first-child').addClass('smartsearch-focus');
					} else {
						if (e.which == 38) $('.smartsearch-focus').removeClass('smartsearch-focus').prev('a').addClass('smartsearch-focus');
						if (e.which == 40) $('.smartsearch-focus').removeClass('smartsearch-focus').next('a').addClass('smartsearch-focus');
					}
				}
			});
		});
		
		function showSmartSearch() {
			searchinput.next().html('<div class="smartsearch-bottom"><img src="catalog/view/theme/default/image/loading<?php if ($version < 150) echo '_1'; ?>.gif" /></div>').show();
			$.ajax({
				url: 'index.php?route=module/smartsearch/smartsearch&search=' + encodeURIComponent(searchinput.val()),
				dataType: 'json',
				success: function(data) {
					var html = '';
					if (data.length) {
						for (i = 0; i < data.length; i++) {
							html += '<a class="smartsearch-product" href="' + data[i]['href'] + '&<?php echo $query_string; ?>=' + encodeURIComponent(searchinput.val()) + '">';
							<?php if ($settings['ajax_image_width']) { ?>
								html += '<img src="' + data[i]['image'] + '" />';
							<?php } ?>
							html += '<strong>' + data[i]['name'];
							<?php if ($settings['ajax_model']) { ?>
								html += ' (' + data[i]['model'] + ')';
							<?php } ?>
							<?php if ($settings['ajax_price']) { ?>
								if (data[i]['price']) {
									var price = '<span style="color: <?php echo $settings['ajax_price_color']; ?>;' + (data[i]['special'] ? 'text-decoration: line-through' : '') + '">' + data[i]['price'] + '</span>';
									var special = (data[i]['special'] ? '<span style="color: <?php echo $settings['ajax_special_color']; ?>">' + data[i]['special'] + '</span>' : '');
									html += '<span style="float: right">' + price + ' ' + special + '</span>';
								}
							<?php } ?>
							html += '</strong><br />';
							<?php if ($settings['ajax_description']) { ?>
								html += data[i]['description'];
							<?php } ?>
							html += '</a>';
						}
						<?php if ($settings['ajax_viewall'][$this->session->data['language']]) { ?>
							html += '<div class="smartsearch-bottom"><a href="<?php echo $this->config->get('config_url'); ?>index.php?route=product/search&<?php echo $query_string; ?>=' + encodeURIComponent(searchinput.val()) + '"><?php echo html_entity_decode($settings['ajax_viewall'][$this->session->data['language']], ENT_QUOTES, 'UTF-8'); ?></a></div>';
						<?php } ?>
					} else {
						html = '<div class="smartsearch-bottom"><?php echo html_entity_decode($settings['ajax_noresults'][$this->session->data['language']], ENT_QUOTES, 'UTF-8'); ?></div>';
					}
					searchinput.next().html(html);
				}
			});
		}
		
		function hideSmartSearch() {
			$('.smartsearch').hide();
		}
	</script>
<?php } ?>