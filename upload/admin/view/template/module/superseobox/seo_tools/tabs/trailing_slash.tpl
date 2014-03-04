<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">Trailing slash of URL</label>
		<div class="controls">
			<input type="hidden" name="data[tools][trailing_slash][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['trailing_slash']['status']) echo 'checked="checked"'; ?> name="data[tools][trailing_slash][status]" class="on_off noAlert">
		</div>
	</div>
</div>

<h3>To slash or not to slash?</h3>
<p class="colorFC580B">
Don't use this feature, if your site is in the subdirectory
</p>
<p class="colorFC580B">
This feature work only if  SEO URLs was generated (see in tab generators -> SEO URLs)
</p>
<p>Look below:</p>
<pre>
http://example.com/foo/ (with trailing slash, conventionally a directory)
http://example.com/foo (without trailing slash, conventionally a file)
</pre>
<p>From a technical, search engine standpoint, it's certainly permissible for these two URL versions to contain different content. Your users, however, may find this configuration horribly confusing -- just imagine if www.google.com/webmasters and www.google.com/webmasters/ produced two separate experiences.</p>
<p>For this reason, trailing slash and non-trailing slash URLs often serve the same content. The most common case is when a site is configured with a directory structure:
http://example.com/parent-directory/child-directory/</p>

<p>You can do a quick check on your site to see if the URLs:</br></br>
http://your-domain-here/some-directory-here/ 
(with trailing slash)</br></br>
http://your-domain-here/some-directory-here 
(no trailing slash)</br></br>
don't both return a 200 response code, but that one version redirects to the other.

<ul>
<li>If only one version can be returned (i.e., the other redirects to it), that's great! This behavior is beneficial because it reduces duplicate content. In the particular case of redirects to trailing slash URLs, our search results will likely show the version of the URL with the 200 response code (most often the trailing slash URL) -- regardless of whether the redirect was a 301 or 302.</li>
<li>If both slash and non-trailing-slash versions contain the same content and each returns 200, you can <span class="colorFC580B">TURN ON THIS FUNCTION</span>, and will be OK</li>
</ul>
</p>
