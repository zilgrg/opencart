<?php echo $header; ?>
<?php if ($success) { ?>
    <div class="success" style="margin-bottom: 0px;"><?php echo $success; ?></div>
    <script>
        setTimeout(function () {
            $('.success').slideUp();
        }, 2000);
    </script>
<?php } ?>
<?php if ($warning) { ?>
<div class="warning" style="margin-bottom: 0px;"><?php echo $warning; ?></div>
<script>
    setTimeout(function () {
        $('.warning').slideUp();
    }, 2000);
</script>
<?php } ?>
<div id="content" class="journal-content" data-ng-controller="MainController">
<div class="dummy-bg"> </div>
<nav>
    <div class="sticky">
        <a class="set-menu" href="<?php echo $base_href;?>#/home"><div class="logo">Journal <small>v.<?php echo JOURNAL_VERSION; ?></small></div></a>
    </div>
    <ul id="nav">
        <li class="divider">Control Panel</li>
        <li class="first-li cp">
            <a class="set-menu" href="<?php echo $base_href;?>#/settings/general/{{getActiveSkin()}}" data-icon='&#xe094;'>Settings</a>
            <ul data-icon='&#xe61f;'>
                <li>
                    <a href="<?php echo $base_href;?>#/settings/general/{{getActiveSkin()}}" data-icon='&#xe094;'>Global</a>
                    <ul data-icon='&#xe61f;'>
                        <li><a href="<?php echo $base_href;?>#/settings/general/{{getActiveSkin()}}">General</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/pages/{{getActiveSkin()}}">Pages</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/productlabels/{{getActiveSkin()}}">Product Labels</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/notification/{{getActiveSkin()}}">Notification</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/quickview/{{getActiveSkin()}}">Quickview</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/welcome/{{getActiveSkin()}}">Welcome Module</a></li>
                    </ul>
                </li>
                <li>
                    <a href="<?php echo $base_href;?>#/settings/header/{{getActiveSkin()}}" data-icon='&#xe094;'>Header</a>
                    <ul data-icon='&#xe61f;'>
                        <li><a href="<?php echo $base_href;?>#/settings/header/{{getActiveSkin()}}">General</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/headermenus/{{getActiveSkin()}}">Menus</a></li>
                    </ul>
                </li>
                <li><a href="<?php echo $base_href;?>#/settings/footer/{{getActiveSkin()}}">Footer</a></li>
                <li>
                    <a href="<?php echo $base_href;?>#/settings/moduleslider/{{getActiveSkin()}}" data-icon='&#xe094;'>Modules</a>
                    <ul data-icon='&#xe61f;'>
                        <li><a href="<?php echo $base_href;?>#/settings/moduleslider/{{getActiveSkin()}}">Slider</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/modulecarousel/{{getActiveSkin()}}">Carousel</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/modulecustomsections/{{getActiveSkin()}}">Custom Sections</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/modulesuperfilter/{{getActiveSkin()}}">Super Filter</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/modulecmsblocks/{{getActiveSkin()}}">CMS Blocks</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/moduletextrotator/{{getActiveSkin()}}">Text Rotator</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/moduleheadlinerotator/{{getActiveSkin()}}">Headline Rotator</a></li>
                        <li><a href="<?php echo $base_href;?>#/settings/modulephotogallery/{{getActiveSkin()}}">Photo Gallery</a></li>
                    </ul>
                </li>
                <li><a href="<?php echo $base_href;?>#/settings/productgrid/{{getActiveSkin()}}">Product Grid</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/productlist/{{getActiveSkin()}}">Product List</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/productpage/{{getActiveSkin()}}">Product Page</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/category/{{getActiveSkin()}}">Category Page</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/sidecolumn/{{getActiveSkin()}}">Side Column</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/catalog/{{getActiveSkin()}}">Catalog Mode</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/custom_code/{{getActiveSkin()}}">Custom Code</a></li>
                <li><a href="<?php echo $base_href;?>#/settings/system">System & Performance</a></li>
            </ul>
        </li>
        <li class="cp">
            <a class="menu-menu" href="<?php echo $base_href;?>#/menus/primary" data-icon='&#xe094;' >Menus</a>
            <ul data-icon='&#xe61f;'>
                <li><a href="<?php echo $base_href;?>#/menus/primary">Top Menu</a></li>
                <li><a href="<?php echo $base_href;?>#/menus/secondary">Secondary Menu</a></li>
                <li><a href="<?php echo $base_href;?>#/menus/main">Main Menu</a></li>
            </ul>
        </li>
        <li class="cp">
            <a class="foot-menu" href="<?php echo $base_href;?>#/footer/menu" data-icon='&#xe094;' >Footer</a>
            <ul data-icon='&#xe61f;'>
                <li><a href="<?php echo $base_href;?>#/footer/menu">Menu</a></li>
                <li><a href="<?php echo $base_href;?>#/footer/copyright">Copyright</a></li>
                <li><a href="<?php echo $base_href;?>#/footer/payments">Payments</a></li>
            </ul>
        </li>
        <li class="divider">Modules</li>
        <li>
            <a class="slide-menu" href="<?php echo $base_href;?>#/module/simple_slider/all" data-icon='&#xe094;'>Slider</a>
            <ul data-icon='&#xe61f;'>
                <li><a href="<?php echo $base_href;?>#/module/simple_slider/all">Journal</a></li>
                <li><a href="<?php echo $base_href;?>#/module/slider/all">Revolution</a></li>
            </ul>
        </li>
        <li>
            <a class="b-menu" href="<?php echo $base_href;?>#/module/static_banners/all">Banners</a>
        </li>
        <li>
            <a class="car-menu" href="<?php echo $base_href;?>#/module/carousel/all">Carousel</a>
        </li>
        <li>
            <a class="cs-menu" href="<?php echo $base_href;?>#/module/custom_sections/all">Custom Sections</a>
        </li>
        <li>
            <a class="cms-menu" href="<?php echo $base_href;?>#/module/cms_blocks/all">CMS Blocks</a>
        </li>
        <li>
            <a class="sf-menu" href="<?php echo $base_href;?>#/module/super_filter/all">Super Filter</a>
        </li>
        <li>
            <a class="sc-menu" href="<?php echo $base_href;?>#/module/side_category/all">Side Category</a>
        </li>
        <li>
            <a class="tr-menu" href="<?php echo $base_href;?>#/module/text_rotator/all">Text Rotator</a>
        </li>
        <li>
            <a class="hr-menu" href="<?php echo $base_href;?>#/module/headline_rotator/all">Headline Rotator</a>
        </li>
        <li>
            <a class="pg-menu" href="<?php echo $base_href;?>#/module/photo_gallery/all">Photo Gallery</a>
        </li>
        <li>
            <a class="sb-menu" href="<?php echo $base_href;?>#/module/side_blocks/all">Side Blocks</a>
        </li>
        <li>
            <a class="fs-menu" href="<?php echo $base_href;?>#/module/fullscreen_slider/all">Fullscreen Slider</a>
        </li>
        <li>
            <a class="pt-menu" href="<?php echo $base_href;?>#/module/product_tabs/all">Product Tabs</a>
        </li>
        <?php if (defined('J2ENV')): ?>
        <li>
            <a class="cs-menu" href="<?php echo $base_href;?>#/module/multi_modules/all">Multi Modules</a>
        </li>
        <li>
            <a class="cs-menu" href="<?php echo $base_href;?>#/module/newsletter/all">Newsletter</a>
        </li>
        <?php endif; ?>
    </ul>
</nav>

<div class="dummy-module-header"> </div>

<div class="journal-loading"><span>Loading...</span></div>
<div class="border-top"> </div>
<div class="journal-body" data-ng-view>
<div></div>
</div>

<div style="clear: both"></div>

</div>

<script>
    var Journal2Config = $.parseJSON('<?php echo addslashes(json_encode($journal2_config)); ?>');
</script>

<script src="view/journal2/lib/require/require.js" data-main="view/journal2/js/main.js"></script>

<?php echo $footer; ?>

