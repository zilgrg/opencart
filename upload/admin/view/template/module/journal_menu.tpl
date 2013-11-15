<?php echo $header; ?>
<div id="JMenu" data-ng-app="JMenu">
    <form novalidate name="form">
    <div id="content" data-ng-controller="JMenuCtrl">
        <div class="heading">
            <h1><?php echo $doc_title; ?></h1>
            <div class="links">
                <a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
                <a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
            </div>
            <div class="buttons">
                <span class="loading" style="display: none;">Saving...</span>
                <a class="btn btn-success" data-ng-click="save();" data-ng-disabled="form.$invalid" id="save-btn"><?php echo $button_save; ?></a>
                <a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
            </div>
        </div>

        <style>
        a, a:visited{
            color:white;
        }
        table.form tbody tr:last-child td{
            border-bottom: 1px dotted #CCC;
        }
        table.form > tbody > tr > td:first-child{
            width: 130px;
        }
        .button-remove{
            float: right;
        }
        .vtabs-content table tr:last-child td:last-child,
        .vtabs-content table tr:last-child td:first-child{
            border-radius: 0;
        }
        table.list{
            width:730px;
            margin-bottom: 0;
        }
        table.list td{
            text-align: center;
            height: 25px;
            padding:8px 0;
        }
        form .ng-invalid {
            border: 1px solid red;
        }
        </style>

        <div class="box">
            <div class="content">
                <table class="form">
                    <tbody>
                        <tr>
                            <td style='width:140px; text-align:right; background:#4a4c58; color:white;'><strong style='font-size: 15px;'>Mega Menu Store:</strong></td>
                            <td style='font-size: 15px; background:#4a4c58; color:white;'>
                                <select custom-select data-ng-model="store_id" data-ng-options="store.store_id as store.name for store in CONSTS.stores" data-ng-change="load()"></select>
                            </td>
                            <td style='width:140px; text-align:right; background:#4a4c58; color:white;'><strong style='font-size: 15px;'>Mega Menu Status:</strong></td>
                            <td style='font-size: 15px; background:#4a4c58; color:white;'>
                                <select class="yes_no" data-ng-model="status" switchify>
                                    <option value="1">On</option>
                                    <option value="0">Off</option>
                                </select>
                            </td>
                        </tr>
                        <!-- <tr>
                            <td>Slide down: </td>
                            <td>
                                <select data-ng-model="animation" switchify>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>
                            </td>
                        </tr> -->
                        <tr>
                            <td colspan="4">
                                <div id="tabs" class="vtabs">
                                    <a href="#tab-{{$index}}" data-ng-repeat="tab in tabs">{{getTabTitle(tab)}} <img src="view/image/delete.png" data-ng-click="removeTab($index)" onclick="return false;" /></a><span>Add New Item <img src="view/image/add.png" alt="" data-ng-click="addTab()" /></span>
                                </div>
                                <div id="tab-{{$index}}" class="vtabs-content" data-ng-repeat="tab in tabs">
                                    <table class="form">
                                        <tr>
                                            <td>Menu Type:</td>
                                            <td>
                                                <select data-ng-model="tab.itemType" custom-select ng-change="resetItems($index)">
                                                    <option value="megamenu">Categories</option>
                                                    <option value="brands">Brands</option>
                                                    <!-- <option value="customblock">Custom block</option> -->
                                                    <option value="products">Products</option>
                                                    <option value="simplemenu">Standard Menu</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Menu Name:</td>
                                            <td>
                                                <div data-ng-repeat="language in CONSTS.languages" class="multilang">
                                                    <input type="text" data-ng-model="tab.name[language.language_id]" required /><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" /><span class="error" ng-show="isValid(tab.name[language.language_id])">Required</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Status:</td>
                                            <td>
                                                <select class="yes_no" data-ng-model="tab.status" switchify>
                                                    <option value="1">On</option>
                                                    <option value="0">Off</option>
                                                </select>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>Sort Order:</td>
                                            <td><input style='width:25px;' type="text" size="3" data-ng-model="tab.sort_order" /></td>
                                        </tr>
                                        <tr data-ng-show="isMegaMenu(tab)">
                                            <td>Top menu link:</td>
                                            <td><input type="text" data-ng-model="tab.megamenu.top_link" /></td>
                                        </tr>

                                        <!-- megamenu -->
                                        <tr data-ng-show="isMegaMenu(tab)">
                                            <td>Show Images:</td>
                                            <td>
                                                <select class="yes_no" data-ng-model="tab.megamenu.showImages" switchify>
                                                    <option value="1">Yes</option>
                                                    <option value="0">No</option>
                                                </select>
                                            </td>
                                        </tr>                                        
                                        <tr data-ng-show="isMegaMenu(tab)">
                                            <td>Max Subcategory Items:<br /><small>Leave empty to show all</small></td>
                                            <td><input style='width:25px;' type="text" size="3" data-ng-model="tab.megamenu.maxSubItems" /></td>
                                        </tr>
                                        <tr data-ng-show="isMegaMenu(tab) && hasLimit(tab)">
                                            <td>More Text:</td>
                                            <td>
                                                <div data-ng-repeat="language in CONSTS.languages" class="multilang">
                                                    <input type="text" data-ng-model="tab.megamenu.moreText[language.language_id]" data-ng-required="hasLimit(tab)" /><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" /><span class="error" ng-show="isValid(tab.megamenu.moreText[language.language_id])">Required</span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isMegaMenu(tab)" data-ng-repeat="category in tab.megamenu.categories">
                                            <td colspan="2">
                                                <input type="text" data-ng-model="category.data" typeahead="category as category.name|htmlfilter for category in getCategories($viewValue)" required />
                                                <input type="button" data-ng-click="removeMegaMenuCategory(tab, $index)" value="Remove" class="btn button-remove" />
                                                <input type="hidden" data-ng-model="category.data.category_id" required />
                                                <span class="error" ng-show="isValid(category.data.name)">Required</span>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isMegaMenu(tab)">
                                            <td style='background: #4a4c58; color:white' colspan="2"><button data-ng-click="addMegaMenuCategory(tab)" class="btn">Add Category</button> <i>(AutoComplete)</i></td>
                                        </tr>

                                        <!-- brands -->
                                        <tr data-ng-show="isBrands(tab)">
                                            <td>Show Images:</td>
                                            <td>
                                                <select class="yes_no" data-ng-model="tab.brands.showImages" switchify>
                                                    <option value="1">Yes</option>
                                                    <option value="0">No</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isBrands(tab)" data-ng-repeat="brand in tab.brands.brands">
                                            <td colspan="2">
                                                <input type="text" data-ng-model="brand.data" typeahead="brand as brand.name for brand in getBrands($viewValue)" required />
                                                <input type="button" data-ng-click="removeBrand(tab, $index)" value="Remove" class="btn button-remove" />
                                                <input type="hidden" data-ng-model="brand.data.manufacturer_id" required />
                                                <span class="error" ng-show="isValid(brand.data.name)">Required</span>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isBrands(tab)">
                                            <td style='background: #4a4c58; color:white'  colspan="2"><button class="btn" data-ng-click="addBrand(tab)">Add Brand</button><i> (AutoComplete)</i></td>
                                        </tr>

                                        <!-- customblock -->
                                        <!-- <tr data-ng-show="isCustomBlock(tab)">
                                            <td colspan="2">
                                                <div class="language-tabs htabs">
                                                    <a href="#language-tab-{{$parent.$index}}-{{$index}}" data-ng-repeat="language in CONSTS.languages"><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" />{{language.name}}</a>
                                                </div>
                                                <div id="language-tab-{{$parent.$index}}-{{$index}}" class="htabs-content" data-ng-repeat="language in CONSTS.languages">
                                                    <textarea style="width: 100%; height: 400px" ck-editor data-ng-model="tab.customblock[language.language_id]"></textarea>
                                                </div>
                                            </td>
                                        </tr> -->

                                        <!-- simple menu -->
                                        <tr data-ng-show="isSimpleMenu(tab)">
                                            <td>Link:</td>
                                            <td><input type="text" data-ng-model="tab.simplemenu.link" /></td>
                                        </tr>
                                        <tr data-ng-show="isSimpleMenu(tab)">
                                            <td>New Tab:</td>
                                            <td>
                                                <select class="yes_no" data-ng-model="tab.simplemenu.newWindow" switchify>
                                                    <option value="1">Yes</option>
                                                    <option value="0">No</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isSimpleMenu(tab)">
                                            <td style='padding: 0;' colspan="2">
                                                <table class="list">
                                                    <thead>
                                                        <tr>
                                                            <td>Sub-Menu Item</td>
                                                            <td>Link</td>
                                                            <td>New Tab</td>
                                                            <td>Delete</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr data-ng-repeat="item in tab.simplemenu.items">
                                                            <td>
                                                                <div data-ng-repeat="language in CONSTS.languages" class="multilang">
                                                                    <input type="text" data-ng-model="item.name[language.language_id]" required /><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" />
                                                                </div>
                                                            </td>
                                                            <td><input type="text" data-ng-model="item.link" /></td>
                                                            <td>
                                                                <select class="yes_no" data-ng-model="item.newWindow" switchify>
                                                                    <option value="1">Yes</option>
                                                                    <option value="0">No</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="button" data-ng-click="removeSimpleMenuItem(tab, $index)" value="Remove" class="btn" /></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isSimpleMenu(tab)">
                                            <td style='background: #4a4c58; color:white'  colspan="2"><button data-ng-click="addSimpleMenuItem(tab)" class="btn">Add Sub-Menu </button></td>
                                        </tr>

                                        <!-- prodcut-menu -->
                                        <tr data-ng-show="isProducts(tab)">
                                            <td>Show Images:</td>
                                            <td>
                                                <select class="yes_no" data-ng-model="tab.products.showImages" switchify>
                                                    <option value="1">Yes</option>
                                                    <option value="0">No</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isProducts(tab)" data-ng-repeat="product in tab.products.products">
                                            <td colspan="2">
                                                <input type="text" data-ng-model="product.data" typeahead="product as product.name for product in getProducts($viewValue)" required />
                                                <input type="button" data-ng-click="removeProducts(tab, $index)" value="Remove" class="btn button-remove" />
                                                <input type="hidden" data-ng-model="product.data.product_id" required />
                                                <span class="error" ng-show="isValid(product.data.name)">Required</span>
                                            </td>
                                        </tr>
                                        <tr data-ng-show="isProducts(tab)">
                                            <td style='background: #4a4c58; color:white' colspan="2"><button data-ng-click="addProducts(tab)" class="btn">Add Product</button> <i>(AutoComplete)</i></td>
                                        </tr>

                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    </form>
</div>
<script type="text/javascript">
    JMenu.CONSTS = _.extend(JMenu.CONSTS, $.parseJSON('<?php echo json_encode($js_consts); ?>'));
</script>
<?php echo $footer; ?>


