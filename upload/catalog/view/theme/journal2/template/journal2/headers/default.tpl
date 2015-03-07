<header class="journal-header-default">

    <div class="journal-top-header j-min"></div>

    <div id="header" class="journal-header">

        <div class="journal-logo j-tall xs-100 sm-100 md-33 lg-25 xl-25">
            <?php if ($logo) { ?>
            <div id="logo">
                <a href="<?php echo str_replace($home, 'index.php?route=common/home', ''); ?>">
                    <?php echo Journal2Utils::getLogo($this->config); ?>
                </a>
            </div>
            <?php } ?>
        </div>

        <div class="journal-links j-min xs-100 sm-100 md-66 lg-50 xl-50">
            <div class="links j-min">
                <?php echo $this->journal2->settings->get('config_primary_menu'); ?>
            </div>
        </div>

        <?php if (!Journal2Cache::$mobile_detect->isMobile() || !$this->journal2->settings->get('responsive_design')): ?>
        <div class="journal-cart j-min xs-100 sm-100 md-33 lg-25 xl-25">
            <?php echo $cart; ?>
        </div>
        <?php endif; ?>

        <div class="row journal-login j-min xs-100 sm-100 md-66 lg-50 xl-50">
            <div class="journal-language">
                <?php echo $language; ?>
            </div>
            <div class="journal-currency">
                <?php echo $currency; ?>
            </div>
            <div class="journal-secondary">
                <?php echo $this->journal2->settings->get('config_secondary_menu'); ?>
            </div>
        </div>

        <div class="journal-search row j-min xs-100 sm-100 md-33 lg-25 xl-25">
            <?php if (Front::$IS_OC2): ?>
            <?php echo $search; ?>
            <?php else: ?>
            <div>
                <div id="search" class="j-min">
                    <div class="button-search j-min"><i></i></div>
                    <?php if (isset($filter_name)): /* v1541 compatibility */ ?>
                    <?php if ($filter_name) { ?>
                    <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" autocomplete="off" />
                    <?php } else { ?>
                    <input type="text" name="filter_name" value="<?php echo $text_search; ?>" autocomplete="off" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
                    <?php } ?>
                    <?php else: ?>
                    <input type="text" name="search" placeholder="<?php echo $this->journal2->settings->get('search_placeholder_text'); ?>" value="<?php echo $search; ?>" autocomplete="off" />
                    <?php endif; /* end v1541 compatibility */ ?>
                </div>
            </div>
            <?php endif; ?>
        </div>

        <?php if (Journal2Cache::$mobile_detect->isMobile() && $this->journal2->settings->get('responsive_design')): ?>
        <div class="journal-cart j-min xs-100 sm-100 md-33 lg-25 xl-25">
            <?php echo $cart; ?>
        </div>
        <?php endif; ?>

        <div class="journal-menu j-min xs-100 sm-100 md-100 lg-75 xl-75">
            <?php echo $this->journal2->settings->get('config_mega_menu'); ?>
        </div>
    </div>
    <?php if (Journal2Cache::$mobile_detect->isMobile() && $this->journal2->settings->get('responsive_design')): ?>
    <script>
        if($(window).width() < 980){
            $('.journal-header-default .journal-search').after($('.journal-header-default .journal-cart'));
        }
    </script>
    <?php endif; ?>
</header>