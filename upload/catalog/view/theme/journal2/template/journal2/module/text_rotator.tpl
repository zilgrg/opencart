<div class="journal-rotator box text-rotator <?php echo $hide_on_mobile_class; ?> bullets-<?php echo $bullets_position; ?> align-<?php echo $text_align; ?> bullets-<?php echo $bullets ? 'on' : 'off'; ?>" id="journal-rotator-<?php echo $module; ?>" style="<?php echo $rotator_css; ?>; <?php echo isset($css) ? $css : ''; ?>">
    <?php foreach ($sections as $section): ?>
    <div class="quote" style="<?php echo $quote_css; ?>">
        <?php if ($section['image']): ?>
        <img src="image/<?php echo $section['image']; ?>" alt="" class="rotator-image image-<?php echo $image_align; ?>" style="<?php echo $image_css; ?>" />
        <?php endif; ?>
        <span class="rotator-text"><?php echo $section['icon']; ?><?php echo $section['text']; ?></span>
        <?php if ($section['author']): ?>
        <div class="rotator-author" style="<?php echo $author_css; ?>">- <?php echo $section['author']; ?></div>
        <?php endif; ?>
        <div class="clearfix"> </div>
    </div>
    <?php endforeach; ?>
</div>
<script>
    (function () {
        var single_quote = parseInt('<?php echo count($sections); ?>', 10) <= 1;

        $('#journal-rotator-<?php echo $module; ?>').quovolver({
            children        : '.quote',
            equalHeight     : false,
            navPosition     : single_quote ? '' : 'below',
            navNum          : '<?php echo $bullets; ?>' ? true : false,
            pauseOnHover    : false,
            autoPlay        : !single_quote,
            autoPlaySpeed   : '<?php echo $transition_delay; ?>',
            transitionSpeed : 300
        });
    })();
</script>