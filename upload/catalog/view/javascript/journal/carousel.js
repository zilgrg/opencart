(function($){

	$(function(){
		$('#container .box').each(function(){
			var $ul = $('<ul>');
			$(this).find('.box-product > div').each(function(){
				var $li = $('<li>');
				$li.append($(this));
				$ul.append($li);
			});
			$(this).append($ul);

		});
	});

})(jQuery);