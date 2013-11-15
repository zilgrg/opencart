<?php echo $header; ?>
<div id="JProdTabs" data-ng-app="JProdTabs">
	<div id="content" data-ng-controller="JProdTabsCtrl">
		<div class="heading">
			<h1><?php echo $doc_title; ?></h1>
			<div class="links">
				<a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
				<a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
			</div>
			<div class="buttons">
                <span class="loading" style="display: none;">Saving...</span>
                <a class="btn btn-success" data-ng-click="save();"><?php echo $button_save; ?></a>
                <a class="btn btn-danger" href="<?php echo $cancel; ?>"><?php echo $button_cancel; ?></a>
            </div>
		</div>
        <style>
        a, a:visited{
            color:white;
        }
        table.form > tbody > tr > td:first-child{
            width: 90px;
        }
        table.form tbody tr:last-child td{
            border-bottom: 1px dotted #CCC;
        }
        input[type="text"]{
            margin-right: 5px;
        }
        </style>


		<div class="box">
            <div class="content">
                <table class="form">
                    <tbody>
                        <tr>
                            <td style='width:85px; background:#4a4c58; color:white;'><strong style='font-size: 15px;'>Global tab:</strong></td>
                            <td style='background:#4a4c58; color:white;'>
                                <select class="yes_no" data-ng-model="global_tab" switchify>
                                    <option value="1">On</option>
                                    <option value="0">Off</option>
                                </select>
                            </td>
                            <td style='width:220px; background:#4a4c58; color:white;' data-ng-show="global_tab == 0"><strong style='font-size: 15px;'>Product name:</strong> <i>(AutoComplete)</i></td>
                            <td style='background:#4a4c58; color:white;' data-ng-show="global_tab == 0">
                                <input type="text" data-ng-model="product.data" typeahead="product as product.name for product in getProducts($viewValue)" required />
                                <input type="hidden" data-ng-model="product.data.product_id" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div id="tabs" class="vtabs">
                                    <a href="#tab-{{$index}}" data-ng-click="tabChange($event)" data-ng-repeat="tab in tabs">{{getTabTitle(tab)}} <img src="view/image/delete.png" data-ng-click="removeTab($index)" onclick="return false;" /></a><span>Add New Tab <img src="view/image/add.png" alt="" data-ng-click="addTab()" /></span>
                                </div>
                                <div id="tab-{{$index}}" class="vtabs-content" data-ng-repeat="tab in tabs">
                                    <table class="form">
                                        <tr>
                                            <td>Name:</td>
                                            <td>
                                                <div data-ng-repeat="language in CONSTS.languages">
                                                    <input type="text" data-ng-model="tab.name[language.language_id]" required /><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" />
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
<!--                                         <tr>
                                            <td>Position: <br /> <small>Relative to the original tab structure - Description, Specifications, Review</small></td>
                                            <td>
                                                <select data-ng-model="tab.position">
                                                    <option value="1">First</option>
                                                    <option value="2">Second</option>
                                                    <option value="3">Third</option>
                                                    <option value="4">Last</option>
                                                </select>
                                            </td>
                                        </tr> -->
                                        <tr>
                                            <td colspan="2">
                                                <div class="language-tabs htabs">
                                                    <a href="#language-tab-{{$parent.$index}}-{{$index}}" data-ng-repeat="language in CONSTS.languages"><img data-ng-src="view/image/flags/{{language.image}}" title="{{language.name}}" />{{language.name}}</a>
                                                </div>
                                                <div id="language-tab-{{$parent.$index}}-{{$index}}" class="htabs-content" data-ng-repeat="language in CONSTS.languages">
                                                    <textarea style="width: 100%; height: 400px" ck-editor data-ng-model="tab.text[language.language_id]"></textarea>
                                                </div>
                                            </td>
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
</div>
<script type="text/javascript">
    JProdTabs.CONSTS = _.extend(JProdTabs.CONSTS, $.parseJSON('<?php echo json_encode($js_consts); ?>'));
</script>
<?php echo $footer; ?>