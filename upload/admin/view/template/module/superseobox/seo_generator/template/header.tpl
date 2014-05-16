<form class="form-horizontal">
<table class="table table-condensed no-border">
	<tbody>
	<tr>
	<td colspan="2">
		<h3><?php echo ${'gen_tab_content_name_'.$entity_category_name}; ?></h3>
			<div class="accordion-group info-area">
				<div class="accordion-heading" <?php if($entity_category_name == 'urls') { ?> data-intro="Click here to see context help and template examples for every tabs" data-step="5" data-position="bottom" <?php } ?> >
				  <a class="accordion-toggle" data-toggle="collapse" href="#example-<?php echo $entity_category_name; ?>">
					<span class="lead">Click here to see help and example of writing template for <?php echo ${'text_category_name_'.$entity_category_name}; ?></span>
				  </a>
				</div>
				<div id="example-<?php echo $entity_category_name; ?>" class="accordion-body collapse out">
					<div class="accordion-inner">
						<button type="button" class="close">x</button>
						<?php echo ${'gen_tab_content_exapmle_'.$entity_category_name}; ?>
						<div class="alert">
						<h4>SUPPORT SPIN FORMAT!</h4> 
						<h5>
							Generator supports Spin format. For example if you wrote the next template:
							<pre>{buy|cheap|discount on} the !pn {on sale|and free shipping|online}</pre>
							, then you get unique texts for differents pages:
							<pre>1. cheap the Canon EOS on sale
2. buy the Apple Cinema 30" online
3. discount on the Ipod Touch  and free shipping</pre>
							This example of template gives 9 unique texts 3X3, but if you add a new spin text, for example:
							<pre>{Only today|Quick|Fast} {buy|cheap|discount on} the !pn {on sale|and free shipping|online}</pre>
							, you can get 3X3X3 = 27 combination of texts!
						</h5>
						</div>
					</div>
				</div>
			</div>

	</td>
	</tr>