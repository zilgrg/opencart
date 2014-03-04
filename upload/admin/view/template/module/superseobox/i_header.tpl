<?php if($direction == 'rtl'){ /* templ_url */ ?>
<style>
	body *{
		direction: ltr!important;
	}
</style>
<?php } ?>

<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>

	<div class="box">
		<div class="heading">
			<h1 style="color: #0088CC;"><img style="margin-top: -8px;" src="view/stylesheet/superseobox/images/logo-small.png" alt="" /> <?php echo $heading_title; ?> (<?php echo $version; ?>)</h1>
			<div class="pull-right" style="margin-top: 5px;">
			<script class="start_here">
			jQuery(document).ready(function() {
				setTimeout(function(){
					ssb_blink('.start_here');
				}, 1000);
				setTimeout(function(){
					$('.start_here').stop().fadeOut('1000').remove();
				}, 6000);
				
				function ssb_blink(selector) {
					$(selector).fadeOut('1000',function() {
						$(this).fadeIn('1000',function() {
							ssb_blink(this);
						});
					});
				}
			});
			</script>
			<span class="start_here" style="color:red; margin-top:10px; font-size:120%; font-weight:bold;">Start from here >>></span>
			<a class="btn btn-small btn-warning intro-start" data-toggle="tooltip" title="Take this tour to quickly learn about the use of this plugin" >Introduction Tour</a>
			
			<a href="https://www.youtube.com/watch?v=bJ5_sdxMhik&hd=1&vq=hd720" target="_blank" class="btn btn-small btn-warning videotutorial" data-toggle="tooltip" title="Look at the video tutorial" >Videotutorial</a>
			
			<a href="<?php echo $urls['about_info']; ?>" class="btn btn-small btn-info" type="button" data-toggle="modal">About</a>

			<a href="<?php echo $urls['cancel']; ?>" class="btn btn-small" type="button">Exit</a>
			</div>
		</div>
		<div class="content">