<p>Enter the verify meta values for:</p>
<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="https://www.google.com/webmasters/tools/dashboard?hl=en&amp;siteUrl=<?php  echo urlencode(HTTP_CATALOG); ?>%2F">Google Webmaster Tools</a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][google]" value="<?php echo $data['tools']['webm_tool']['data']['google']; ?>">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="http://www.bing.com/webmaster/?rfp=1#/Dashboard/?url=<?php echo str_replace( 'http://', '', HTTP_CATALOG ) ?>">Bing Webmaster Tools</a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][bing]" value="<?php echo $data['tools']['webm_tool']['data']['bing']; ?>">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="http://www.alexa.com/pro/subscription">Alexa Verification ID</a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][alexa]" value="<?php echo $data['tools']['webm_tool']['data']['alexa']; ?>">
		</div>
	</div>
<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn btn-success ajax_action span2" type="button">Save</a>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/COcl6ax38IY?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<p>
You can use the boxes above to verify with the different Webmaster Tools, if your site is already verified, you can just forget about these.
</p>
<p>What is a Google Webmaster Tools? </br>Google Webmaster Tools is a no-charge web service by Google for webmasters. It allows webmasters to check indexing status and optimize visibility of their websites. It is part of a marketing effort to reach out to Webmasters and promote Google services. This is borne out by the fact that the tool does NOT cover search results from other search engines, such as Bing, Yahoo, or Baidu - something that is not clearly highlighted and understood by users.</p>

<p>It has tools that let the webmasters:</p>

<ul>
	<li>Submit and check a <a href="/wiki/Sitemap" title="Sitemap" class="mw-redirect">sitemap</a></li>
	<li>Check and set the crawl rate, and view statistics about how <a href="/wiki/Googlebot" title="Googlebot">Googlebot</a> accesses a particular site</li>
	<li>Generate and check a <a href="/wiki/Robots.txt" title="Robots.txt" class="mw-redirect">robots.txt</a> file. It also helps to discover pages that are blocked in robots.txt by chance.</li>
	<li>List internal and external pages that link to the site</li>
	<li>Get a list of broken links for the site</li>
	<li>See what keyword searches on Google led to the site being listed in the <a href="/wiki/Search_engine_results_page" title="Search engine results page">SERPs</a>, and the click through rates of such listings</li>
	<li>View statistics about how Google indexes the site, and if it found any errors while doing it</li>
	<li>Set a preferred domain (e.g. prefer example.com over www.example.com or vice versa), which determines how the site URL is displayed in SERPs</li>
	<li>highlight to <a href="/wiki/Google_Search" title="Google Search">Google Search</a> elements of structured data which are used to enrich search hit entries (released in December 2012 as Google Highlighter)<sup id="cite_ref-boudreaux2013_1-0" class="reference"><a href="#cite_note-boudreaux2013-1"><span>[</span>1<span>]</span></a></sup></li>
</ul>
