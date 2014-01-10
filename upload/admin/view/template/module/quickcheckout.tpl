<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <?php if ($text_quick_start) { ?>
  <div class="attention"><?php echo $text_quick_start; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
	  <div class="vtabs"><a href="#general"><?php echo $tab_general; ?></a><a href="#technical"><?php echo $tab_technical; ?></a><a href="#field"><?php echo $tab_field; ?></a><a href="#module"><?php echo $tab_module; ?></a><a href="#survey"><?php echo $tab_survey; ?></a><a href="#delivery"><?php echo $tab_delivery; ?></a><a href="#countdown"><?php echo $tab_countdown; ?></a><a href="#support"><?php echo $tab_support; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    <div id="general" class="vtabs-content">
		  <table class="form">
            <tr>
			  <td style="width:200px;"><?php echo $entry_status; ?></td>
			  <td style="width: 200px;"><select name="quickcheckout_status">
                <?php if ($quickcheckout_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_load_screen; ?></td>
              <td><select name="quickcheckout_load_screen">
                <?php if ($quickcheckout_load_screen) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
			<tr>
			  <td><?php echo $entry_newsletter; ?></td>
              <td><select name="quickcheckout_newsletter">
                <?php if ($quickcheckout_newsletter) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_payment_logo; ?></td>
			  <td><select name="quickcheckout_payment_logo">
                <?php if ($quickcheckout_payment_logo) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_shipping; ?></td>
			  <td><select name="quickcheckout_shipping">
                <?php if ($quickcheckout_shipping) { ?>
                <option value="1" selected="selected"><?php echo $text_radio; ?></option>
                <option value="0"><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_radio; ?></option>
                <option value="0" selected="selected"><?php echo $text_select; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_payment; ?></td>
			  <td><select name="quickcheckout_payment">
                <?php if ($quickcheckout_payment) { ?>
                <option value="1" selected="selected"><?php echo $text_radio; ?></option>
                <option value="0"><?php echo $text_select; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_radio; ?></option>
                <option value="0" selected="selected"><?php echo $text_select; ?></option>
                <?php } ?>
              </select></td>
            </tr>
			<tr>
			  <td><?php echo $entry_highlight_error; ?></td>
			  <td><select name="quickcheckout_highlight_error">
                <?php if ($quickcheckout_highlight_error) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_text_error; ?></td>
			  <td><select name="quickcheckout_text_error">
                <?php if ($quickcheckout_text_error) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
			<tr>
			  <td><?php echo $entry_edit_cart; ?></td>
			  <td><select name="quickcheckout_edit_cart">
                <?php if ($quickcheckout_edit_cart) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_layout; ?></td>
			  <td><select name="quickcheckout_layout">
                <?php if ($quickcheckout_layout == '1') { ?>
                <option value="1" selected="selected"><?php echo $text_one_column; ?></option>
                <option value="2"><?php echo $text_two_column; ?></option>
                <option value="3"><?php echo $text_three_column; ?></option>
                <?php } elseif ($quickcheckout_layout == '2') { ?>
                <option value="1"><?php echo $text_one_column; ?></option>
                <option value="2" selected="selected"><?php echo $text_two_column; ?></option>
                <option value="3"><?php echo $text_three_column; ?></option>
                <?php } else { ?>
				<option value="1"><?php echo $text_one_column; ?></option>
                <option value="2"><?php echo $text_two_column; ?></option>
                <option value="3" selected="selected"><?php echo $text_three_column; ?></option>
				<?php } ?>
              </select></td>
			</tr>
		  </table>
		</div>
		<div id="technical" class="vtabs-content">
		  <table class="form">
            <tr>
			  <td style="width:200px;"><?php echo $entry_auto_submit; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_auto_submit">
                <?php if ($quickcheckout_auto_submit) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_responsive; ?></td>
              <td><select name="quickcheckout_responsive">
                <?php if ($quickcheckout_responsive) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
			<tr>
			  <td><?php echo $entry_country_reload; ?></td>
			  <td><select name="quickcheckout_country_reload">
                <?php if ($quickcheckout_country_reload) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_payment_reload; ?></td>
			  <td><select name="quickcheckout_payment_reload">
                <?php if ($quickcheckout_payment_reload) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
		  </table>
		</div>
        <div id="field" class="vtabs-content">
		  <table class="form">
		    <tr>
			  <td style="width:200px;"><?php echo $entry_firstname; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_firstname">
				<?php if ($quickcheckout_firstname) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			  <td style="width:200px;"><?php echo $entry_lastname; ?></td>
			  <td><select name="quickcheckout_lastname">
				<?php if ($quickcheckout_lastname) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_telephone; ?></td>
			  <td><select name="quickcheckout_telephone">
				<?php if ($quickcheckout_telephone) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			  <td><?php echo $entry_fax; ?></td>
			  <td><select name="quickcheckout_fax">
				<?php if ($quickcheckout_fax) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
		    <tr>
			  <td><?php echo $entry_company; ?></td>
			  <td><select name="quickcheckout_company">
				<?php if ($quickcheckout_company) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			  <td><?php echo $entry_address_1; ?></td>
			  <td><select name="quickcheckout_address_1">
				<?php if ($quickcheckout_address_1) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_address_2; ?></td>
			  <td><select name="quickcheckout_address_2">
				<?php if ($quickcheckout_address_2) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			  <td><?php echo $entry_city; ?></td>
			  <td><select name="quickcheckout_city">
				<?php if ($quickcheckout_city) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_postcode; ?></td>
			  <td><select name="quickcheckout_postcode">
				<?php if ($quickcheckout_postcode) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			  <td><?php echo $entry_country; ?></td>
			  <td><select name="quickcheckout_country">
				<?php if ($quickcheckout_country) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_zone; ?></td>
			  <td><select name="quickcheckout_zone">
				<?php if ($quickcheckout_zone) { ?>
				<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
				<option value="0"><?php echo $text_disabled; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_enabled; ?></option>
				<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
				<?php } ?>
			  </select></td>
			</tr>
		  </table>
		</div>
		<div id="module" class="vtabs-content">
		  <table class="form">
		    <tr>
              <td style="width:200px;"><?php echo $entry_coupon; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_coupon">
                <?php if ($quickcheckout_coupon) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_voucher; ?></td>
			  <td><select name="quickcheckout_voucher">
                <?php if ($quickcheckout_voucher) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
		    <tr>
			  <td><?php echo $entry_reward; ?></td>
			  <td><select name="quickcheckout_reward">
                <?php if ($quickcheckout_reward) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
              <td><?php echo $entry_cart; ?></td>
			  <td><select name="quickcheckout_cart">
                <?php if ($quickcheckout_cart) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            </tr>
			<tr>
			  <td><?php echo $entry_login; ?></td>
			  <td><select name="quickcheckout_login">
                <?php if ($quickcheckout_login) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td></td>
			  <td></td>
            </tr>
			<tr>
			  <td><?php echo $entry_html_header; ?></td>
			  <td><?php foreach ($languages as $language) { ?>
				<textarea name="quickcheckout_html_header[<?php echo $language['language_id']; ?>]"><?php echo !empty($quickcheckout_html_header[$language['language_id']]) ? $quickcheckout_html_header[$language['language_id']] : ''; ?></textarea> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?></td>
			  <td><?php echo $entry_html_footer; ?></td>
			  <td><?php foreach ($languages as $language) { ?>
				<textarea name="quickcheckout_html_footer[<?php echo $language['language_id']; ?>]"><?php echo !empty($quickcheckout_html_footer[$language['language_id']]) ? $quickcheckout_html_footer[$language['language_id']] : ''; ?></textarea> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?></td>
			</tr>
          </table>
		</div>
		<div id="survey" class="vtabs-content">
		  <table class="form">
			<tr>
		  	  <td style="width:200px;"><?php echo $entry_survey; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_survey">
                <?php if ($quickcheckout_survey) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_survey_required; ?></td>
			  <td><select name="quickcheckout_survey_required">
                <?php if ($quickcheckout_survey_required) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_survey_text; ?></td>
			  <td><?php foreach ($languages as $language) { ?>
				<input type="text" name="quickcheckout_survey_text[<?php echo $language['language_id']; ?>]" value="<?php echo !empty($quickcheckout_survey_text[$language['language_id']]) ? $quickcheckout_survey_text[$language['language_id']] : ''; ?>" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?></td>
			  <td><?php echo $entry_survey_type; ?></td>
			  <td><select name="quickcheckout_survey_type">
                <?php if ($quickcheckout_survey_type) { ?>
                <option value="1" selected="selected"><?php echo $text_select; ?></option>
                <option value="0"><?php echo $text_text; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_select; ?></option>
                <option value="0" selected="selected"><?php echo $text_text; ?></option>
                <?php } ?>
              </select></td>
			</tr>
			<tr>
			  <td colspan="4">
			    <table id="survey-answer" class="list">
				  <thead>
				  <tr>
					<td class="left" colspan="2"><?php echo $entry_survey_answer; ?></td>
				  </tr>
				  </thead>
				  <tbody>
				  <?php $survey_answer_row = 0; ?>
				  <?php foreach ($quickcheckout_survey_answers as $survey_answer) { ?>
				  <tr id="survey-answer-<?php echo $survey_answer_row; ?>">
				    <td class="left"><?php foreach ($languages as $language) { ?>
					  <input type="text" name="quickcheckout_survey_answers[<?php echo $survey_answer_row; ?>][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($survey_answer[$language['language_id']]) ? $survey_answer[$language['language_id']] : ''; ?>" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
					<?php } ?></td>
					<td class="right"><a class="button" onClick="$('#survey-answer-<?php echo $survey_answer_row; ?>').remove();"><span><?php echo $button_remove; ?></span></a></td>
					<?php $survey_answer_row++; ?>
				  </tr>
				  <?php } ?>
				  </tbody>
				  <tfoot>
				  <tr>
				    <td class="right" colspan="2"><a class="button" onClick="addAnswer();"><span><?php echo $button_add; ?></span></a></td>
				  </tr>
				  </tfoot>
				</table>
			  </td>
			</tr>
		  </table>
		</div>
		<div id="delivery" class="vtabs-content">
		  <table class="form">
		    <tr>
			  <td style="width:200px;"><?php echo $entry_delivery; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_delivery">
			    <?php if ($quickcheckout_delivery) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_delivery_time; ?></td>
			  <td><select name="quickcheckout_delivery_time">
			    <?php if ($quickcheckout_delivery_time == '1') { ?>
                <option value="1" selected="selected"><?php echo $text_choose; ?></option>
                <option value="2"><?php echo $text_estimate; ?></option>
                <option value="3"><?php echo $text_select; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
				<?php } elseif ($quickcheckout_delivery_time == '2') { ?>
				<option value="1"><?php echo $text_choose; ?></option>
                <option value="2" selected="selected"><?php echo $text_estimate; ?></option>
                <option value="3"><?php echo $text_select; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
				<?php } elseif ($quickcheckout_delivery_time == '3') { ?>
				<option value="1"><?php echo $text_choose; ?></option>
                <option value="2"><?php echo $text_estimate; ?></option>
                <option value="3" selected="selected"><?php echo $text_select; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_choose; ?></option>
                <option value="2"><?php echo $text_estimate; ?></option>
                <option value="3"><?php echo $text_select; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			</tr>
			<tr>
			  <td><?php echo $entry_delivery_required; ?></td>
			  <td><select name="quickcheckout_delivery_required">
			    <?php if ($quickcheckout_delivery_required) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td><?php echo $entry_delivery_unavailable; ?></td>
			  <td><textarea name="quickcheckout_delivery_unavailable" style="width:170px; height:90px;"><?php echo $quickcheckout_delivery_unavailable; ?></textarea></td>
		    </tr>
			<tr>
			  <td><?php echo $entry_delivery_min; ?></td>
			  <td><input type="text" name="quickcheckout_delivery_min" value="<?php echo $quickcheckout_delivery_min; ?>" size="3" /></td>
			  <td><?php echo $entry_delivery_max; ?></td>
			  <td><input type="text" name="quickcheckout_delivery_max" value="<?php echo $quickcheckout_delivery_max; ?>" size="3" /></td>
			</tr>
			<tr>
			  <td><?php echo $entry_delivery_min_hour; ?></td>
			  <td><input type="text" name="quickcheckout_delivery_min_hour" value="<?php echo $quickcheckout_delivery_min_hour; ?>" size="3" /></td>
			  <td><?php echo $entry_delivery_max_hour; ?></td>
			  <td><input type="text" name="quickcheckout_delivery_max_hour" value="<?php echo $quickcheckout_delivery_max_hour; ?>" size="3" /></td>
			</tr>
			<tr>
			  <td colspan="4">
			    <table id="delivery-time" class="list">
				  <thead>
				  <tr>
					<td class="left" colspan="2"><?php echo $entry_delivery_times; ?></td>
				  </tr>
				  </thead>
				  <tbody>
				  <?php $delivery_time_row = 0; ?>
				  <?php foreach ($quickcheckout_delivery_times as $delivery_time) { ?>
				  <tr id="delivery-time-<?php echo $delivery_time_row; ?>">
				    <td class="left"><?php foreach ($languages as $language) { ?>
					  <input type="text" name="quickcheckout_delivery_times[<?php echo $delivery_time_row; ?>][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($delivery_time[$language['language_id']]) ? $delivery_time[$language['language_id']] : ''; ?>" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
					<?php } ?></td>
					<td class="right"><a class="button" onClick="$('#delivery-time-<?php echo $delivery_time_row; ?>').remove();"><span><?php echo $button_remove; ?></span></a></td>
					<?php $delivery_time_row++; ?>
				  </tr>
				  <?php } ?>
				  </tbody>
				  <tfoot>
				  <tr>
				    <td class="right" colspan="2"><a class="button" onClick="addTime();"><span><?php echo $button_add; ?></span></a></td>
				  </tr>
				  </tfoot>
				</table>
			  </td>
			</tr>
		  </table>
		</div>
		<div id="countdown" class="vtabs-content">
		  <table class="form">
		    <tr>
			  <td style="width:200px;"><?php echo $entry_countdown; ?></td>
			  <td style="width:200px;"><select name="quickcheckout_countdown">
			    <?php if ($quickcheckout_countdown) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
			  <td style="width:200px;"><?php echo $entry_countdown_start; ?></td>
			  <td><select name="quickcheckout_countdown_start">
			    <?php if ($quickcheckout_countdown_start) { ?>
                <option value="1" selected="selected"><?php echo $text_day; ?></option>
                <option value="0"><?php echo $text_specific; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_day; ?></option>
                <option value="0" selected="selected"><?php echo $text_specific; ?></option>
                <?php } ?>
              </select></td>
			</tr>
			<tr id="countdown-date">
			  <td><?php echo $entry_countdown_date_start; ?></td>
			  <td><input type="text" name="quickcheckout_countdown_date_start" value="<?php echo $quickcheckout_countdown_date_start; ?>" class="date" /></td>
			  <td><?php echo $entry_countdown_date_end; ?></td>
			  <td><input type="text" name="quickcheckout_countdown_date_end" value="<?php echo $quickcheckout_countdown_date_end; ?>" class="date" /></td>
			</tr>
			<tr id="countdown-time">
			  <td><?php echo $entry_countdown_time; ?></td>
			  <td><input type="text" name="quickcheckout_countdown_time" value="<?php echo $quickcheckout_countdown_time; ?>" /></td>
			</tr>
			<tr>
			  <td><?php echo $entry_countdown_text; ?></td>
			  <td><?php foreach ($languages as $language) { ?>
			    <textarea name="quickcheckout_countdown_text[<?php echo $language['language_id']; ?>]" style="width:170px; height:90px;"><?php echo !empty($quickcheckout_countdown_text[$language['language_id']]) ? $quickcheckout_countdown_text[$language['language_id']] : ''; ?></textarea> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?></td>
			</tr>
		  </table>
		</div>
		<div id="support" class="vtabs-content">
		  <table class="form">
		    <tr>
			  <td colspan="2"><?php echo $text_support; ?></td>
			</tr>
		    <tr>
			  <td><?php echo $entry_mail_name; ?></td>
			  <td><input type="text" name="mail_name" value="" /></td>
			</tr>
			<tr>
			  <td><?php echo $entry_mail_email; ?></td>
			  <td><input type="text" name="mail_email" value="" /></td>
			</tr>
			<tr>
			  <td><?php echo $entry_mail_order_id; ?></td>
			  <td><input type="text" name="mail_order_id" value="" /></td>
			</tr>
			<tr>
			  <td><?php echo $entry_mail_message; ?></td>
			  <td><textarea name="mail_message" style="width:300px; height:100px;"></textarea></td>
			</tr>
			<tr>
			  <td colspan="2"><a class="button" id="button-mail"><span><?php echo $button_mail; ?></span></a></td>
			</tr>
			<tr>
			  <td><a class="button" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=7382" target="_blank" rel="nofollow"><span><?php echo $text_review; ?></span></a></td>
			  <td><a class="button" href="http://www.marketinsg.com/quick-checkout" target="_blank"><span><?php echo $text_purchase; ?></span></a></td>
			</tr>
		  </table>
		</div>
      </form>
    </div>
  </div>
  <div style="text-align:center; color:#222222;">Quick Checkout v7.1 by <a target="_blank" href="http://www.marketinsg.com/">MarketInSG</a></div>
</div>
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.vtabs a').tabs();
});

$('.date').datetimepicker({
	dateFormat: 'd M yy'
});

$('select[name=\'quickcheckout_countdown_start\']').change(function() {
	if ($('select[name=\'quickcheckout_countdown_start\']').val() == '1') {
		$('#countdown-time').fadeIn();
		$('#countdown-date').fadeOut();
	} else {
		$('#countdown-date').fadeIn();
		$('#countdown-time').fadeOut();
	}
});

$('select[name=\'quickcheckout_countdown_start\']').trigger('change');

$('select[name=\'quickcheckout_survey_type\']').change(function() {
	if ($('select[name=\'quickcheckout_survey_type\']').val() == '1') {
		$('#survey-answer').fadeIn();
	} else {
		$('#survey-answer').fadeOut();
	}
});

$('select[name=\'quickcheckout_survey_type\']').trigger('change');

var survey_answer_row = <?php echo $survey_answer_row; ?>;

function addAnswer() {
	html  = '<tr id="survey-answer-' + survey_answer_row + '">';
	html += '  <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input type="text" name="quickcheckout_survey_answers[' + survey_answer_row + '][<?php echo $language['language_id']; ?>]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
	<?php } ?>
	html += '  </td>';
	html += '  <td class="right"><a class="button" onClick="$(\'#survey-answer-' + survey_answer_row + '\').remove();"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';
	
	$('#survey-answer tbody').append(html);
	
	survey_answer_row++;
}

$('select[name=\'quickcheckout_delivery_time\']').change(function() {
	if ($('select[name=\'quickcheckout_delivery_time\']').val() == '3') {
		$('#delivery-time').fadeIn();
	} else {
		$('#delivery-time').fadeOut();
	}
});

$('select[name=\'quickcheckout_delivery_time\']').trigger('change');

var delivery_time_row = <?php echo $delivery_time_row; ?>;

function addTime() {
	html  = '<tr id="delivery-time-' + delivery_time_row + '">';
	html += '  <td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input type="text" name="quickcheckout_delivery_times[' + delivery_time_row + '][<?php echo $language['language_id']; ?>]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
	<?php } ?>
	html += '  </td>';
	html += '  <td class="right"><a class="button" onClick="$(\'#delivery-time-' + delivery_time_row + '\').remove();"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';
	
	$('#delivery-time tbody').append(html);
	
	delivery_time_row++;
}

$('#button-mail').click(function() {
	$.ajax({
		url: 'index.php?route=module/quickcheckout/mail&token=<?php echo $token; ?>',
		type: 'post',
		data: $('input[name=\'mail_name\'], input[name=\'mail_email\'], input[name=\'mail_order_id\'], textarea[name=\'mail_message\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-mail').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt="" /></span>');
		},
		success: function(json) {
			$('.wait, .error').remove();
			
			if (json['error']) {
				if (json['error']['warning']) {
					alert(json['error']['warning']);
				}
				
				if (json['error']['name']) {
					$('input[name=\'mail_name\']').after('<span class="error">' + json['error']['name'] + '</span>');
				}
				
				if (json['error']['email']) {
					$('input[name=\'mail_email\']').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['order_id']) {
					$('input[name=\'mail_order_id\']').after('<span class="error">' + json['error']['order_id'] + '</span>');
				}
				
				if (json['error']['message']) {
					$('textarea[name=\'mail_message\']').after('<span class="error">' + json['error']['message'] + '</span>');
				}
			} else {
				alert(json['success']);
				
				$('input[name=\'mail_name\']').val('');
				$('input[name=\'mail_email\']').val('');
				$('input[name=\'mail_order_id\']').val('');
				$('textarea[name=\'mail_message\']').val('');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});
//--></script> 
<?php echo $footer; ?>