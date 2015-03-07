<div class="sticky">
<div class="module-header">
    <div class='module-name'>Settings<span>Footer</span></div>

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

<div class="module-body footer-options">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="accordion.close_others" /></label>
    </div>
    <accordion id="main-accordion" close-others="accordion.close_others">
        <accordion-group is-open="accordion.accordions[0]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">General</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Boxed Footer</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.fullwidth_footer">
                            <switch-option key="boxed-footer">ON</switch-option>
                            <switch-option key="fullwidth-footer">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_bg_color"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Background Image</span>
                    <span class="module-create-option">
                        <j-opt-background data-ng-model="settings.footer_bg_image"></j-opt-background>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Border Settings</span>
                        <span class="module-create-option">
                            <j-opt-border data-ng-model="settings.footer_border"></j-opt-border>
                        </span>
                        <a href="#" target="_blank" class="journal-tip"> </a>
                    </li>
                    <li>
                        <span class="module-create-title">Top Spacing</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.footer_top_margin">
                                <switch-option key="20">ON</switch-option>
                                <switch-option key="0">OFF</switch-option>
                            </switch>
                        </span>
                        <a href="#" target="_blank" class="journal-tip"> </a>
                    </li>
                    <li>
                        <span class="module-create-title">Bottom Spacing</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.footer_bottom_margin">
                                <switch-option key="20">ON</switch-option>
                                <switch-option key="0">OFF</switch-option>
                            </switch>
                        </span>
                        <a href="#" target="_blank" class="journal-tip"> </a>
                    </li>
                </ul>
            </accordion-group>
        <accordion-group is-open="accordion.accordions[1]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Columns</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Titles Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_titles"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Titles Divider Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_titles_divider"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Titles Divider Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.footer_titles_divider_type">
                            <switch-option key="solid">Solid</switch-option>
                            <switch-option key="dashed">Dashed</switch-option>
                            <switch-option key="dotted">Dotted</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Title Align</span>
                        <span class="module-create-option">
                            <switch data-ng-model="settings.footer_titles_align">
                                <switch-option key="left">Left</switch-option>
                                <switch-option key="center">Center</switch-option>
                                <switch-option key="right">Right</switch-option>
                            </switch>
                        </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Text Links Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_links"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Links Font Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_links_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>


                <accordion-group is-open="true">
                    <accordion-heading>
                        <div class="accordion-bar bar-level-1">HTML Column</div>
                    </accordion-heading>
                    <ul class="module-create-options">
                        <li>
                            <span class="module-create-title">Headings Font <small>H1 - H3 tags</small></span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_html_heading_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Block Font <small>p tag</small></span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_html_p_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Headings Spacing <small>Padding Bottom</small></span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.footer_html_heading_padding" class="journal-number-field"></j-opt-text>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Paragraph  Spacing <small>Padding Bottom</small></span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.footer_html_p_padding" class="journal-number-field"></j-opt-text>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <!--<li>-->
                            <!--<span class="module-create-title">HTML Font Color</span>-->
                    <!--<span class="module-create-option">-->
                        <!--<j-opt-color data-ng-model="settings.html_font_color"></j-opt-color>-->
                    <!--</span>-->
                            <!--<a href="#" target="_blank" class="journal-tip"> </a>-->
                        <!--</li>-->
                        <li>
                            <span class="module-create-title">HTML Text Line Height <small>In pixels</small></span>
                    <span class="module-create-option">
                        <j-opt-text data-ng-model="settings.html_line_height" class="journal-number-field"></j-opt-text>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        </ul>
                    </accordion-group>


                <accordion-group is-open="true">
                    <accordion-heading>
                        <div class="accordion-bar bar-level-1">Product Column</div>
                    </accordion-heading>
                    <ul class="module-create-options">
                        <li>
                            <span class="module-create-title">Image Dimensions</span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.footer_product_image_width" class="journal-number-field"></j-opt-text> x
                                <j-opt-text data-ng-model="settings.footer_product_image_height" class="journal-number-field"></j-opt-text>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Item Padding <small>Spacing between products</small></span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.footer_product_padding" class="journal-number-field"></j-opt-text>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Product Name Overflow </span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.footer_product_name_overflow">
                            <switch-option key="nowrap">ON</switch-option>
                            <switch-option key="normal">OFF</switch-option>
                        </switch>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Name Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_product_name_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Name Font Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_product_name_font_hover"></j-opt-color>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Price Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_product_price_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Old Price Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_product_old_price_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Divider Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_product_divider"></j-opt-color>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Divider Type</span>
                            <span class="module-create-option">
                                <switch data-ng-model="settings.footer_product_divider_type">
                                    <switch-option key="solid">Solid</switch-option>
                                    <switch-option key="dashed">Dashed</switch-option>
                                    <switch-option key="dotted">Dotted</switch-option>
                                </switch>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                    </ul>
                </accordion-group>

                <!--Blog Column-->

                <accordion-group is-open="true">
                    <accordion-heading>
                        <div class="accordion-bar bar-level-1">Blog Post Column</div>
                    </accordion-heading>
                    <ul class="module-create-options">
                        <li>
                            <span class="module-create-title">Image Dimensions</span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.footer_post_image_width" class="journal-number-field"></j-opt-text> x
                                <j-opt-text data-ng-model="settings.footer_post_image_height" class="journal-number-field"></j-opt-text>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Item Padding <small>Spacing between posts</small></span>
                            <span class="module-create-option">
                                <j-opt-text data-ng-model="settings.footer_post_padding" class="journal-number-field"></j-opt-text>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Post Title Overflow </span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.footer_post_name_overflow">
                            <switch-option key="nowrap">ON</switch-option>
                            <switch-option key="normal">OFF</switch-option>
                        </switch>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Post Title Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.footer_post_name_font"></j-opt-font>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Post Title Font Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_post_name_font_hover"></j-opt-color>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Date Font</span>
                            <span class="module-create-option">
                                <j-opt-font data-ng-model="settings.footer_post_price_date"></j-opt-font>
                            </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Date Icon Color</span>
                                <span class="module-create-option">
                                    <j-opt-color data-ng-model="settings.footer_post_date_icon_color"></j-opt-color>
                                </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                        <li>
                            <span class="module-create-title">Comments Icon Color</span>
                                <span class="module-create-option">
                                    <j-opt-color data-ng-model="settings.footer_post_comment_icon_color"></j-opt-color>
                                </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>


                        <li>
                            <span class="module-create-title">Divider Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_post_divider"></j-opt-color>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>

                        <li>
                            <span class="module-create-title">Divider Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.footer_post_divider_type">
                            <switch-option key="solid">Solid</switch-option>
                            <switch-option key="dashed">Dashed</switch-option>
                            <switch-option key="dotted">Dotted</switch-option>
                        </switch>
                    </span>
                            <a href="#" target="_blank" class="journal-tip"> </a>
                        </li>
                    </ul>
                </accordion-group>
                    </ul>
            </accordion-group>
        <accordion-group is-open="accordion.accordions[2]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Contacts Bar</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.contacts_bar_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Icon Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.contacts_icon_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Icon Background Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.contacts_icon_bg_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Icon Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.contacts_icon_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Bar Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.contacts_bar_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Contacts Bar Shadow</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.contacts_bar_shadow">
                            <switch-option key="none">OFF</switch-option>
                            <switch-option key="0 0 7px rgba(0,0,0,.4)">Normal</switch-option>
                            <switch-option key="0 0px 10px 1px rgba(0, 0, 0, 0.05)">Soft</switch-option>

                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Center Icons Display</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.contacts_display">
                            <switch-option key="on">ON</switch-option>
                            <switch-option key="off">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Text Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.contacts_text_font"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                <li>
                    <span class="module-create-title">Text Link Hover</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.contacts_text_font_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                 <li>
                    <span class="module-create-title">Tooltip Font Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.footer_tooltip_font"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
                 <li>
                    <span class="module-create-title">Tooltip Background Color</span>
                            <span class="module-create-option">
                                <j-opt-color data-ng-model="settings.footer_tooltip_bg_color"></j-opt-color>
                            </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>

                 <li>
                    <span class="module-create-title">Tooltip Border Radius</span>
                            <span class="module-create-option">
                                <j-opt-border data-ng-model="settings.footer_tooltip_border" editor="hide-style"></j-opt-border>
                            </span>
                    <a href="#" target="_blank" class="journal-tip"></a>
                </li>
            </ul>
        </accordion-group>
        <accordion-group is-open="accordion.accordions[3]">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Bottom Bar</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Copyright Font</span>
                    <span class="module-create-option">
                        <j-opt-font data-ng-model="settings.copyright_font_settings"></j-opt-font>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Copyright Link Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.copyright_link"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Copyright Link Hover Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.copyright_link_hover"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>

                <li>
                    <span class="module-create-title">Bar Background Color</span>
                    <span class="module-create-option">
                        <j-opt-color data-ng-model="settings.bottom_bar_bg"></j-opt-color>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>


                <li>
                    <span class="module-create-title">Bar Shadow</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.bottom_bar_shadow">
                            <switch-option key="none">OFF</switch-option>
                            <switch-option key="0 0 7px rgba(0,0,0,.4)">Normal</switch-option>
                            <switch-option key="0 6px 20px rgba(0,0,0,.2)">Soft</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Fullwidth Bar</span>
                    <span class="module-create-option">
                        <switch data-ng-model="settings.boxed_bottom">
                            <switch-option key="fullwidth-bar">ON</switch-option>
                            <switch-option key="boxed-bar">OFF</switch-option>
                        </switch>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
                <li>
                    <span class="module-create-title">Bar Border Settings</span>
                    <span class="module-create-option">
                        <j-opt-border data-ng-model="settings.bottom_bar_border"></j-opt-border>
                    </span>
                    <a href="#" target="_blank" class="journal-tip"> </a>
                </li>
            </ul>
        </accordion-group>
    </accordion>
</div>
