<!-- MODAL DESCRIPTION OF ADDITIONAL SETTINGS FOR PARAMETERS (dasp) !-->
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-info_tab-generate-dasp-label">Additional settings description</h3>
  </div>
  <div class="modal-body">
	<p class="lead">
	Some of the parameters has additional settings, which give us more flexibility in writing SEO templates.
	</p>

	<h4 style="text-align:left;"> Table of the additional settings (here you can see where and what additional settings possible to write) </h4>

	<table class="table table-bordered">
	<thead>
	<tr>
		<th style="text-align:center;"></th>
		<?php foreach ($patterns_setting as $key => $val) { if(!isset($val['additional']))continue; ?>
			<th style="text-align:center;">!<?php echo $key; ?> </br> <?php echo $patterns[$key]['name']; ?></th>
		<?php } ?>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td>In the product template</td>
		<td>...</td>
		<td>Nt # Ns</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Ns</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>

	<tr>
		<td>In the category template</td>
		<td>...</td>
		<td>Ns</td>
		<td>...</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	
	<tr>
		<td>In the brand template</td>
		<td>Ns</td>
		<td>...</td>
		<td>...</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	
	<tr>
		<td>In the info template</td>
		<td>...</td>
		<td>...</td>
		<td>...</td>
		<td>...</td>
		<td>Ns</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	</tbody>
	</table>
	<div class="info-area">
	Every additional settings must be put in brackets after name of the parameters, without any spaces</br>
	Notations:
	<dl class="dl-horizontal">
		<dt>Nt</dt>
		<dd>- total number of items to writing <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Ns</dt>
		<dd>- total number of sentences to writing <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Pn</dt>
		<dd>- punctuation between items <span class="colorFC580B">(any character except #)</span></dd>
		<dt>Tb</dt>
		<dd>- text before every items <span class="colorFC580B">(any text, which not include char #)</span></dd>
		<dt>#</dt>
		<dd>- delimiter between settings</dd>
		<dt>...</dt>
		<dd>- not using</dd>
	</dl>
	</div>
	
	<div class="lead"><h4>Example: write parameter with additional setting "#ep"(example products)</h4> 
	<span class="label label-info">!ep(3 #; # to buy ) </span>, where </br>
	<dl class="dl-horizontal">
		<dt><span class="label label-info">3</span></dt>
		<dd>- total number of the example products</dd>
		<dt><span class="label label-info">;</span></dt>
		<dd>- punctuation between products</dd>
		<dt><span class="label label-info">to buy</span></dt>
		<dd>- text before every products names</dd>
		<dt><span class="label label-info">#</span></dt>
		<dd>- delimiter between settings</dd>
	</dl>
	and this template will generate next text: <span class="color08c">"to buy Product1; to buy Product2; to buy Product3;". </span></br>
	If you will write this parameter for categories template -  examples of products will be get from every category.
	If you will write this parameter for brands template -  examples of products will be get from every brand. 
	</div>
	<p class="lead clearfix">
	<img class="img-polaroid img-rounded pull-left" src="view/stylesheet/superseobox/images/param_descrip/param_structura.jpg" style="margin-right:20px;">
	Here you can see common structure of the parameter, which you can use in template.
	<a data-dismiss="modal" href="<?php echo $urls['param_descrip']; ?>" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign"></i> Click here to see parameters description</a>
	</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>