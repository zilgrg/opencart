<div style="<?php echo $width; ?>" class="tp-banner-container box <?php echo $js_options['hideThumbs'] ? 'nav-on-hover' : '' ?> <?php echo $slider_class; ?> <?php echo $js_options['thumbAmount'] === '' ? 'full-thumbs' : ''; ?> <?php echo $hide_on_mobile_class; ?>">
    <div class="tp-banner" id="journal-slider-<?php echo $module; ?>">
        <ul>
            <?php foreach ($slides as $slide): ?>
            <li <?php echo $slide['data']; ?> >
            <?php if ($preload_images): ?>
            <img src="image/data/journal2/transparent.png" data-lazyload="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>" />
            <?php else: ?>
            <img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>" />
            <?php endif; ?>
            <?php foreach ($slide['captions'] as $caption): ?>
            <div id="jcaption-<?php echo $caption['id']; ?>" class="tp-caption <?php echo $caption['classes']; ?>" style="<?php echo $caption['css']; ?>" <?php echo $caption['data']; ?>>
            <?php echo $caption['content']; ?>
            </div>
            <?php endforeach; ?>
            </li>
            <?php endforeach; ?>
         </ul>
        <?php if ($timer === 'top'): ?>
        <div class="tp-bannertimer"></div>
        <?php elseif ($timer === 'bottom'): ?>
        <div class="tp-bannertimer tp-bottom"></div>
        <?php endif; ?>
    </div>
</div>

<script>
    (function () {
        $('<style><?php echo implode(" ", $global_style); ?></style>').appendTo($('head'));
        var opts = $.parseJSON('<?php echo json_encode($js_options); ?>');
        opts.hideThumbs = 0;
        opts.videoJsPath = 'catalog/view/theme/journal2/lib/rs-plugin/videojs/'
        $('#journal-slider-<?php echo $module; ?>').revolution(opts);
        <?php if ($timer !== 'top' && $timer !== 'bottom'): ?>
        $('#journal-slider-<?php echo $module; ?> .tp-bannertimer').hide();
        <?php endif; ?>
    })();
</script>
