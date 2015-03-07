<div class="journal-fullscreen-slider">
    <?php if ($transparent_overlay): ?>
    <div class="transparent-overlay" style="background-image: url('<?php echo $transparent_overlay; ?>');"></div>
    <?php endif; ?>
    <?php if (is_array($images) && count($images) > 0): ?>
    <script>
        jQuery(function($){
            var opts = {
                transition          : '<?php echo $transition; ?>',
                transition_speed    : parseInt('<?php echo $transition_speed; ?>', 10),
                slide_interval      : parseInt('<?php echo $transition_delay; ?>'),
                slides              : $.parseJSON('<?php echo json_encode($images); ?>')
            }
            $.supersized(opts);
        });
    </script>
    <?php endif; ?>
</div>