<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-category">
      <ul>
        <?php foreach ($categories as $category) { ?>
        <li>
          <?php if ($category['category_id'] == $category_id) { ?>
          <a href="<?php echo $category['href']; ?>" class="filter-active"><?php echo $category['name']; ?><span>-</span></a>
          <?php } else { ?>
          <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?><span>+</span></a>
          <?php } ?>
          <?php if ($category['children']) { ?>
          <ul>
            <?php foreach ($category['children'] as $child) { ?>
            <li>
              <?php if ($child['category_id'] == $child_id) { ?>
              <a href="<?php echo $child['href']; ?>" class="filter-active"> - <?php echo $child['name']; ?></a>
              <?php } else { ?>
              <a href="<?php echo $child['href']; ?>"> - <?php echo $child['name']; ?></a>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

$(function(){
  $('.box-category a > span').each(function(){
    if (!$('+ ul', $(this).parent()).length) {
      $(this).hide();
    }
  });
  $('.box-category a > span').click(function(e){
    e.preventDefault();
    $('+ ul', $(this).parent()).slideToggle();
    $(this).parent().toggleClass('active');
    $(this).html($(this).parent().hasClass('active') ? "-" : "+");
    return false;
  });
  $('.filter-active span').click();
});
//--></script>
