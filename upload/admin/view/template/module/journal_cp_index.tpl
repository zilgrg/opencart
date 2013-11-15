<?php
  // echo "<pre>" . print_r($journal_settings['menus']['subcategories']['categories_menu'], TRUE) . "</pre>"; die();
  function generate_text($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    echo '<input type="text" name="journal_settings[' . $setting['name'] . ']" value="' . $value . '" data-default="' . htmlspecialchars($setting['default_value']) . '" />';
  }

  function generate_select($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    $cls = count($setting['options']) === 2 ? 'class="yes_no"' : '';
    echo '<select ' . $cls . ' name="journal_settings[' . $setting['name'] . ']" data-default="' . htmlspecialchars($setting['default_value']) . '">' ."\n";
    foreach($setting['options'] as $option_key => $option_value) {
      if ($setting['value'] == $option_key) {
        echo '<option value="' . $option_key . '" selected="selected">' . $option_value . '</option>' ."\n";
      } else {
        echo '<option value="' . $option_key . '">' . $option_value . '</option>' ."\n";
      }
    }
    echo '</select>' ."\n";
  }

  function generate_color($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    echo '<input type="text" name="journal_settings[' . $setting['name'] . ']" value="' . $value . '" class="color {required:false}" data-default="' . htmlspecialchars($setting['default_value']) . '" />';
  }

  function generate_textarea($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    echo '<textarea name="journal_settings[' . $setting['name'] . ']" data-default="' . htmlspecialchars($setting['default_value']) . '">' . $value . '</textarea>';
  }

  function generate_upload($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    echo '<input type="hidden" id="image_' . $setting['name'] . '" name="journal_settings[' . $setting['name'] . ']" value="' . $value . '" data-default="' . htmlspecialchars($setting['default_value']) . '" />';
    echo '<span style="background-image: url(\'' . $setting['thumb'] . '\'); " id="thumb_' . $setting['name'] . '" alt="' . $setting['label'] . '" class="upload-thumb" data-default="' . htmlspecialchars($setting['default_thumb']) . '"></span>';
    echo '<a href="#" class="choose-img">Browse</a><a href="#" class="clear-img">Clear</a>';
  }

  function generate_font($setting) {
    $fonts = $setting['font_families'];
    $sizes = range(8, 48);
    $weights = array('bold', 'normal');
    $transforms = array('none', 'uppercase', 'lowercase');

    $first_font = reset($fonts);

    if (!isset($setting['default_value']['font-family'])) $setting['default_value']['font-family'] = $first_font[0]['font_name'];
    if (!isset($setting['default_value']['font-size'])) $setting['default_value']['font-size'] = $sizes[0];
    if (!isset($setting['default_value']['font-weight'])) $setting['default_value']['font-weight'] = $weights[0];
    if (!isset($setting['default_value']['text-transform'])) $setting['default_value']['text-transform'] = $transforms[0];

    echo '<select name="journal_settings[' . $setting['name'] . '][font-family]" data-default="' . $setting['default_value']['font-family'] . '">';

    foreach ($fonts as $label => $font_group) {
      echo '<optgroup label="' . ucfirst($label) . '">';
      foreach ($font_group as $font) {

        if ($setting['value']['font-family'] == $font['font_name']) {
          echo '<option value="' . $font['font_name'] . '" selected="selected">' . $font['font_name'] . '</option>';
        } else {
          echo '<option value="' . $font['font_name'] . '">' . $font['font_name'] . '</option>';
        }
      }
      echo '</optgroup>';

    }
    echo '</select>';

    echo '<select name="journal_settings[' . $setting['name'] . '][font-size]" data-default="' . $setting['default_value']['font-size'] . '">';
    foreach ($sizes as $size) {
      if ($setting['value']['font-size'] == $size) {
        echo '<option value="' . $size . '" selected="selected">' . $size . 'px</option>';
      } else {
        echo '<option value="' . $size . '">' . $size . 'px</option>';
      }
    }
    echo '</select>';

    echo '<select name="journal_settings[' . $setting['name'] . '][font-weight]" data-default="' . $setting['default_value']['font-weight'] . '">';
    foreach ($weights as $weight) {
      if ($setting['value']['font-weight'] == $weight) {
        echo '<option value="' . $weight . '" selected="selected">' . ucfirst($weight) . '</option>';
      } else {
        echo '<option value="' . $weight . '">' . ucfirst($weight) . '</option>';
      }
    }
    echo '</select>';

    echo '<select name="journal_settings[' . $setting['name'] . '][text-transform]" data-default="' . $setting['default_value']['text-transform'] . '">';
    foreach ($transforms as $transform) {
      if ($setting['value']['text-transform'] == $transform) {
        echo '<option value="' . $transform . '" selected="selected">' . ucfirst($transform) . '</option>';
      } else {
        echo '<option value="' . $transform . '">' . ucfirst($transform) . '</option>';
      }
    }
    echo '</select>';

  }

  function generate_multiupload($setting) {
    $value = $setting['value'];
    echo '<table class="form multiupload" data-count="' . count($value) . '" data-setting-name="' . $setting['name'] . '" data-default="' . htmlspecialchars(json_encode($setting['default_value'])) . '">';
    echo '<thead><tr>';
    echo '<td>Image</td>';
    echo '<td>Name</td>';
    echo '<td>Link</td>';
    echo '<td>Sort Order</td>';
    echo '<td>Delete</td>';
    echo '</tr></thead>';
    $id = 0;
    foreach ($value as $val) {
      $field_id = "image_" . $setting['name'] . "_" . $id;
      $thumb_id = "thumb_" . $setting['name'] . "_" . $id;
      echo '<tbody><tr>';
      echo '<td><input type="hidden" name="journal_settings[' . $setting['name'] . '][' . $id . '][img]" value="' . $val['img'] . '" id="' . $field_id . '" /><span style="background-image: url(\'' . $val['thumb'] . '\');" id="' . $thumb_id . '" class="upload-thumb choose-img"></span></td>';
      echo '<td><input class="name" type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][name]" value="' . $val['name'] . '" /></td>';
      echo '<td><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][link]" value="' . $val['link'] . '" /></td>';
      echo '<td><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][sort_order]" value="' . $val['sort_order'] . '" /></td>';
      echo '<td><a href="#" class="remove-image button">Remove</a></td>';
      echo '</tr></tbody>';
      $id++;
    }
    echo '<tfoot>';
    echo '</tfoot>';
    echo '</table>';
    echo '<a href="#" class="add-image button">Add item</a>';
  }

  function generate_editor($setting) {
    /* $value = $setting['value'] ? $setting['value'] : $setting['default_value']; */ $value = $setting['value'];
    echo '<textarea id="editor_' . $setting['name'] . '" name="journal_settings[' . $setting['name'] . ']" data-default="' . htmlspecialchars($setting['default_value']) . '">' . $value . '</textarea>';
  }

  function generate_menu($setting, $languages) {
    $value = $setting['value'];
    echo '<table class="form menu" data-count="' . count($value) . '" data-setting-name="' . $setting['name'] . '" data-default="' . htmlspecialchars(json_encode($setting['default_value'])) . '">';
    echo '<thead><tr>';
    echo '<td>Icon</td>';
    echo '<td>Name</td>';
    echo '<td>Link</td>';
    echo '<td>Sort</td>';
    echo '<td>New Tab</td>';
    echo '<td>Delete</td>';
    echo '</tr></thead>';
    $id = 0;
    foreach ($value as $val) {
      $field_id = "image_" . $setting['name'] . "_" . $id;
      $thumb_id = "thumb_" . $setting['name'] . "_" . $id;

      echo '<tbody><tr>';
      echo '<td><input type="hidden" name="journal_settings[' . $setting['name'] . '][' . $id . '][img]" value="' . $val['img'] . '" id="' . $field_id . '" /><span style="background-image: url(\'' . $val['thumb'] . '\');" id="' . $thumb_id . '" class="upload-thumb choose-img"></span></td>';
      echo '<td>';
      foreach ($languages as $language):
        $value = isset($val['name'][$language['language_id']]) ? $val['name'][$language['language_id']] : '';
        echo '<div class="menu-name"><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][name][' . $language['language_id'] . ']" value="' . $value . '"/>';
        echo '<img src="view/image/flags/' . $language['image'] . '" title="' . $language['name'] . '" /></div>';
      endforeach;
      echo '</td>';
      echo '<td><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][link]" value="' . $val['link'] . '"/></td>';
      echo '<td><input class="small" type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][sort_order]" value="' . $val['sort_order'] . '"/></td>';
      echo '<td><select class="yes_no" name="journal_settings[' . $setting['name'] . '][' . $id . '][new_window]" value="' . $val['new_window'] . '">';
      $selected1 = $val['new_window'] ? 'selected="selected"' : '';
      $selected0 = !$val['new_window'] ? 'selected="selected"' : '';
      echo '<option value="1"' . $selected1 . '>Yes</option>';
      echo '<option value="0"' . $selected0 . '>No</option>';
      echo '</select></td>';
      echo '<td><a href="#" class="remove-image button">Remove</a></td>';
      echo '</tr></tbody>';
      $id++;
    }
    echo '<tfoot>';
    echo '</tfoot>';
    echo '</table>';
    echo '<a href="#" class="add-top-menu-item button">Add item</a>';
  }

  function generate_categ_menu($setting, $languages) {
    $value = $setting['value'];
    echo '<table class="form menu" data-count="' . count($value) . '" data-setting-name="' . $setting['name'] . '" data-default="' . htmlspecialchars(json_encode($setting['default_value'])) . '">';
    echo '<thead><tr>';
    echo '<td>Sub</td>';
    echo '<td>Name</td>';
    echo '<td>Link</td>';
    echo '<td>Sort</td>';
    echo '<td>New Tab</td>';
    echo '<td>Delete</td>';
    echo '</tr></thead>';
    $id = 0;
    foreach ($value as $val) {
      // if (isset($val['subcategs']) && is_object($val['subcategs'])) $val['subcategs'] = get_object_vars($val['subcategs']);

      $count = isset($val['subcategs']) && is_array($val['subcategs']) ? count($val['subcategs']) : 0;

      $prod_categ_id = isset($val['id']) && $val['id'] ? $val['id'] : null;

      echo '<tbody class="main-categ-' . $id . '" data-class="' . $id . '" data-count="' . $count . '" data-setting-name="' . $setting['name'] . '"><tr>';
      echo '<td><a href="#" class="add-categ-sub-menu button">+</a></td>';
      echo '<td>';
      foreach ($languages as $language):
        $value = isset($val['name'][$language['language_id']]) ? $val['name'][$language['language_id']] : '';
        echo '<div class="menu-name"><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][name][' . $language['language_id'] . ']" value="' . $value . '"/>';
        echo '<img src="view/image/flags/' . $language['image'] . '" title="' . $language['name'] . '" /></div>';
      endforeach;
      // if ($prod_categ_id !== null) {
        echo '<input type="hidden" name="journal_settings[' . $setting['name'] . '][' . $id . '][id]" value="' . $prod_categ_id .'" />';
      // }
      echo '</td>';
      echo '<td><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][link]" value="' . $val['link'] . '" ' . ($prod_categ_id === null ? '' : 'readonly="readonly"'). '/></td>';
      echo '<td><input class="small" type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][sort_order]" value="' . $val['sort_order'] . '"/></td>';
      echo '<td><select class="yes_no" name="journal_settings[' . $setting['name'] . '][' . $id . '][new_window]" value="' . $val['new_window'] . '">';
      $selected1 = $val['new_window'] ? 'selected="selected"' : '';
      $selected0 = !$val['new_window'] ? 'selected="selected"' : '';
      echo '<option value="1"' . $selected1 . '>Yes</option>';
      echo '<option value="0"' . $selected0 . '>No</option>';
      echo '</select></td>';
      echo '<td><a href="#" class="remove-image button">Remove</a></td>';
      echo '</tr></tbody>';

      /*generate subcategs*/
      if (isset($val['subcategs'])) {
        $sub_id = 0;
        foreach ($val['subcategs'] as $subval) {

          $prod_categ_id = isset($subval['id']) && $subval['id'] ? $subval['id'] : null;

          $last_child = $sub_id === count($val['subcategs']) - 1 ? 'subcateg-last' : '';

          echo '<tbody class="subcateg subcateg_' . $id . ' ' . $last_child . '" data-parent-categ="' . $id . '"><tr>';
          echo '<td>&nbsp;</td>';
          echo '<td>';
          foreach ($languages as $language):
            $value = isset($subval['name'][$language['language_id']]) ? $subval['name'][$language['language_id']] : '';
            echo '<div class="menu-name" data-hidden-name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][id]"><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][name][' . $language['language_id'] . ']" value="' . $value . '"/>';
            echo '<img src="view/image/flags/' . $language['image'] . '" title="' . $language['name'] . '" /></div>';
          endforeach;
          // if ($prod_categ_id !== null) {
            echo '<input type="hidden" name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][id]" value="' . $prod_categ_id .'" />';
          // }
          echo '</td>';
          echo '<td><input type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][link]" value="' . $subval['link'] . '" ' . ($prod_categ_id === null ? '' : 'readonly="readonly"'). '/></td>';
          echo '<td><input class="small" type="text" name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][sort_order]" value="' . $subval['sort_order'] . '"/></td>';
          echo '<td><select class="yes_no" name="journal_settings[' . $setting['name'] . '][' . $id . '][subcategs][' . $sub_id . '][new_window]" value="' . $subval['new_window'] . '">';
          $selected1 = $subval['new_window'] ? 'selected="selected"' : '';
          $selected0 = !$subval['new_window'] ? 'selected="selected"' : '';
          echo '<option value="1"' . $selected1 . '>Yes</option>';
          echo '<option value="0"' . $selected0 . '>No</option>';
          echo '</select></td>';
          echo '<td><a href="#" class="remove-image button">Remove</a></td>';
          echo '</tr></tbody>';
          $sub_id++;
        }
      }
      /*end of generate subcategs*/
      $id++;
    }
    echo '<tfoot>';
    echo '</tfoot>';
    echo '</table>';
    echo '<a href="#" class="add-categ-menu-item button">Add item</a>';
  }

  function generate_multilang($setting, $languages) {
    foreach ($languages as $language):
      $value = isset($setting['value']['l_' . $language['language_id']]) ? $setting['value']['l_' . $language['language_id']] : '';
      echo '<div class="multilanguage-input"><input type="text" name="journal_settings[' . $setting['name'] . '][l_' . $language['language_id'] . ']" value="' . $value . '"/>';
      echo '<img src="view/image/flags/' . $language['image'] . '" title="' . $language['name'] . '" /></div>';
    endforeach;
  }

  function generate_html($settings, $categ, $subcateg = NULL) {
    if (in_array($categ, array('fonts'))) return;
    $db_settings = NULL;
    if ($subcateg == NULL && isset($settings[$categ])) {
      $db_settings = $settings[$categ];
    }
    if ($subcateg != NULL && isset($settings[$categ]) && isset($settings[$categ]['subcategories'][$subcateg])) {
      $db_settings = $settings[$categ]['subcategories'][$subcateg];
    }
    if ($db_settings == NULL) {
      echo '<div>No options avaliable!</div>';
      return;
    }
    echo '<table class="form">' . "\n";
    $index = 0;
    foreach ($db_settings as $setting) { $index++;
      $cls = array('categ_' . $setting['category'], 'setting_' . $setting['name'], 'input_' . $setting['input']);
      if ($subcateg) {
        $cls[] = 'subcateg_' . $setting['subcategory'];
      }
      echo '<tr class="' . implode(' ', $cls) . '"><td align="right" class="label">' . $setting['label'] . ': </td><td class="value"><div>';
      switch ($setting['input']) {
        case 'select'     : generate_select($setting);      break;
        case 'color'      : generate_color($setting);       break;
        case 'textarea'   : generate_textarea($setting);    break;
        case 'upload'     : generate_upload($setting);      break;
        case 'font'       : generate_font($setting);        break;
        case 'multiupload': generate_multiupload($setting); break;
        case 'editor'     : generate_editor($setting);      break;
        case 'menu'       : generate_menu($setting, $settings['all_languages']);        break;
        case 'categ_menu' : generate_categ_menu($setting, $settings['all_languages']);        break;
        case 'multilang'  : generate_multilang($setting, $settings['all_languages']);        break;
        case 'custom_block'  : generate_custom_block($setting, $settings['all_languages']);        break;
        default           : generate_text($setting);        break;
      }
      if ($setting['tip']) {
        echo '<a class="journal-tip" target="_blank" href="http://journal.digital-atelier.com/tips/' . $setting['tip'] . '"></a>';
      } else {
        $tip = $setting['category'];
        if ($setting['category'] === 'colors') {
          $tip = 'colors_' . $setting['subcategory'] . '_' . $index;
        } else {
          $tip = $setting['category'] . '_' . $setting['subcategory'] . '_' . $index;
        }
        echo '<a class="journal-tip" target="_blank" href="http://journal.digital-atelier.com/tips/' . $tip . '.jpg"></a>';
      }
      echo '</div></td></tr>';
    }
    echo '</table>' . "\n";
  }

  function generate_custom_block($setting, $languages) {
    $value = $setting['value'];

    if (!is_array($value)) {
      $value = array();
    }

    $tab_no = 1;
    echo '<div class="vtabs sec-tabs block-tabs" data-count="' . (count($value) + 1) . '">';
    foreach ($value as $val) {
      echo "
        <a href=\"#tab-custom-tab-module-{$tab_no}\" id=\"custom-tab-module-{$tab_no}\">
          Block {$tab_no} &nbsp; <img src=\"view/image/delete.png\" onclick=\"$('#custom-tab-module-{$tab_no}').remove(); $('#tab-custom-tab-module-{$tab_no}').remove(); $('.block-tabs a:first').trigger('click'); return false;\" />
        </a>
      ";
      $tab_no++;
    }
    echo '<span id="custom-block-add">Add New Block &nbsp; <img src="view/image/add.png" alt="" onclick="addCustomBlock();" /></span>';
    echo '</div>';
    $tab_no = 1;
    foreach ($value as $val) {
      if ($val['status']) {
        $selected_1 = 'selected="selected"';
        $selected_0 = '';
      } else {
        $selected_1 = '';
        $selected_0 = 'selected="selected"';
      }
      if ($val['alignment']) {
        $selected_left = 'selected="selected"';
        $selected_right = '';
      } else {
        $selected_left = '';
        $selected_right = 'selected="selected"';
      }
      if ($val['position']) {
        $selected_absolute = 'selected="selected"';
        $selected_fixed = '';
      } else {
        $selected_absolute = '';
        $selected_fixed = 'selected="selected"';
      }
      echo "
        <div id=\"tab-custom-tab-module-{$tab_no}\" class=\"vtabs-content\">
          <table class=\"form\">
            <tbody>
            <tr>
              <td>Block Status: </td>
              <td>
                <select class=\"yes_no\" name=\"journal_settings[{$setting['name']}][$tab_no][status]\">
                  <option value=\"1\" {$selected_1}>On</option>
                  <option value=\"0\" {$selected_0}>Off</option>
                </select>
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_status.jpg\"></a>
              </td>
            </tr>

            <tr>
              <td>Icon: </td>
              <td>
                <input type=\"hidden\" name=\"journal_settings[{$setting['name']}][$tab_no][img]\" value=\"{$val['img']}\" id=\"journal_settings-{$setting['name']}-{$tab_no}-img\" />
                <span style=\"background-image: url('{$val['thumb']}'); background-color: #{$val['icon_bgcolor']}\" id=\"journal_settings-{$setting['name']}-{$tab_no}-thumb\" class=\"upload-thumb choose-img\"></span>
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_icon.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td>Icon Background Color: </td>
              <td>
                <input type=\"text\" class=\"color {onImmediateChange:'preview_block_icon_bg_color(this);', required:false}\" name=\"journal_settings[{$setting['name']}][$tab_no][icon_bgcolor]\" value=\"{$val['icon_bgcolor']}\" />
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_icon_bg_color.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td>Content Background Color: </td>
              <td>
                <input type=\"text\" class=\"color {required:false}\" name=\"journal_settings[{$setting['name']}][$tab_no][content_bgcolor]\" value=\"{$val['content_bgcolor']}\" />
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_bg_color.jpg\"></a>
              </td>
            </tr>

            <tr>
              <td>Alignment: </td>
              <td>
                <select name=\"journal_settings[{$setting['name']}][$tab_no][alignment]\">
                  <option value=\"1\" {$selected_left}>Left</option>
                  <option value=\"0\" {$selected_right}>Right</option>
                </select>
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_alignment.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td>Position: </td>
              <td>
                <select name=\"journal_settings[{$setting['name']}][$tab_no][position]\">
                  <option value=\"1\" {$selected_absolute}>Scroll</option>
                  <option value=\"0\" {$selected_fixed}>Fixed</option>
                </select>
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_position.jpg\"></a>
              </td>
            </tr>

            <tr>
              <td>Content Width: </td>
              <td>
                <input type=\"text\" class=\"short\" name=\"journal_settings[{$setting['name']}][$tab_no][width]\" value=\"{$val['width']}\" size=\"3\" />
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_width.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td>Offset Top: </td>
              <td>
                <input type=\"text\" class=\"short\" name=\"journal_settings[{$setting['name']}][$tab_no][offset_top]\" value=\"{$val['offset_top']}\" size=\"3\" />
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_offset_top.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td>Content padding: </td>
              <td>
                <input type=\"text\" class=\"short\" name=\"journal_settings[{$setting['name']}][$tab_no][content_padding]\" value=\"{$val['content_padding']}\" size=\"3\" />
                <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_padding.jpg\"></a>
              </td>
            </tr>
            <tr>
              <td colspan=\"2\">
      ";

      echo "<div class=\"htabs\">";
      foreach ($languages as $language) {
        echo "<a href=\"#tab-language-{$tab_no}-{$language['language_id']}\"><img src=\"view/image/flags/{$language['image']}\" title=\"{$language['name']}\" />{$language['name']}</a>";
      }
      echo "</div>";

      foreach ($languages as $language) {
        $text = isset($val['language'][$language['language_id']]) ? $val['language'][$language['language_id']] : '';
        echo "
          <div id=\"tab-language-{$tab_no}-{$language['language_id']}\">
            <textarea class=\"custom-block\" name=\"journal_settings[{$setting['name']}][$tab_no][language][{$language['language_id']}]\" id=\"description-{$tab_no}-{$language['language_id']}\">{$text}</textarea>
          </div>
        ";
      }
      echo "
              </td>
            </tr>
            </tbody>
          </table>
        </div>
      ";
      $tab_no++;
    }
  }
