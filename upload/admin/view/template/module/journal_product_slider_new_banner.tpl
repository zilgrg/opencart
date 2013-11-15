<?php echo $header; ?>
<div id="content">
      <!-- <div class="loader"> <p>Loading...</p></div> -->
    <div class="heading">
      <h1> <?php echo $doc_title; ?></h1>
      <div class="links">
          <a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
          <a href="http://journal.digital-atelier.com/docs" class="docs-link" target="_blank">Documentation</a>
      </div>
      <div class="buttons"><a onclick="$('#form').submit();" class="btn btn-success"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a></div>
    </div>
    <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">

    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form new-banner">
          <tr>
            <td><?php echo $entry_name; ?></td>
            <td>
              <input style="width:88px"  type="text" name="banner_options[name]" value="<?php echo $options['name']; ?>" size="100" />
              <?php if ($error_name) { ?>
              <span class="error"><?php echo $error_name; ?></span>
              <?php }?>
            </td>
          </tr>

          <tr>
            <td>Module Title</td>
            <td><?php foreach ($languages as $language) { $value = isset($options['header'][$language['language_id']]) ? $options['header'][$language['language_id']] : '';?>
              <input type="text" class="large" name="banner_options[header][<?php echo $language['language_id']; ?>]" value="<?php echo $value; ?>" /> <img class="flag" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td>
              <?php echo $entry_effect; ?>
            </td>
            <td class="left fx"><select name="banner_options[fx]">
                <?php foreach ($banner_effects as $effect => $effect_name): ?>
                  <?php $selected = $effect === $options['fx'] ? 'selected' : ''; ?>
                  <?php $disabled = $effect[0] === '-' ? 'disabled' : ''; ?>
                  <option value="<?php echo $effect;?>" <?php echo $selected; ?> <?php echo $disabled; ?>><?php echo $effect_name;?></option>
                <?php endforeach; ?>
              </select>
            </td>
          </tr>

          <tr>
            <td>Transition Speed</td>
            <td><input style="width:42px" type="text" name="banner_options[time]" value="<?php echo $options['time']; ?>" size="5" />
              <?php if ($error_interval) { ?>
              <span class="error"><?php echo $error_interval; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td>Slide Interval</td>
            <td><input style="width:42px" type="text" name="banner_options[transPeriod]" value="<?php echo $options['transPeriod']; ?>" size="5" />
            <?php if ($error_speed) { ?>
             <span class="error"><?php echo $error_speed; ?></span>
            <?php } ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_show_bullets; ?></td>
            <td class="left"><select class="yes_no" name="banner_options[pagination]">
                  <?php if ($options['pagination'] === 'y') { ?>
                  <option value="y" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="n"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="y"><?php echo $text_yes; ?></option>
                  <option value="n" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
          </tr>

          <tr>
            <td><?php echo $entry_auto_play; ?></td>
            <td class="left"><select class="yes_no" name="banner_options[autoAdvance]">
                  <?php if ($options['autoAdvance'] === 'y') { ?>
                  <option value="y" selected="selected"><?php echo $text_yes; ?></option>
                  <option value="n"><?php echo $text_no; ?></option>
                  <?php } else { ?>
                  <option value="y"><?php echo $text_yes; ?></option>
                  <option value="n" selected="selected"><?php echo $text_no; ?></option>
                  <?php } ?>
                </select></td>
          </tr>
        </table>
        <table id="images" class="list">
          <thead>
            <tr>
              <td class="left">Product <i>(Auto-complete)</i></td>
              <td class="left">Remove</td>
            </tr>
          </thead>
          <?php $image_row = 0; ?>
          <?php foreach ($banner_products as $product) : ?>
          <tbody id="image-row<?php echo $image_row; ?>">
            <tr>
              <td class="left">
                <input type="text" class="autocomplete" value="<?php echo $product['name']; ?>" /><input type="hidden" name="banner_products[]" value="<?php echo $product['id']; ?>" /></td>
              <td class="right"><a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $image_row++; endforeach; ?>
          <tfoot><tr>
            <td colspan="5" class="right"><a onclick="addProduct();" class="btn btn-primary" style='float: right; margin-right: 93px;'><?php echo $button_add_product; ?></a></td>
          </tr></tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$(function(){
  $('select[name="banner_type"]').change(function(){
    $(".settings").hide();
    $("." + $(this).val()).show();
  });
  $(".settings").hide();
  $("." + $('select[name="banner_type"]').val()).show();
});

var image_row = <?php echo $image_row; ?>;

function addProduct() {
  html  = '<tbody id="image-row' + image_row + '">';
  html += '<tr>';
  html += '<td class="left">';
  html += '<input type="text" class="autocomplete" value="" /><input type="hidden" name="banner_products[]" value="" /></td>';
  html += '<td class="right"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn"><?php echo $button_remove; ?></a></td>';
  html += '</tr>';
  html += '</tbody>';

  $("table tfoot").before(html);

  image_row++;

  addAutoComplete();
}

function addAutoComplete() {
$('.autocomplete').autocomplete({
  delay: 0,
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item.name,
            value: item.product_id,
            model: item.model
          }
        }));
      }
    });
  },
  select: function(event, ui) {
    $(this).attr('value', ui.item.label);
    $(this).siblings('input').first().attr('value', ui.item.value);
    return false;
  },
  focus: function(event, ui) {
        return false;
    }
});
}
addAutoComplete();

//--></script>
<?php echo $footer; ?>