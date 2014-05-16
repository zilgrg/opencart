<div class="span6 pull-left" style="margin: 0 10px 20px 0;">
	<div class="control-group form-horizontal">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Mode for product</label>
				<?php $mode = $data['tools']['seo_breadcrumbs']['data']['product']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="direct" class="btn btn-success <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set direct path for breadcrumbs" >
						Direct</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="shortest" class="btn btn-success <?php if($mode == 'shortest') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set shortest path for breadcrumbs" >
						Shortest</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="longest" class="btn btn-success <?php if($mode == 'longest') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set largest path for breadcrumbs" >
						Longest</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul path for breadcrumbs" >
						Default</a>
					</div>
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][product][mode]" value="<?php echo $mode; ?>">
				</div>
			</div>
		</form>
	</div>
	
	<div class="control-group form-horizontal">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Mode for category</label>
				<?php $mode = $data['tools']['seo_breadcrumbs']['data']['category']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="direct" class="btn btn-success <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set direct path for breadcrumbs" >
						Direct</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="full" class="btn btn-success <?php if($mode == 'full') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set shortest path for breadcrumbs" >
						Full</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul path for breadcrumbs" >
						Default</a>
					</div>
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][category][mode]" value="<?php echo $mode; ?>">
				</div>
			</div>
		</form>
	</div>

	<div class="row">
		<div class="span3">
			<div class="control-group">
				<label class="control-label">Reverse breadcrumbs for product</label>
				<div class="controls">
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][product][reverse]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_breadcrumbs']['data']['product']['reverse']) echo 'checked="checked"'; ?> name="data[tools][seo_breadcrumbs][data][product][reverse]" class="on_off">
				</div>
			</div>	
		</div>
		<div class="span3">
			<div class="control-group">
				<label class="control-label">Reverse breadcrumbs for category</label>
				<div class="controls">
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][category][reverse]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_breadcrumbs']['data']['category']['reverse']) echo 'checked="checked"'; ?> name="data[tools][seo_breadcrumbs][data][category][reverse]" class="on_off">
				</div>
			</div>		
		</div>
	</div>
	<div class="row">
		<div class="span3">
			<div class="control-group">
				<label class="control-label">Add title to "Home section"</label>
				<div class="controls">
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][additional][title]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_breadcrumbs']['data']['additional']['title']) echo 'checked="checked"'; ?> name="data[tools][seo_breadcrumbs][data][additional][title]" class="on_off">
				</div>
			</div>
		</div>
		<div class="span3">
			<div class="control-group">
				<label class="control-label">Change "Home section" on "Store name"</label>
				<div class="controls">
					<input type="hidden" name="data[tools][seo_breadcrumbs][data][additional][home_to_store]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_breadcrumbs']['data']['additional']['home_to_store']) echo 'checked="checked"'; ?> name="data[tools][seo_breadcrumbs][data][additional][home_to_store]" class="on_off">
				</div>
			</div>	
		</div>
	</div>	
</div>

<h3>Improve your breadcrumbs</h3>

<p>Here you can easily customize your breadcrumbs for displayed full structure path for products and categories pages. </br>This function works for the next pages:
<ul>
	<li>category pages</li>
	<li>product pages</li>
</ul>

<p style="clear:both;">Look when you enter on product pages from home page, for example, after clicked on one of product on the bestseller products list, you go on product page, and what you see on the breadcrumbs:
<pre>Home >> Product name</pre>
, but if you enter on this page from category you will see:
<pre>Home >> Category >> Product name</pre>
When you use this function you will be have the same breadcrumbs, no matter where you click on this product (bestseller, latest, special, search, e.t.c, ).</p>

<h4>Additional functions</h4>
<p>
1. When you turn ON function "Reverse breadcrumbs", all your breadcrumbs will be exchange the places:
<pre>Product name >> Category >> Home</pre> 
</p>
<p>2. Function the "Add title to store name", adds title to "Home section":
<pre>Product name << Category << Home | Store Title </pre> 
</p>
<p>3. Function the "Change home on Store name", replaces text "Home section" on the breadcrumbs on "Store name":
<pre>Product name >> Category >> Store name </pre> 
</p>

<script>
	function setRadiobuttonValue(){
		
	}
</script>