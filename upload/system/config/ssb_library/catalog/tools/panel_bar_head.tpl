<?php 
	if (isset($this->request->server['HTTPS']) AND (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
		$pageURL = HTTPS_SERVER;
	}else{
		$pageURL = HTTP_SERVER;
	}
	$panel_box 		= $tools['panel_box'];
	$share_button	= $share_button	= $tools['panel_box']['mode'] == 'button' ? true : false;
	$combination	= $tools['panel_box']['position']['combination'];
	$panel_box_css	= $tools['panel_box']['css'];
	$soc_buttons	= $tools['soc_buttons'];
	$qr_code		= $tools['qr_code'];
	$_SESSION['ssb_page_title'] = $page_title 	= $title;
	$share_image	= $logo;
	$url_get_qr		= $this->url->link('module/superseobox/get_qr');
	$countReader 	= $pageURL . 'catalog/view/javascript/ssb_js/share_qr/sharrre.php';
?>

<?php	
$sharrre_script = $pageURL . 'catalog/view/javascript/ssb_js/share_qr/jquery.sharrre.min.js';
$float_script 	= $pageURL . 'catalog/view/javascript/ssb_js/share_qr/floating-1.12.js';
$tipsy_script	= $pageURL . 'catalog/view/javascript/ssb_js/jquery.tipsy.js';
?>

<?php if($tools['soc_buttons']['status']){ ?>
<script src="<?php echo $sharrre_script; ?>" type="text/javascript" ></script>
<?php }?>
<script src="<?php echo $float_script; ?>" type="text/javascript" ></script>
<script src="<?php echo $tipsy_script; ?>" type="text/javascript" ></script>

<script type="text/javascript">

var shPanelBar = {
	data : {
		pan_box			: <?php echo json_encode($panel_box); ?>,
		panel_box_css	: <?php echo json_encode($panel_box_css); ?>,
		combination		: '<?php echo $combination; ?>',
		combination_orig: '<?php echo $combination; ?>',
		share_button	: <?php echo json_encode($share_button); ?>, 
		soc_buttons		: <?php echo json_encode($soc_buttons); ?>,
		qr_code			: <?php echo json_encode($qr_code); ?>,
		pb_pos			: <?php echo json_encode($panel_box['position']); ?>,
		page_title		: '<?php echo $page_title; ?>',
		share_image		: '<?php echo $share_image; ?>',
		opacity_lev		: <?php echo (float)$panel_box_css['opacity']; ?>,
		pb_orig_pos 	: {},
		url_get_qr 		: '<?php echo $url_get_qr; ?>',
		direction		: '<?php echo $panel_box['position']['direction']; ?>',
		direction_orig	: '<?php echo $panel_box['position']['direction']; ?>'
	},
	
	preparePosParam : function(){
			var pb_pos = shPanelBar.data.pb_pos;
			var pb_pos_prepared = {};
			
			if(pb_pos.targetLeft)	{pb_pos_prepared.targetLeft 	= 0;}
				else{delete shPanelBar.data.pb_pos.targetLeft;}
			
			if(pb_pos.targetRight)	{pb_pos_prepared.targetRight	= 0;}
				else{delete shPanelBar.data.pb_pos.targetRight;}
			
			if(pb_pos.targetTop)	{pb_pos_prepared.targetTop		= 0;}
				else{delete shPanelBar.data.pb_pos.targetTop;}
			
			if(pb_pos.targetBottom)	{pb_pos_prepared.targetBottom	= 0;}
				else{delete shPanelBar.data.pb_pos.targetBottom;}
			
			if(pb_pos.centerX)		{pb_pos_prepared.centerX		= true;}
				else{delete shPanelBar.data.pb_pos.centerX;}
			
			if(pb_pos.centerY)		{pb_pos_prepared.centerY		= true;}
				else{delete shPanelBar.data.pb_pos.centerY;}
			
			$.extend(shPanelBar.data.pb_pos, pb_pos_prepared);
			shPanelBar.data.pb_orig_pos = jQuery.extend(true, {}, shPanelBar.data.pb_pos);
	},
	
	init : function(){
		//alert(JSON.stringify(shPanelBar.data.pb_pos));
		
		var behavior = shPanelBar.data.pan_box.behavior;
		if(behavior.hide && behavior.width_less){
			if($(window).width() < behavior.width_less){
				$('#ssb-share-bar').remove();
				return false;
			}
		}
		shPanelBar.checkSort();
		
		shPanelBar.preparePosParam();
		
		if($('meta[name=pinterest]').length && $('meta[name=pinterest]').attr('content')){
			shPanelBar.data.share_image = $('meta[name=pinterest]').attr('content');
		}

		shPanelBar.addSocialButton();
		
		var pb_pos = shPanelBar.data.pb_pos;

		$('#ssb-share-bar, .ssb-shar-container, .ssb-shar-button').hover(function () {
            $(this).fadeTo('slow', 1.0);
        },
        function () {
            $(this).fadeTo('slow', shPanelBar.data.opacity_lev); 
        });
		
		var time = 1000;
			setTimeout(function(){
			if(pb_pos.centerX || pb_pos.direction == 'horizontal'){
				shPanelBar.data.direction_orig = 'horizontal';
				shPanelBar.changeCSSSharBar('horizontal');
			}else{
				shPanelBar.data.direction_orig = 'vertical';
				shPanelBar.changeCSSSharBar('vertical');
			}
		},time);
		
		if(shPanelBar.data.share_button){
			shPanelBar.makeShareButton();
		}
		
		if(shPanelBar.data.pan_box.animate){
			floatingMenu.add('ssb-share-bar', pb_pos);
		}else{
		//fixed position
			shPanelBar.setShareBarFixed();
			
			if(pb_pos.centerX || pb_pos.centerY){
				$( window ).resize(function() {
					shPanelBar.setShareBarFixed();
				});
			}
		}
		
		if((behavior.move_to || behavior.hide) && behavior.width_less){
			shPanelBar.condition(behavior);
		}
		//alert(shPanelBar.data.share_button);
	},
	
	makeShareButton : function(){
		var $ssb_share_bar 	= $('#ssb-share-bar');
		var $ssb_share_items= $('#ssb-share-bar>div');
		
		//alert($ssb_share_bar.html());
		
		$ssb_share_bar.append('<div class="ssb-shar-button"></div>');
		$ssb_share_bar.append('<div class="ssb-shar-container"></div>');
		$ssb_share_bar.find('.ssb-shar-container').append($ssb_share_items);
		
		//$ssb_share_bar.css
		
		$('.ssb-shar-button').click(function() {
			shPanelBar.animateClickSharBut();
		});
		
		
		shPanelBar.changeCSSSharBut();
		
	},
	
	animateClickSharBut :function(combination){
		var combination = combination ? combination : shPanelBar.data.combination;
		
		var $ssb_shar_container = $('.ssb-shar-container');
		
		var css_hide = {};
		var css_show = {};
		var shift = 58;
		//alert(combination);
		switch(combination)
		{
			case 'lt':
				css_hide.left 	= 0;
				css_show.left 	= shift;
			break;
			case 'ltx':
				css_hide.top 	= 0;
				css_show.top 	= shift;
			break;
			case 'rt':
				css_hide.right 	= 0;
				css_show.right 	= shift;
			break;
			case 'lty':
				css_hide.left 	= 0;
				css_show.left 	= shift;
			break;
			case 'rty':
				css_hide.right 	= 0;
				css_show.right 	= shift;
			break;
			case 'lb':
				css_hide.left 	= 0;
				css_show.left 	= shift;
			break;
			case 'lbx':
				css_hide.bottom 	= 0;
				css_show.bottom = shift;
			break;
			case 'rb':
				css_hide.right 	= 0;
				css_show.right 	= shift;
			break;
		}
		
		css_hide.opacity = 'toggle';
		css_show.opacity = 'toggle';
		
		if($ssb_shar_container.hasClass('pan_show')){
			$ssb_shar_container.removeClass('pan_show');
			animate(css_hide);
		}else{
			$ssb_shar_container.addClass('pan_show');
			//alert(JSON.stringify(css_show));
			animate(css_show);
		}
		
		function animate(css){
			$ssb_shar_container.animate(
				css, {
				duration: 700, 
				specialEasing: {
				opacity: 'linear',
				height: 'swing'
				}
			});
			
		}
	},
	
	changeCSSSharBut :function(combination){
		var combination = combination ? combination : shPanelBar.data.combination;
		
		if(combination == 'original'){
			combination = shPanelBar.data.combination = shPanelBar.data.combination_orig;
		}else{
			shPanelBar.data.combination = combination;
		}
		
		var padding = 5;
		//alert(combination);
		var css = {};
		
		switch(combination)
		{
			case 'lt':
				css.right  	= 'auto';
				css.bottom  = 'auto';
				css.left 	= 0;
				css.top  	= 0;
			break;
			case 'ltx':
				css.left 	= shPanelBar.data.width/2 - 25 + 0;
				css.top  	= 0;
				css.right  	= 'auto';
				css.bottom  = 'auto';
			case 'rt':
				
				css.right 	= 0;
				css.top  	= 0;
			break;
			case 'lty':
				css.left 	= 0;
				if(shPanelBar.data.direction == 'vertical'){
					css.top = shPanelBar.data.height/2 - 25 + 0;
				}else{
					css.top = padding;
				}
			break;
			case 'rty':
				css.right 	= 0;
				if(shPanelBar.data.direction == 'vertical'){
					css.top = shPanelBar.data.height/2 - 25 + 0;
				}else{
				
					css.top = padding;
				}
			break;
			case 'lb':
				css.left 	= 0;
				css.bottom  = 0;
			break;
			case 'lbx':
				css.left 	= shPanelBar.data.width/2 - 25 + padding;
				css.bottom  = 0;
				css.top     = 'auto';
				css.right   = 'auto';
			break;
			case 'rb':
				css.right 	= 0;
				css.bottom  = 0;
			break;
		}
		//alert(JSON.stringify(css));
		$('.ssb-shar-button').css(css);
		
	},
	
	checkSort : function(){
		var $ssb_share_bar 	= $('#ssb-share-bar');
		var soc_buttons 	= shPanelBar.data.soc_buttons.data;
		var qr_code			= shPanelBar.data.qr_code;
		
		var seo_items = [];
		
		$.each(soc_buttons, function(name, val){
			seo_items.push({'name' : name.toLowerCase(), 'sort' : val.data.sort});
		});
		
		seo_items.push({'name' : 'ssb_qr-code', 'sort' : qr_code.data.sort});
		
		seo_items.sort(function(a, b){
			var a1= a.sort, b1= b.sort;
			if(a1== b1) return 0;
			return a1> b1? 1: -1;
		});

		$.each(seo_items, function(i, val){
			var $seo_item = $ssb_share_bar.find('.' + val.name);
			$ssb_share_bar.append($seo_item);
		});
	},
	
	condition : function(behavior){
		//alert(JSON.stringify(behavior));
		
		var width_less = parseInt(behavior.width_less);
		
		checkCondition();
		
		
		$( window ).resize(function() {
			checkCondition();
		});
		
		function checkCondition(){
			
			if(behavior.hide){
			//hide
				if($(window).width() < width_less){
					$('#ssb-share-bar').hide();
				}else{
					$('#ssb-share-bar').show();
				}
			}else if(behavior.move_to){
			//move_to
				//alert($(window).width()+' == '+width_less);
				//alert($(window).width() < width_less);
				if($(window).width() < width_less){
					
					shPanelBar.changeCSSSharBar('horizontal');
				
					var combination = '';
				
					if(!shPanelBar.data.pan_box.animate){
						shPanelBar.data.pb_pos.targetLeft = 0;
						delete shPanelBar.data.pb_pos.targetRight;
						
						shPanelBar.data.pb_pos.centerX = true;
						delete shPanelBar.data.pb_pos.centerY;
	
						if(behavior.move_to == 'top'){
							shPanelBar.data.pb_pos.targetTop = 0;
							combination = 'ltx';
						}else if(behavior.move_to == 'bottom'){
							shPanelBar.data.pb_pos.targetBottom = 0;
							combination = 'lbx';
						}
						shPanelBar.setShareBarFixed();
						
						if(shPanelBar.data.share_button){
							shPanelBar.changeCSSSharBut(combination);
						}
						return;
					}
					
					floatingArray[0].targetLeft		= 0;
					floatingArray[0].targetRight	= undefined;

					floatingArray[0].centerX 		= true;
					floatingArray[0].centerY 		= undefined;
					
					if(behavior.move_to == 'top'){
						floatingArray[0].targetTop		= 0;
						floatingArray[0].targetBottom	= undefined;
						combination = 'ltx';
					}else if(behavior.move_to == 'bottom'){
						floatingArray[0].targetTop		= undefined;
						floatingArray[0].targetBottom	= 0;
						combination = 'lbx';
					}
					
					if(shPanelBar.data.share_button){
						shPanelBar.changeCSSSharBut(combination);
					}

				}else{
					
					var pb_pos = shPanelBar.data.pb_pos;
					shPanelBar.data.direction = shPanelBar.data.direction_orig;
					shPanelBar.changeCSSSharBar(shPanelBar.data.direction);

					if(!shPanelBar.data.pan_box.animate){
						shPanelBar.data.pb_pos = jQuery.extend(true, {}, shPanelBar.data.pb_orig_pos);
						shPanelBar.setShareBarFixed();
						if(shPanelBar.data.share_button){
							shPanelBar.changeCSSSharBut('original');
						}
						return;
					}
				
					floatingArray[0].targetLeft		= pb_pos.targetLeft	;
					floatingArray[0].targetRight	= pb_pos.targetRight;

					floatingArray[0].centerX 		= pb_pos.centerX;
					floatingArray[0].centerY 		= pb_pos.centerY;
					
					floatingArray[0].targetTop		= pb_pos.targetTop;
					floatingArray[0].targetBottom	= pb_pos.targetBottom;
					
					if(shPanelBar.data.share_button){
						shPanelBar.changeCSSSharBut('original');
					}
				}
			}
		}
	},
	
	changeCSSSharBar :function(vector){
		if(vector == 'horizontal'){
			$('#ssb-share-bar').css('width', shPanelBar.data.width+'px');
			$('#ssb-share-bar').css('height', '82px');
			$('#ssb-share-bar, #ssb-share-bar .ssb-shar-container').css('padding', '5px 0');

			$('.sharrre').css('margin', '0 5px 0 5px');
			$('.sharrre div.box').css('margin-bottom', '0px'); 
			shPanelBar.data.direction = 'horizontal';
		}else{
			$('#ssb-share-bar').css('height', shPanelBar.data.height+'px');
			$('#ssb-share-bar').css('width', '52px');
			$('#ssb-share-bar, #ssb-share-bar .ssb-shar-container').css('padding', '5px');
			
			$('.sharrre').css('margin', '0px');
			$('.sharrre div.box').css('margin-bottom', '20px'); 
			shPanelBar.data.direction = 'vertical';
		}
		$('.sharrre div.box:last').css('margin-right', '0px'); 
		$('.sharrre div.box:last').css('margin-bottom', '0px');
	},
	
	setShareBarFixed :function(){

		var pb_pos = shPanelBar.data.pb_pos;
		
		var $ssb_shar_bar = $('#ssb-share-bar');
	
		$ssb_shar_bar.css('position', 'fixed');
		
		if(pb_pos.centerX){
			var shar_bar_w 	= $ssb_shar_bar.width();
			var doc_w = $(window).width();

			var center_x = (doc_w-shar_bar_w)/2;
		}
		if(pb_pos.centerY){
			var shar_bar_h 	= $ssb_shar_bar.height();
			var doc_h 		= $(window).height();
			
			var center_y = (doc_h-shar_bar_h)/2;
		}

		var share_css = {};
		
		if(pb_pos.targetLeft === 0)	{share_css.left 	= '0px';}
		if(pb_pos.targetRight === 0)	{share_css.right 	= '0px';}
		if(pb_pos.targetTop === 0)		{share_css.top 		= '0px';}
		if(pb_pos.targetBottom === 0){share_css.bottom 	= '0px';}
		
		if(center_x){	
			share_css.left 		= center_x + 'px';
			delete share_css.right;
		}

		if(center_y){	
			share_css.top 	= center_y + 'px';
			delete share_css.bottom;
		}
		//alert(JSON.stringify(pb_pos));
		//alert(JSON.stringify(share_css));
		$ssb_shar_bar.css(share_css);
	},
	
	addSocialButton :function(){
		var pb_pos = shPanelBar.data.pb_pos;
		var soc_buttons = shPanelBar.data.soc_buttons;
		var countReader = '<?php echo $countReader; ?>';

		var count_item = 0;
		
		if(soc_buttons.data.Facebook.status){
			addButton('facebook');
		}
		
		if(soc_buttons.data.Google.status){
			addButton('google', 'googlePlus');
		}
		
		
		if(soc_buttons.data.Linkedin.status){
			addButton('linkedin');
		}

		if(soc_buttons.data.Twitter.status){
			$('#ssb-share-bar .twitter').sharrre({
			  share: {
				twitter: true
			  },
			  enableHover: false,
			  enableTracking: true,
			  buttons: { twitter: {via: ''}}, //todo nickname
			  click: function(api, options){
				api.simulateClick();
				api.openPopup('twitter');
			  },
			  urlCurl : countReader
			});
			count_item++;
		}
		
		if(soc_buttons.data.Pinterest.status){
			$('#ssb-share-bar .pinterest').sharrre({
			  share: {
				pinterest: true
			  },
			  enableHover: false,
			  enableTracking: true,
			  buttons: { 
				pinterest: { 
					url: document.location.href, 
					media: shPanelBar.data.share_image,
					description: shPanelBar.data.page_title,
					layout: 'horizontal'
				} 
			  }, 
			  click: function(api, options){
				api.simulateClick();
				api.openPopup('pinterest');
			  },
			  urlCurl : countReader
			});
			count_item++;
		}

		if(soc_buttons.data.Odnoklassniki.status){
			$('.odkl-klass-stat').attr('href', document.location.href); 
			count_item++;
		}
		
		//helper function
		function addButton(button, soc_name){
			if(!soc_name) soc_name = button;
			var share_but = {};
			share_but[soc_name] = true;
			
			$('#ssb-share-bar .' + button).sharrre({
			  share: share_but,
			  enableHover: false,
			  enableTracking: true,
			  click: function(api, options){
				api.simulateClick();
				api.openPopup(soc_name);
			  },
			  urlCurl : countReader
			});
			count_item++;
		}
		
		if(shPanelBar.data.qr_code.status){
			shPanelBar.showQRcode();
			count_item++;
		}
		
		//set height and with of shar box
		shPanelBar.data.height = count_item * 102 - 20; //20 martgin-bottom of the last .box =0
		shPanelBar.data.width  = count_item * 62;
		if(pb_pos.centerX || pb_pos.direction == 'horizontal'){
			$('#ssb-share-bar').css('width', shPanelBar.data.width+'px');
		}else{
			$('#ssb-share-bar').css('height', shPanelBar.data.height+'px');
		}
	},

	showQRcode : function(){
		var combination = shPanelBar.data.combination;
		var pos;
		
		if(combination == 'lt' || combination == 'lb' || combination == 'lty'){
			pos = 'w';
		}else if(combination == 'rt' || combination == 'rb' || combination == 'rty'){
			pos = 'e';
		}else if(combination == 'ltx'){
			pos = 'n';
		}else if(combination == 'lbx'){
			pos = 's';
		}

		$('#ssb-share-bar .ssb_qr-code').tipsy({gravity: pos, html: true,  opacity: 1});
	}
}

jQuery(document).ready(function () {
	shPanelBar.init();
	
});

</script>

<style type="text/css">
.tipsy { font-size: 10px; position: absolute; padding: 5px; z-index: 100000; }
  .tipsy-inner { background-color: #000; color: #FFF; padding: 5px 8px 4px 8px; text-align: center; }

  /* Rounded corners */
  .tipsy-inner { border-radius: 3px; -moz-border-radius: 3px; -webkit-border-radius: 3px; }
  
  /* Uncomment for shadow */
  /*.tipsy-inner { box-shadow: 0 0 5px #000000; -webkit-box-shadow: 0 0 5px #000000; -moz-box-shadow: 0 0 5px #000000; }*/
  
  .tipsy-arrow { position: absolute; width: 0; height: 0; line-height: 0; border: 5px dashed #000; }
  
  /* Rules to colour arrows */
  .tipsy-arrow-n { border-bottom-color: #000; }
  .tipsy-arrow-s { border-top-color: #000; }
  .tipsy-arrow-e { border-left-color: #000; }
  .tipsy-arrow-w { border-right-color: #000; }
  
	.tipsy-n .tipsy-arrow { top: 0px; left: 50%; margin-left: -5px; border-bottom-style: solid; border-top: none; border-left-color: transparent; border-right-color: transparent; }
    .tipsy-nw .tipsy-arrow { top: 0; left: 10px; border-bottom-style: solid; border-top: none; border-left-color: transparent; border-right-color: transparent;}
    .tipsy-ne .tipsy-arrow { top: 0; right: 10px; border-bottom-style: solid; border-top: none;  border-left-color: transparent; border-right-color: transparent;}
  .tipsy-s .tipsy-arrow { bottom: 0; left: 50%; margin-left: -5px; border-top-style: solid; border-bottom: none;  border-left-color: transparent; border-right-color: transparent; }
    .tipsy-sw .tipsy-arrow { bottom: 0; left: 10px; border-top-style: solid; border-bottom: none;  border-left-color: transparent; border-right-color: transparent; }
    .tipsy-se .tipsy-arrow { bottom: 0; right: 10px; border-top-style: solid; border-bottom: none; border-left-color: transparent; border-right-color: transparent; }
  .tipsy-e .tipsy-arrow { right: 0; top: 50%; margin-top: -5px; border-left-style: solid; border-right: none; border-top-color: transparent; border-bottom-color: transparent; }
  .tipsy-w .tipsy-arrow { left: 0; top: 50%; margin-top: -5px; border-right-style: solid; border-left: none; border-top-color: transparent; border-bottom-color: transparent; }


.ssb-shar-container{
	display:none;
	position: absolute;
	padding:5px;
}
<?php 
	$startUrl = HTTP_SERVER;
	if (isset($this->request->server['HTTPS']) AND (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {$startUrl = HTTPS_SERVER;}
?>
.ssb-shar-button{
	position: absolute;
	width:  50px;
	height: 50px;
	background: #000 url('<?php echo $startUrl; ?>image/ssb_image/share-icon-white.png') center center no-repeat;
	
}

/* sharrre */	
.sharrre{
	float:left;
  }
  .sharrre .box a:hover{
	text-decoration:none;
  }
  .sharrre .count {
	color:#525b67;
	display:block;
	font-size:18px;
	font-weight:bold;
	line-height:40px;
	height:40px;
	position:relative;
	text-align:center;
	width:50px;
	-webkit-border-radius:4px;
	-moz-border-radius:4px;
	border-radius:4px;
	border:1px solid #b2c6cc;
	background: #fbfbfb; /* Old browsers */
	background: -moz-linear-gradient(top, #fbfbfb 0%, #f6f6f6 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fbfbfb), color-stop(100%,#f6f6f6)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* IE10+ */
	background: linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fbfbfb', endColorstr='#f6f6f6',GradientType=0 ); /* IE6-9 */
  }
  .sharrre .count:before, .sharrre .count:after {
	content:'';
	display:block;
	position:absolute;
	left:49%;
	width:0;
	height:0;
  }
  .sharrre .count:before {
	border:solid 7px transparent;
	border-top-color:#b2c6cc;
	margin-left:-7px;
	bottom: -14px;
  }
  .sharrre .count:after {
	border:solid 6px transparent;
	margin-left:-6px;
	bottom:-12px;
	border-top-color:#fbfbfb;
  }
  .sharrre .share {
	color:#FFFFFF;
	display:block;
	font-size:12px;
	font-weight:bold;
	height:30px;
	line-height:30px;
	margin-top:8px;
	padding:0;
	text-align:center;
	text-decoration:none;
	width:50px;
	-webkit-border-radius:4px;
	-moz-border-radius:4px;
	border-radius:4px; 
  }  

  
#ssb-share-bar{
	position:absolute;  
    border: 0px;  
    z-index: 10000;
	
	<?php if($panel_box['position']['targetRight']) $panel_box_css['margin'] = -(int)$panel_box_css['margin']; ?>
	margin: <?php echo (int)$panel_box_css['margin']; ?>px;
}
	
#ssb-share-bar <?php if($share_button){ ?>.ssb-shar-container<?php }?>{
	
	padding: 5px 0;
	
	<?php if($panel_box_css['bg_status']) { ?>
	background:<?php echo $panel_box_css['background']; ?>;
	<?php } ?>
	
	-webkit-border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
	-moz-border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
	border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
	
	<?php $opacity = $panel_box_css['opacity'] =='' ? 1 : (float)$panel_box_css['opacity']; ?>;
	-moz-opacity: <?php echo $opacity; ?>;
	opacity: <?php echo $opacity; ?>;
	-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=<?php echo $opacity; ?>);
}
	
	<?php if($share_button){ ?>
	.ssb-shar-button{
		background-color:<?php echo $panel_box_css['background']; ?>;
		
		-webkit-border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
		-moz-border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
		border-radius: <?php echo (int)$panel_box_css['border_r']; ?>px;
		
		<?php if($panel_box['position']['targetRight']) $panel_box_css['margin'] = -(int)$panel_box_css['margin']; ?>
		margin: <?php echo (int)$panel_box_css['margin']; ?>px;
		
		<?php $opacity = $panel_box_css['opacity'] =='' ? 1 : (float)$panel_box_css['opacity']; ?>;
		-moz-opacity: <?php echo $opacity; ?>;
		opacity: <?php echo $opacity; ?>;
		-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=<?php echo $opacity; ?>);
	}
	<?php } ?>

	<?php if($soc_buttons['data']['Twitter']['status']){ ?> 
	#ssb-share-bar .twitter .share {
		text-shadow: 1px 0px 0px #0077be;
		filter: dropshadow(color=#0077be, offx=1, offy=0); 
		border:1px solid #0075c5;
		background: #26c3eb;
		background: -moz-linear-gradient(top, #26c3eb 0%, #26b3e6 50%, #00a2e1 51%, #0080d6 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#26c3eb), color-stop(50%,#26b3e6), color-stop(51%,#00a2e1), color-stop(100%,#0080d6)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* IE10+ */
		background: linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#26c3eb', endColorstr='#0080d6',GradientType=0 ); /* IE6-9 */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #5cd3f1 inset;
	}<?php }?>
	  
	<?php if($soc_buttons['data']['Facebook']['status']){ ?>  
	#ssb-share-bar .facebook .share {
		text-shadow: 1px 0px 0px #26427e;
		filter: dropshadow(color=#26427e, offx=1, offy=0); 
		border:1px solid #24417c;
		background: #5582c9; /* Old browsers */
		background: -moz-linear-gradient(top, #5582c9 0%, #33539a 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#5582c9), color-stop(100%,#33539a)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #5582c9 0%,#33539a 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #5582c9 0%,#33539a 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #5582c9 0%,#33539a 100%); /* IE10+ */
		background: linear-gradient(top, #5582c9 0%,#33539a 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5582c9', endColorstr='#33539a',GradientType=0 ); /* IE6-9 */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #80a1d6 inset;
	}<?php }?>
	 
	<?php if($soc_buttons['data']['Google']['status']){ ?> 
	#ssb-share-bar .google .share {
		font-size: 130%;
		text-shadow: 1px 0px 0px #222222;
		filter: dropshadow(color=#222222, offx=1, offy=0); 
		border:1px solid #262626;
		background: #6d6d6d; /* Old browsers */
		background: -moz-linear-gradient(top, #6d6d6d 0%, #434343 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#6d6d6d), color-stop(100%,#434343)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* IE10+ */
		background: linear-gradient(top, #6d6d6d 0%,#434343 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6d6d6d', endColorstr='#434343',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	 
	<?php if($soc_buttons['data']['Pinterest']['status']){ ?> 
	#ssb-share-bar .pinterest .share {
		font-size: 120%;
		text-shadow: 1px 0px 0px #9B171E;
		filter: dropshadow(color=#9B171E, offx=1, offy=0); 
		border:1px solid #9B171E;
		background: #C51E25; /* Old browsers */
		background: -moz-linear-gradient(top, #E45259 0%, #C51E25 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#C51E25)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #E45259 0%,#C51E25 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #E45259 0%,#C51E25 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #E45259 0%,#C51E25 100%); /* IE10+ */
		background: linear-gradient(top, #E45259 0%,#C51E25 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#C51E25',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	
	<?php if($soc_buttons['data']['Linkedin']['status']){ ?>
	#ssb-share-bar .linkedin .share {
		text-shadow: 1px 0px 0px #666666;
		filter: dropshadow(color=#666666, offx=1, offy=0); 
		border:1px solid #666666;
		background: #757575; /* Old browsers */
		background: -moz-linear-gradient(top, #BBBBBB 0%, #757575 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#757575)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* IE10+ */
		background: linear-gradient(top, #BBBBBB 0%,#757575 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#757575',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	
	<?php if($soc_buttons['data']['Odnoklassniki']['status']){ ?>
	#ssb-share-bar .odnoklassniki .share {
		font-size: 130%;
		text-shadow: 1px 0px 0px #B7610B;
		filter: dropshadow(color=#B7610B, offx=1, offy=0); 
		border:1px solid #B7610B;
		background: #DD750D; /* Old browsers */
		background: -moz-linear-gradient(top, #F59B41 0%, #DD750D 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#DD750D)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* IE10+ */
		background: linear-gradient(top, #F59B41 0%,#DD750D 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#DD750D',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}
	#ssb-share-bar .odnoklassniki span.non-count{
		border:0px!important;
		-moz-opacity: 0;
		opacity: 0;
		-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=0);
	}
	#ssb-share-bar .odnoklassniki .share span.count{
		display: block;
		margin-top: -80px;
		margin-left: -1px;
		text-shadow: 0px 0px #fff;
	}<?php }?>
	
	
	
	
	
	<?php if($qr_code['status']){ ?>
	#ssb-share-bar .ssb_qr-code .count{border: 1px solid #fff;}
	#ssb-share-bar .ssb_qr-code img.count{border: 0px;}
	#ssb-share-bar .ssb_qr-code .share {
		font-size: 120%;
		text-shadow: 1px 0px 0px #2C2C2C;
		filter: dropshadow(color=#2C2C2C, offx=1, offy=0); 
		border:1px solid #4B4B00 ;
		background: #5A5A02 ; /* Old browsers */
		background: -moz-linear-gradient(top, #C2CA04   0%, #5A5A02  100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#5A5A02 )); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* IE10+ */
		background: linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#5A5A02 ',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
</style>