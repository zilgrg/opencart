<div class="sticky">
<div class="module-header">
    <div class='module-name'>Footer <span>Menu</span></div>

    <store-picker data-url="footer/menu"></store-picker>

    <div class="module-buttons">
        <a class="btn green" data-ng-click="save($event)">Save</a>
        <a class="btn red" data-ng-click="reset($event)">Reset</a>
    </div>
</div>
</div>
<div class="module-body footer-columns" data-ng-hide="isLoading">
    <div class="accordion-bar bar-level-0 bar-expand" >
        <a data-ng-click="toggleAccordion(rows, 'scope', null, true)" class="hint--top" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(rows, 'scope', null, false)" class="hint--top" data-hint="Collapse All"><i class="collapse-icon"></i></a>
        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="close_others" /></label>
    </div>
    <accordion close-others="close_others">
        <!-- rows -->
        <accordion-group data-ng-repeat="row in rows" is-open="row.is_open">
            <div class="dummy-1"> </div>
            <accordion-heading>
                <div class="accordion-bar bar-level-0">Row {{$index + 1}} <a href="javascript:;" class="accordion-remove slide-remove" data-ng-click="removeRow($index)"><b ></b>Remove</a></div>
            </accordion-heading>
            <ul class="module-create-options lvl-0">
                <li>
                    <span class="module-create-title">Row Type</span>
                    <span class="module-create-option">
                        <switch data-ng-model="row.type">
                            <switch-option key="columns">Columns</switch-option>
                            <switch-option key="contacts">Contacts</switch-option>
                        </switch>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Items per Row</span>
                    <span class="module-create-option">
                        <j-opt-items-per-row data-ng-model="row.items_per_row"></j-opt-items-per-row>
                    </span>
                </li>
                <li>
                    <span class="module-create-title">Sort Order</span>
                    <span class="module-create-option">
                        <input type="text" data-ng-model="row.sort_order" class="journal-input journal-sort" />
                    </span>
                </li>
            </ul>
            <div class="accordion-bar bar-level-1 bar-expand" data-ng-show="row.type === 'columns'">
                <a data-ng-click="toggleAccordion(row.columns, null, row, true)" class="hint--top hint-fix" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(row.columns, null, row, false)" class="hint--top hint-fix" data-hint="Collapse All"><i class="collapse-icon"></i></a>
                <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="row.close_others" /></label>
            </div>
            <accordion close-others="row.close_others" data-ng-show="row.type === 'columns'">
                <!-- columns -->
                <accordion-group data-ng-repeat="column in row.columns" is-open="column.is_open">
                    <div class="dummy-2"> </div>
                    <accordion-heading>
                        <div class="accordion-bar bar-level-1">Column {{$index + 1}} <a href="javascript:;" class="accordion-remove slide-remove" data-ng-click="removeColumn(row, $index)"><b ></b>Remove</a></div>
                    </accordion-heading>
                    <ul class="module-create-options lvl-1">
                        <li>
                            <span class="module-create-title">Column Type</span>
                            <span class="module-create-option">
                                <switch data-ng-model="column.type">
                                    <switch-option key="menu">Menu</switch-option>
                                    <switch-option key="text">HTML</switch-option>
                                </switch>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Column Title</span>
                            <span class="module-create-option">
                                <j-opt-text-lang data-ng-model="column.title"></j-opt-text-lang>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Sort Order</span>
                            <span class="module-create-option">
                                <input type="text" data-ng-model="column.sort_order" class="journal-input journal-sort" />
                            </span>
                        </li>
                        <li data-ng-show="column.type === 'text'">
                            <span class="module-create-title">Text</span>
                            <span class="module-create-option">
                                <ck-editor data-ng-model="column.text"></ck-editor>
                            </span>
                        </li>
                    </ul>
                    <!-- column item -->
                    <div class="accordion-bar bar-level-2 bar-expand" data-ng-show="row.type === 'columns'">
                        <a data-ng-click="toggleAccordion(column.items, null, column, true)" class="hint--top hint-fix" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(column.items, null, column, false)" class="hint--top hint-fix" data-hint="Collapse All"><i class="collapse-icon"></i></a>
                        <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="column.close_others" /></label>
                    </div>
                    <accordion close-others="column.close_others" data-ng-show="column.type === 'menu'">
                        <accordion-group data-ng-repeat="item in column.items" is-open="item.is_open">
                            <div class="dummy-3"> </div>
                            <accordion-heading>
                                <div class="accordion-bar bar-level-2"> Menu Item {{$index + 1}} <a href="javascript:;" class="accordion-remove slide-remove" data-ng-click="removeItem(column, $index)"><b ></b>Remove</a></div>
                            </accordion-heading>
                            <ul class="module-create-options lvl-2">
                                <li>
                                    <span class="module-create-title">Icon</span>
                                    <span class="module-create-option">
                                        <icon-select data-ng-model="item.icon"></icon-select>
                                    </span>
                                </li>
                                <li>
                                    <span class="module-create-title">Link</span>
                                    <span class="module-create-option">
                                        <menu-item data-ng-model="item.menu"></menu-item>
                                    </span>
                                </li>
                                <li data-ng-hide="item.menu.menu_type === 'custom'">
                                    <span class="module-create-title">Name Overwrite</span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="item.name_overwrite">
                                            <switch-option key="1">ON</switch-option>
                                            <switch-option key="0">OFF</switch-option>
                                        </switch>
                                    </span>
                                </li>
                                <li data-ng-show="item.name_overwrite === '1' || item.menu.menu_type === 'custom'">
                                    <span class="module-create-title">Name</span>
                                    <span class="module-create-option">
                                        <j-opt-text-lang data-ng-model="item.name"></j-opt-text-lang>
                                    </span>
                                </li>
                                <li>
                                    <span class="module-create-title">Open in New Tab</span>
                                    <span class="module-create-option">
                                        <switch data-ng-model="item.target">
                                            <switch-option key="1">ON</switch-option>
                                            <switch-option key="0">OFF</switch-option>
                                        </switch>
                                    </span>
                                </li>
                                <li>
                                    <span class="module-create-title">Sort Order</span>
                                    <span class="module-create-option">
                                        <input type="text" data-ng-model="item.sort_order" class="journal-input journal-sort" />
                                    </span>
                                </li>
                            </ul>
                        </accordion-group>
                    </accordion>
                    <div class="add-level add-level-2" data-ng-click="addItem(column)" data-ng-show="row.type === 'columns' && column.type === 'menu'">Add Menu Item +</div>
                </accordion-group>
            </accordion>
            <div class="accordion-bar bar-level-1 bar-expand" data-ng-show="row.type === 'contacts'">
                <a data-ng-click="toggleAccordion(row.contacts, null, row, true)" class="hint--top hint-fix" data-hint="Expand All"><i class="expand-icon"></i></a>  <a data-ng-click="toggleAccordion(row.contacts, null, row, false)" class="hint--top hint-fix" data-hint="Collapse All"><i class="collapse-icon"></i></a>
                <label class="close-others hint--top" data-hint="Close Others"><input type="checkbox" data-ng-model="row.close_others" /></label>
            </div>
            <accordion close-others="row.close_others" data-ng-show="row.type === 'contacts'">
                <!-- contacts -->
                <accordion-group data-ng-repeat="contact in row.contacts" is-open="contact.is_open">
                    <accordion-heading>
                        <div class="accordion-bar bar-level-1">{{ 'Contact ' + ($index + 1) }} <a href="javascript:;" class="accordion-remove slide-remove" data-ng-click="removeContact(row, $index)"><b ></b>Remove</a></div>
                    </accordion-heading>
                    <ul class="module-create-options">
                        <li>
                            <span class="module-create-title">Position</span>
                            <span class="module-create-option">
                                <switch data-ng-model="contact.position">
                                    <switch-option key="left">Left</switch-option>
                                    <switch-option key="right">Right</switch-option>
                                </switch>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Icon</span>
                            <span class="module-create-option">
                                <icon-select data-ng-model="contact.icon"></icon-select>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Name</span>
                            <span class="module-create-option">
                                <j-opt-text-lang data-ng-model="contact.name"></j-opt-text-lang>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Show as Tooltip</span>
                            <span class="module-create-option">
                                <switch data-ng-model="contact.tooltip">
                                    <switch-option key="1">ON</switch-option>
                                    <switch-option key="0">OFF</switch-option>
                                </switch>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Link</span>
                            <span class="module-create-option">
                                <menu-item data-ng-model="contact.link"></menu-item>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Open in New Tab</span>
                            <span class="module-create-option">
                                <switch data-ng-model="contact.target">
                                    <switch-option key="1">ON</switch-option>
                                    <switch-option key="0">OFF</switch-option>
                                </switch>
                            </span>
                        </li>
                        <li>
                            <span class="module-create-title">Sort Order</span>
                            <span class="module-create-option">
                                <input type="text" class="journal-input journal-sort" data-ng-model="contact.sort_order" />
                            </span>
                        </li>
                    </ul>
                </accordion-group>
            </accordion>
            <div class="add-level add-level-1" data-ng-click="addColumn(row)" data-ng-show="row.type === 'columns'">Add Column +</div>
            <div class="add-level add-level-1" data-ng-click="addContact(row)" data-ng-show="row.type === 'contacts'">Add Contacts +</div>
        </accordion-group>
    </accordion>
    <div class="add-level add-level-0" data-ng-click="addRow()">Add Row + </div>
</div>
