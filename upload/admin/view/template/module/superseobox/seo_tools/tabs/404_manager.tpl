<div class="pull-left" style="margin-bottom:20px; margin-right:30px;">
<div class="control-group">
	<div class="controls">
		<?php 
		$additional_data = 'additionData[function]=setRedirect404Data';
		$review_url = $this->url->link('module/superseobox/ajax', 'token=' . $this->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_tools/modal/redirect_404&'.$additional_data, 'SSL');
		?>
		
		<a style="color: #fff;" data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $review_url; ?>" class="btn btn-warning redirect_404_open" type="button" data-toggle="modal">Open table with existing urls</a>
	</div>
</div>
</div>
<h3>Easily redirect 404s to suggested SEO URLs</h3>
<p class="colorFC580B">
	This feature works only if  SEO URLs was generated and active (see in tab generators -&gt; SEO URLs)
</p>
<p>The 404 manager presents you with a list of urls that were requested by visitors and that could not be found on your site.</p>
<p>It is quite important to monitor these pages, as they can be the sign of:</p>
<ul>
	<li>
		bad links on your site
	</li>
	<li>
		links that you updated on your site, but are still bookmarked by users, while you did not provide an automatic redirect from the old address to the new one
	</li>
</ul>
<p>Of course, most of the times, 404 requests will simply comes from typos in links, or possibly failed attacks on your site. But if one of the options listed above is true, you should take appropriate measures and fix the broken links, or create redirects as needed, so that users can update their bookmarks. Please note that the same apply to search engines, and so if you changed one or more of your urls, you must to make sure you provide them with a way to find the new urls.</p>
<p>If needed, you can click on one of the url record listed, and associate it with one of your site SEO url:</p>
<p>From a SEO standpoint, it is very important that a page you removed from your site be recorded as such by search engines. It means either you set up a 301 redirect from the old url to the page that replaces it - using 404 manager, or a .htaccess redirect rule - or you simply let the 404 error happens.</p>
<p>Search engines will record that the old page no longer exists. If you provided a redirect, it will record the new page instead. If not, it will simply discard the content of the old page.</p>