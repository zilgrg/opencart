<!-- MODAL PARAMETERS DESCRIPTION !-->
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3>Parameters description</h3>
  </div>
  <div class="modal-body">
	<p class="lead">
	SEO generator use the parameters which allow you to construct specific phrases (templates) for generate SEO text.
	</p>
    <p class="lead clearfix">
	<img class="img-polaroid img-rounded pull-left" src="view/stylesheet/superseobox/images/param_descrip/param_structura.jpg" style="margin-right:20px;">
	Here you can see common structure of the parameters, which you can use in templates.
	<a data-dismiss="modal" href="<?php echo $urls['param_setting_descrip']; ?>" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign"></i> Click here to see Additional settings for parameters</a>
	</p>
	</br>
	<h4 style="text-align:left;"> Below, you can see description of the all parameters, just click on its name </h4>
	
	<div class="tabbable param_descrip_modal"> 
		<ul class="nav nav-tabs">
			<?php $i_nav_param_descrip = 1; foreach ($patterns as $key => $val) { ?>
				<li <?php if($i_nav_param_descrip ==1) echo  "class=\"active\"";?> ><a href="#descrip-<?php echo $key; ?>" data-toggle="tab">!<?php echo $key; ?></a></li>
			<?php $i_nav_param_descrip++; } ?>
		</ul>
		
		<div class="tab-content">
			<?php $i_nav_param_descrip = 1; foreach ($patterns as $key => $val) { ?>
				<div class="tab-pane <?php if($i_nav_param_descrip ==1) echo  "active";?>" id="descrip-<?php echo $key; ?>">
					<h3 style="text-align:left;"><?php echo $val['name']; ?></h3>
					<?php if(isset($val['descrip'])) {?>
						<p class="lead" ><?php echo $val['descrip']; ?></p>
					<?php } ?>
					<?php if(isset($val['images'])) {
						foreach ($val['images'] as $image) {?>
							<img class="pull-left" src="view/stylesheet/superseobox/images/param_descrip/<?php echo $image['file'] ?>" class="">
							<p class="clearfix lead" ><?php echo $image['text'] ?></p>
					<?php }} ?>
				</div>
			<?php $i_nav_param_descrip++; } ?>
		</div>	
	</div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