?>
<?php echo $header; ?>
<div class="loader"> Loading...</div>
<!-- Save as Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">Save settings as custom skin:</h3>
  </div>
  <div class="modal-body">
    Skin name: <input class="name" type="text" name="" value="" />
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
    <button class="btn btn-primary do-save-btn">Save Changes</button>
  </div>
</div>
<!-- End Save as Modal -->

<!-- Modal -->
<div id="storeModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myStoreModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myStoreModalLabel">Choose the stores on which to apply the current Control Panel settings:</h3>
  </div>
  <div class="modal-body">
    <ul style="list-style-type: none;">
    <?php foreach ($stores as $store): ?>
      <li>
        <?php $checked = in_array($store['store_id'], $store_ids) ? 'checked="checked"' : ''; ?>
        <label for="checkbox-store<?php echo $store['store_id']; ?>"></label>
        <input id="checkbox-store<?php echo $store['store_id']; ?>" class="check" type="checkbox" value="<?php echo $store['store_id']; ?>" <?php echo $checked; ?> /> <?php echo $store['name']; ?><br />
      </li>
    <?php endforeach; ?>
    </ul>
  </div>
  <div class="modal-footer">
    <!-- <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button> -->
    <button data-dismiss="modal" class="btn btn-primary">Done</button>
  </div>
