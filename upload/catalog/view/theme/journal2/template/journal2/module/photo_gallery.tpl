<div class="box journal-gallery <?php echo $hide_on_mobile_class; ?> <?php echo $carousel ? 'journal-carousel' : ''; ?> <?php echo isset($arrows) && $arrows === 'top' ? 'arrows-top' : ''; ?>" id="journal-gallery-<?php echo $module; ?>" style="<?php echo isset($css) ? $css : ''; ?>">
    <?php if ($title): ?>
    <div class="box-heading"><?php echo $title; ?></div>
    <?php endif; ?>
    <div class="box-content">
    <?php foreach ($images as $image): ?>
        <div class="gallery-thumb <?php echo !$carousel ? $grid_classes : ''; ?>">
            <a href="<?php echo $image['image']; ?>" style="<?php echo $image_border; ?>" data-thumb="<?php echo $image['thumb']; ?>" class="swipebox" title="<?php echo $image['name']; ?>">
                <div class="item-hover"></div>
                <img src="<?php echo $image['thumb']; ?>" alt="<?php echo $image['name']; ?>" />
            </a>
        </div>
    <?php endforeach; ?>
    </div>
    <?php if ($carousel): ?>
    <?php
        $grid = Journal2Utils::getItemGrid($items_per_row, $this->journal2->settings->get('site_width', 1024), $this->journal2->settings->get('config_columns_count'));
    $grid = array(
        array(0,    $is_column ? 3 : (int)$grid['xs']),
        array(470,  $is_column ? 3 : (int)$grid['sm']),
        array(760,  $is_column ? 3 : (int)$grid['md']),
        array(980,  $is_column ? 3 : (int)$grid['lg']),
        array(1100, $is_column ? 3 : (int)$grid['xl'])
    );
    ?>
    <script>
        (function () {
            var opts = $.parseJSON('<?php echo json_encode($grid); ?>');

            jQuery110("#journal-gallery-<?php echo $module; ?> .box-content").owlCarousel({
                itemsCustom:opts,
                autoPlay: <?php echo $autoplay ? $autoplay : 'false'; ?>,
                touchDrag: <?php echo $touch_drag ? 'true' : 'false'; ?>,
                stopOnHover: <?php echo $pause_on_hover ? 'true' : 'false'; ?>,
                navigation:true,
                scrollPerPage:true,
                navigationText : false,
                slideSpeed: <?php echo $slide_speed; ?>,
                margin:10
            });
            <?php if ($arrows === 'side'): ?>
            $('#journal-gallery-<?php echo $module; ?> .owl-buttons').addClass('side-buttons');
            <?php endif; ?>

            <?php if ($arrows === 'none'): ?>
            $('#journal-gallery-<?php echo $module; ?> .owl-buttons').hide();
            <?php endif; ?>

            <?php if (!$bullets): ?>
            $('#journal-gallery-<?php echo $module; ?> .owl-pagination').hide();
            <?php endif; ?>
        })();
    </script>
    <?php endif; ?>
    <script>
        $(function(){
            $('#journal-gallery-<?php echo $module; ?> .swipebox').swipebox();
        });
    </script>
</div>
