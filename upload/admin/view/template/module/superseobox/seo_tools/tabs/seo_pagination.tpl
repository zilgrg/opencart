<div class="pull-left">
	<div class="control-group">
		<label class="control-label">Change the pagination to SEO format</label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][status]" value="">
			<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['status']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][status]" class="on_off">
		</div>
	</div></br>
	<div class="control-group">
		<label class="control-label">Add the pagination to the header section</label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][data][pag_link_in_header]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['data']['pag_link_in_header']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][data][pag_link_in_header]" class="on_off">
		</div>
	</div></br>
	<div class="control-group">
		<label class="control-label">Add to the title "Page [number]" for pages of categories and brands.</label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][data][add_pag_title]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['data']['add_pag_title']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][data][add_pag_title]" class="on_off">
		</div>
	</div>
	
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/njn8uXTWiGg" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>

<p class="colorFC580B">
	This feature works only if  SEO URLs was generated (see in tab generators -&gt; SEO URLs)
</p>

<h3>Indicate paginated content</h3>

<p>Sites paginate content in various ways. If you paginate content on your site, and you want that content to appear in search results, we recommend turn ON the two next options.</p>

<ul>
  <li><strong>Change links in the pagination block to SEO format</strong> When your numbers of page will be placed in the path of your URLs, then Google and other search engines can see this pages. And add their to the search engine results page (SERP)</li>
  <li><strong>Use <code>rel="next"</code> and <code>rel="prev"</code> links</strong> to indicate the relationship between component URLs. This markup provides a strong hint to Google that you would like us to treat these pages as a logical sequence, thus consolidating their linking properties and usually sending searchers to the first page.</li>
</ul>

<h3>Using rel="next" and rel="prev"</h3>

<p>You can use the HTML attributes <code>rel="next"</code> and <code>rel="prev"</code> to indicate the relationship between individual URLs. Using these attributes is a strong hint to Google that you want us to treat these pages as a logical sequence.</p>

<p>Let's say you have content paginated into the following URLs:</p>

<pre>
http://www.site.com/catalog?page=1
http://www.site.com/catalog?page=2
http://www.site.com/catalog?page=3
http://www.site.com/catalog?page=4
</pre>

<ol>
  <li>The firstly, all links will be changed to SEO format, like this:
	<pre>
	http://www.site.com/catalog/page-1
	http://www.site.com/catalog/page-2
	http://www.site.com/catalog/page-3
	http://www.site.com/catalog/page-4</pre>
  </li>	
  <li>In the <code>&lt;head&gt;</code> section of the first page (http://www.site.com/catalog/page-1), add a link tag pointing to the next page in the sequence, like this:

    <pre>&lt;link rel="next" href="http://www.site.com/catalog/page-2"&gt;</pre>

    <p>Because this is the first URL in the sequence, there's no need to add markup for <code>rel="prev"</code>.</p>
  </li>
  <li>On the second and third pages, add links pointing to the previous and next URLs in the sequence. For example, you could add the following to the second page of the sequence:
    <pre>&lt;link rel="prev" href="http://www.site.com/catalog/page-1"&gt;
&lt;link rel="next" href="http://www.site.com/catalog1/page-3"&gt;
</pre>
  </li>
  <li>On the final page of the sequence (http://www.site.com/catalog1/page-4&gt;), add a link pointing to the previous URL, like this:
    <pre>&lt;link rel="prev" href="http://www.site.com/catalog1/page-3"&gt;</pre>

    <p>Because this is the final URL in the sequence, ther's no need to add a <code>rel="next"</code>&nbsp;link.</p>
  </li>
</ol>