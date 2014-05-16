<div class="pull-left form-horizontal" style="margin-right:25px;width: 500px;">
	<div class="control-group">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Mode for product</label>
				<?php $mode = $data['tools']['path_manager']['data']['product']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="direct" class="btn btn-success <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set direct path" >
						Direct</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="shortest" class="btn btn-success <?php if($mode == 'shortest') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set shortest path" >
						Shortest</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="longest" class="btn btn-success <?php if($mode == 'longest') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set largest path" >
						Longest</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul path for breadcrumbs" >
						Default</a>
					</div>
					<input type="hidden" name="data[tools][path_manager][data][product][mode]" value="<?php echo $mode; ?>">
				</div>				
			</div>
		</form>
	</div>
	
	<div class="control-group">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Mode for category</label>
				<?php $mode = $data['tools']['path_manager']['data']['category']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="direct" class="btn btn-success <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set direct path for breadcrumbs" >
						Direct</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="full" class="btn btn-success <?php if($mode == 'full') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set shortest path for breadcrumbs" >
						Full</a>
						<a type="button" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul path for breadcrumbs" >
						Default</a>
					</div>
					<input type="hidden" name="data[tools][path_manager][data][category][mode]" value="<?php echo $mode; ?>">
				</div>				
			</div>
		</form>
	</div>
</div>
<p class="colorFC580B">
	This feature works only if  SEO URLs was generated (see in tab generators -&gt; SEO URLs)
</p>
<h5>Get full control on your links for the pages of category and product.</h5>
Here you can set mode for creating links of products on the next pages:
<ul class="pull-right" style="margin-right: 200px;">
	<li>categories pages</li>
	<li>products pages</li>
	<li>related products pages</li>
	<li>compare products pages</li>
	<li>bestseller products pages</li>
	<li>latest products pages</li>
	<li>special products pages</li>
	<li>search products pages</li>
	<li>featured products pages</li>
</ul>

<p style="clear: both;">As you saw many of the urls of products, has direct links without category path, or have urls which contain different categories. </br>After activate this function you will have only one path to a product, that will improve navigation and eliminate duplicates of pages with different links.<br> 
<span style="font-weight:bold;">With this function your site will be working with rule: "ONE PAGE - ONE PRODUCT - ONE LINK"</span></p>

<h4>You can set the next mode for creating links:</h4>
<dl>
	<dt>Direct</dt>
	<dd>
		This mode creates links to products without any categories
		Links on the products will be creating by the next scheme:
		<pre>www.site.com/product_name.html</pre>
	</dd>
	<dt>Shortest</dt>
	<dd>
		In this mode will be created more shortest link on products. For example, if your product "product_name" there is in a few categories:
		<pre>www.site.com/category_X/subcategory_Y/product_name.html
www.site.com/category_Z/product_name.html</pre>
		, then will be shown shortest link  <pre>www.site.com/category_Z/product_name.html</pre>
	</dd>
	<dt>Longest</dt>
	<dd>
		In this mode will be created more longest link on products. For example, if your product "product_name" there is in a few categories:
		<pre>www.site.com/category_X/subcategory_Y/product_name.html
www.site.com/category_Z/product_name.html</pre>
		, then will be shown longest link  <pre>www.site.com/category_X/subcategory_Y/product_name.html</pre>
	</dd>
	<dt>Full (only for categories)</dt>
	<dd>
		In this mode will be created full path to category, for examle:
		<pre>www.site.com/category_X/subcategory_Y/subcategory_Z
www.site.com/category_Z</pre>
		,  then will be shown longest link  <pre>www.site.com/category_X/subcategory_Y/subcategory_Z</pre>
	</dd>
	<dt>Default</dt>
	<dd>
		This is standard Opencart logic for create links. Paladin don't generate any links.
	</dd>
</dl>