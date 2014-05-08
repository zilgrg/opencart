<div class="sticky">
<div class="module-header">
    <div class='module-name'>Carousel <span data-ng-show="module_id == null">New Module</span><span data-ng-show="module_id != null">Edit Module</span></div>
    <div class="module-buttons">
        <a href="<?php echo $base_href;?>#/module/{{module_type}}/all/{{module_id}}" data-ng-show="module_id != null" class="btn blue">Add to Layout</a>
        <a data-ng-click="save($event)" class="btn green">Save</a>
        <a href="<?php echo $base_href;?>#/module/{{module_type}}/all" data-ng-show="module_id == null" class="btn red">Cancel</a>
        <a data-ng-click="delete($event)" data-ng-show="module_id != null" class="btn red">Delete</a>
    </div>
</div>
</div>
<div class="module-body module-form">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="module_data.close_others" /></label>
    </div>
    <accordion close-others="module_data.close_others">
        <accordion-group is-open="module_data.general_is_open">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">General Options</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Module Name</span>
                    <span class="module-create-option">
                        <input type="text" class="journal-input journal-name-field" data-ng-model="module_data.module_name" required />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Module Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.module_type">
                            <switch-option key="product">Product</switch-option>
                            <switch-option key="category">Category</switch-option>
                            <switch-option key="manufacturer">Brand</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Image Dimensions</span>
                    <span class="module-create-option">
                        <input type="text" class="journal-number-field" data-ng-model="module_data.image_width" /> x <input type="text" class="journal-number-field" data-ng-model="module_data.image_height" />
                        <switch data-ng-model="module_data.image_type">
                            <switch-option key="fit">Fit</switch-option>
                            <switch-option key="crop">Crop</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Items per Row</span>
                    <span class="module-create-option">
                        <j-opt-items-per-row data-ng-model="module_data.items_per_row"></j-opt-items-per-row>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Arrows</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.arrows">
                            <switch-option key="none">None</switch-option>
                            <switch-option key="top">Top</switch-option>
                            <switch-option key="side">Side</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Bullets</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.bullets">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Hide Title Bar <small>Single Carousel Only</small></span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.show_title">
                            <switch-option key="0">ON</switch-option>
                            <switch-option key="1">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-if="module_data.module_type == 'manufacturer'">
                    <span class="module-create-title">Brand Name</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.brand_name">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Autoplay</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.autoplay">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="module_data.autoplay == '1'">
                    <span class="module-create-title">Pause on Hover</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.pause_on_hover">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="module_data.autoplay == '1'">
                    <span class="module-create-title">Transition Delay</span>
                    <span class="module-create-option">
                        <input type="text" class="journal-number-field" data-ng-model="module_data.transition_delay" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Transition Speed</span>
                    <span class="module-create-option">
                        <input type="text" class="journal-number-field" data-ng-model="module_data.transition_speed" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Disable on Mobile</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.disable_mobile">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-hide="module_data.disable_mobile">
                    <span class="module-create-title">Touch Drag</span>
                    <span class="module-create-option">
                        <switch data-ng-model="module_data.touch_drag">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
            </ul>
        </accordion-group>
        <accordion-group is-open="module_data.top_bottom_is_open">
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Top or Bottom Position Settings</div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Background</span>
                        <span class="module-create-option">
                            <j-opt-background data-ng-model="module_data.background" data-bgcolor="true"></j-opt-background>
                        </span>
                </li>
                <li>
                    <span class="module-create-title">Fullwidth Module</span>
                        <span class="module-create-option">
                            <switch data-ng-model="module_data.fullwidth">
                                <switch-option key="1">ON</switch-option>
                                <switch-option key="0">OFF</switch-option>
                            </switch>
                        </span>
                </li>
                <li>
                    <span class="module-create-title">Margin<small>Top/Bottom</small></span>
                    <span class="module-create-option">
                        <input type="text" class="journal-number-field" data-ng-model="module_data.margin_top" /> x <input type="text" class="journal-number-field" data-ng-model="module_data.margin_bottom" />
                    </span>
                </li>
            </ul>
        </accordion-group>
        <accordion-group data-ng-repeat="section in module_data.product_sections" data-ng-if="module_data.module_type == 'product'" is-open="section.is_open">
            <accordion-heading>
                <div class="accordion-bar bar-level-1"> {{section.section_title.value[default_language] || ('Section ' + ($index + 1))}} <a class="accordion-remove slide-remove" data-ng-click="removeSection(module_data.product_sections, $index)"><b></b>Remove</a></div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Section Title</span>
                    <span class="module-create-option">
                        <j-opt-text-lang data-ng-model="section.section_title"></j-opt-text-lang>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Section Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.section_type">
                            <switch-option key="module">Module</switch-option>
                            <switch-option key="category">Category</switch-option>
                            <switch-option key="manufacturer">Brand</switch-option>
                            <switch-option key="random">Random</switch-option>
                            <switch-option key="custom">Custom</switch-option>
                            <switch-option key="link">Link</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'module'">
                    <span class="module-create-title">Module Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.module_type">
                            <switch-option key="featured">Featured</switch-option>
                            <switch-option key="bestsellers">Bestsellers</switch-option>
                            <switch-option key="specials">Specials</switch-option>
                            <switch-option key="latest">Latest</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'category'">
                    <span class="module-create-title">Category</span>
                    <span class="module-create-option">
                        <category-search model="section.category.data"></category-search>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'manufacturer'">
                    <span class="module-create-title">Brand</span>
                    <span class="module-create-option">
                        <manufacturer-search model="section.manufacturer.data"></manufacturer-search>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'custom'">
                    <span class="module-create-title">Products</span>
                    <span class="module-create-option">
                         <ul class="simple-list">
                             <li data-ng-repeat="item in section.products">
                                 <product-search model="item.data"></product-search>
                                 <a class="btn red delete" href="javascript:;" data-ng-click="removeProduct(section, $index)">X</a>
                             </li>
                         </ul>
                        <a href="javascript:;" class="btn blue add-product" data-ng-click="addProduct(section)">Add</a>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'random'">
                    <span class="module-create-title">Random From</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.random_from">
                           <switch-option key="all"> &nbsp;&nbsp;&nbsp; All &nbsp;&nbsp;&nbsp;</switch-option>
                           <switch-option key="category">Category</switch-option>
                       </switch>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'random' && section.random_from == 'category'">
                    <span class="module-create-title">Category</span>
                    <span class="module-create-option">
                        <category-search model="section.random_from_category"></category-search>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Link</span>
                    <span class="module-create-option">
                        <menu-item data-ng-model="section.link"></menu-item>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Open in new window</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.new_window">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Status</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.status">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Default Section</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.default_section" data-ng-change="setDefault(module_data.product_sections, $index)">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Item Limit</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.items_limit" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Sort Order</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.sort_order" />
                    </span>
                </li>
            </ul>
        </accordion-group>
        <accordion-group data-ng-repeat="section in module_data.category_sections" data-ng-if="module_data.module_type == 'category'" is-open="section.is_open">
            <accordion-heading>
                <div class="accordion-bar bar-level-1"> {{section.section_title.value[default_language] || ('Section ' + ($index + 1))}} <a class="accordion-remove slide-remove" data-ng-click="removeSection(module_data.category_sections, $index)"><b></b>Remove</a></div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Section Title</span>
                    <span class="module-create-option">
                        <j-opt-text-lang data-ng-model="section.section_title"></j-opt-text-lang>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Category</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.section_type">
                            <switch-option key="top">Top</switch-option>
                            <switch-option key="sub">Sub</switch-option>
                            <switch-option key="custom">Custom</switch-option>
                            <switch-option key="link">Link</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'sub'">
                    <span class="module-create-title">Category</span>
                    <span class="module-create-option">
                        <category-search model="section.category_sub"></category-search>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'custom'">
                    <span class="module-create-title">Categories</span>
                    <span class="module-create-option">
                        <ul class="simple-list">
                            <li data-ng-repeat="item in section.categories">
                                <category-search model="item.data"></category-search>
                                <a class="btn red delete" href="javascript:;" data-ng-click="removeCategory(section, $index)">X</a>
                            </li>
                        </ul>
                        <a href="javascript:;" class="btn blue add-product" data-ng-click="addCategory(section)">Add</a>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Link</span>
                    <span class="module-create-option">
                        <menu-item data-ng-model="section.link"></menu-item>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Open in new window</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.new_window">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Status</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.status">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Default section</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.default_section"  data-ng-change="setDefault(module_data.category_sections, $index)">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Items Limit</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.items_limit" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Sort Order</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.sort_order" />
                    </span>
                </li>
            </ul>
        </accordion-group>
        <accordion-group data-ng-repeat="section in module_data.manufacturer_sections" data-ng-if="module_data.module_type == 'manufacturer'" is-open="section.is_open">
            <accordion-heading>
                <div class="accordion-bar bar-level-1"> {{section.section_title.value[default_language] || ('Section ' + ($index + 1))}} <a class="accordion-remove slide-remove" data-ng-click="removeSection(module_data.manufacturer_sections, $index)"><b></b>Remove</a></div>
            </accordion-heading>
            <ul class="module-create-options">
                <li>
                    <span class="module-create-title">Section Title</span>
                    <span class="module-create-option">
                        <j-opt-text-lang data-ng-model="section.section_title"></j-opt-text-lang>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Brands</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.section_type">
                            <switch-option key="all">&nbsp;&nbsp;&nbsp;All&nbsp;&nbsp;&nbsp;</switch-option>
                            <switch-option key="custom">Custom</switch-option>
                            <switch-option key="link">Link</switch-option>
                        </switch>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'custom'">
                    <span class="module-create-title">Brands</span>
                    <span class="module-create-option">
                        <ul class="simple-list">
                            <li data-ng-repeat="item in section.manufacturers">
                                <manufacturer-search model="item.data"></manufacturer-search>
                                <a class="btn red delete" href="javascript:;" data-ng-click="removeManufacturer(section, $index)">X</a>
                            </li>
                        </ul>
                        <a href="javascript:;" class="btn blue add-product" data-ng-click="addManufacturer(section)">Add</a>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Link</span>
                    <span class="module-create-option">
                        <menu-item data-ng-model="section.link"></menu-item>
                    </span>
                </li>
                <li data-ng-show="section.section_type == 'link'">
                    <span class="module-create-title">Open in new window</span>
                    <span class="module-create-option">
                        <switch data-ng-model="section.new_window">
                            <switch-option key="1">ON</switch-option>
                            <switch-option key="0">OFF</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Status</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.status">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Default section</span>
                       <span class="module-create-option">
                       <switch data-ng-model="section.default_section" data-ng-change="setDefault(module_data.manufacturer_sections, $index)">
                           <switch-option key="1">ON</switch-option>
                           <switch-option key="0">OFF</switch-option>
                       </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Items Limit</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.items_limit" />
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Sort Order</span>
                    <span class="module-create-option">
                         <input type="text" value="" class="journal-input journal-sort" data-ng-model="section.sort_order" />
                    </span>
                </li>
            </ul>
        </accordion-group>
    </accordion>
    <div class="add-level add-level-1" data-ng-click="addSection(module_data.module_type)">Add Tab +</div>
</div>
