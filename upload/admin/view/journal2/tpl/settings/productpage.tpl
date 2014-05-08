<div class="sticky">
    <div class="module-header">
        <div class='module-name'>Settings<span>Product Page</span></div>

        <skin-manager data-url="settings/general"></skin-manager>

        <div class="module-buttons">
            <?php if (defined('J2ENV')): ?>
            <a class="btn blue" data-ng-show="skin_id < 100" data-ng-click="saveDefault($event)">Export</a>
            <?php endif; ?>
            <!--<a class="btn blue" data-ng-click="multiStore($event)">MultiStore</a>-->
            <a class="btn blue" data-ng-click="saveAs($event)">Save As</a>
            <a class="btn green" data-ng-click="save($event)">Save</a>
            <a class="btn red" data-ng-show="skin_id < 100" data-ng-click="reset($event)">Reset</a>
            <a class="btn red" data-ng-show="skin_id >= 100" data-ng-click="delete($event)">Delete</a>
        </div>
    </div>
</div>

<div class="module-body custom-code">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="accordion.close_others" /></label>
    </div>
    <accordion id="main-accordion" close-others="accordion.close_others">
        <!--General-->
        <accordion-group is-open="accordion.accordions[0]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">General</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Page Split Ratio <small>Left Side / Right Side</small></span>
                        <span class="module-create-option">
                <switch data-ng-model="settings.split_ratio">
                    <switch-option key="split-70-30">70/30</switch-option>
                    <switch-option key="split-60-40">60/40</switch-option>
                    <switch-option key="split-50-50">50/50</switch-option>
                    <switch-option key="split-40-60">40/60</switch-option>
                    <switch-option key="split-30-70">30/70</switch-option>
                </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>

        <!--Product Image-->
        <accordion-group is-open="accordion.accordions[1]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Product Image</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Border Settings <small>Main Product Image</small></span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_image_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Border Settings <small>Additional Images</small></span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.product_page_additional_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Additional Image Width <small>Images Per Row</small></span>
                    <span class="module-create-option">
                        <j-opt-slider data-ng-model="settings.product_page_additional_width" data-range="1,8" data-step="1"></j-opt-slider>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Additional Images Spacing</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.product_page_additional_spacing" class="journal-number-field"></j-opt-text>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Cloud Zoom</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.product_page_cloud_zoom">
                                <switch-option key="1">ON</switch-option>
                                <switch-option key="0">OFF</switch-option>
                            </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Product Gallery</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.product_page_gallery">
                                <switch-option key="1">ON</switch-option>
                                <switch-option key="0">OFF</switch-option>
                            </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li data-ng-show="settings.product_page_gallery == '1'">
                    <span class="module-create-title">Gallery Text</span>
                        <span class="module-create-option">
                            <j-opt-text-lang data-ng-model="settings.product_page_gallery_text"></j-opt-text-lang>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.product_page_gallery == '1'">
                    <span class="module-create-title">Gallery Text Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_gallery_text_font"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li data-ng-show="settings.product_page_gallery == '1'">
                    <span class="module-create-title">Gallery Text Icon</span>
                        <span class="module-create-option">
                            <j-opt-icon data-ng-model="settings.product_page_gallery_text_icon"></j-opt-icon>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Carousel Mode</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_page_gallery_carousel">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-hide="settings.product_page_gallery_carousel == '0'">
                    <span class="module-create-title">Carousel Autoplay</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_page_gallery_carousel_autoplay">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-hide="settings.product_page_gallery_carousel == '0' || settings.product_page_gallery_carousel_autoplay == '0'">
                    <span class="module-create-title">Pause on Hover</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_page_gallery_carousel_pause_on_hover">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1' && settings.product_page_gallery_carousel_autoplay == '1'">
                    <span class="module-create-title">Transition Delay</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.product_page_gallery_carousel_transition_delay" class="journal-number-field"></j-opt-text>
                    </span>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Transition Speed</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.product_page_gallery_carousel_transition_speed" class="journal-number-field"></j-opt-text>
                    </span>
                </li>
                <li data-ng-hide="settings.product_page_gallery_carousel == '0'">
                    <span class="module-create-title">Touch Drag</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_page_gallery_carousel_touch_drag">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                <span class="module-create-title">Carousel Arrows</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.product_page_gallery_carousel_arrows">
                            <switch-option key="hover">Hover</switch-option>
                            <switch-option key="always">Always</switch-option>
                            <switch-option key="never">Never</switch-option>
                        </switch>
                    </span>
                <a href="#" target="_blank" class="journal-tip"></a>
            </li>

                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Carousel Arrow Left</span>
                        <span class="module-create-option">
                            <j-opt-icon data-ng-model="settings.product_page_gallery_carousel_icon_left"></j-opt-icon>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Carousel Arrow Right</span>
                        <span class="module-create-option">
                            <j-opt-icon data-ng-model="settings.product_page_gallery_carousel_icon_right"></j-opt-icon>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>


                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Arrows Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.product_page_gallery_carousel_icon_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Buttons Background</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.product_page_gallery_carousel_icon_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Buttons Background Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.product_page_gallery_carousel_icon_bg_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Buttons Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.product_page_gallery_carousel_icon_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Vertical Offset</span>
                        <span class="module-create-option">
                            <j-opt-text data-ng-model="settings.product_page_gallery_carousel_icon_offset" class="journal-number-field"></j-opt-text>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li data-ng-show="settings.product_page_gallery_carousel == '1'">
                    <span class="module-create-title">Buttons Size <small>Width x Height</small></span>
                        <span class="module-create-option">
                            <j-opt-text data-ng-model="settings.product_page_gallery_carousel_icon_width" class="journal-number-field"></j-opt-text> x
                            <j-opt-text data-ng-model="settings.product_page_gallery_carousel_icon_height" class="journal-number-field"></j-opt-text>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>


                <!--Product Labels-->

                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Product Labels</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Latest Label</span>
                                <span class="module-create-option">
                                    <switch data-ng-model="settings.product_page_latest_label_status">
                                        <switch-option key="block">ON</switch-option>
                                        <switch-option key="none">OFF</switch-option>
                                    </switch>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>
                            <li>
                                <span class="module-create-title">Special Label</span>
                                <span class="module-create-option">
                                    <switch data-ng-model="settings.product_page_special_label_status">
                                        <switch-option key="block">ON</switch-option>
                                        <switch-option key="none">OFF</switch-option>
                                    </switch>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>
                            <li>
                                <span class="module-create-title">Out of Stock</span>
                                <span class="module-create-option">
                                    <switch data-ng-model="settings.product_page_outofstock_label_status">
                                        <switch-option key="block">ON</switch-option>
                                        <switch-option key="none">OFF</switch-option>
                                    </switch>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>
                        </ul>
                    </accordion-group>
                </accordion>

            </ul>
        </accordion-group>
        <!--Product Options-->
        <accordion-group is-open="accordion.accordions[2]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Product Details</div>
            </accordion-heading>
            <ul class="module-create-options">



            <li>
                <span class="module-create-title">Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_options_font"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Links</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_options_links"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Links Hover</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_options_links_hover"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_options_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Item Background Color</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_options_item_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Item Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_options_item_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Item Padding <small>Top - Right - Bottom - Left</small></span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.product_page_options_padding_top" class="journal-sort"></j-opt-text> -
                                <j-opt-text data-ng-model="settings.product_page_options_padding_right" class="journal-sort"></j-opt-text> -
                                <j-opt-text data-ng-model="settings.product_page_options_padding_bottom" class="journal-sort"></j-opt-text> -
                                <j-opt-text data-ng-model="settings.product_page_options_padding_left" class="journal-sort"></j-opt-text>
                            </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Spacing <small>Margin Bottom</small></span>
                        <span class="module-create-option">
                            <j-opt-text data-ng-model="settings.product_page_options_margin" class="journal-number-field"></j-opt-text>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <!--Stats-->

                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Product Stats</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Product Views</span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="settings.product_page_options_views">
                                            <switch-option key="1">ON</switch-option>
                                            <switch-option key="0">OFF</switch-option>
                                        </switch>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li data-ng-show="settings.product_page_options_views == '1'">
                                <span class="module-create-title">Product Views Text</span>
                                    <span class="module-create-option">
                                        <j-opt-text-lang data-ng-model="settings.product_page_options_views_text"></j-opt-text-lang>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">In Stock Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_instock_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Out of Stock Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_outstock_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>


                        </ul>
                    </accordion-group>
                </accordion>

                <!--Price-->
                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Product Price</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Price Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_price_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Old Price Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_old_price_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Old Price Background</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_options_old_price_bg"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Old Price Border Settings</span>
                                    <span class="module-create-option">
                                        <j-opt-border data-ng-model="settings.product_page_options_old_price_border"></j-opt-border>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Ex Tax Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_tax_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Reward Points Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_rewards_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Discounts Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_discount_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>

                <!--Options-->
                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Product Options</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Title Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_title"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Option Group Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_option_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Option Label Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_option_label"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Option Label Font Hover</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_option_label_hover"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Title Background Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_options_title_bg"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <!--<li>-->
                                <!--<span class="module-create-title">Options Divider Color</span>-->
                                    <!--<span class="module-create-option">-->
                                        <!--<j-opt-color data-ng-model="settings.product_page_options_divider"></j-opt-color>-->
                                    <!--</span>-->
                                <!--<a href="#" target="_blank" class="journal-tip"></a>-->
                            <!--</li>-->

                            <li>
                                <span class="module-create-title">Push Select</span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="settings.product_page_options_push_select">
                                            <switch-option key="1">ON</switch-option>
                                            <switch-option key="0">OFF</switch-option>
                                        </switch>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Push Item Radius</span>
                                    <span class="module-create-option">
                                        <j-opt-border data-ng-model="settings.product_page_options_push_border" editor="hide-style"></j-opt-border>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Push Select Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_options_push_select_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Push Background Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_options_push_select_bg"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Push Active Font Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_options_push_select_font_active"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Push Active Background</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_options_push_select_bg_active"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li data-ng-show="settings.product_page_options_push_select == '1'">
                                <span class="module-create-title">Inner Shadow <small>Push Effect</small></span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="settings.product_page_options_push_shadow">
                                            <switch-option key="inset 0 0 8px rgba(0, 0, 0, 0.7)">ON</switch-option>
                                            <switch-option key="none">OFF</switch-option>
                                        </switch>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                        </ul>
                    </accordion-group>
                </accordion>

                <!--Quantity-->
                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Quantity Buttons</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Buttons Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_qty_color"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Buttons Hover Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_qty_hover_color"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Background Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_qty_bg_color"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Background Hover Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_qty_bg_hover_color"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Border Settings</span>
                                    <span class="module-create-option">
                                        <j-opt-border data-ng-model="settings.product_page_qty_border"></j-opt-border>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>

                <!--Button Override-->
                <accordion>
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Add to Cart Button</div>
                        </accordion-heading>
                        <ul class="module-create-options">

                            <li>
                                <span class="module-create-title">Button Font</span>
                                <span class="module-create-option">
                                    <j-opt-font data-ng-model="settings.product_page_button_font"></j-opt-font>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Font Hover Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_button_font_hover"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>


                            <li>
                                <span class="module-create-title">Background Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_button_bg"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>


                            <li>
                                <span class="module-create-title">Background Hover Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_button_bg_hover"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Border Settings</span>
                                    <span class="module-create-option">
                                        <j-opt-border data-ng-model="settings.product_page_button_border"></j-opt-border>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Border Hover Color</span>
                                    <span class="module-create-option">
                                        <j-opt-color data-ng-model="settings.product_page_button_border_hover"></j-opt-color>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Line Height Adjust <small>Vertical Centering</small> </span>
                                <span class="module-create-option">
                                    <j-opt-text data-ng-model="settings.product_page_button_line_height" class="journal-number-field"></j-opt-text>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Button Icon</span>
                                <span class="module-create-option">
                                    <j-opt-icon data-ng-model="settings.product_page_button_icon"></j-opt-icon>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                            <li>
                                <span class="module-create-title">Icon Position</span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="settings.product_page_button_icon_position">
                                            <switch-option key="left">Left</switch-option>
                                            <switch-option key="right">Right</switch-option>
                                        </switch>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>
                            <li>
                                <span class="module-create-title">Inner Shadow <small>Push Effect</small></span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="settings.product_page_button_active_shadow">
                                            <switch-option key="inset 0 1px 10px rgba(0, 0, 0, 0.8)">ON</switch-option>
                                            <switch-option key="none">OFF</switch-option>
                                        </switch>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>

                <!--Wishlist/Compare-->
                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Wishlist Compare</div>
                        </accordion-heading>
                        <ul class="module-create-options">
                            <li>
                                <span class="module-create-title">Font</span>
                                <span class="module-create-option">
                                    <j-opt-font data-ng-model="settings.product_page_wishlist_font"></j-opt-font>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Font Hover Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.product_page_wishlist_font_hover"></j-opt-color>
                                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Background Color</span>
                                        <span class="module-create-option">
                                            <j-opt-color data-ng-model="settings.product_page_wishlist_bg"></j-opt-color>
                                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Wishlist Icon</span>
                                <span class="module-create-option">
                                    <j-opt-icon data-ng-model="settings.product_page_wishlist_icon"></j-opt-icon>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                            <li>
                                <span class="module-create-title">Compare Icon</span>
                                <span class="module-create-option">
                                    <j-opt-icon data-ng-model="settings.product_page_compare_icon"></j-opt-icon>
                                </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>
                        </ul>
                    </accordion-group>
                </accordion>


            </ul>
        </accordion-group>
        <!--Share Plugin-->
        <accordion-group is-open="accordion.accordions[3]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Share Plugin</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Status</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.share_buttons_status">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Background Color</span>
                                <span class="module-create-option">
                                    <j-opt-color data-ng-model="settings.share_buttons_bg"></j-opt-color>
                                </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Disable on mobile</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.share_buttons_disable_on_mobile">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.share_buttons_status == '1'">
                    <span class="module-create-title">Share Buttons</span>
                    <span class="module-create-option">
                        <ul class="simple-list">
                            <li data-ng-repeat="button in settings.share_buttons">
                                <img data-ng-src="{{shareThisButtons[button.id].img}}"/>
                                <select ui-select2="shareThisSelect" data-ng-model="button.id">
                                    <option value="{{b.id}}" data-img="{{b.img}}" data-ng-repeat="b in shareThisButtons">{{b.name}}</option>
                                </select>
                                <a class="btn red delete" href="javascript:;" data-ng-click="removeButton($index)">X</a>
                            </li>
                        </ul>
                        <a href="javascript:;" class="btn blue add-product" data-ng-click="addButton()">Add</a>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.share_buttons_status == '1'">
                    <span class="module-create-title">Buttons Style</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.share_buttons_style">
                            <switch-option key="_hcount">List</switch-option>
                            <switch-option key="_large">Large</switch-option>
                            <switch-option key=" ">Small</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.share_buttons_status == '1'">
                    <span class="module-create-title">Buttons Position</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.share_buttons_position">
                            <switch-option key="bottom">Bottom</switch-option>
                            <switch-option key="left">Left</switch-option>
                            <switch-option key="right">Right</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-show="settings.share_buttons_status == '1'">
                    <span class="module-create-title">Share This Account Key <small>Optional</small></span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.share_buttons_account_key"></j-opt-text>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>
        <!--Product Tabs-->
        <accordion-group is-open="accordion.accordions[4]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Product Tabs</div>
            </accordion-heading>
            <ul class="module-create-options">

                <!--Tabs-->
                <li>
                    <span class="module-create-title">Tabs Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_tabs_font"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tabs Font Hover</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_font_hover"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tabs Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tabs Background Hover</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_bg_hover"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tabs Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_tabs_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Shadow</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.product_page_tabs_shadow">
                                <switch-option key="inset 0 -3px 6px -2px rgba(0, 0, 0, 0.5)">ON</switch-option>
                                <switch-option key="none">OFF</switch-option>
                            </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <!--Tabs Content-->

                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Tabs Content<span>&nbsp; Description</span></div>
                        </accordion-heading>
                        <ul class="module-create-options">

                            <li>
                                <span class="module-create-title">Content Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_tabs_content_font"></j-opt-font>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Headings Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_tabs_content_h_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Content Lists Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_tabs_content_ul_font"></j-opt-font>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Content Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_content_bg"></j-opt-color>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_tabs_content_border"></j-opt-border>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Padding</span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_padding" class="journal-number-field"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Description Line Height</span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tabs_line_height" class="journal-number-field"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>

                <!--Tabs Content Image-->

                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Custom Blocks<span>&nbsp; Image Position</span></div>
                        </accordion-heading>
                        <ul class="module-create-options">

                            <li>
                                <span class="module-create-title">Title Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_tabs_content_image_title_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Content Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_tabs_content_image_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>


                            <li>
                                <span class="module-create-title">Content Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_content_image_bg"></j-opt-color>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_tabs_content_image_border"></j-opt-border>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Padding <small>Top - Right - Bottom - Left</small></span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_image_padding_top" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_image_padding_right" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_image_padding_bottom" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_image_padding_left" class="journal-sort"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Line Height</span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tab_image_line_height" class="journal-number-field"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>

                <!--Tabs Content Options-->

                <accordion close-others="false">
                    <accordion-group is-open="false">
                        <accordion-heading>
                            <div class="accordion-bar bar-level-1">Custom Blocks<span>&nbsp; Options Position</span></div>
                        </accordion-heading>
                        <ul class="module-create-options">

                            <li>
                                <span class="module-create-title">Title Font</span>
                                    <span class="module-create-option">
                                        <j-opt-font data-ng-model="settings.product_page_tabs_content_option_title_font"></j-opt-font>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Content Font </span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.product_page_tabs_content_option_font"></j-opt-font>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>

                            <li>
                                <span class="module-create-title">Content Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.product_page_tabs_content_option_bg"></j-opt-color>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.product_page_tabs_content_option_border"></j-opt-border>
                        </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Content Padding <small>Top - Right - Bottom - Left</small></span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_option_padding_top" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_option_padding_right" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_option_padding_bottom" class="journal-sort"></j-opt-text> -
                                        <j-opt-text data-ng-model="settings.product_page_tabs_content_option_padding_left" class="journal-sort"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"></a>
                            </li>
                            <li>
                                <span class="module-create-title">Line Height</span>
                                    <span class="module-create-option">
                                        <j-opt-text data-ng-model="settings.product_page_tab_options_line_height" class="journal-number-field"></j-opt-text>
                                    </span>
                                <a href="#" target="_blank" class="journal-tip"> </a>
                            </li>

                        </ul>
                    </accordion-group>
                </accordion>
            </ul>
        </accordion-group>

        <!--Product Tags-->
        <accordion-group is-open="accordion.accordions[5]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Product Tags</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                <span class="module-create-title">Title Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.tags_title_font"></j-opt-font>
                        </span>
                <a href="#" target="_blank" class="journal-tip"></a>
            </li>

                <li>
                    <span class="module-create-title">Title Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.tags_title_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tag Font</span>
                        <span class="module-create-option">
                            <j-opt-font data-ng-model="settings.tags_font"></j-opt-font>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Tag Background</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.tags_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tag Font Hover</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.tags_hover_font"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Tag Background Hover</span>
                        <span class="module-create-option">
                            <j-opt-color data-ng-model="settings.tags_hover_bg"></j-opt-color>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tag Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.tags_border"></j-opt-border>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li>
                    <span class="module-create-title">Tags Align</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.tags_align">
                            <switch-option key="left">Left</switch-option>
                            <switch-option key="center">Center</switch-option>
                            <switch-option key="right">Right</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>

        <!--Related Products-->
        <accordion-group is-open="accordion.accordions[6]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Related Products</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Status</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_status">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-hide="settings.related_products_status == '0'">
                    <span class="module-create-title">Products per Row</span>
                    <span class="module-create-option">
                        <j-opt-items-per-row data-range="1,8" data-step="1" data-ng-model="settings.related_products_items_per_row"></j-opt-items-per-row>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-hide="settings.related_products_status == '0'">
                    <span class="module-create-title">Carousel Mode</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                <li data-ng-hide="settings.related_products_carousel == '0' || settings.related_products_status == '0'">
                    <span class="module-create-title">Carousel Arrows</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel_arrows">
                            <switch-option key="none">None</switch-option>
                            <switch-option key="top">Top</switch-option>
                            <switch-option key="side">Side</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-hide="settings.related_products_carousel == '0' || settings.related_products_status == '0'">
                    <span class="module-create-title">Carousel Bullets</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel_bullets">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-hide="settings.related_products_carousel == '0' || settings.related_products_status == '0'">
                    <span class="module-create-title">Carousel Autoplay</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel_autoplay">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-hide="settings.related_products_carousel == '0' || settings.related_products_status == '0' || settings.related_products_carousel_autoplay == '0'">
                    <span class="module-create-title">Pause on Hover</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel_pause_on_hover">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="settings.related_products_carousel == '1' && settings.related_products_status == '1' && settings.related_products_carousel_autoplay == '1'">
                    <span class="module-create-title">Transition Delay</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.related_products_carousel_transition_delay" class="journal-number-field"></j-opt-text>
                    </span>
                </li>
                <li data-ng-show="settings.related_products_carousel == '1' && settings.related_products_status == '1'">
                    <span class="module-create-title">Transition Speed</span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.related_products_carousel_transition_speed" class="journal-number-field"></j-opt-text>
                    </span>
                </li>
                <li data-ng-show="settings.related_products_carousel == '1' && settings.related_products_status == '1'">
                    <span class="module-create-title">Touch Drag</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.related_products_carousel_touch_drag">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
            </ul>
        </accordion-group>
    </accordion>
</div>
