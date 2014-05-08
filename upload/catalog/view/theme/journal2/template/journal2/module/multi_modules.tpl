<div class="multi-modules-wrapper <?php echo $disable_mobile; ?>" style="<?php echo isset($css) ? $css : ''; ?>">
    <div class="box multi-modules" style="<?php echo $module_spacing ? 'margin-right: -' . $module_spacing : ''; ?>">
        <?php foreach ($columns as $column): ?>
        <div class="multi-modules-column <?php echo $column['classes']; ?>" style="<?php echo $module_spacing ? 'padding-right: ' . $module_spacing . '; margin-bottom: -' . $module_spacing : ''; ?>">
            <?php foreach ($column['modules'] as $module): ?>
            <div class="multi-modules-row <?php echo $module['class']; ?>" style="<?php echo $module_spacing ? 'margin-bottom: ' . $module_spacing : ''; ?>">
            <?php echo $module['content']; ?>
            </div>
            <?php endforeach; ?>
        </div>
        <?php endforeach; ?>
        <div class="clearfix"> </div>
    </div>
</div>