</div>
<!-- End Modal -->


<div id="content" class="cp">
      <div class="heading">
        <h1><?php echo $doc_title; ?> <small>v.<?php echo $journal_version; ?></small></h1>
        <div class="links">
            <a href="http://journal.digital-atelier.com/" class="demo-link" target="_blank">Journal Demo</a> &nbsp; | &nbsp;
            <a href="http://journal.digital-atelier.com/docs/#!/journal_cp" class="docs-link" target="_blank">Documentation</a>
        </div>
        <div class="buttons">
          <?php if ($update_avaliable): ?>
          <a onclick="$(this).html('<?php echo $text_update_in_progress; ?>');location = '<?php echo $update; ?>';" class="btn btn-info"><?php echo $button_update; ?></a>
          <?php endif; ?>
          <a onclick="check_form()" class="btn btn-success"><?php echo $button_save; ?></a>
          <a onclick="location = '<?php echo $cancel; ?>';" class="btn btn-danger"><?php echo $button_cancel; ?></a>
        </div>
      </div>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <script>
    $(document).ready(function(){
      setTimeout(function() {
        $('.success').delay(3000).fadeOut('slow');
      }, 1000);
    });
    </script>
  	<div class="box">

	    <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="store_ids" value="<?php echo implode(',', $store_ids); ?>" />
        <!-- subheader -->
  			<div id="subheader">
          <table class="form">
            <tr>
              <td class="stats" style="width:137px" align="right">
                Control panel status:
                <select class="yes_no" name="journal_theme_status">
                <?php if ($theme_status): ?>
                <option value="1" selected="selected">On</option>
                <option value="0">Off</option>
                <?php else: ?>
                <option value="1">On</option>
                <option value="0" selected="selected">Off</option>
                <?php endif; ?>
                </select>
              </td>


              <td class="stats" style="width:130px; padding-top:9px; text-align:center">
                Active Skin:<div class="pusher"> </div>
                <select id="journal-theme-selector" name="journal_theme" data-href="<?php echo $action; ?>">
                <?php foreach ($themes as $categ_name => $themes): ?>
                <optgroup label="<?php echo $themes['category']; ?>">
                  <?php foreach ($themes['themes'] as $theme): ?>
                  <option value="<?php echo $theme['theme_id']; ?>" <?php if($theme['theme_id'] === $current_theme) echo 'selected="selected"'; ?>><?php echo $theme['theme_name']; ?></option>
                  <?php endforeach; ?>
                </optgroup>
                <?php endforeach; ?>
                </select>
              </td>

              <?php /*
                <option value="<?php echo $theme['theme_id']; ?>" <?php if($theme['theme_id'] === $current_theme) echo 'selected="selected"'; ?>><?php echo $theme['theme_name']; ?></option>

              */?>


                <?php if (!$core_theme): ?>
                <td style='padding-left:20px; width:210px; border-right: 1px dotted #ccc'>
                <a href="#" class="btn delete-theme" data-href="<?php echo $delete; ?>">Delete Skin</a>
                <?php else: ?>
                 <td style='padding-left:20px; width:100px; border-right: 1px dotted #ccc'>
                <?php endif; ?>
                <a href="#myModal" role="button" class="btn" data-toggle="modal">Save Skin</a>
              </td>

              <td style='padding-left:20px; max-width:215px; border-right: 1px dotted #ccc; width:202px'>
              <a href="<?php echo $export; ?>" style='margin-right:8px;' class="btn">Export CP</a>
                <span class="fileupload fileupload-new" data-provides="fileupload">
                  <span class="btn btn-file"><span class="fileupload-new">Import CP</span><span class="fileupload-exists">Change</span><input type="file" name="import_file" /></span>
                </span>
              </td>

                <td style='padding-right:15px;'>
                <a href="#storeModal" role="button" class="btn btn-primary" data-toggle="modal" style='float:right'>Multi-Store</a>
             </td>
            </tr>
          </table>
        </div>
        <a href="http://www.google.com/fonts/" target="_blank" class="preview-fonts">Fonts Preview</a>
        <a href="#" class="btn btn-primary reset-theme">Reset Section</a>

        <!-- horizontal tabs -->
        <div class="htabs main-tabs ui-tabs">
          <?php foreach ($tabs as $category => $subcategories): ?>
          <a href="#main-tabs-<?php echo $category; ?>"><?php echo $tabs_labels['htab_' . $category]; ?></a>
          <?php endforeach;?>
        </div>
        <!-- horizontal tabs content -->
        <?php foreach ($tabs as $category => $subcategories): ?>
          <div id="main-tabs-<?php echo $category; ?>" class="ui-tabs-hide">
            <!-- vertical tabs -->
            <?php if ($subcategories): ?>
            <div class="vtabs sec-tabs ui-tabs">
            <?php foreach ($subcategories as $subcategory): ?>
              <a href="#sec-tab-<?php echo $category; ?>-<?php echo $subcategory; ?>"><?php echo $tabs_labels['vtab_' . $subcategory]; ?></a>
            <?php endforeach; ?>
            </div>
            <?php endif; ?>
            <!-- vertical tabs content -->
            <?php if ($subcategories): ?>
            <?php foreach ($subcategories as $subcategory): ?>
            <div id="sec-tab-<?php echo $category; ?>-<?php echo $subcategory; ?>" class="vtabs-content ui-tabs-hide">
              <?php echo generate_html($journal_settings, $category, $subcategory); ?>
            </div>
            <?php endforeach; ?>
            <?php else: ?>
            <?php echo generate_html($journal_settings, $category); ?>
            <?php endif; ?>
          </div>
        <?php endforeach; ?>
        </form>
		</div>
	</div>
