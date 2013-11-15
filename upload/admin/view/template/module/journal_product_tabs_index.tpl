<?php echo $header; ?>
<div>
	<div id="content">
		<div class="heading">
			<h1><?php echo $doc_title; ?></h1>
			<div class="links">
				<a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
				<a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
			</div>
			<div class="buttons">
				<span class="loading" style="display: none;">Saving...</span>
				<a href="<?php echo $create; ?>" class="btn btn-success"><?php echo $button_create; ?></a>
				<a class="btn btn-danger" onclick="$('#form').submit();"><?php echo $button_delete; ?></a>
			</div>
		</div>
		<div class="box">
			<div class="content">
				<style>
				a, a:visited{
					color:white;
				}
					#form{
						width: 100%;
					}
					.left{
						width:770px;
						font-weight: bold;
					}
					td{
						background-color: #f6f6f6 !important;
					}
				</style>
				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
					<table id="module" class="list no-modules">
						<thead>
							<tr>
								<td width="1" style="text-align: center;">Delete</td>
								<td class="left"><?php echo $entry_product; ?></td>
								<td class="right">Edit</td>
							</tr>
						</thead>
						<tbody>
							<?php foreach ($products as $product): ?>
							<tr>
								<td style="text-align: center; border-bottom: 1px dotted #ccc"><input class="check" type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" /></td>
								<td class="left"><?php echo $product['name']; ?></td>
								<td class="right"><a href="<?php echo $create . '&product_id=' . $product['product_id']; ?>" class="btn">Edit</a></td>
							</tr>
							<?php endforeach; ?>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?>