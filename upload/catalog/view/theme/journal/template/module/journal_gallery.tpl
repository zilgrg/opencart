<div class="box journal-gallery">
	<div class="box-heading"><?php echo $module_name; ?></div>
	<div class="box-content">
		<div id="journal-gallery-<?php echo $module; ?>">
			<?php foreach ($images as $image) { ?>
			<a style="<?php echo $image['visible']; ?>" rel="gallery-module-<?php echo $module; ?>" href="<?php echo $image['popup']; ?>" title="<?php echo $image['caption']; ;?>" class="swipebox">
				<img src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>" title="<?php echo $image['caption']; ;?>" alt="<?php echo $image['caption']; ;?>" />
			</a>
			<?php } ?>
		</div>
	</div>
	<?php if ($border_width): ?>
	<script type="text/javascript">
	(function(){
		var width = '<?php echo $border_width; ?>';
		var color = '#<?php echo $border_color; ?>';
		var speed = <?php echo $border_speed; ?>;
		$('#journal-gallery-<?php echo $module; ?> a').borderEffect({borderColor : color, speed: speed, borderWidth: width});
	})();
	</script>
	<?php endif; ?>
</div>