</div>
<script type="text/javascript">
var OC_TOKEN = '<?php echo $token; ?>';
</script>
<script type="text/javascript" src="view/javascript/journal/jscolor.js"></script>
<script type="text/javascript" src="view/javascript/journal/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

function categ_autocomplete($input) {
      $input.autocomplete({
          delay: 500,
          source: function(request, response) {
            $.ajax({
              url: 'index.php?route=module/journal_cp/category_autocomplete&token=' + OC_TOKEN + '&filter_name=' +  encodeURIComponent(request.term),
              dataType: 'json',
              success: function(json) {
                // console.log(json);
                response($.map(json, function(item) {
                  return {
                    label: item.name,
                    value: item.category_id
                  };
                }));
              }
            });
          },
          select: function(event, ui) {
            $(this).val(ui.item.label.split(' > ').pop());
            $(this).closest('td').find('input[type="hidden"]').val(ui.item.value);
            $(this).closest('tr').find('td:first-child + td + td').find('input[type="text"]').attr('readonly', 'readonly');
            return false;
          },
          focus: function(event, ui) {
            return false;
          }
        });
    }

$(function(){
  $('#sec-tab-menus-categories_menu_extended .menu-name input[type="text"]').each(function(){
    categ_autocomplete($(this));
  });
  $('#sec-tab-menus-categories_menu_extended .menu-name input[type="text"]').live('change', function(){
    if ($(this).val().trim().length == 0) {
      $(this).closest('td').find('input[type="hidden"]').val('');
      $(this).closest('tr').find('td + td + td').find('input[type="text"]').removeAttr('readonly');
    }
  });
})

