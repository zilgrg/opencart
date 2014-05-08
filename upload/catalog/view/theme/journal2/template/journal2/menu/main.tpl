<?php
    function renderMultiLevelMenu($menu) {
        $html = '';
        if (isset($menu['subcategories']) && is_array($menu['subcategories'])) {
            foreach ($menu['subcategories'] as $menu_item) {
                $submenu = renderMultiLevelMenu($menu_item);
                $html .= '<li>';
                $span = $submenu ? ' <i class="menu-plus"></i>' : '';
                if ($menu_item['href']) {
                    $html .= '<a href="' . $menu_item['href'] . '">' . $menu_item['name'] . $span . '</a>';
                } else {
                    $html .= '<a>' . $menu_item['name'] . $span . '</a>';
                }
                if ($submenu) {
                    $html .= ' <span class="mobile-plus">+</span>';
                }
                $html .= $submenu;
                $html .= '</li>';
            }
        }
        return $html ? '<ul>' . $html . '</ul>' : '';
    }
?>
<div class="mobile-trigger"><?php echo $this->journal2->settings->get('mobile_menu_text'); ?></div>
<ul class="super-menu mobile-menu menu-<?php echo $display; ?>" style="table-layout: <?php echo $table_css_style; ?>">
    <?php foreach ($menu_items as $menu_item): ?>
    <li class="<?php echo $menu_item['type']; ?> <?php echo $menu_item['class']; ?>">
        <?php if ($menu_item['href']): ?>
        <a href="<?php echo $menu_item['href']; ?>"><?php echo $menu_item['icon']; ?><?php if (!$menu_item['hide_text']): ?><span class="main-menu-text"><?php echo $menu_item['name']; ?></span><?php endif; ?></a>
        <?php else: ?>
        <a><?php echo $menu_item['icon']; ?><?php if (!$menu_item['hide_text']): ?><span class="main-menu-text"><?php echo $menu_item['name']; ?></span><?php endif; ?></a>
        <?php endif; ?>
        <?php if ($menu_item['type'] === 'mega-menu-categories' && $menu_item['items']): ?>
        <div class="mega-menu">
            <div>
            <?php foreach($menu_item['items'] as $submenu_item): ?>
            <div class="mega-menu-item <?php echo $menu_item['classes']; ?> <?php echo $menu_item['show_class']; ?>">
                <div>
                    <h3><a href="<?php echo $submenu_item['href']; ?>"><?php echo $submenu_item['name']; ?></a></h3>
                    <?php if (in_array($menu_item['show'], array('image', 'both'))): ?>
                    <a href="<?php echo $submenu_item['href']; ?>"><img src="<?php echo $submenu_item['image']; ?>" data-default-src="<?php echo $submenu_item['image']; ?>" alt="<?php echo $submenu_item['name']; ?>"/></a>
                    <?php endif; ?>
                    <?php if (in_array($menu_item['show'], array('links', 'both'))): ?>
                    <ul>
                        <?php $index = 0; foreach ($submenu_item['items'] as $sub2menu_item): if ($menu_item['limit'] && $menu_item['limit'] <= $index) continue; $index++; ?>
                        <li data-image="<?php echo $sub2menu_item['image']; ?>"><a href="<?php echo $sub2menu_item['href']; ?>"><?php echo $sub2menu_item['name']; ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                    <?php endif; ?>
                    <span class="clearfix"> </span>
                </div>
            </div>
            <?php endforeach; ?>
            </div>
            <span class="clearfix"> </span>
        </div>
        <span class="clearfix"> </span>

        <?php endif; ?>
        <?php if ($menu_item['type'] === 'mega-menu-products' && $menu_item['items']): ?>
        <div class="mega-menu">
            <div>
            <?php $index = 0; foreach($menu_item['items'] as $submenu_item): if ($menu_item['limit'] && $menu_item['limit'] <= $index) continue; $index++; ?>
            <div class="mega-menu-item product-grid-item <?php echo $menu_item['classes']; ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display');?> <?php echo $this->journal2->settings->get('product_grid_button_block_button');?>">
                <div class="product-wrapper">
                    <div class="image">
                        <a href="<?php echo $submenu_item['href']; ?>">
                           <img src="<?php echo $submenu_item['image']; ?>" alt="<?php echo $submenu_item['name']; ?>"/>
                        </a>
                        <?php foreach ($submenu_item['labels'] as $label => $name): ?>
                        <?php if ($label === 'outofstock'): ?>
                        <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
                        <?php else: ?>
                        <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
                        <?php endif; ?>
                        <?php endforeach; ?>
                        <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
                        <div class="wishlist"><a onclick="addToWishList('<?php echo $submenu_item['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                        <div class="compare"><a onclick="addToCompare('<?php echo $submenu_item['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
                        <?php endif; ?>

                    </div>
                    <div class="product-details">
                        <div class="name"><a href="<?php echo $submenu_item['href']; ?>"><?php echo $submenu_item['name']; ?></a></div>
                        <?php if ($submenu_item['price']) { ?>
                        <div class="price">
                            <?php if (!$submenu_item['special']) { ?>
                            <?php echo $submenu_item['price']; ?>
                            <?php } else { ?>
                            <div class="sale"></div>
                            <span class="price-old"><?php echo $submenu_item['price']; ?></span> <span class="price-new"><?php echo $submenu_item['special']; ?></span>
                            <?php } ?>
                        </div>
                        <?php } ?>
                        <?php if ($submenu_item['rating']) { ?>
                        <div class="rating"><img width="83" height="15" src="catalog/view/theme/default/image/stars-<?php echo $submenu_item['rating']; ?>.png" alt="<?php echo $submenu_item['reviews']; ?>" /></div>
                        <?php } ?>
                        <hr>
                        <div class="cart">
                            <a onclick="addToCart('<?php echo $submenu_item['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
                        </div>
                        <div class="wishlist"><a onclick="addToWishList('<?php echo $submenu_item['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                        <div class="compare"><a onclick="addToCompare('<?php echo $submenu_item['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
                    </div>
                </div>
            </div>
            <?php endforeach; ?>
            </div>
            <span class="clearfix"> </span>
        </div>
        <span class="clearfix"> </span>
        <?php endif; ?>
        <?php if ($menu_item['type'] === 'mega-menu-brands' && $menu_item['items']): ?>
        <div class="mega-menu">
            <div>
            <?php foreach($menu_item['items'] as $submenu_item): ?>
            <div class="mega-menu-item <?php echo $menu_item['classes']; ?>">
                <div>
                    <?php if ($submenu_item['show'] !== 'image' && $submenu_item['name']): ?>
                    <h3><a href="<?php echo $submenu_item['href']; ?>"><?php echo $submenu_item['name']; ?></a></h3>
                    <?php endif; ?>
                    <?php if ($submenu_item['show'] !== 'text'): ?>
                    <a href="<?php echo $submenu_item['href']; ?>"> <img src="<?php echo $submenu_item['image']; ?>" alt="<?php echo $submenu_item['name']; ?>"/></a>
                    <?php endif; ?>
                    <ul>
                        <?php foreach ($submenu_item['items'] as $sub2menu_item): ?>
                        <li data-image="<?php echo $sub2menu_item['image']; ?>"><a href="<?php echo $sub2menu_item['href']; ?>"><?php echo $sub2menu_item['name']; ?></a></li>
                        <?php endforeach; ?>
                    </ul>
                    <span class="clearfix"> </span>
                </div>
            </div>
            <?php endforeach; ?>
            </div>
            <span class="clearfix"> </span>
        </div>
        <?php endif; ?>
        <?php if ($menu_item['type'] === 'drop-down'): ?>
        <?php echo renderMultiLevelMenu($menu_item); ?>
        <?php endif; ?>
        <?php if ($menu_item['type'] === 'mega-menu-html'): ?>
        <div class="mega-menu">
            <div>
            <?php foreach ($menu_item['html_blocks'] as $block): ?>
            <div class="mega-menu-item <?php echo $menu_item['classes']; ?>">
                <div>
                <?php if ($block['title']): ?>
                <?php if ($block['link']): ?>
                <h3><a href="<?php echo $block['link']; ?>"><?php echo $block['title']; ?></a></h3>
                <?php else: ?>
                <h3><?php echo $block['title']; ?></h3>
                <?php endif; ?>
                <?php endif; ?>
                <?php if ($block['text']): ?>
                <div class="wrapper">
                    <?php echo $block['text']; ?>
                </div>
                <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
            </div>
            <span class="clearfix"> </span>
        </div>
        <?php endif; ?>
        <span class="mobile-plus">+</span>
    </li>
    <?php endforeach; ?>
</ul>
