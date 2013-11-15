<?php echo $header; ?>
<style>
.buttons a{
        color:white;
    }
</style>


<div id="JRev" data-ng-app="JRev">
	<div id="content" data-ng-controller="JRevPosCtrl">
		<div class="heading">
			<h1><?php echo $doc_title; ?></h1>
			<div class="links">
				<a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
				<a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
			</div>
			<div class="buttons">
				<span class="loading" style="display: none;">Saving...</span>
				<a class="btn btn-success" data-ng-click="save();"><?php echo $button_save; ?></a>
				<a class="btn btn-danger" href="<?php echo $consts['extensions_url']; ?>"><?php echo $button_cancel; ?></a>
			</div>
		</div>
		<div class="box">
			<div class="content">
				<div id="tabs" class="htabs">
					<a href="<?php echo $consts['active_url']; ?>" class="selected"><?php echo $tab_active; ?></a>
					<a href="<?php echo $consts['list_url']; ?>"><?php echo $tab_list; ?></a>
				</div>
				<form id="form">
					<table id="module" class="list">
						<thead>
							<tr>
								<td class="left"><?php echo $entry_slider; ?></td>
								<td class="left"><?php echo $entry_layout; ?></td>
								<td class="left"><?php echo $entry_status; ?></td>
								<td class="left"><?php echo $entry_sort_order; ?></td>
								<td class="left">Remove</td>
							</tr>
						</thead>
						<tbody>
							<tr data-ng-repeat="module in modules">
								<td class="left">
									<select data-ng-model="module.slider" data-ng-options="slider.id as slider.data.title for slider in sliders" custom-select></select>
								</td>
								<td class="left">
									<select data-ng-model="module.layout_id" data-ng-options="layout.layout_id as layout.name for layout in layouts" custom-select></select>
								</td>
								<td class="left">
									<select data-ng-model="module.status" switchify>
										<option value="1">On</option>
										<option value="0">Off</option>
									</select>
								</td>
								<td class="right">
									<input type="text" style='width:25px; text-align: center;' size="3" data-ng-model="module.sort_order" />
								</td>
								<td class="left">
									<input class="btn" type="button" data-ng-click="deleteModule($index)" value="<?php echo $button_delete; ?>" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="4"></td>
								<td class="left"><a data-ng-click="insertModule();" class="btn btn-primary">Add Module</a></td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $js_consts; ?>
<?php echo $footer; ?>