function check_form() {

  var error = false;

  // $('#sec-tab-menus-top_menu .menu-name input[type=text]').each(function(){
  //   var $this = $(this);
  //   if ($this.val().trim().length === 0) {
  //     $('a[href=#main-tabs-menus]').click();
  //     $('a[href=#sec-tab-menus-top_menu]').click();
  //     $this.focus();
  //     alert('<?php echo $error_menu_name; ?>');
  //     error = true;
  //     return false;
  //   }
  // });

  if (error) {
    return false;
  }

  $('#sec-tab-menus-categories_menu .menu-name input[type=text]').each(function(){
    var $this = $(this);
    if ($this.val().trim().length === 0) {
      $('a[href=#main-tabs-menus]').click();
      $('a[href=#sec-tab-menus-categories_menu]').click();
      $this.focus();
      alert('<?php echo $error_menu_name; ?>');
      error = true;
      return false;
    }
  });

  if (error) {
    return false;
  }

  $('#sec-tab-footer-contacts .setting_contact_methods table.multiupload input.name').each(function(){
    var $this = $(this);
    if ($this.val().trim().length === 0) {
      $('a[href=#main-tabs-footer]').click();
      $('a[href=#sec-tab-footer-contacts]').click();
      $this.focus();
      alert('<?php echo $error_contact_method_name; ?>');
      error = true;
      return false;
    }
  });

  if (error) {
    return false;
  }

  $('#form').submit();
}

(function(){
  $('.main-tabs a').tabs();
  $('.sec-tabs a').tabs();
  $('.main-tabs a').click(function(){
      var tab = $(this).attr("href");
      $(tab + ' .sec-tabs a').first().click();
      if (tab === '#main-tabs-fonts') {
        $('.preview-fonts').show();
      } else {
        $('.preview-fonts').hide();
      }
  });
  $('.ui-tabs-hide').removeClass('ui-tabs-hide');
  // $('a[href=#main-tabs-menus]').click();
  // $('a[href=#sec-tab-menus-categories_menu]').click();
})();

