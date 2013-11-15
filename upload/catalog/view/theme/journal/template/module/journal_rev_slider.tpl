<div class="rev-<?php echo $sliderclass; ?>-container <?php echo $rev_slider_class; ?>" id="journal-rev-slider-<?php echo $module; ?>" style="max-height: <?php echo $height; ?>">
	<div class="rev rev-<?php echo $sliderclass; ?> <?php echo $rev_slider_class; ?>">
		<ul style="display: none;">
			<?php foreach ($slider['slides'] as $slide): ?>
			<li <?php echo $slide['data']; ?>>
				<img src="<?php echo $slide['bgimage']; ?>" data-fullwidthcentering="on"  />
				<?php foreach ($slide['captions'] as $caption): ?>
				<div class="<?php echo $caption['cls']; ?> cpt-<?php echo $caption['caption_type']; ?>" <?php echo $caption['data']; ?> <?php echo $caption['css']; ?> >
					<?php if($caption['caption_type'] === 'img'): ?>
						<?php if($caption['caption_url']): ?>
							<?php if($caption['caption_url_new_tab']): ?>
								<a href="<?php echo $caption['caption_url']; ?>" target="_blank"><img src="<?php echo $caption['img']; ?>"></a>
							<?php else: ?>
								<a href="<?php echo $caption['caption_url']; ?>"><img src="<?php echo $caption['img']; ?>"></a>
							<?php endif; ?>
						<?php else: ?>
							<img src="<?php echo $caption['img']; ?>">
						<?php endif; ?>
					<?php elseif($caption['caption_type'] === 'video'): ?>
						<?php if($caption['video_type'] === 'youtube'): ?>
						<iframe src="//www.youtube.com/embed/<?php echo $caption['url']; ?>?hd=1&amp;wmode=opaque&amp;controls=1&amp;showinfo=0" width="<?php echo $caption['video_width']; ?>" height="<?php echo $caption['video_height']; ?>"></iframe>
						<?php elseif($caption['video_type'] === 'vimeo'): ?>
						<iframe src="//player.vimeo.com/video/<?php echo $caption['url']; ?>?title=0&amp;byline=0&amp;portrait=0;api=1" width="<?php echo $caption['video_width']; ?>" height="<?php echo $caption['video_height']; ?>"></iframe>
						<?php else: ?>
						<video class="video-js vjs-default-skin" controls preload="none" width="<?php echo $caption['video_width']; ?>" height="<?php echo $caption['video_height']; ?>" data-setup="{}">
							<source src="<?php echo $caption['url']; ?>.mp4" type='video/mp4' />
							<source src="<?php echo $caption['url']; ?>.webm" type='video/webm' />
							<source src="<?php echo $caption['url']; ?>.ogv" type='video/ogg' />
						</video>
						<?php endif; ?>
					<?php else: ?>
						<?php if($caption['caption_url']): ?>
							<?php if($caption['caption_url_new_tab']): ?>
								<a href="<?php echo $caption['caption_url']; ?>" target="_blank" <?php echo $caption['mouseevents']; ?> ><?php echo $caption['text']; ?></a>
							<?php else: ?>
								<a href="<?php echo $caption['caption_url']; ?>" <?php echo $caption['mouseevents']; ?> ><?php echo $caption['text']; ?></a>
							<?php endif; ?>
						<?php else: ?>
							<?php echo $caption['text']; ?>
						<?php endif; ?>
					<?php endif; ?>
				</div>
				<?php endforeach; ?>
			</li>
			<?php endforeach; ?>
		</ul>
		<div class="tp-bannershadow"></div>
		<div class="tp-thumbs"></div>
		<?php if ($slider_timer === 'top'): ?>
		<div class="tp-bannertimer"></div>
		<?php endif; ?>
		<?php if ($slider_timer === 'bottom'): ?>
		<div class="tp-bannertimer tp-bottom"></div>
		<?php endif; ?>
	</div>
</div>

<script type="text/javascript">
$(function(){
	$('header').after($('#journal-rev-slider-<?php echo $module; ?>'));
	$('#journal-rev-slider-<?php echo $module; ?> div.rev').revolution($.parseJSON('<?php echo json_encode($slider["options"]); ?>'));
	$('#journal-rev-slider-<?php echo $module; ?> div.rev > ul').show();
});
</script>

