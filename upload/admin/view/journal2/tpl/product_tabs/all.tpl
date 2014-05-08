<div class="module-header">
    <div class='module-name'>Product Tabs <span>All Tabs</span></div>
    <div class="module-buttons">
        <a href="<?php echo $base_href;?>#/module/{{module_type}}/form" class="btn blue">Create New</a>
    </div>
</div>
<form>
    <div class="module-body module-all p-tabs">
        <div class="accordion-bar bar-level-0 bar-expand" >
        </div>
        <accordion close-others="false">
            <accordion-group data-ng-repeat="module in modules" is-open="opened_modules[module.module_id]">
                <accordion-heading>
                    <div class="accordion-bar bar-level-0 bar-pt">
                        {{module.module_data.module_name}}
                        <span class="module-options">
                             <a href="<?php echo $base_href;?>#/module/{{module_type}}/form/{{module.module_id}}" data-ng-click="$event.stopPropagation()" class="accordion-remove edit-module"><b></b>Edit </a>
                        </span>
                    </div>
                </accordion-heading>
            </accordion-group>
        </accordion>
    </div>
</form>