(function($){

  function image_upload(field, thumb) {
    $('#dialog').remove();

    $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

    $('#dialog').dialog({
      title: '<?php echo $text_image_manager; ?>',
      close: function (event, ui) {
        if ($('#' + field).attr('value')) {
          $('#' + thumb).css('background-image', 'url("../image/' + $('#' + field).attr('value') + '")');
          // $.ajax({
          //   url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          //   dataType: 'text',
          //   success: function(data) {
          //     $('#' + thumb).css('background-image', 'url("' + data + '")');
          //   }
          // });
        }
      },
      bgiframe: false,
      width: 700,
      height: 400,
      resizable: false,
      modal: false
    });
  };

  function add_image($table, defaults) {
    if (!defaults) defaults = {};
    if (!defaults.img) defaults.img = '';
    if (!defaults.thumb) defaults.thumb = '<?php echo $no_image; ?>';
    if (!defaults.name) defaults.name = '';
    if (!defaults.link) defaults.link = '';
    if (!defaults.sort_order) defaults.sort_order = '';
    var id = parseInt($table.attr("data-count")) + 1;
    $table.attr("data-count", id);
    var name = $table.attr('data-setting-name');

    var field_id = "image_" + name + "_" + id;
    var thumb_id = "thumb_" + name + "_" + id;

    var html = '<tbody><tr>';
    html += '<td><input type="hidden" name="journal_settings[' + name + '][' + id + '][img]" id="' + field_id + '" value="' + defaults.img + '" /><span style="background-image: url(\'' + defaults.thumb + '\'); " id="' + thumb_id + '" class="upload-thumb choose-img"></span></td>';
    html += '<td><input type="text" class="name" name="journal_settings[' + name + '][' + id + '][name]" value="' + defaults.name + '"/></td>';
    html += '<td><input type="text" name="journal_settings[' + name + '][' + id + '][link]" value="' + defaults.link + '"/></td>';
    html += '<td><input type="text" name="journal_settings[' + name + '][' + id + '][sort_order]" value="' + defaults.sort_order + '"/></td>';
    html += '<td><a href="#" class="remove-image button">Remove</a></td>';
    html += '</tr></tbody>';

    $table.parent().find('table tfoot').before(html);
    is_empty();
  }

  function is_empty() {
    if ($('.input_multiupload table tbody').length == 0) {
      $('.input_multiupload .add-image').before('<div class="no-images"><?php echo $no_images; ?></div>');
    } else {
      $('.no-images').remove();
    }
  }

  function add_top_menu_item($table, defaults) {
    if (!defaults) defaults = {};
    if (!defaults.img) defaults.img = '';
    if (!defaults.thumb) defaults.thumb = '<?php echo $no_image; ?>';
    if (!defaults.name) defaults.name = '';
    if (!defaults.link) defaults.link = '';
    if (!defaults.sort_order) defaults.sort_order = '';
    var id = parseInt($table.attr("data-count")) + 1;
    $table.attr("data-count", id);
    var name = $table.attr('data-setting-name');

    var field_id = "image_" + name + "_" + id;
    var thumb_id = "thumb_" + name + "_" + id;

    var html = '<tbody><tr>';
    html += '<td><input type="hidden" name="journal_settings[' + name + '][' + id + '][img]" id="' + field_id + '" value="' + defaults.img + '" /><span style="background-image: url(\'' + defaults.thumb + '\');" id="' + thumb_id + '" class="upload-thumb choose-img"></span></td>';
    html += '<td>';
    <?php foreach ($journal_settings['all_languages'] as $language): ?>
    html += '<div class="menu-name"><input type="text" name="journal_settings[' + name + '][' + id + '][name][<?php echo $language['language_id']; ?>]" value="' + defaults.name + '"/>';
    html += '<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>';
    <?php endforeach; ?>
    html += '</td>';
    html += '<td><input type="text" name="journal_settings[' + name + '][' + id + '][link]" value="' + defaults.link + '"/></td>';
    html += '<td><input class="small" type="text" name="journal_settings[' + name + '][' + id + '][sort_order]" value="' + defaults.sort_order + '"/></td>';
    html += '<td><select class="yes_no" name="journal_settings[' + name + '][' + id + '][new_window]" value="' + defaults.sort_order + '">';
    html += '<option value="1"><?php echo $text_yes; ?></option>';
    html += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
    html += '</select></td>';
    html += '<td><a href="#" class="remove-image button">Remove</a></td>';
    html += '</tr></tbody>';

    $table.parent().find('table tfoot').before(html);
    $table.find('.yes_no').switchify();
  }

  function add_categ_menu_item($table, defaults) {
    var enable_autocomplete = $table.closest('.vtabs-content').attr('id') === 'sec-tab-menus-categories_menu_extended';
    if (!defaults) defaults = {};
    if (!defaults.img) defaults.img = '';
    if (!defaults.thumb) defaults.thumb = '<?php echo $no_image; ?>';
    if (!defaults.name) defaults.name = '';
    if (!defaults.link) defaults.link = '';
    if (!defaults.sort_order) defaults.sort_order = '';
    var id = parseInt($table.attr("data-count")) + 1;
    $table.attr("data-count", id);
    var name = $table.attr('data-setting-name');

    var field_id = "image_" + name + "_" + id;
    var thumb_id = "thumb_" + name + "_" + id;

    var html = '<tbody class="main-categ-' + id + '" data-class="' + id + '" data-count="0" data-setting-name="' + name + '"><tr>';
    html += '<td><a href="#" class="add-categ-sub-menu button">+</a></td>';
    html += '<td>';
    <?php foreach ($journal_settings['all_languages'] as $language): ?>
    html += '<div class="menu-name"><input type="text" name="journal_settings[' + name + '][' + id + '][name][<?php echo $language['language_id']; ?>]" value="' + defaults.name + '"/>';
    html += '<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>';
    <?php endforeach; ?>
    if (enable_autocomplete) {
    html += '<input type="hidden" name="journal_settings[' + name + '][' + id + '][id]" value="' + defaults.link + '"/>';
    }
    html += '</td>';
    html += '<td><input type="text" name="journal_settings[' + name + '][' + id + '][link]" value=""/></td>';
    html += '<td><input class="small" type="text" name="journal_settings[' + name + '][' + id + '][sort_order]" value="' + defaults.sort_order + '"/></td>';
    html += '<td><select class="yes_no" name="journal_settings[' + name + '][' + id + '][new_window]" value="' + defaults.sort_order + '">';
    html += '<option value="1"><?php echo $text_yes; ?></option>';
    html += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
    html += '</select></td>';
    html += '<td><a href="#" class="remove-image button">Remove</a></td>';
    html += '</tr></tbody>';

    $table.parent().find('table tfoot').before(html);
    $table.find('.yes_no').switchify();

    if(enable_autocomplete) {
      $table.find('.menu-name input[type="text"]').each(function(){
        categ_autocomplete($(this));
      });
    }
  }

  function add_categ_sub_menu($table, defaults) {
    var enable_autocomplete = $table.closest('.vtabs-content').attr('id') === 'sec-tab-menus-categories_menu_extended';
    if (!defaults) defaults = {};
    if (!defaults.img) defaults.img = '';
    if (!defaults.thumb) defaults.thumb = '<?php echo $no_image; ?>';
    if (!defaults.name) defaults.name = '';
    if (!defaults.link) defaults.link = '';
    if (!defaults.sort_order) defaults.sort_order = '';
    var id = parseInt($table.attr("data-count")) + 1;
    $table.attr("data-count", id);
    var name = $table.attr('data-setting-name');

    var categ_id = parseInt($table.attr("data-class"));

    var field_id = "image_" + name + "_" + id;
    var thumb_id = "thumb_" + name + "_" + id;

    var html = '<tbody class="subcateg subcateg-last subcateg_' + categ_id + '" data-parent-categ="' + categ_id + '"><tr>';
    html += '<td>&nbsp;</td>';
    html += '<td>';
    <?php foreach ($journal_settings['all_languages'] as $language): ?>
    html += '<div class="menu-name" data-hidden-name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][id]"><input type="text" name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][name][<?php echo $language['language_id']; ?>]" value="' + defaults.name + '"/>';
    html += '<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>';
    <?php endforeach; ?>
    if (enable_autocomplete) {
    html += '<input type="hidden" name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][id]" value=""/>';
    }
    html += '</td>';
    html += '<td><input type="text" name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][link]" value="' + defaults.link + '"/></td>';
    html += '<td><input class="small" type="text" name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][sort_order]" value="' + defaults.sort_order + '"/></td>';
    html += '<td><select class="yes_no" name="journal_settings[' + name + '][' + categ_id + '][subcategs][' + id + '][new_window]" value="' + defaults.sort_order + '">';
    html += '<option value="1"><?php echo $text_yes; ?></option>';
    html += '<option value="0" selected="selected"><?php echo $text_no; ?></option>';
    html += '</select></td>';
    html += '<td><a href="#" class="remove-image button">Remove</a></td>';
    html += '</tr></tbody>';

    var $pos = $table;

    for (var i=0; i<$table.attr('data-count'); i++) {
      $pos.removeClass('subcateg-last');
      $pos = $pos.next();
    }

    $pos.before(html);
    $table.find('.yes_no').switchify();
    if(enable_autocomplete) {
      $('#sec-tab-menus-categories_menu_extended .menu-name input[type="text"]').each(function(){
        categ_autocomplete($(this));
      });
    }
  }


  $(function(){

    // image upload
    (function(){

      $('.choose-img').live('click', function(){
        var field = $(this).parent().find('input').attr("id");
        var thumb = $(this).parent().find('span.upload-thumb').attr("id");
        image_upload(field, thumb);
        return false;
      });

      $('.clear-img').click(function(){
        $(this).parent().find('input').val('');
        $(this).parent().find('span.upload-thumb').css('background-image', 'url("<?php echo $no_image; ?>")');

        return false;
      });
    })();

    // editor
    (function(){
      $('.input_editor textarea, textarea.custom-block').each(function(){
        CKEDITOR.replace($(this).attr('id'), {
          filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
        });
      });
    })();

    // multi upload
    (function(){

      $('.add-image').click(function(){
        var $table = $(this).parent().find('table');
        add_image($table);
        return false;
      });

      $('.remove-image').live('click', function(){
        var $parent = $(this).parent().parent().parent();
        var sub_categs = $parent.attr('data-class');
        if (sub_categs) {
          $('.subcateg_' + sub_categs).remove();
        }
        var parent_categ = $parent.attr('data-parent-categ');
        $parent.remove();
        if ($.isNumeric(parent_categ)) {
          var parent_class = $('.main-categ-' + parent_categ).attr('data-class');
          $('.subcateg_' + parent_class).removeClass('subcateg-last').last().addClass('subcateg-last');
          $('.main-categ-' + parent_categ).attr('data-count', $('.subcateg_' + parent_class).length);
        }
        is_empty();
        return false;
      });

      is_empty();

    })();

    // menus
    (function(){
      $('.add-top-menu-item').click(function(){
        var $table = $(this).parent().find('table');
        add_top_menu_item($table);
        return false;
      });

      // $('.add-top-menu-item').live('click', function(){
      //   $(this).parent().parent().parent().remove();
      //   // is_empty();
      //   return false;
      // });

      $('.add-categ-menu-item').click(function(){
        var $table = $(this).parent().find('table');
        add_categ_menu_item($table);
        return false;
      });

      // $('.add-categ-menu-item').live('click', function(){
      //   $(this).parent().parent().parent().remove();
      //   // is_empty();
      //   return false;
      // });

      $('.add-categ-sub-menu').live('click', function(){
        // console.log($(this).parent().parent().parent());
        var $table = $(this).parent().parent().parent();
        add_categ_sub_menu($table);
        $('.yes_no').switchify();
        return false;
      });

      // is_empty();
    })();

    // theme management
    (function(){
      $("#journal-theme-selector").change(function(e, param){
        if (param !== true) {
          location = $(this).attr("data-href") + "&theme=" + $(this).val();
        }
      });

      $(".reset-theme").click(function() {
        if (!confirm('Confirm reset?')) return false;
        var category = $('.main-tabs a.selected').attr('href');
        var subcategory = $(category + ' .sec-tabs a.selected').attr('href');
        var selector = subcategory ? category + ' ' + subcategory : category;
        $(selector + ' .value').each(function(){

          // reset selects, inputs, textarea
          $(this).find('select,input,textarea').each(function(){
            if (!$(this).attr('data-default')) return;
            $(this).val($(this).attr('data-default'));
            if ($(this).hasClass('color')) {
              $(this)[0].color.fromString($(this).attr('data-default'));
            }
          });

          $(this).find('select').not($('.yes_no')).each(function(){
            var select = $(this);
            var wrap = select.prev();
            wrap.text($('option:selected', this).text());
          });

          $(this).find('.yes_no').each(function(){
            var $controls = $(this).data('switch').data('controls');
            if ($(this).val() === 'on') {
              $controls.on();
            } else {
              $controls.off();
            }
          });

          // reset images
          $(this).find('img.upload-thumb').each(function(){
            if (!$(this).attr('data-default')) return;
            $(this).css("background-image", "url:'(" + $(this).attr('data-default') + "')");
          });

          // reset multiupload
          $(this).find('table.multiupload').each(function(){
            $(this).find('tbody').remove();
            is_empty();
            if (!$(this).attr('data-default')) return;
            var def = $.parseJSON($(this).attr('data-default'));
            var $table = $(this).parent().find('table');
            // console.log(def);
            $.each(def, function(index, value){
              // console.log($table);
              // console.log(value);
              add_image($table, value);
            });
          });
        });
        return false;
      });

      $(".delete-theme").click(function() {
        if (!confirm('Confirm delete?')) return false;
        location = $(this).attr("data-href");
        return false;
      });

      $('.do-save-btn').click(function(){
        $("#form").prepend('<input type="hidden" name="journal_new_theme" value="' + $("#myModal .name").val() + '" />');
        $("#form").submit();
        return false;
      });
    })();

    (function(){
      var fonts_url = '<?php echo str_replace("&amp;", "&", $fonts_url); ?>';
      $('#main-tabs-fonts').load(fonts_url, function(){
        var sel = $('#main-tabs-fonts select');
        var wrap = sel.parent();
        sel.css('opacity', 0);
        sel.wrap('<div class="select-wrap" />');
        $('<span class="val"></span>').prependTo($('.select-wrap'));
        sel.each(function(){
          var select = $(this);
            var wrap = select.prev();
            select.change(function () {
                wrap.text($('option:selected', this).text());
            });
        }).trigger('change');

        var html = '<thead><tr>';
        html += '<td><?php echo $th_var_name; ?></td><td>';
        html += '<span class="th-font-name"><?php echo $th_font_name; ?></span>';
        html += '<span class="th-font-size"><?php echo $th_font_size; ?></span>';
        // html += '<span class="th-line-height"><?php echo $th_line_height; ?></span>';
        html += '<span class="th-font-weight"><?php echo $th_font_weight; ?></span>';
        html += '<span class="th-font-style"><?php echo $th_font_style; ?></span>';
        html += '<span class="th-font-transform"><?php echo $th_font_transform; ?></span>';

        html += '</td></tr></thead>';
        $('#main-tabs-fonts table.form').prepend(html);
      });
    })();
  });

})(jQuery);
</script>

