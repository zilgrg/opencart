<?php echo $header; ?>
<style>
.buttons a{
        color:white;
    }
</style>
<div id="JRev" data-ng-app="JRev">
	<div id="content" data-ng-controller="JRevSlidersCtrl">
		<div class="heading">
			<h1><?php echo $doc_title; ?></h1>
			<div class="links">
				<a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
				<a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
			</div>
			<div class="buttons">
				<a href="<?php echo $consts['edit_url']; ?>" class="btn btn-success">Create New</a>
				<a data-ng-click="deleteSliders()" class="btn btn-danger"><?php echo $button_delete; ?></a>
			</div>
		</div>

		<div class="box">
			<div class="content">
				<div id="tabs" class="htabs">
					<a href="<?php echo $consts['active_url']; ?>"><?php echo $tab_active; ?></a>
					<a href="<?php echo $consts['list_url']; ?>" class="selected"><?php echo $tab_list; ?></a>
				</div>
				<form method="post" enctype="multipart/form-data" id="form">
					<table class="list">
						<thead>
							<tr>
								<td width="1" style="text-align: center;">Delete</td>
								<td class="left"><?php echo $column_category; ?></td>
								<td class="right"><?php echo $column_action; ?></td>
							</tr>
						</thead>
						<tbody>
							<tr data-ng-repeat="slider in sliders">
								<td class="left" style="text-align: center;"><input class="check" type="checkbox" name="selected[]" value="{{slider.id}}" /></td>
								<td class="left" style=" font-weight: bold; font-size: 13px ">{{slider.data.title}}</td>
								<td class="right" style="width:100px"><a class="btn" href="{{editUrl(slider.id)}}"><?php echo $button_edit; ?></a></td>
							</tr>
						</tbody>
						<tfoot data-ng-show="{{sliders.length == 0}}">
							<tr>
								<td class="center no_modules" colspan="4"><?php echo $text_no_results; ?></td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
</script>
<?php echo $js_consts; ?>
<?php echo $footer; ?>