<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">Canonical link</label>
		<div class="controls">
			<input type="hidden" name="data[tools][canonical][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['canonical']['status']) echo 'checked="checked"'; ?> name="data[tools][canonical][status]" class="on_off noAlert">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/Cm9onOGTgeM?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>What is a canonical page?</h3>

<p>A canonical page is the preferred version of a set of pages with highly similar content.</p>
<h3>Why specify a canonical page?</h3>
<p>It's common for a site to have several pages listing the same set of products. For example, one page might display products sorted in alphabetical order, while other pages display the same products listed by price or by rating. For example:</p>
<pre>http://www.site.com/category1/subcategory2/product.php?sort=alpha
http://www.site.com/category2/product.php&sort=price</pre>
<p>If Google knows that these pages have the same content, we may index only one version for our search results. Our algorithms select the page we think best answers the user's query. Now, however, users can specify a canonical page to search engines by adding a <code>&lt;link&gt;</code> element with the attribute <code>rel="canonical"</code> to the <code>&lt;head&gt;</code> section of the non-canonical version of the page. Adding this link and attribute lets site owners identify sets of identical content and suggest to Google: "Of all these pages with identical content, this page is the most useful. Please prioritize it in search results."</p>
<h3>How do this module specify a canonical URL?</h3>
<p>This module specify a canonical URL in the way:</p>
<ul>
	<li><strong>Add a <code>rel="canonical"</code> link to the <code>&lt;head&gt;</code> section of the non-canonical version of each HTML page.</strong>
		<p>To specify a canonical link to the page http://www.site.com/category1/subcategory2/product.php?sort=alpha, create a <code>&lt;link&gt;</code> element as follows:</p>
		<pre>&lt;link rel="canonical" href="http://www.site.com/product.php"&gt;</pre> and this product will be access on this address.
	</li>
</ul>
<h3>Is rel="canonical" a suggestion or a directive?</h3>
<p>This new option lets site owners suggest the version of a page that Google should treat as canonical. Google will take this into account, in conjunction with other signals, when determining which URL sets contain identical content, and calculating the most relevant of these pages to display in search results.</p>
<h3>Must the content on a set of pages be similar to the content on the canonical version?</h3>
<p>Yes. The <code>rel="canonical"</code> attribute should be used only to specify the preferred version of many pages with identical content (although minor differences, such as sort order, are okay).</p>
<p>For instance, if a site has a set of pages for the same model of dance shoe, each varying only by the color of the shoe pictured, it may make sense to set the page highlighting the most popular color as the canonical version so that Google may be more likely to show that page in search results. However, <code>rel="canonical"</code> would not be appropriate if that same site simply wanted a gel insole page to rank higher than the shoe page.</p>

<button onClick = "alert(('.node').getSelected().join(''))" value= "Show selected">Show selected</button>

<script>

(function($){
  $.fn.getSelected = function(o){

 

        var str = [];

 

  $(this).each(function(){

                var id = $(this).attr('id');

    str.push(id.replace(/[^d]+/,''));

    });

  return str;

  }

})(jQuery);

 

/* ????????? Ctrl, Shift */

 

(function($){

  $.fn.shifty = function(o){

    var o = $.extend({

      className:'selected', // ???????? ?????? ?? ?????????

      select:function(){},  // ??????? ??? ?????????

      unselect:function(){} // ??????? ??? ?????? ?????????

    }, o);

    elems = $(this); // ???????? ????????

    last = null;

    var className = o.className; // ? ???????? ??????

    return $(this).each(function(){

              var block = $(this); // ???????? ? ????????? ?????????       

                     this.onselectstart = function(){return false}; // ??????? ?????? ????????? ? IE

        block.unbind('click').css({'-moz-user-select':'','-webkit-user-select':'','user-select':''}); // ? ? ????????? ?????????

                block.click(function(e){ // ??? ??????? ???????

                    if (!e.ctrlKey && !e.shiftKey) {

             elems.removeClass(className); // ??????? ????????? ?? ???? ?????????

              $(this).addClass(className); // ????????? ????????? ? ???????? ????????

              o.unselect(elems); // ?? ?? ????? ? ???????????????? ????????

              o.select($(this));

                    last = elems.index($(this));

          }

                if (e.ctrlKey) {  // ???? ?????? ??????? ctrl

                  block.toggleClass(className); // ??????? ???? ????????? ?????????

                  last = elems.index(block); // ?????????? ????? ????????

                  o.unselect(elems); // ??????? ?????????, ???????? ???????????????? ???????

                  o.select(elems.filter('.' + className)); // ????????? ???????????????? ??????? ??? ?????????? ?????????

          }

          if (e.shiftKey) { // ???? ?????? ??????? shift        

                  first = elems.index(block); // ??????? ???????, ? ???????? ???????? ?????????

                  if (first < last) { // ???????? ??????????? ???????? ? ??????????? ?? ???????????

                    elems.filter(':gt(' + (first - 1) + ')').addClass(className);

                    elems.filter(':lt(' + first + '),:gt(' + last + ')').removeClass(className);

                  } else {

                    elems.filter(':gt(' + last + ')').addClass(className);

                    elems.filter(':lt(' + last + '),:gt(' + first + ')').removeClass(className);

                  }

                  o.unselect(elems);  // ??????? ????????? ???????????????? ????????

                  o.select(elems.filter('.' + className)); // ????????? ???????????????? ??????? ??? ????????

          }

              });       

    });

  };

})(jQuery);


$(document).ready(function(){
    $('*').click(function(e) {
		if (e.ctrlKey) {
			var nodeName = $(this)[0].nodeName.toLowerCase();
			var nodes = ['div', 'p', 'span', 'label', 'li'];
			if(nodeName == 'span' || nodeName == 'div' || nodeName == 'p' || nodeName == 'label'){
				console.log(nodeName);
				$(this).addClass('selected');
				event.stopPropagation();
				return false;
			}
		}
    });
});

</script>

<style>
.selected {
background-color:#fff;
border: 1px solid red;
} 
.node {
-moz-user-select':'none';
'-webkit-user-select':'none';
'user-select':'none';
}

</style>
