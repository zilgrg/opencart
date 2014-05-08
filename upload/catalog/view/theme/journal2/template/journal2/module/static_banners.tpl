<div class="box static-banners <?php echo $hide_on_mobile_class; ?>" style="<?php echo isset($css) ? $css : ''; ?>">
    <div>
    <?php if ($title): ?>
    <div class="box-heading"><?php echo $title; ?></div>
    <?php endif; ?>
<?php foreach ($sections as $section): ?>
    <div class="static-banner <?php echo $grid_classes; ?>">
        <?php if ($section['link']): ?>
        <a href="<?php echo $section['link']; ?>" <?php echo $section['target']; ?>><img style="<?php echo $image_border; ?>" src="<?php echo $section['content']; ?>" alt="" /></a>
        <?php else: ?>
        <img style="<?php echo $image_border; ?>" src="<?php echo $section['content']; ?>" alt="" />
        <?php endif; ?>
    </div>
<?php endforeach; ?>
    </div>
</div>