<script type="text/javascript">

$(function(){
  $('.main-tabs a').click(function(){
    $.address.value($(this).attr('href').substr(1));
  });

  $('.sec-tabs a').not($('.block-tabs a')).click(function(){
    $.address.value($('.main-tabs a.selected').attr('href').substr(1) + '/' + $(this).attr('href').substr(1));
  });

  $.address.init(function(event){
    var main, sec, cookie = $.cookie('journal_cp_path');
    if (cookie) {
      cookie = cookie.split('/');
      if (cookie[0]) {
        main = cookie[0];
        if (cookie[1]) {
          sec = cookie[1];
        }
      }
    } else {
      main = $('.main-tabs a').first().attr('href').substr(1);
      if($('#' + main + ' .sec-tabs a').length > 0) {
        sec = $('#' + main + ' .sec-tabs a').first().attr('href').substr(1);
      }
    }

    $('a[href="#' + main +'"]').click();

    if (sec) {
      $('a[href="#' + sec +'"]').click();
    }

  });

  $.address.change(function(event){
    $.cookie('journal_cp_path', event.value.substr(1), { expires: 365, path: '/' });
  });
});

</script>

<script type="text/javascript">

$(function(){

  var opts = ['background_pattern', 'header_bg_image', 'container_bg_image', 'side_shade_bg_image', 'footer_bg_image'];

  $.each(opts, function (index, value){
    var $main = $('.setting_' + value);
    var $pos = $('.setting_' + value + '_position');
    var $rep = $('.setting_' + value + '_repeat');
    $main.find('a.journal-tip').before($pos.find('.select-wrap').addClass('bg-prop'));
    $main.find('a.journal-tip').before($rep.find('.select-wrap').addClass('bg-prop'));
    $pos.remove();
    $rep.remove();
  });

});

</script>

<script type="text/javascript">

