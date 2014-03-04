<div id="qa" class="tab-pane active">
<ul class="media-list q-list">
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q1</div>
    </a>
    <div class="media-body" data-position="bottom" data-intro="And on the end, we recommend start your work with reading Frequently Asked Questions, which you find in tab Get Support -> Frequently Asked Questions" data-step="11">
		<h4 class="media-heading">How do I get started with Generator tab properly?</h4>
		Firstly, you must do backup of your Database, here you can learn about it:
		<a href="http://www.siteground.com/tutorials/php-mysql/mysql_export.htm" target="_blank">MySQL Backup/Restore Tutorial</a></br>
		Secondly, you must go to "Generators" -> "Setting" and:</br>
		<ul>
			<li>Get countries for parameter !wc (World's countries)</li>
			<li>Get cities for parameter !wt (World's towns)</li>
			<li>Then you can go to generate SEO items for every tabs</li>
		</ul>
    </div>
  </li>
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q2</div>
    </a>
    <div class="media-body">
		<h4 class="media-heading">I have generated SEO URLs, and after this I got 404 error in the front. What do I do wrong?</h4>
		You must find in main folder of website file .htaccess.txt and rename it to .htaccess
    </div>
  </li>
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q3</div>
    </a>
    <div class="media-body">
		<h4 class="media-heading">I generated SEO URLs, but in address field I still see route, product_id and other parameters. What do I do wrong?</h4>
		You must find in main folder of website file .htaccess.txt and rename it to .htaccess
    </div>
  </li>
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q4</div>
    </a>
    <div class="media-body">
		<h4 class="media-heading">I have site in subdirectory. After generating SEO URLs, I got "Page not found...". What I must to do?</h4>
		The best way to do this is in the HTACCESS file. 
		You must find the line:</br>
		<pre>RewriteRule ^([^?]*) index.php?_route_=$1 [L,QSA]</pre>
		And replace it on:
		<pre>RewriteRule ^([^?]*) SUBDIRECTORY/index.php?_route_=$1 [L,QSA]</pre>,
		WHERE SUBDIRECTORY - name of your directory, where installed Opencart site
    </div>
  </li>
    <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q5</div>
    </a>
    <div class="media-body">
      <h4 class="media-heading">Is there a limit on the number of products or category in Database for normal work this module?</h4>
		We tested this module on website with more 8000 items of products and, for example, for generate tags for all products this module having spent 13.56 sec. Our algorithm for generating SEO items uses minimal number of request to database, before start generate it prepares all necessary data and put it to cache and then works only with cache, that improves it speed
    </div>
  </li>
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q6</div>
    </a>
    <div class="media-body">
      <h4 class="media-heading">How much time I need for SEO improving in  SERP(Search Engine Results Page),  after generating all items, and switching-on all SEO features?</h4>
		For acceleration SERP, after SEO optimization, you must:</br>
		<ul>
			<li>Generate new XML Sitemap for your site, for example <a href="http://www.web-site-map.com" target="_blank">here</a></li>
			<li>Inform Google, Yahoo, Bing and other search engines about new XML map, and invite them spiders on yours website.</li>
			<li>After that, you have to wait 2-4 weeks for the results</li>
		</ul>
    </div>
  </li>
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q7</div>
    </a>
    <div class="media-body">
      <h4 class="media-heading">What is the difference between Paladins SEO and Nitro?</h4>
		This is different modules, and each of it does other work.</br>
		Nitro - creates cache for every page for enhance speed of download pages;</br>
		PSM - create additional code, HTML  and SEO URLs for every page for enhance  search engine results page (SERP);
	</div>
  </li>  
  <li class="media">
 	<a class="pull-left q-a">
      <div class="q-icon">Q8</div>
    </a>
    <div class="media-body">
      <h4 class="media-heading">Is it possible to do the same URLs that "PACk SEO PRO"?</h4>
		We can guarantee, that all urls will be same on 95%.</br> If you have a few languages, URLs will not be same, because PACk SEO PRO adds language code to keyword, but Paladin SEO creates virtual subdirectory, for example:</br>
		<pre>PACk SEO PRO (French): mysite.com/category/product-fr.html</pre>
		<pre>Paladin SEO (French):&nbsp; mysite.com/category/fr/product.html</pre>
		</pre>
	</div>
  </li>    
</ul>

<style>
.q-list a.q-a:hover {
	text-decoration:none;
	cursor:default;
}

.q-list .media-body {
	color:#777;
	font-weight:normal;	
	display: table-cell;
	vertical-align: middle;
	height: 64px;
}

.q-list .media-heading {
	color:#555;
	font-weight:normal;	
	font-size:18px;
	margin-top:3px;
}

.q-icon {
	width:64px;
	height:64px; 
	background: #cecece;
	border-radius: 60px;
	color: white;
	line-height: 64px;
	text-align: center;
	font-size: 22px;
}
</style>
</div>