$(function(){

  var $tr = $('.setting_categories_menu_extended_status');
  var $td1 = $tr.find('td').first();
  var $td2 = $tr.find('td').first().next();

  $td2.find('> div').prepend('<span class="custom-label">' + $td1.html() + '</span>');

});

</script>

<script type="text/javascript">

$(function(){
  $('#storeModal ul li a').click(function(){
    var data = [];
    $('#storeModal .check:checked').each(function(){
      data.push($(this).val());
    });
    $('input[name="store_ids"]').val(data.join(','));
  });
});

</script>

<script type="text/javascript">


  function addCustomBlock() {
    var count = parseInt($('.setting_custom_blocks .vtabs').attr('data-count'));
    $('.setting_custom_blocks .vtabs').attr('data-count', count + 1);

    var html = "";

    html += '<div id=\"tab-custom-tab-module-' + count + '\" class=\"vtabs-content\">';
    html += '      <table class=\"form\">';
    html += '        <tr>';
    html += '          <td>Block Status: </td>';
    html += '          <td>';
    html += '            <select class=\"yes_no\" name=\"journal_settings[custom_blocks][' + count + '][status]\">';
    html += '              <option value=\"1\" selected=\"selected\">On</option>';
    html += '              <option value=\"0\">Off</option>';
    html += '            </select>';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_status.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Icon: </td>';
    html += '          <td>';
    html += '            <input type=\"hidden\" name=\"journal_settings[custom_blocks][' + count + '][img]\" value=\"\" id=\"journal_settings-custom_blocks-' + count + '-img\" />';
    html += '            <span style=\"\" id=\"journal_settings-custom_blocks-' + count + '-thumb\" class=\"upload-thumb choose-img\"></span>';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_icon.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Icon Background Color: </td>';
    html += '          <td><input id=\"journal_settings-custom_blocks-' + count + '-icon_bgcolor\" type=\"text\" class=\"color\" name=\"journal_settings[custom_blocks][' + count + '][icon_bgcolor]\" value=\"\" size=\"3\" />';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_icon_bg_color.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Content Background Color: </td>';
    html += '          <td><input id=\"journal_settings-custom_blocks-' + count + '-content_bgcolor\" type=\"text\" class=\"color\" name=\"journal_settings[custom_blocks][' + count + '][content_bgcolor]\" value=\"\" size=\"3\" />';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_bg_color.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Alignment: </td>';
    html += '          <td>';
    html += '            <select name=\"journal_settings[custom_blocks][' + count + '][alignment]\">';
    html += '              <option value=\"1\">Left</option>';
    html += '              <option value=\"0\" selected=\"selected\">Right</option>';
    html += '            </select>';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_alignment.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Position: </td>';
    html += '          <td>';
    html += '            <select name=\"journal_settings[custom_blocks][' + count + '][position]\">';
    html += '              <option value=\"1\">Scroll</option>';
    html += '              <option value=\"0\" selected=\"selected\">Fixed</option>';
    html += '            </select>';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_position.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Content Width: </td>';
    html += '          <td><input type=\"text\" class=\"short\" name=\"journal_settings[custom_blocks][' + count + '][width]\" value=\"\" size=\"3\" />';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_width.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Offset top: </td>';
    html += '          <td><input type=\"text\" class=\"short\" name=\"journal_settings[custom_blocks][' + count + '][offset_top]\" value=\"\" size=\"3\" />';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_offset_top.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td>Content padding: </td>';
    html += '          <td><input type=\"text\" class=\"short\" name=\"journal_settings[custom_blocks][' + count + '][content_padding]\" value=\"\" size=\"3\" />';
    html += '            <a class=\"journal-tip\" target=\"_blank\" href=\"http://journal.digital-atelier.com/tips/custom_blocks_content_padding.jpg\"></a>';
    html += '          </td>';
    html += '        </tr>';
    html += '        <tr>';
    html += '          <td colspan=\"2\">';
    html += '           <div class=\"htabs\">';

    <?php foreach ($languages as $language) { ?>
    html += '<a href=\"#tab-language-' + count + '-<?php echo $language['language_id']; ?>\"><img src=\"view/image/flags/<?php echo $language['image']; ?>\" title=\"<?php echo $language['name']; ?>\" /><?php echo $language['name']; ?></a>';
    <?php } ?>

    html += '</div>';

    <?php foreach ($languages as $language) { ?>
    html += '<div id=\"tab-language-' + count + '-<?php echo $language['language_id']; ?>\">';
    html += '<textarea class=\"custom-block\" name=\"journal_settings[custom_blocks][' + count + '][language][<?php echo $language['language_id']; ?>]\" id=\"description-' + count + '-<?php echo $language['language_id']; ?>\"></textarea>';
    html += '</div>';
    <?php } ?>

    html += '          </td>';
    html += '        </tr>';
    html += '      </table>';
    html += '</div>';

    var $html = $(html);

    $('.setting_custom_blocks .value > div').append($html);

    new jscolor.color(document.getElementById('journal_settings-custom_blocks-' + count + '-icon_bgcolor'), {
      onImmediateChange: preview_block_icon_bg_color,
      required: false
    });
    new jscolor.color(document.getElementById('journal_settings-custom_blocks-' + count + '-content_bgcolor'), {
      required: false
    });

    $('#custom-block-add').before('<a href="#tab-custom-tab-module-' + count + '" id="custom-tab-module-' + count + '">Block ' + count + ' &nbsp; <img src="view/image/delete.png" alt="" onclick="$(\'.block-tabs a:first\').trigger(\'click\'); $(\'#custom-tab-module-' + count + '\').remove(); $(\'#tab-custom-tab-module-' + count + '\').remove(); return false;" /></a>');

    $('.setting_custom_blocks .htabs a').tabs();
    $('.setting_custom_blocks .vtabs a').tabs();

    $('#custom-tab-module-' + count).click();
    $('#tab-custom-tab-module-' + count + ' .htabs a').first().click();
    $('#tab-custom-tab-module-' + count + ' .yes_no').switchify();
    var sel = $('#tab-custom-tab-module-' + count + ' select').not($('.yes_no'));
    var wrap = sel.parent();
    sel.css('opacity', 0);
    sel.wrap('<div class="select-wrap" />');
    $('<span class="val"></span>').prependTo($('.select-wrap'));
    sel.each(function(){
      var select = $(this);
      var wrap = select.prev();
      select.change(function () {
        wrap.text($('option:selected', this).text());
      });
    });
    sel.trigger('change', true);

    <?php foreach ($languages as $language) { ?>
      CKEDITOR.replace('description-' + count + '-<?php echo $language["language_id"]; ?>', {
          filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
          filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
      });
    <?php } ?>
    return false;
  }

  $(function(){
    $('.setting_custom_blocks .htabs a').tabs();
    $('.setting_custom_blocks .vtabs a').tabs();

    $('.setting_custom_blocks .vtabs a').click(function(){
      var href = $(this).attr('href');
      $(href + ' .htabs a').first().click();
    });
  });

  function preview_block_icon_bg_color(elem) {
    elem = elem || this;
    var $parent = $(elem.valueElement).closest('table');
    var value = elem.valueElement.value ? '#' + elem.valueElement.value : 'transparent';
    $parent.find('.upload-thumb').css('background-color', value);
  }
</script>

<?php echo $footer;