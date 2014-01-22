 
<?php echo $header; ?>
<!--     <span class="gritter-add-primary btn btn-default btn-block hidden">For notifications on saving</span>-->
     
<div id="fb-root"></div>
<fieldset class="group-select" style="margin: 0;border:none;">
<?php if($settings['general']['layout']=='3-Column'){ ?>    
    <div class="supercheckout-threecolumns supercheckout-container supercheckout-skin-generic " id="supercheckout-columnleft">
        <div class="supercheckout-column-left columnleftsort" id="columnleft-1" style="width:<?php $i= $settings['general']['column_width']['three-column'][1]*.90; echo $i; ?>%"> 
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['login']['three-column']['column']; ?>" data-row="<?php echo $sort_block['login']['three-column']['row']; ?>"  >
                <ul class="headingCheckout">
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-1"><?php if(!$logged){ echo $text_login_option;}else{echo 'Welcome '.$firstName. ' '.$lastName;} ?></p>

                    </li>
                </ul>
                <div id="checkoutLogin">
                    <div class="checkout-content">

                    </div>
                    <?php if(!$logged){  ?>
                    <div class="supercheckout-extra-wrap">
                        <b><?php echo $entry_email; ?><span class="supercheckout-required">*</span></b><br />
                        <input type="text" id="email" name="email" value="" class="large-field" />
                        <br/>
                    </div>    
                    <div id="loginDetails" class="left" style="display:<?php if($settings['step']['login']['option']['guest']['display'] ){ echo 'block'; }else{ echo 'none';} ?>;">
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="guest">
                                <?php if ($account == 'guest') { ?>
                                <input type="radio" name="account" value="guest" id="guest" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="guest" id="guest" />
                                <?php } ?>
                                <b><?php echo $text_guest; ?></b></label>
                            <br />
                        </div>
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="register">
                                <?php if ($account == 'register') { ?>
                                <input type="radio" name="account" value="register" id="register" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="register" id="register" />
                                <?php } ?>
                                <b><?php echo $text_register; ?></b></label>
                            <br />
                        </div>                    
                    </div>
                    <div id="supercheckout-login" class="right" >
                        <div class="supercheckout-extra-wrap">
                            <b><?php echo $entry_password; ?><span class="supercheckout-required">*</span></b><br />
                            <input type="password" id="password" name="password" value="" class="large-field" />
                            <br />
                            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                            <br />
                            <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="flipkartbuttonsmall" /><br />
                        </div>
                    </div> 
                    <?php if($facebook_enable || $google_enable) { ?>
                    <div class="orSeparator" style="display:<?php if($settings['step']['login']['option']['login']['display'] || $settings['step']['login']['option']['guest']['display'] ){ echo ''; }else{ echo 'none';} ?>;"></div>
                    <h3>Sign in with</h3>
                    <div class="socialNetwork">
                        <?php if($facebook_enable){ ?>
                        <div class="fbButton" id="fb-auth" ></div>
                        <?php }if($google_enable){ ?>
                        <div class="googleButton" onclick="window.open('<?php echo $url; ?>', 'name','resizable=1,scrollbars=no,width=500,height=400')"></div>
                        <?php } ?>
                        <div class="supercheckout-clear"></div>
                    </div>
                    <?php } ?>
                    <?php }else{ ?>
                    <div class="myaccount">
                        <ol class="rectangle-list">                            
                            <li>
                                <a href="<?php echo $myAccount; ?>"><?php echo $text_my_account; ?></a>
                            </li>
<!--                            <li style="float:left;">
                                <a href="<?php echo $myOrder; ?>"><?php echo $text_my_orders; ?></a>
                            </li>-->
                            <li>
                                <a href="<?php echo $logoutLink; ?>"><?php echo $text_logout; ?></a>
                            </li>
                            <div class="supercheckout-clear"></div>

                        </ol>
                    </div>

                    <?php } ?>
                </div>
            </div>
            <br/>
            
            <div  class="supercheckout-blocks"  data-column="<?php echo $sort_block['payment_address']['three-column']['column']; ?>" data-row="<?php echo $sort_block['payment_address']['three-column']['row']; ?>">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-2">Billing Address</p>
                    </li>
                </ul>
                <div id="checkoutBillingAddress">
                    <?php if ($addresses) { ?>

                    <div class="checkout-content">

                    </div>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
                        <label for="payment-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>    
                    <div id="payment-existing">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="payment_address" value="new" id="payment-address-new" />
                            <label for="payment-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table id="payment_address_table" class="supercheckout-form">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $payment_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company']['sort_order'] ?>" >
                                <td><?php echo $entry_company; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="company" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company_id']['sort_order'] ?>" >
                                <td><?php echo $entry_company_id; ?><span class="supercheckout-required" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';}} ?>;">*</span>
                                <input type="text" name="company_id" value="" class="large-field" /></td>
                            </tr>                            
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['tax_id']['sort_order'] ?>" >
                                <td><?php echo $entry_tax_id; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    
                                    <input type="text" name="tax_id" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_1']['sort_order'] ?>" >
                                <td> <?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_2']['sort_order'] ?>" >
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['city']['sort_order'] ?>" >
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['postcode']['sort_order'] ?>" >
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="payment-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['country_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['zone_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                            
                        </table>
                    </div>
                    <ul>
                        <li>
                            <div class="input-box input-different-shipping" style="display:<?php if(!$logged){  if($settings['option']['guest']['payment_address']['fields']['shipping']['display']){echo 'block';}else{echo 'none';}}?>;">
                                <input name="use_for_shipping" id="shipping_use"  checked="checked" type="checkbox">
                                <label for="shipping_use"><b><?php echo $text_ship_same_address; ?></b></label>
                            </div>
                        </li>
                    </ul>
                </div>
                <br/>
            </div>      
            <div class="supercheckout-blocks" data-column="<?php echo $sort_block['shipping_address']['three-column']['column']; ?>" data-row="<?php echo $sort_block['shipping_address']['three-column']['row']; ?>">
            <div id="checkoutShippingAddress">
                <div class="checkout-content">

                </div>
                
                    <ul>
                        <li>
                            <p class="supercheckout-numbers supercheckout-numbers-ship"><?php echo $text_shipping_address; ?></p>
                        </li>
                    </ul>
                    <?php if ($addresses) { ?>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
                        <label for="shipping-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>
                    <div id="shipping-existing" class="styled-select">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
                            <label for="shipping-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="shipping-new"style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table class="supercheckout-form" id="shipping_address_table">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"   data-percentage="<?php echo $shipping_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>                           
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_1']['sort_order'] ?>">
                                <td><?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span> 
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_2']['sort_order'] ?>">
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['city']['sort_order'] ?>">
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['postcode']['sort_order'] ?>">
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="shipping-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['country_id']['sort_order'] ?>">
                                <td><?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['zone_id']['sort_order'] ?>">
                                <td><?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                        </table>
                    </div>
                </div>                    

            </div>
        </div>

        <div class="supercheckout-column-middle columnleftsort" id="columnleft-2"  style="width:<?php $i= $settings['general']['column_width']['three-column'][2]*.91; echo $i; ?>%">
            
            <?php if($settings['step']['shipping_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['shipping_method']['three-column']['column']; ?>" data-row="<?php echo $sort_block['shipping_method']['three-column']['row']; ?>" >
                
                <ul>
                    <li style="display:inline;">
                        <p class="supercheckout-numbers supercheckout-numbers-3"><?php echo $text_shipping_method; ?></p>
                        <div class="loader" id="shippingMethodLoader"></div>
                    </li>                
                </ul>
                
                
                <div id="shipping-method">
                    <?php if(!$shipping_required){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="permanent-warning" style="display: block;">No shipping required with these product(s).<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                <?php } ?> 
                    <?php if($error_warning_shipping){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="warning" style="display: block;"><?php echo $error_warning_shipping; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                    <?php } ?>
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($shipping_methods && $shipping_required) { ?>

                    <table class="radio">
                        <?php foreach ($shipping_methods as $shipping_method) { ?>
                        <?php if($settings['step']['shipping_method']['display_title']){ ?>
                        <tr>
                            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
                        </tr>
                        <?php } ?>
                        <?php if (!$shipping_method['error']) { ?>
                        <?php foreach ($shipping_method['quote'] as $quote) { ?>
                        <tr class="highlight">
                            <td><?php if(!isset($shipping_code)){ $shipping_code = ''; }if(($quote['code'] == $shipping_code) || !(isset($shipping_code))) { ?>
                                <?php $codeShipping = $quote['code']; ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                                <?php } ?></td>
                            <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
                            <td style="text-align: right;" class="price"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                        </tr>
                        <?php } ?>
                        <?php } else { ?>
                        <tr>
                            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
                        </tr>
                        <?php } ?>
                        <?php } ?>
                    </table>
                    <br />
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
            <?php if($settings['step']['payment_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['payment_method']['three-column']['column']; ?>" data-row="<?php echo $sort_block['payment_method']['three-column']['row']; ?>" >
                
                <ul>
                    <li >
                        <p class="supercheckout-numbers supercheckout-numbers-4"><?php echo $text_payment_method; ?></p>
                        <div class="loader" id="paymentMethodLoader"></div>
                    </li>                
                </ul>
                
                <div id="payment-method">
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($payment_methods) { ?>                 
                    <table class="radio">
                        <?php foreach ($payment_methods as $payment_method) { ?>
                        <tr class="highlight">
                            <td><?php if ($payment_method['code'] == $payment_code || !$payment_code) { ?>
                                <?php $code = $payment_method['code']; ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  />
                                <?php } ?></td>
                            <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
                        </tr>
                        <?php } ?>
                    </table>                 
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
        </div>
        <div class="supercheckout-column-right columnleftsort" id="columnleft-3" style="width:<?php $i= $settings['general']['column_width']['three-column'][3]*.91; echo $i; ?>%">
            <div class="supercheckout-blocks confirmCheckoutBack" data-column="<?php echo $sort_block['cart']['three-column']['column']; ?>" data-row="<?php echo $sort_block['cart']['three-column']['row']; ?>" style="display:<?php if($logged){ if($settings['option']['logged']['cart']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['display']){ echo' ';}else{ echo'none';}} ?>;">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-check"><?php echo $text_confirm_order; ?></p>
                        <div class="loader" id="confirmLoader"></div>
                    </li>
                </ul>
                <div id="confirmCheckout">
                    <div class="checkout-content">

                    </div>
                    <?php if (!isset($redirect)) { ?>
                    
                    <table class="supercheckout-summary">
                        <thead>
                            <tr>
                                
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name"><?php echo $column_name; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_model; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_quantity; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total" style="text-align:center;"><?php echo $column_price; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $column_total; ?></th>
                                <th class="supercheckout-qty"><?php echo "Action"; ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product) { ?>
                            <tr>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name">
                                    
                                    <div ><a <?php if($logged){ if($settings['option']['logged']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';} }else{ if($settings['option']['guest']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';}} ?> data-title="<?php echo $product['name']; ?>" data-content="<img src='<?php echo $product['thumb']; ?>' />" data-placement="left" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    <?php foreach ($product['option'] as $option) { ?>
                                    <br />
                                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                    <?php } ?></div></td> 
                                    <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $product['model']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty">
                                    <input class="quantitybox" type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" ><br>
                                    
                                        <a href="javascript://" id="<?php echo $product['key']; ?>" onclick="updateQuantity(this.id);" ><small><?php echo "Update" ?></small></a>                                    
                                    </td>
                                    
                                </td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['price']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['total']; ?></td>
                                <td class="supercheckout-qty"><a href="javascript://" id="<?php echo $product['key']; ?>" onclick="removeProduct(this.id);" class="removeProduct"><div id="<?php echo $product['key']; ?>"  title="Delete"></div></a></td>
                            </tr>
                            <?php } ?>
                            <?php foreach ($vouchers as $voucher) { ?>
                            <tr>
                                <td class="supercheckout-name"><?php echo $voucher['description']; ?></td>
                                <td class="supercheckout-qty">1</td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                            </tr>
                            <?php } ?>
                        </tbody>                    
                    </table>
                    <table class="supercheckout-totals">
                        <tbody>
                                <?php foreach ($totals as $total) { ?>
                            <tr>
                                <td class="title"><b><?php echo $total['title']; if($total['code']=='voucher' || $total['code']=='coupon'){echo'<a href="javascript://" id="'.$total['code'].'"  onclick="redeem(this.id);" ><div title="Redeem" class="removeProduct"></div></a></td>';} ?></b></td>
                                <td class="value"><span class="price"><?php echo $total['text']; ?></span> </td>                                
                            </tr>
                            <?php } ?>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Coupon code:</b></td>
                                <td class="value"><input  id="coupon_code" name="coupon" type="text" class="voucherText">
                                    <input type="hidden" value="coupon" name="next">
                                    <input id="button-coupon" type="button" class="buttonVoucher" onclick="callCoupon();">
                                </td>
                            </tr>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Voucher code:</b></td>
                                <td class="value"><input  id="voucher_code" name="voucher" type="text" class="voucherText">
                                    <input type="hidden" value="voucher" name="next">
                                    <input id="button-voucher" type="button" class="buttonVoucher" onclick="callVoucher();">
                                </td>
                            </tr>
                            </tr>
                        </tbody>
                        
                    </table>            
                    <?php } ?>

                </div>


            </div>
            <div id="payment_display_block"  class="supercheckout-blocks" data-column="<?php echo $sort_block['confirm']['three-column']['column']; ?>" data-row="<?php echo $sort_block['confirm']['three-column']['row']; ?>" >
                <div class="checkout-content"> </div>
                <div id="display_payment">
                    
                    <?php echo $payment_display; ?></div>
        
                <div id="supercheckout-comments" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';}} ?>;">
                <b><?php echo $text_comments; ?></b>
                <textarea id="comment_order" name="comment" rows="8" style="width: 98%;height: 39px;"></textarea>
                <br />
                <br />
                </div>
                <?php if ($text_agree) { ?>                
                <div id="supercheckout-agree" class="right" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';}} ?>;">
                    
                    <?php if ($agree) { ?>
                    <input type="checkbox" name="agree" value="1" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="agree" value="1" />
                    <?php } ?><?php echo " ".$text_agree; ?>
                </div>                
                <?php } ?>
                <div class="right" id="placeorderButton">
                    <input type="button" id="confirm_order" class="flipkartbutton" value="Place Order" />
                </div>
            </div>
                                
        </div>
    </div>
    <?php }elseif($settings['general']['layout']=='2-Column'){ ?>
    <div class="supercheckout-threecolumns supercheckout-container supercheckout-skin-generic " id="supercheckout-columnleft">
        <div class="supercheckout-column-left columnleftsort" id="columnleft-1" style="width:<?php $i= $settings['general']['column_width']['two-column']['out'][1]*.89; echo $i; ?>%"> 
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['login']['two-column']['column']; ?>" data-row="<?php echo $sort_block['login']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['login']['two-column']['column-inside']; ?>"  >
                <ul class="headingCheckout">
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-1"><?php if(!$logged){ echo $text_login_option;}else{echo 'Welcome '.$firstName. ' '.$lastName;} ?></p>

                    </li>
                </ul>
                <div id="checkoutLogin">
                    <div class="checkout-content">

                    </div>
                    <?php if(!$logged){  ?>
                    <div class="supercheckout-extra-wrap">
                        <b><?php echo $entry_email; ?><span class="supercheckout-required">*</span></b><br />
                        <input type="text" id="email" name="email" value="" class="large-field" />
                        <br/>
                    </div>    
                    <div id="loginDetails" class="left" style="display:<?php if($settings['step']['login']['option']['guest']['display'] ){ echo 'block'; }else{ echo 'none';} ?>;">
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="guest">
                                <?php if ($account == 'guest') { ?>
                                <input type="radio" name="account" value="guest" id="guest" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="guest" id="guest" />
                                <?php } ?>
                                <b><?php echo $text_guest; ?></b></label>
                            <br />
                        </div>
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="register">
                                <?php if ($account == 'register') { ?>
                                <input type="radio" name="account" value="register" id="register" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="register" id="register" />
                                <?php } ?>
                                <b><?php echo $text_register; ?></b></label>
                            <br />
                        </div>                    
                    </div>
                    <div id="supercheckout-login" class="right" >
                        <div class="supercheckout-extra-wrap">
                            <b><?php echo $entry_password; ?><span class="supercheckout-required">*</span></b><br />
                            <input type="password" id="password" name="password" value="" class="large-field" />
                            <br />
                            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                            <br />
                            <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="flipkartbuttonsmall" /><br />
                        </div>
                    </div> 
                    <?php if($facebook_enable || $google_enable) { ?>
                    <div class="orSeparator" style="display:<?php if($settings['step']['login']['option']['login']['display'] || $settings['step']['login']['option']['guest']['display'] ){ echo ''; }else{ echo 'none';} ?>;"></div>
                    <h3>Sign in with</h3>
                    <div class="socialNetwork">
                        <?php if($facebook_enable){ ?>
                        <div class="fbButton" id="fb-auth" ></div>
                        <?php }if($google_enable){ ?>
                        <div class="googleButton" onclick="window.open('<?php echo $url; ?>', 'name','resizable=1,scrollbars=no,width=500,height=400')"></div>
                        <?php } ?>
                        <div class="supercheckout-clear"></div>
                    </div>
                    <?php } ?>
                    <?php }else{ ?>
                    <div class="myaccount">
                        <ol class="rectangle-list">                            
                            <li>
                                <a href="<?php echo $myAccount; ?>"><?php echo $text_my_account; ?></a>
                            </li>
<!--                            <li style="float:left;">
                                <a href="<?php echo $myOrder; ?>"><?php echo $text_my_orders; ?></a>
                            </li>-->
                            <li>
                                <a href="<?php echo $logoutLink; ?>"><?php echo $text_logout; ?></a>
                            </li>
                            <div class="supercheckout-clear"></div>

                        </ol>
                    </div>

                    <?php } ?>
                </div>
            </div>
            
            
            <div  class="supercheckout-blocks"  data-column="<?php echo $sort_block['payment_address']['two-column']['column']; ?>" data-row="<?php echo $sort_block['payment_address']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['payment_address']['two-column']['column-inside']; ?>">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-2">Billing Address</p>
                    </li>
                </ul>
                <div id="checkoutBillingAddress">
                    <?php if ($addresses) { ?>

                    <div class="checkout-content">

                    </div>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
                        <label for="payment-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>    
                    <div id="payment-existing">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="payment_address" value="new" id="payment-address-new" />
                            <label for="payment-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table id="payment_address_table" class="supercheckout-form">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $payment_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['telephone']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['telephone']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['telephone']['sort_order'] ?>">
                                <td> <?php echo $entry_telephone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['telephone']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['telephone']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="telephone" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company']['sort_order'] ?>" >
                                <td><?php echo $entry_company; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="company" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company_id']['sort_order'] ?>" >
                                <td><?php echo $entry_company_id; ?><span class="supercheckout-required" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';}} ?>;">*</span>
                                <input type="text" name="company_id" value="" class="large-field" /></td>
                            </tr>                            
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['tax_id']['sort_order'] ?>" >
                                <td><?php echo $entry_tax_id; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    
                                    <input type="text" name="tax_id" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_1']['sort_order'] ?>" >
                                <td> <?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_2']['sort_order'] ?>" >
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['city']['sort_order'] ?>" >
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['postcode']['sort_order'] ?>" >
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="payment-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['country_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['zone_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                            
                        </table>
                    </div>
                    <ul>
                        <li>
                            <div class="input-box input-different-shipping" style="display:<?php if(!$logged){  if($settings['option']['guest']['payment_address']['fields']['shipping']['display']){echo 'block';}else{echo 'none';}}?>;">
                                <input name="use_for_shipping" id="shipping_use"  checked="checked" type="checkbox">
                                <label for="shipping_use"><b><?php echo $text_ship_same_address; ?></b></label>
                            </div>
                        </li>
                    </ul>
                </div>
                <br/>
            </div>      
            <div class="supercheckout-blocks" data-column="<?php echo $sort_block['shipping_address']['two-column']['column']; ?>" data-row="<?php echo $sort_block['shipping_address']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['shipping_address']['two-column']['column-inside']; ?>">
            <div id="checkoutShippingAddress">
                <div class="checkout-content">

                </div>
                
                    <ul>
                        <li>
                            <p class="supercheckout-numbers supercheckout-numbers-ship"><?php echo $text_shipping_address; ?></p>
                        </li>
                    </ul>
                    <?php if ($addresses) { ?>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
                        <label for="shipping-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>
                    <div id="shipping-existing" class="styled-select">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
                            <label for="shipping-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="shipping-new"style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table class="supercheckout-form" id="shipping_address_table">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"   data-percentage="<?php echo $shipping_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>                           
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_1']['sort_order'] ?>">
                                <td><?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span> 
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_2']['sort_order'] ?>">
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['city']['sort_order'] ?>">
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['postcode']['sort_order'] ?>">
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="shipping-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['country_id']['sort_order'] ?>">
                                <td><?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['zone_id']['sort_order'] ?>">
                                <td><?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                        </table>
                    </div>
                </div>                    

            </div>
                                
                                
                                
<!--              COLUMLN 2 PART                  -->
            <?php if($settings['step']['shipping_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['shipping_method']['two-column']['column']; ?>" data-row="<?php echo $sort_block['shipping_method']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['shipping_method']['two-column']['column-inside']; ?>" >
                
                <ul>
                    <li style="display:inline;">
                        <p class="supercheckout-numbers supercheckout-numbers-3"><?php echo $text_shipping_method; ?></p>
                        <div class="loader" id="shippingMethodLoader"></div>
                    </li>                
                </ul>
                
                               
                <div id="shipping-method">
                    <?php if(!$shipping_required){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="permanent-warning" style="display: block;">No shipping required with these product(s).<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                <?php } ?> 
                    <?php if($error_warning_shipping){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="warning" style="display: block;"><?php echo $error_warning_shipping; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                    <?php } ?>
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($shipping_methods && $shipping_required) { ?>

                    <table class="radio">
                        <?php foreach ($shipping_methods as $shipping_method) { ?>
                        <?php if($settings['step']['shipping_method']['display_title']){ ?>
                        <tr>
                            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
                        </tr>
                        <?php } ?>
                        <?php if (!$shipping_method['error']) { ?>
                        <?php foreach ($shipping_method['quote'] as $quote) { ?>
                        <tr class="highlight">
                            <td><?php if(!isset($shipping_code)){ $shipping_code = ''; }if(($quote['code'] == $shipping_code) || !(isset($shipping_code))) { ?>
                                <?php $codeShipping = $quote['code']; ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                                <?php } ?></td>
                            <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
                            <td style="text-align: right;" class="price"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                        </tr>
                        <?php } ?>
                        <?php } else { ?>
                        <tr>
                            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
                        </tr>
                        <?php } ?>
                        <?php } ?>
                    </table>
                    <br />
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
            <?php if($settings['step']['payment_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['payment_method']['two-column']['column']; ?>" data-row="<?php echo $sort_block['payment_method']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['payment_method']['two-column']['column-inside']; ?>">
                
                <ul>
                    <li >
                        <p class="supercheckout-numbers supercheckout-numbers-4"><?php echo $text_payment_method; ?></p>
                        <div class="loader" id="paymentMethodLoader"></div>
                    </li>                
                </ul>
                
                <div id="payment-method">
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($payment_methods) { ?>                 
                    <table class="radio">
                        <?php foreach ($payment_methods as $payment_method) { ?>
                        <tr class="highlight">
                            <td><?php if ($payment_method['code'] == $payment_code || !$payment_code) { ?>
                                <?php $code = $payment_method['code']; ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  />
                                <?php } ?></td>
                            <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
                        </tr>
                        <?php } ?>
                    </table>                 
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
            <div class="supercheckout-blocks confirmCheckoutBack" data-column="<?php echo $sort_block['cart']['two-column']['column']; ?>" data-row="<?php echo $sort_block['cart']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['cart']['two-column']['column-inside']; ?>" style="display:<?php if($logged){ if($settings['option']['logged']['cart']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['display']){ echo' ';}else{ echo'none';}} ?>;">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-check"><?php echo $text_confirm_order; ?></p>
                        <div class="loader" id="confirmLoader"></div>
                    </li>
                </ul>
                <div id="confirmCheckout">
                    <div class="checkout-content">

                    </div>
                    <?php if (!isset($redirect)) { ?>
                    
                    <table class="supercheckout-summary">
                        <thead>
                            <tr>
                                
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name"><?php echo $column_name; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_model; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_quantity; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total" style="text-align:center;"><?php echo $column_price; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $column_total; ?></th>
                                <th class="supercheckout-qty"><?php echo "Action"; ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product) { ?>
                            <tr>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name">
                                    
                                    <div ><a <?php if($logged){ if($settings['option']['logged']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';} }else{ if($settings['option']['guest']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';}} ?> data-title="<?php echo $product['name']; ?>" data-content="<img src='<?php echo $product['thumb']; ?>' />" data-placement="left" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    <?php foreach ($product['option'] as $option) { ?>
                                    <br />
                                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                    <?php } ?></div></td> 
                                    <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $product['model']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty">
                                    <input class="quantitybox" type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" ><br>
                                    
                                        <a href="javascript://" id="<?php echo $product['key']; ?>" onclick="updateQuantity(this.id);" ><small><?php echo "Update" ?></small></a>                                    
                                    </td>
                                    
                                </td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['price']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['total']; ?></td>
                                <td class="supercheckout-qty"><a href="javascript://" id="<?php echo $product['key']; ?>" onclick="removeProduct(this.id);" class="removeProduct"><div id="<?php echo $product['key']; ?>"  title="Delete"></div></a></td>
                            </tr>
                            <?php } ?>
                            <?php foreach ($vouchers as $voucher) { ?>
                            <tr>
                                <td class="supercheckout-name"><?php echo $voucher['description']; ?></td>
                                <td class="supercheckout-qty">1</td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                            </tr>
                            <?php } ?>
                        </tbody>                    
                    </table>
                    <table class="supercheckout-totals">
                        <tbody>
                                <?php foreach ($totals as $total) { ?>
                            <tr>
                                <td class="title"><b><?php echo $total['title']; if($total['code']=='voucher' || $total['code']=='coupon'){echo'<a href="javascript://" id="'.$total['code'].'"  onclick="redeem(this.id);" ><div title="Redeem" class="removeProduct"></div></a></td>';} ?></b></td>
                                <td class="value"><span class="price"><?php echo $total['text']; ?></span> </td>                                
                            </tr>
                            <?php } ?>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Coupon code:</b></td>
                                <td class="value"><input  id="coupon_code" name="coupon" type="text" class="voucherText">
                                    <input type="hidden" value="coupon" name="next">
                                    <input id="button-coupon" type="button" class="buttonVoucher" onclick="callCoupon();">
                                </td>
                            </tr>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Voucher code:</b></td>
                                <td class="value"><input  id="voucher_code" name="voucher" type="text" class="voucherText">
                                    <input type="hidden" value="voucher" name="next">
                                    <input id="button-voucher" type="button" class="buttonVoucher" onclick="callVoucher();">
                                </td>
                            </tr>
                            </tr>
                        </tbody>
                        
                    </table>            
                    <?php } ?>

                </div>


            </div>
            <div id="payment_display_block"  class="supercheckout-blocks" data-column="<?php echo $sort_block['confirm']['two-column']['column']; ?>" data-row="<?php echo $sort_block['confirm']['two-column']['row']; ?>" data-column-inside="<?php echo $sort_block['confirm']['two-column']['column-inside']; ?>" >
                <div class="checkout-content"> </div>
                <div id="display_payment">
                    
                    <?php echo $payment_display; ?></div>
        
                <div id="supercheckout-comments" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';}} ?>;">
                <b><?php echo $text_comments; ?></b>
                <textarea id="comment_order" name="comment" rows="8" style="width: 98%;height: 39px;"></textarea>
                <br />
                <br />
                </div>
                <?php if ($text_agree) { ?>                
                <div id="supercheckout-agree" class="right" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';}} ?>;">
                    
                    <?php if ($agree) { ?>
                    <input type="checkbox" name="agree" value="1" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="agree" value="1" />
                    <?php } ?><?php echo " ".$text_agree; ?>
                </div>                
                <?php } ?>
                <div class="right" id="placeorderButton">
                    <input type="button" id="confirm_order" class="flipkartbutton" value="Place Order" />
                </div>
            </div>
        </div>

        <div class="supercheckout-column-middle columnleftsort" id="columnleft-2"  style="width:<?php $i= $settings['general']['column_width']['two-column']['out'][2]*.94; echo $i; ?>%">
            <div class="supercheckout-column-left columnleftsort" id="column-2-upper" style="width:100%;height:auto;"> 
            </div>
            <div class="supercheckout-column-left columnleftsort" id="column-1-inside" style="width:<?php $i= $settings['general']['column_width']['two-column']['inside'][1]*.94; echo $i; ?>%"> 
            </div>
            <div class="supercheckout-column-middle columnleftsort" id="column-2-inside"  style="width:<?php $i= $settings['general']['column_width']['two-column']['inside'][2]*.94; echo $i; ?>%">
            
            </div>
            <div class="supercheckout-column-middle columnleftsort" id="column-2-lower"  style="width:100%;height:auto;">
            
            </div>
        </div>
    </div>
    <?php }elseif($settings['general']['layout']=='1-Column'){ ?>
    <div class="supercheckout-threecolumns supercheckout-container supercheckout-skin-generic " id="supercheckout-columnleft">
        <div class="supercheckout-column-left columnleftsort" id="columnleft-1" style="width:97%"> 
            <div  class="supercheckout-blocks" data-row="<?php echo $sort_block['login']['one-column']['row']; ?>" >
                <ul class="headingCheckout">
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-1"><?php if(!$logged){ echo $text_login_option;}else{echo 'Welcome '.$firstName. ' '.$lastName;} ?></p>

                    </li>
                </ul>
                <div id="checkoutLogin">
                    <div class="checkout-content">

                    </div>
                    <?php if(!$logged){  ?>
                    <div class="supercheckout-extra-wrap">
                        <b><?php echo $entry_email; ?><span class="supercheckout-required">*</span></b><br />
                        <input type="text" id="email" name="email" value="" class="large-field" />
                        <br/>
                    </div>    
                    <div id="loginDetails" class="left" style="display:<?php if($settings['step']['login']['option']['guest']['display'] ){ echo 'block'; }else{ echo 'none';} ?>;">
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="guest">
                                <?php if ($account == 'guest') { ?>
                                <input type="radio" name="account" value="guest" id="guest" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="guest" id="guest" />
                                <?php } ?>
                                <b><?php echo $text_guest; ?></b></label>
                            <br />
                        </div>
                        
                        <div class="supercheckout-extra-wrap">
                            <label for="register">
                                <?php if ($account == 'register') { ?>
                                <input type="radio" name="account" value="register" id="register" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="account" value="register" id="register" />
                                <?php } ?>
                                <b><?php echo $text_register; ?></b></label>
                            <br />
                        </div>                    
                    </div>
                    <div id="supercheckout-login" class="right" >
                        <div class="supercheckout-extra-wrap">
                            <b><?php echo $entry_password; ?><span class="supercheckout-required">*</span></b><br />
                            <input type="password" id="password" name="password" value="" class="large-field" />
                            <br />
                            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                            <br />
                            <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="flipkartbuttonsmall" /><br />
                        </div>
                    </div> 
                    <?php if($facebook_enable || $google_enable) { ?>
                    <div class="orSeparator" style="display:<?php if($settings['step']['login']['option']['login']['display'] || $settings['step']['login']['option']['guest']['display'] ){ echo ''; }else{ echo 'none';} ?>;"></div>
                    <h3>Sign in with</h3>
                    <div class="socialNetwork">
                        <?php if($facebook_enable){ ?>
                        <div class="fbButton" id="fb-auth" ></div>
                        <?php }if($google_enable){ ?>
                        <div class="googleButton" onclick="window.open('<?php echo $url; ?>', 'name','resizable=1,scrollbars=no,width=500,height=400')"></div>
                        <?php } ?>
                        <div class="supercheckout-clear"></div>
                    </div>
                    <?php } ?>
                    <?php }else{ ?>
                    <div class="myaccount">
                        <ol class="rectangle-list">                            
                            <li>
                                <a href="<?php echo $myAccount; ?>"><?php echo $text_my_account; ?></a>
                            </li>
<!--                            <li style="float:left;">
                                <a href="<?php echo $myOrder; ?>"><?php echo $text_my_orders; ?></a>
                            </li>-->
                            <li>
                                <a href="<?php echo $logoutLink; ?>"><?php echo $text_logout; ?></a>
                            </li>
                            <div class="supercheckout-clear"></div>

                        </ol>
                    </div>

                    <?php } ?>
                </div>
            </div>
            
            
            <div  class="supercheckout-blocks" data-row="<?php echo $sort_block['payment_address']['one-column']['row']; ?>">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-numbers-2">Billing Address</p>
                    </li>
                </ul>
                <div id="checkoutBillingAddress">
                    <?php if ($addresses) { ?>

                    <div class="checkout-content">

                    </div>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
                        <label for="payment-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>    
                    <div id="payment-existing">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="payment_address" value="new" id="payment-address-new" />
                            <label for="payment-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table id="payment_address_table" class="supercheckout-form">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $payment_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['telephone']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['telephone']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['telephone']['sort_order'] ?>">
                                <td> <?php echo $entry_telephone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['telephone']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['telephone']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="telephone" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company']['sort_order'] ?>" >
                                <td><?php echo $entry_company; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="company" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['company_id']['sort_order'] ?>" >
                                <td><?php echo $entry_company_id; ?><span class="supercheckout-required" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['company_id']['require']){ echo'inline';}else{ echo'none';}} ?>;">*</span>
                                <input type="text" name="company_id" value="" class="large-field" /></td>
                            </tr>                            
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['tax_id']['sort_order'] ?>" >
                                <td><?php echo $entry_tax_id; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['tax_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                    
                                    <input type="text" name="tax_id" value="" class="large-field" /></td>
                            </tr>
                            
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_1']['sort_order'] ?>" >
                                <td> <?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['address_2']['sort_order'] ?>" >
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['city']['sort_order'] ?>" >
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['postcode']['sort_order'] ?>" >
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="payment-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['country_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $payment_address_sort_order['fields']['zone_id']['sort_order'] ?>" >
                                <td> <?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['payment_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                            
                        </table>
                    </div>
                    <ul>
                        <li>
                            <div class="input-box input-different-shipping" style="display:<?php if(!$logged){  if($settings['option']['guest']['payment_address']['fields']['shipping']['display']){echo 'block';}else{echo 'none';}}?>;">
                                <input name="use_for_shipping" id="shipping_use"  checked="checked" type="checkbox">
                                <label for="shipping_use"><b><?php echo $text_ship_same_address; ?></b></label>
                            </div>
                        </li>
                    </ul>
                </div>
                <br/>
            </div>      
            <div class="supercheckout-blocks" data-row="<?php echo $sort_block['shipping_address']['one-column']['row']; ?>">
            <div id="checkoutShippingAddress">
                <div class="checkout-content">

                </div>
                
                    <ul>
                        <li>
                            <p class="supercheckout-numbers supercheckout-numbers-ship"><?php echo $text_shipping_address; ?></p>
                        </li>
                    </ul>
                    <?php if ($addresses) { ?>
                    <div class="supercheckout-extra-wrap">
                        <input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
                        <label for="shipping-address-existing"><?php echo $text_address_existing; ?></label>
                    </div>
                    <div id="shipping-existing" class="styled-select">
                        <select name="address_id" style="width: 92%; margin-bottom: 15px;">
                            <?php foreach ($addresses as $address) { ?>
                            <?php if ($address['address_id'] == $address_id) { ?>
                            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="supercheckout-extra-wrap">
                        <p>
                            <input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
                            <label for="shipping-address-new"><?php echo $text_address_new; ?></label>
                        </p>
                    </div>
                    <?php } ?>
                    <div id="shipping-new"style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
                        <table class="supercheckout-form" id="shipping_address_table">
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['display']){ echo'block';}else{ echo'none';}} ?>;"   data-percentage="<?php echo $shipping_address_sort_order['fields']['firstname']['sort_order'] ?>" >
                                <td> <?php echo $entry_firstname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['firstname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="firstname" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['lastname']['sort_order'] ?>">
                                <td> <?php echo $entry_lastname; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['lastname']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="lastname" value="" class="large-field" /></td>
                            </tr>                           
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_1']['sort_order'] ?>">
                                <td><?php echo $entry_address_1; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_1']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span> 
                                <input type="text" name="address_1" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['address_2']['sort_order'] ?>">
                                <td><?php echo $entry_address_2; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['address_2']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="address_2" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['city']['sort_order'] ?>">
                                <td><?php echo $entry_city; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['city']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <input type="text" name="city" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['display']){ echo'block';}else{ echo'none';}} ?>;"  data-percentage="<?php echo $shipping_address_sort_order['fields']['postcode']['sort_order'] ?>">
                                <td><?php echo $entry_postcode; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['postcode']['require']){ echo'inline';}else{ echo'none';}} ?>;" id="shipping-postcode-required" class="supercheckout-required">*</span>
                                <input type="text" name="postcode" value="" class="large-field" /></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['country_id']['sort_order'] ?>">
                                <td><?php echo $entry_country; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['country_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="country_id" class="large-field">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($countries as $country) { ?>
                                        <?php if (($country['country_id'] == $country_id)) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select></td>
                            </tr>
                            <tr class="sort_data" style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['display']){ echo'block';}else{ echo'none';}} ?>;" data-percentage="<?php echo $shipping_address_sort_order['fields']['zone_id']['sort_order'] ?>">
                                <td><?php echo $entry_zone; ?><span style="display:<?php if($logged){ if($settings['option']['logged']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';} }else{ if($settings['option']['guest']['shipping_address']['fields']['zone_id']['require']){ echo'inline';}else{ echo'none';}} ?>;" class="supercheckout-required">*</span>
                                <select name="zone_id" class="large-field">
                                        <?php echo $zones_default; ?>
                                    </select></td>
                            </tr>
                        </table>
                    </div>
                </div>                    

            </div>
                                
                                
                                
<!--              COLUMLN 2 PART                  -->
            <?php if($settings['step']['shipping_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-row="<?php echo $sort_block['shipping_method']['one-column']['row']; ?>">
                
                <ul>
                    <li style="display:inline;">
                        <p class="supercheckout-numbers supercheckout-numbers-3"><?php echo $text_shipping_method; ?></p>
                        <div class="loader" id="shippingMethodLoader"></div>
                    </li>                
                </ul>
                
                
                <div id="shipping-method">
                    <?php if(!$shipping_required){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="permanent-warning" style="display: block;">No shipping required with these product(s).<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                <?php } ?> 
                    <?php if($error_warning_shipping){ ?>
                    <div class="checkout-content" style="display:block">
                        <div class="warning" style="display: block;"><?php echo $error_warning_shipping; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
                    </div>
                    <?php } ?>
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($shipping_methods && $shipping_required) { ?>

                    <table class="radio">
                        <?php foreach ($shipping_methods as $shipping_method) { ?>
                        <?php if($settings['step']['shipping_method']['display_title']){ ?>
                        <tr>
                            <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
                        </tr>
                        <?php } ?>
                        <?php if (!$shipping_method['error']) { ?>
                        <?php foreach ($shipping_method['quote'] as $quote) { ?>
                        <tr class="highlight">
                            <td><?php if(!isset($shipping_code)){ $shipping_code = ''; }if(($quote['code'] == $shipping_code) || !(isset($shipping_code))) { ?>
                                <?php $codeShipping = $quote['code']; ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
                                <?php } ?></td>
                            <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
                            <td style="text-align: right;" class="price"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
                        </tr>
                        <?php } ?>
                        <?php } else { ?>
                        <tr>
                            <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
                        </tr>
                        <?php } ?>
                        <?php } ?>
                    </table>
                    <br />
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
            <?php if($settings['step']['payment_method']['display_options']){ ?>
            <div  class="supercheckout-blocks" data-column="<?php echo $sort_block['payment_method']['one-column']['column']; ?>" data-row="<?php echo $sort_block['payment_method']['one-column']['row']; ?>" data-column-inside="<?php echo $sort_block['payment_method']['one-column']['column-inside']; ?>">
                
                <ul>
                    <li >
                        <p class="supercheckout-numbers supercheckout-numbers-4"><?php echo $text_payment_method; ?></p>
                        <div class="loader" id="paymentMethodLoader"></div>
                    </li>                
                </ul>
                
                <div id="payment-method">
                    <div class="checkout-content">

                    </div>
                    <?php if ($error_warning) { ?>
                    <div class="warning"><?php echo $error_warning; ?></div>
                    <?php } ?>
                    <?php if ($payment_methods) { ?>                 
                    <table class="radio">
                        <?php foreach ($payment_methods as $payment_method) { ?>
                        <tr class="highlight">
                            <td><?php if ($payment_method['code'] == $payment_code || !$payment_code) { ?>
                                <?php $code = $payment_method['code']; ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  checked="checked" />
                                <?php } else { ?>
                                <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>"  />
                                <?php } ?></td>
                            <td><label for="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></label></td>
                        </tr>
                        <?php } ?>
                    </table>                 
                    <?php } ?>
                </div>
                
            </div>
            <?php } ?>
            <div class="supercheckout-blocks confirmCheckoutBack" data-row="<?php echo $sort_block['cart']['one-column']['row']; ?>" style="display:<?php if($logged){ if($settings['option']['logged']['cart']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['display']){ echo' ';}else{ echo'none';}} ?>;">
                <ul>
                    <li>
                        <p class="supercheckout-numbers supercheckout-check"><?php echo $text_confirm_order; ?></p>
                        <div class="loader" id="confirmLoader"></div>
                    </li>
                </ul>
                <div id="confirmCheckout">
                    <div class="checkout-content">

                    </div>
                    <?php if (!isset($redirect)) { ?>
                    
                    <table class="supercheckout-summary">
                        <thead>
                            <tr>
                                
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name"><?php echo $column_name; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_model; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $column_quantity; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total" style="text-align:center;"><?php echo $column_price; ?></th>
                                <th style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $column_total; ?></th>
                                <th class="supercheckout-qty"><?php echo "Action"; ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($products as $product) { ?>
                            <tr>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['name']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['name']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-name">
                                    
                                    <div ><a <?php if($logged){ if($settings['option']['logged']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';} }else{ if($settings['option']['guest']['cart']['columns']['image']){ echo'data-toggle="popover"';}else{ echo'';}} ?> data-title="<?php echo $product['name']; ?>" data-content="<img src='<?php echo $product['thumb']; ?>' />" data-placement="right" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    <?php foreach ($product['option'] as $option) { ?>
                                    <br />
                                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                    <?php } ?></div></td> 
                                    <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['model']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['model']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty"><?php echo $product['model']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['quantity']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-qty">
                                    <input class="quantitybox" type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" ><br>
                                    
                                        <a href="javascript://" id="<?php echo $product['key']; ?>" onclick="updateQuantity(this.id);" ><small><?php echo "Update" ?></small></a>                                    
                                    </td>
                                    
                                </td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['price']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['price']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['price']; ?></td>
                                <td style="display:<?php if($logged){ if($settings['option']['logged']['cart']['columns']['total']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['columns']['total']){ echo' ';}else{ echo'none';}} ?>;" class="supercheckout-total"><?php echo $product['total']; ?></td>
                                <td class="supercheckout-qty"><a href="javascript://" id="<?php echo $product['key']; ?>" onclick="removeProduct(this.id);" class="removeProduct"><div id="<?php echo $product['key']; ?>"  title="Delete"></div></a></td>
                            </tr>
                            <?php } ?>
                            <?php foreach ($vouchers as $voucher) { ?>
                            <tr>
                                <td class="supercheckout-name"><?php echo $voucher['description']; ?></td>
                                <td class="supercheckout-qty">1</td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                                <td class="supercheckout-total"><?php echo $voucher['amount']; ?></td>
                            </tr>
                            <?php } ?>
                        </tbody>                    
                    </table>
                    <table class="supercheckout-totals">
                        <tbody>
                                <?php foreach ($totals as $total) { ?>
                            <tr>
                                <td class="title"><b><?php echo $total['title']; if($total['code']=='voucher' || $total['code']=='coupon'){echo'<a href="javascript://" id="'.$total['code'].'"  onclick="redeem(this.id);" ><div title="Redeem" class="removeProduct"></div></a></td>';} ?></b></td>
                                <td class="value"><span class="price"><?php echo $total['text']; ?></span> </td>                                
                            </tr>
                            <?php } ?>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['coupon']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Coupon code:</b></td>
                                <td class="value"><input  id="coupon_code" name="coupon" type="text" class="voucherText">
                                    <input type="hidden" value="coupon" name="next">
                                    <input id="button-coupon" type="button" class="buttonVoucher" onclick="callCoupon();">
                                </td>
                            </tr>
                            <tr style="display:<?php if($logged){ if($settings['option']['logged']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';} }else{ if($settings['option']['guest']['cart']['option']['voucher']['display']){ echo' ';}else{ echo'none';}} ?>;">
                                <td class="title"><b>Voucher code:</b></td>
                                <td class="value"><input  id="voucher_code" name="voucher" type="text" class="voucherText">
                                    <input type="hidden" value="voucher" name="next">
                                    <input id="button-voucher" type="button" class="buttonVoucher" onclick="callVoucher();">
                                </td>
                            </tr>
                            </tr>
                        </tbody>
                        
                    </table>            
                    <?php } ?>

                </div>


            </div>
            <div id="payment_display_block"  class="supercheckout-blocks" data-row="<?php echo $sort_block['confirm']['one-column']['row']; ?>" >
                <div class="checkout-content"> </div>
                <div id="display_payment">
                    
                    <?php echo $payment_display; ?></div>
        
                <div id="supercheckout-comments" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['comment']['display']){ echo'block';}else{ echo'none';}} ?>;">
                <b><?php echo $text_comments; ?></b>
                <textarea id="comment_order" name="comment" rows="8" style="width: 98%;height: 39px;"></textarea>
                <br />
                <br />
                </div>
                <?php if ($text_agree) { ?>                
                <div id="supercheckout-agree" class="right" style="display:<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['display']){ echo'block';}else{ echo'none';}} ?>;">
                    
                    <?php if ($agree) { ?>
                    <input type="checkbox" name="agree" value="1" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="agree" value="1" />
                    <?php } ?><?php echo " ".$text_agree; ?>
                </div>                
                <?php } ?>
                <div class="right" id="placeorderButton">
                    <input type="button" id="confirm_order" class="flipkartbutton" value="Place Order" />
                </div>
            </div>
        </div>        
    </div>
    <?php } ?>
</fieldset>
<?php echo $footer; ?>
<script>
    //DISABLING CONFIRM BUTTON FOR 5 SEC AFTER IT IS CLICKED ONCE
    $("#confirm_order").click(function() {
    $('#confirm_order').attr('disabled', true);
            var btn = $(this);
        btn.prop('disabled', true);
        setTimeout(function(){
            btn.prop('disabled', false);
        }, 5000);
        validateCheckout();
        
    });
</script>
<script>
// ON CHANGING PAYMENT METHOD 
$("input[name='payment_method']").change(function(){    
    $('#confirmLoader').show();
    $.ajax({
        url: 'index.php?route=supercheckout/payment_method/validate', 
        type: 'post',
        data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-payment-method').attr('disabled', true);
            $('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-payment-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('#confirmLoader').hide();
            $('.warning, .error').remove();
			
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#payment-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');					
                    $('.warning').fadeIn('slow');
                }			
            } else {
                $.ajax({
                    url: 'index.php?route=supercheckout/payment_display',
                    dataType: 'html',
                    success: function(html) {
                                            
                        $('#display_payment').html(html);
//                        validatePaymentMethodRefresh();
                   
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });	
									
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});
// ON CHANGING SHIPPING  METHOD 

$("input[name='shipping_method']").change(function(){  
    $('#confirmLoader').show();
    $.ajax({
        url: 'index.php?route=supercheckout/shipping_method/validate', 
        type: 'post',
        data: $('#shipping-method input[type=\'radio\']:checked'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-shipping-method').attr('disabled', true);
            $('#button-shipping-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-shipping-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('#confirmLoader').hide();
            $('.warning, .error').remove();
			
            if (json['redirect']) {
            //				location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
                    $('.warning').fadeIn('slow');
                }			
            } else {
                $('#confirmLoader').show();
                $.ajax({
                    url: 'index.php?route=supercheckout/confirm',
                    dataType: 'html',
                    success: function(html) {
                        $('#confirmLoader').hide();
                        $('#confirmCheckout').html(html);
                        $('#paymentDisable').html("");
                        $.ajax({
                            url: 'index.php?route=supercheckout/payment_display',
                            dataType: 'html',
                            success: function(html) {
                                $('#display_payment').html(html);
//                                validatePaymentMethodRefresh();
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });	
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });	
									
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});
</script>

<script>

// ON CONFIRM CLICK VALIDATING THE WHOLE PAGE AT ONCE AND DISPLAYS ERROR ACCORDINGLY
function goToByScroll(id){
    // Remove "link" from the ID
    id = id.replace("link", "");
    // Scroll
    $('html,body').animate({
        scrollTop: $("#"+id).offset().top
        },
    'slow');
}
function validatePaymentAddress(){

    var paymentAddressEnable="1";
    
    if(paymentAddressEnable==1){
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/loginPaymentAddressValidate',
            type: 'post',
            data: $('#checkoutBillingAddress input[type=\'text\'], #checkoutBillingAddress input[type=\'password\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #checkoutBillingAddress input[type=\'radio\']:checked, #checkoutBillingAddress input[type=\'hidden\'], #checkoutBillingAddress select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-payment-address').attr('disabled', true);
                $('#button-payment-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-payment-address').attr('disabled', false);
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .errorsmall').remove();
			
                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    goToByScroll('checkoutBillingAddress');
                    if (json['error']['warning']) {
                        $('#checkoutBillingAddress .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('#checkoutBillingAddress .checkout-content').show();
                        $('.warning').fadeIn('slow');
                    }
								
                    if (json['error']['firstname']) {
                        $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                    }
				
                    if (json['error']['lastname']) {
                        $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                    }	
				
                    if (json['error']['telephone']) {
                        $('#payment-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                    }		
                    if (json['error']['company']) {
                        $('#payment-new input[name=\'company\']').after('<span class="errorsmall">' + json['error']['company'] + '</span>');
                    }
                    if (json['error']['company_id']) {
                        $('#payment-new input[name=\'company_id\']').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                    }	
				
                    if (json['error']['tax_id']) {
                        $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                    }	
														
                    if (json['error']['address_1']) {
                        $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                    }
                    if (json['error']['address_2']) {
                        $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                    }
				
                    if (json['error']['city']) {
                        $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                    }	
				
                    if (json['error']['postcode']) {
                        $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                    }	
				
                    if (json['error']['country']) {
                        $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                    }	
				
                    if (json['error']['zone']) {
                        $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                    }
                } else {
                    validateLoginShippingAddress();
                }
            }
        });
    }
    else{
        validateLoginShippingAddress();
    }
}
function validateLoginShippingAddress(){
    var paymentAddressEnable="1";
    var shippingMethodEnable="<?php echo $settings['step']['shipping_method']['display_options']; ?>";
    var paymentMethodEnable="<?php echo $settings['step']['payment_method']['display_options']; ?>";
    if(paymentAddressEnable==1){
        if(!$('#shipping_use').is(":checked")){    
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/loginShippingAddressValidate',
                type: 'post',
                data: $('#checkoutShippingAddress input[type=\'text\'], #checkoutShippingAddress input[type=\'password\'], #checkoutShippingAddress input[type=\'checkbox\']:checked, #checkoutShippingAddress input[type=\'radio\']:checked, #checkoutShippingAddress select'),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-shipping-address').attr('disabled', true);
                    $('#button-shipping-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },	
                complete: function() {
                    $('#button-shipping-address').attr('disabled', false);
                    $('.wait').remove();
                },			
                success: function(json) {             
                    $('.warning, .error').remove();

                    if (json['redirect']) {
                        location = json['redirect'];
                    } else if (json['error']) {
                        if (json['error']['warning']) {
                            $('#checkoutShippingAddress .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                            $('#checkoutShippingAddress .checkout-content').show();
                            $('.warning').fadeIn('slow');
                        }
                        goToByScroll('checkoutShippingAddress');
                        if (json['error']['firstname']) {
                            $('#shipping-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                        }

                        if (json['error']['lastname']) {
                            $('#shipping-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                        }	

                        if (json['error']['email']) {
                            $('#shipping-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                        }

                        if (json['error']['telephone']) {
                            $('#shipping-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                        }		

                        if (json['error']['address_1']) {
                            $('#shipping-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                        }	
                        if (json['error']['address_2']) {
                            $('#shipping-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                        }
                        if (json['error']['city']) {
                            $('#shipping-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                        }	

                        if (json['error']['postcode']) {
                            $('#shipping-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                        }	

                        if (json['error']['country']) {
                            $('#shipping-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                        }	

                        if (json['error']['zone']) {
                            $('#shipping-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                        }
                    } else {
                        if(shippingMethodEnable==1){
                            validateShippingMethod();
                        }else{
                            if(paymentMethodEnable==1){
                                validatePaymentMethod();
                            }else{
                                var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                                if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                                    validateAgree();
                                }
                                else{
                                    goToConfirm();
                                }
                            }
                        }
                    }
                }
            });
        }else{
            if(shippingMethodEnable==1){
                validateShippingMethod();
            }else{
                if(paymentMethodEnable==1){
                    validatePaymentMethod();
                }else{
                    var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                    if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                        validateAgree();
                    }
                    else{
                        goToConfirm();
                    }
                }
            }
        }
    }
    else{
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/loginShippingAddressValidate',
            type: 'post',
            data: $('#checkoutShippingAddress input[type=\'text\'], #checkoutShippingAddress input[type=\'password\'], #checkoutShippingAddress input[type=\'radio\']:checked, #checkoutShippingAddress select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-shipping-address').attr('disabled', true);
                $('#button-shipping-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-shipping-address').attr('disabled', false);
                $('.wait').remove();
            },			
            success: function(json) {             
                $('.warning, .error').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#checkoutShippingAddress .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                        $('#checkoutShippingAddress .checkout-content').show();
                        $('.warning').fadeIn('slow');
                    }

                    if (json['error']['firstname']) {
                        $('#shipping-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                    }

                    if (json['error']['lastname']) {
                        $('#shipping-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                    }	

                    if (json['error']['email']) {
                        $('#shipping-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                    }

                    if (json['error']['telephone']) {
                        $('#shipping-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                    }		

                    if (json['error']['address_1']) {
                        $('#shipping-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                    }	
                    if (json['error']['address_2']) {
                        $('#shipping-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                    }
                    if (json['error']['city']) {
                        $('#shipping-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                    }	

                    if (json['error']['postcode']) {
                        $('#shipping-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                    }	

                    if (json['error']['country']) {
                        $('#shipping-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                    }	

                    if (json['error']['zone']) {
                        $('#shipping-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                    }
                } else {
                    if(shippingMethodEnable==1){
                        validateShippingMethod();
                    }else{
                        if(paymentMethodEnable==1){
                            validatePaymentMethod();
                        }else{
                            var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                            if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                                validateAgree();
                            }
                            else{
                                goToConfirm();
                            }
                        }
                    }
                }
            }
        });
    }
}
function validateShippingMethod(){
    var paymentMethodEnable="<?php echo $settings['step']['payment_method']['display_options']; ?>";
    $.ajax({
        url: 'index.php?route=supercheckout/shipping_method/validate', 
        type: 'post',
        data: $('#shipping-method input[type=\'radio\']:checked'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-shipping-method').attr('disabled', true);
            $('#button-shipping-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-shipping-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
            //				location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#shipping-method .checkout-content').show();
                    $('.warning').fadeIn('slow');
                }			
            } else {
                if(paymentMethodEnable==1){
                    validatePaymentMethod();
                }else{
                    var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                    if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                        validateAgree();
                    }
                    else{
                        goToConfirm();
                    }
                }                
            }
        }
    });
}
function validatePaymentMethod(){
    $.ajax({
        url: 'index.php?route=supercheckout/payment_method/validate', 
        type: 'post',
        data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea,#payment_display_block input[type=\'checkbox\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-payment-method').attr('disabled', true);
            $('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-payment-method').attr('disabled', false);
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#payment-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#payment-method .checkout-content').show();
                    $('.warning').fadeIn('slow');
                }else if(json['error']['warnings']){
                    $('#payment_display_block .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warnings'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#payment_display_block .checkout-content').show();
                    $('.warning').fadeIn('slow');
                    goToByScroll('payment_display_block');
                }			
            } else {
                var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                var comment="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['comment']['display']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['comment']['display']){ echo'guestblock';}} ?>";               
                if(comment=='loginblock' || comment=='guestblock'){
                    setComment();
                }
                if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                    validateAgree();
                    
                }
                else{
                    goToConfirm();
                }
            }
        }
    });
}
function setComment(){
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/setCommentSession', 
        type: 'post',
        data: $('#comment_order'),
        dataType: 'json',        		
        success: function(json) {
            
        }
    });
}
function validateAgree(){
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/validateAgree', 
        type: 'post',
        data: $('#payment_display_block input[type=\'checkbox\']:checked'),
        dataType: 'json',        		
        success: function(json) {
            $('.warning, .error').remove();

            if (json['error']) {
                if (json['error']['warning']) {
                    $('#payment_display_block .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#payment_display_block .checkout-content').show();
                    $('.warning').fadeIn('slow');
                    goToByScroll('payment_display_block');
                }			
            } else {
                goToConfirm();
            }
        }
    });
    
}
function createGuestAccount(){
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/createGuestAccount',
        type:'post',
        data: $('#checkoutLogin input[type=\'text\']'),
        success: function(html) {
        
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}
function goToConfirm(){    
    $.ajax({
        url: 'index.php?route=supercheckout/confirm',
        dataType: 'html',
        success: function(html) {
            $("#button-confirm , input[type=submit]").trigger("click");
        //            $("#button-confirm , input[type=submit]").unbind("click");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
    
}
function validateEmail(){
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/validateEmail',
        type: 'post',
        data: $('#checkoutLogin input[type=\'text\']'),
        dataType: 'json',
        success: function(json) {
            $('.warning, .error').remove();
            if (json['error']) {
                if (json['error']['warning']) {
                    $('#checkoutLogin .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
                    $('#checkoutLogin .checkout-content').show();
                    $('.warning').fadeIn('slow');
                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow'); 
                }
            }
            else {
                validateGuestPaymentAddress();
            }
                
        }
    });
}
function validateGuestPaymentAddress(){
    var paymentGuestAddressEnable="1";
    var useforShippingEnable="<?php echo $settings['option']['guest']['payment_address']['fields']['shipping']['display']; ?>";
    if(paymentGuestAddressEnable==1){
        if(useforShippingEnable==1){
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/guestPaymentAddressValidate',
                type: 'post',
                data: $('#payment-new  input[type=\'text\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #payment-new select, #checkoutLogin input[name=\'email\'] '),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-guest').attr('disabled', true);
                    $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },	
                complete: function() {
                    $('#button-guest').attr('disabled', false); 
                    $('.wait').remove();
                },			
                success: function(json) {
                    $('.warning, .errorsmall').remove();

                    if (json['redirect']) {
                        location = json['redirect'];
                    }
                    else if (json['error']) {
                        if (json['error']['warning']) {
                            $('#payment-new .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                            $('.warning').fadeIn('slow');
                        }

                        if (json['error']['firstname']) {
                            $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                        }

                        if (json['error']['lastname']) {
                            $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                        }	

                        if (json['error']['email']) {
                            $('#payment-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                        }

                        if (json['error']['telephone']) {
                            $('#vinput[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                        }	
                        if (json['error']['company']) {
                            $('#payment-new input[name=\'company\']').after('<span class="errorsmall">' + json['error']['company'] + '</span>');
                        }
                        if (json['error']['company_id']) {
                            $('#payment-new input[name=\'company_id\']').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                        }	

                        if (json['error']['tax_id']) {
                            $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                        }	

                        if (json['error']['address_1']) {
                            $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                        }	
                        if (json['error']['address_2']) {
                            $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                        }
                        if (json['error']['city']) {
                            $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                        }	

                        if (json['error']['postcode']) {
                            $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                        }	

                        if (json['error']['country']) {
                            $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                        }	

                        if (json['error']['zone']) {
                            $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                        }
                        goToByScroll('checkoutBillingAddress');
                    } 
                    else {
                        checkGuestShippingAddress();
                    }
                }
            });
        }
        else{
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/guestPaymentAddressValidate',
                type: 'post',
                data: $('#payment-new  input[type=\'text\'],  #payment-new select , #checkoutLogin input[name=\'email\']'),
                dataType: 'json',
                beforeSend: function() {
                    $('#button-guest').attr('disabled', true);
                    $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },	
                complete: function() {
                    $('#button-guest').attr('disabled', false); 
                    $('.wait').remove();
                },			
                success: function(json) {
                    $('.warning, .errorsmall').remove();

                    if (json['redirect']) {
                        location = json['redirect'];
                    }
                    else if (json['error']) {
                        if (json['error']['warning']) {
                            $('#payment-new .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                            $('.warning').fadeIn('slow');
                        }

                        if (json['error']['firstname']) {
                            $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                        }

                        if (json['error']['lastname']) {
                            $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                        }	

                        if (json['error']['email']) {
                            $('#payment-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                        }

                        if (json['error']['telephone']) {
                            $('#vinput[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                        }	

                        if (json['error']['company_id']) {
                            $('#payment-new input[name=\'company_id\'] + br').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                        }	

                        if (json['error']['tax_id']) {
                            $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                        }	

                        if (json['error']['address_1']) {
                            $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                        }	
                        if (json['error']['address_2']) {
                            $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                        }
                        if (json['error']['city']) {
                            $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                        }	

                        if (json['error']['postcode']) {
                            $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                        }	

                        if (json['error']['country']) {
                            $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                        }	

                        if (json['error']['zone']) {
                            $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                        }
                        goToByScroll('checkoutBillingAddress');
                    } 
                    else {
                        checkGuestShippingAddress();
                    }
                }
            });
        }
    }else{
        
        validateGuestShippingAddress();
    }
}
function validateGuestShippingAddress(){
    var paymentMethodEnable="<?php echo $settings['step']['payment_method']['display_options']; ?>";
    var shippingMethodEnable="<?php echo $settings['step']['shipping_method']['display_options']; ?>";
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/guestShippingAddressValidate',
        type: 'post',
        data: $('#shipping-new input[type=\'text\'], #shipping-new select'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-guest-shipping').attr('disabled', true);
            $('#button-guest-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-guest-shipping').attr('disabled', false); 
            $('.wait').remove();
        },			
        success: function(json) {
            $('.warning, .errorsmall').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#shipping-new .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');
                }

                if (json['error']['firstname']) {
                    $('#shipping-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                }

                if (json['error']['lastname']) {
                    $('#shipping-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                }	

                if (json['error']['address_1']) {
                    $('#shipping-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                }	
                if (json['error']['address_2']) {
                    $('#shipping-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                }
                if (json['error']['city']) {
                    $('#shipping-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                }	

                if (json['error']['postcode']) {
                    $('#shipping-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                }	

                if (json['error']['country']) {
                    $('#shipping-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                }	

                if (json['error']['zone']) {
                    $('#shipping-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                }
                goToByScroll('checkoutShippingAddress');
            } else {
                var checkGuestRegisterEnable="<?php echo $settings['general']['guestenable']; ?>";
                if(checkGuestRegisterEnable==1){
                    createGuestAccount();
                }
                if(shippingMethodEnable==1){
                    validateShippingMethod();
                }else{
                    if(paymentMethodEnable==1){
                        validatePaymentMethod();
                    }else{
                        var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                        if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                            validateAgree();
                        }
                        else{
                            goToConfirm();
                        }
                    }
                }
            }
        }
    });
}
function checkGuestShippingAddress(){
    var ShippingUseEnable="<?php echo $settings['option']['guest']['payment_address']['fields']['shipping']['display']; ?>"
    var paymentGuestAddressEnable="1";    
    var paymentMethodEnable="<?php echo $settings['step']['payment_method']['display_options']; ?>";
    var shippingMethodEnable="<?php echo $settings['step']['shipping_method']['display_options']; ?>";
    if(ShippingUseEnable==1)
    {
        if($('#shipping_use').is(":checked")){
            var checkGuestRegisterEnable="<?php echo $settings['general']['guestenable']; ?>";
            if(checkGuestRegisterEnable==1){
                createGuestAccount();
            }
            if(shippingMethodEnable==1){
                validateShippingMethod();
            }else{
                if(paymentMethodEnable==1){
                    validatePaymentMethod();
                }else{
                    var agreeRequire="<?php if($logged){ if($settings['option']['logged']['confirm']['fields']['agree']['require']){ echo'loginblock';} }else{ if($settings['option']['guest']['confirm']['fields']['agree']['require']){ echo'guestblock';}} ?>";               
                    if(agreeRequire=='loginblock' || agreeRequire=='guestblock'){
                        validateAgree();
                    }
                    else{
                        goToConfirm();
                    }
                }
            }
        }
        else{
            validateGuestShippingAddress();
        }
    }else{
        validateGuestShippingAddress()
    }
    
}

function validateCheckout(){
//    var loginEnable="<?php echo $settings['step']['login']['option']['login']['display']; ?>";
    var guestEnable="<?php echo $settings['step']['login']['option']['guest']['display']; ?>";
    var loggedIn="<?php echo $logged; ?>";//271
    if(guestEnable==0)
    {
        if(loggedIn==''){
            $('#checkoutLogin .checkout-content').html('<div class="warning" style="display: none;">' + 'Please Login' + '</div>');
            $('#checkoutLogin .checkout-content').show();
            $('.warning').fadeIn('slow');
            $('html, body').animate({
                scrollTop: 0
            }, 'slow'); 
        }else{
            validatePaymentAddress();
        }
    }    
//    if(loginEnable==0 && guestEnable==1)
//    {
//        if(loggedIn==''){
//            validateEmail();
//        }else{
//            validatePaymentAddress();
//        }
//    }
    else{
        var loginRadio=$("input:radio[name=account]:checked").val();
        if(loginRadio=="register"){
            if(loggedIn==''){
                $('#checkoutLogin .checkout-content').html('<div class="warning" style="display: none;">' + 'Please Login' + '</div>');
                $('#checkoutLogin .checkout-content').show();
                $('.warning').fadeIn('slow');
                $('html, body').animate({
                    scrollTop: 0
                }, 'slow');
            }            
        }
        else if(loginRadio=="guest"){
            validateEmail();
        }
        if(loggedIn){
            validatePaymentAddress();
        }
    }
//    if(loginEnable==0 && guestEnable==0)
//    {
//
//        if(loggedIn==''){
//            $('#checkoutLogin .checkout-content').html('<div class="warning" style="display: none;">' + 'Please Login' + '</div>');
//            $('#checkoutLogin .checkout-content').show();
//            $('.warning').fadeIn('slow');
//            $('html, body').animate({
//                scrollTop: 0
//            }, 'slow'); 
//        }else{
//            validatePaymentAddress();
//        }
//    }
}
//FOR REFRESSHING STEPS TO GET ORDER DETAILS
function validatePaymentAddressRefresh(){

    var paymentAddressEnable="1";
    if(paymentAddressEnable==1){
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/setValueForLoginPayment',
            type: 'post',
            dataType:'json',
            data: $('#checkoutBillingAddress input[type=\'text\'], #checkoutBillingAddress input[type=\'password\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #checkoutBillingAddress input[type=\'radio\']:checked, #checkoutBillingAddress input[type=\'hidden\'], #checkoutBillingAddress select, #checkoutBillingAddress input[type=\'checkbox\']:checked'),            
            success: function(json) {              
                    validateLoginShippingAddressRefresh();
            }
        });
    }
    else{
        validateLoginShippingAddressRefresh();
    }
}
function validateLoginShippingAddressRefresh(){
    var paymentAddressEnable="1";
    if(paymentAddressEnable==1){
        if(!$('#shipping_use').is(":checked")){    
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/setValueForLoginShipping',
                type: 'post',
                data: $('#checkoutShippingAddress input[type=\'text\'], #checkoutShippingAddress input[type=\'password\'], #checkoutShippingAddress input[type=\'checkbox\']:checked, #checkoutShippingAddress input[type=\'radio\']:checked, #checkoutShippingAddress select'),
                success: function(json) {             
                    $('.warning, .error').remove();

                    {
                        refreshAll();
                    }
                }
            });
        }else{
            refreshAll();
        }
    }
    else{
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/setValueForLoginShipping',
            type: 'post',
            data: $('#checkoutShippingAddress input[type=\'text\'], #checkoutShippingAddress input[type=\'password\'], #checkoutShippingAddress input[type=\'radio\']:checked, #checkoutShippingAddress select'),
            success: function(json) {             
                refreshAll();
            }
        });
    }
}
function validateShippingMethodRefresh(){
    $.ajax({
        url: 'index.php?route=supercheckout/shipping_method/validate', 
        type: 'post',
        data: $('#shipping-method input[type=\'radio\']:checked'),
        dataType: 'json',
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#shipping-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#shipping-method .checkout-content').show();
                    $('.warning').fadeIn('slow');
                }			
            } else {
                validatePaymentMethodRefresh();
            }
        }
    });
}
function validatePaymentMethodRefresh(){
    $.ajax({
        url: 'index.php?route=supercheckout/payment_method/validate', 
        type: 'post',
        data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea,#payment_display_block input[type=\'checkbox\']'),
        dataType: 'json',
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#payment-method .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#payment-method .checkout-content').show();
                    $('.warning').fadeIn('slow');
                }else if(json['error']['warnings']){
                    $('#payment_display_block .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warnings'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                    $('#payment_display_block .checkout-content').show();
                    $('.warning').fadeIn('slow');
                    goToByScroll('payment_display_block');
                }			
            } else {
                goToConfirmRefresh();
            }
        }
    });
}

function goToConfirmRefresh(){ 
    $.ajax({
        url: 'index.php?route=supercheckout/confirm',
        dataType: 'html',
        success: function(html) {            
            $('#confirmLoader').hide();
            $('#confirmCheckout').html(html);
            $('#paymentDisable').html("");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
    
}
function validateGuestPaymentAddressRefresh(){
    var paymentGuestAddressEnable="1";
    var useforShippingEnable="<?php echo $settings['option']['guest']['payment_address']['fields']['shipping']['display']; ?>";
    if(paymentGuestAddressEnable==1){
        if(useforShippingEnable==1){
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/setValueForGuestPayment',
                type: 'post',
                data: $('#payment-new  input[type=\'text\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #payment-new select, #checkoutLogin input[name=\'email\'] '),                			
                success: function(json) {
                    $('.warning, .errorsmall').remove();

                    {
                        checkGuestShippingAddressRefresh();
                    }
                }
            });
        }
        else{
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/setValueForGuestPayment',
                type: 'post',
                data: $('#payment-new  input[type=\'text\'],  #payment-new select'),			
                success: function(json) {
                {
                    checkGuestShippingAddressRefresh();
                }
                }
            });
        }
    }else{
        
        validateGuestShippingAddressRefresh();
    }
}
function validateGuestShippingAddressRefresh(){
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/setValueForGuestShipping',
        type: 'post',
        data: $('#shipping-new input[type=\'text\'], #shipping-new select'),
        success: function() {
            $('.warning, .errorsmall').remove();                
            refreshAll();
                
        }
    });
}
function checkGuestShippingAddressRefresh(){
    var ShippingUseEnable="<?php echo $settings['option']['guest']['payment_address']['fields']['shipping']['display']; ?>"
    var paymentGuestAddressEnable="1";    
    
    if(ShippingUseEnable==1)
    {
        if($('#shipping_use').is(":checked")){
            
            refreshAll();
        }
        else{
            validateGuestShippingAddressRefresh();
        }
    }else{
        validateGuestShippingAddressRefresh()
    }
    
}


function validateCheckoutRefresh(){ 
//    var loginEnable="<?php echo $settings['step']['login']['option']['login']['display']; ?>";
    var guestEnable="<?php echo $settings['step']['login']['option']['guest']['display']; ?>";
    var loggedIn="<?php echo $logged; ?>";//271
    if(guestEnable==0)
    {
        validatePaymentAddressRefresh();
    }    
//    if(loginEnable==0 && guestEnable==1)
//    {
//        validateGuestPaymentAddressRefresh();
//    }
    else
    {
        if(loggedIn!=""){
            validatePaymentAddressRefresh();
        }else{
            validateGuestPaymentAddressRefresh();
        }
    }
//    if(loginEnable==0 && guestEnable==0)
//    {
//            validatePaymentAddressRefresh();
//    }
}

</script>
<script type="text/javascript"><!--
    $('#checkoutShippingAddress input[name=\'shipping_address\']').live('change', function() {
        if (this.value == 'new') {
            $('#shipping-existing').hide();
            $('#shipping-new').show();
            validateCheckoutRefresh();
        } else {
            $('#shipping-existing').show();
            $('#shipping-new').hide();
            validateCheckoutRefresh();
        }
    });
</script> 
<script type="text/javascript">
// GENERAL SETTING FOR HIDING DISPLAYING NEW & EXISTING SHIPPING ADDRESS
$('#shipping-existing select[name=\'address_id\']').bind('change', function() {
        validateCheckoutRefresh();
    });
    $('#payment-existing select[name=\'address_id\']').bind('change', function() {
        validateCheckoutRefresh();
    });
    $('#shipping-new select[name=\'country_id\']').bind('change', function() {
        if (this.value == '') return;
        
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#shipping-new select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('.wait').remove();
            },			
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('#shipping-postcode-required').show();
                } else {
                    $('#shipping-postcode-required').hide();
                }

                html = '<option value=""><?php echo $text_select; ?></option>';

                if (json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';

                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }

                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }
                
                $('#shipping-new select[name=\'zone_id\']').html(html);
                validateCheckoutRefresh();
                        

            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
</script>
<script type="text/javascript">
// GENERAL SETTING FOR HIDING DISPLAYING NEW & EXISTING BILLING ADDRESS
$('#checkoutBillingAddress input[name=\'payment_address\']').live('change', function() {
    if (this.value == 'new') {
        $('#payment-existing').hide();
        $('#payment-new').show();
        validateCheckoutRefresh();
    } else {
        $('#payment-existing').show();
        $('#payment-new').hide();
        validateCheckoutRefresh();
    }
});
$('#payment-new select[name=\'zone_id\']').bind('change', function() {        
    validateCheckoutRefresh();
});
$('#shipping-new select[name=\'zone_id\']').bind('change', function() {        
    validateCheckoutRefresh();
});   
$('#payment-new select[name=\'country_id\']').bind('change', function() {
    if (this.value == '') return;
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
            $('#payment-new select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },
        complete: function() {
            $('.wait').remove();
        },			
        success: function(json) {
            if (json['postcode_required'] == '1') {
                $('#payment-postcode-required').show();
            } else {
                $('#payment-postcode-required').hide();
            }

            html = '<option value=""><?php echo $text_select; ?></option>';
            if (json['zone'] != '') {
                for (i = 0; i < json['zone'].length; i++) {
                    html += '<option value="' + json['zone'][i]['zone_id'] + '"';

                    if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                        html += ' selected="selected"';
                    }

                    html += '>' + json['zone'][i]['name'] + '</option>';
                }
            } else {
                html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
            }
            validateCheckoutRefresh();
            $('#payment-new select[name=\'zone_id\']').html(html);
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
</script> 
<script>
//ON CHECKING - UNCHECKING USE FOR SHIPPING CHECKBOX
    $(document).ready(function(){
var shipping_display="<?php  echo $settings['option']['guest']['payment_address']['fields']['shipping']['display'] ?>";
var loggedIn="<?php echo $logged; ?>";//271
if(shipping_display=="0" && loggedIn==""){
    $('#checkoutShippingAddress').slideDown('slow');
}
        $("#shipping_use").change(function(){ 
            if($(this).is(":checked"))
            {
                $('#checkoutShippingAddress').slideUp('slow');
                validateCheckoutRefresh();
            }
            else{
                $('#checkoutShippingAddress').slideDown('slow');
                validateCheckoutRefresh();
            }
        });
    });
</script>
<script>
// FOR GENERAL SETTINGS LIKE SLIDE UP AND DOWN, AND LOGIN VALIDATION
var generalDefault="<?php echo $settings['general']['default_option']; ?>";
var guestEnable="<?php echo $settings['step']['login']['option']['guest']['display']; ?>";
var current = $("input:radio[name=account]:checked").val();
if(generalDefault=='guest'&& guestEnable==1 && current=='guest'){
    $('#supercheckout-login').slideUp('fast');
}else{
    $('#supercheckout-login').slideDown('fast');
}

$("input:radio[name=account]").click(function() {
    var value = $("input:radio[name=account]:checked").val();
    if(value=='register')
    {
        $('#supercheckout-login').slideDown('fast');            
    }
    else{
        $('#supercheckout-login').slideUp('fast');
    }
});
//login
$('#button-login').live('click', function() {
    $.ajax({
        url: 'index.php?route=supercheckout/supercheckout/loginValidate',
        type: 'post',
        data: $('#checkoutLogin :input'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-login').attr('disabled', true);
            $('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
        },	
        complete: function() {
            $('#button-login').attr('disabled', false);
            $('.wait').remove();
        },				
        success: function(json) {
            $('.warning, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#columnleft-1 .checkout-content').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
                $('#columnleft-1 .checkout-content').show();
                $('.warning').fadeIn('slow');
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
});    
</script>      
<script>
// FOR ADDING COUPON AND VOUCHERS AND ALSO REDEEMING THEM
//adding coupon
function callCoupon(){
    var code=$('#coupon_code').val();
    if(code==""){
        $("#coupon_code").css({
            "background-color": "#FFD1D1"
        });
    }else{
        $("#coupon_code").css({
            "background-color": "white"
        });
        $('#confirm').html('<div id="loading" style="text-align:center;"><img src="image/data/checkoutPage/loading_large.gif" width="100" height="100"></div>');
        $('#confirmLoader').show();
        $.ajax({
            type: "POST",
            url: "index.php?route=supercheckout/supercheckout/validateCoupon",
            data: 'coupon='+code,
            
            success: function(json) {
                var obj = jQuery.parseJSON( json );

                if (obj.warning) {
                
                $.gritter.add({
                        title: 'Notification!',
                        text: obj.warning,
                //	image: '',
                        class_name:'gritter-warning',
                        sticky: false,
                        time: '2000'
                });
//                    $('#confirmCheckout .checkout-content').html("");
//                    $('#confirmCheckout .checkout-content').prepend('<div class="warning" style="display: none;">' + obj.warning + '</div>');
//                    $('.checkout-content').show();
//                    $('.warning').fadeIn('slow');
                    $('#confirmLoader').hide();
                }                                            
                else{
                        $.gritter.add({
                        title: 'Notification!',
                        text: '<?php echo $text_coupon; ?>',
                //	image: '',
                        class_name:'gritter-success',
                        sticky: false,
                        time: '2000'
                });
                           validatePaymentMethodRefresh();
                }

            }
   
        });
    }
}
//adding voucher
function callVoucher(){
    var code=$('#voucher_code').val();        
    if(code==""){
        $("#voucher_code").css({
            "background-color": "#FFD1D1"
        });
    }else{
        $("#voucher_code").css({
            "background-color": "white"
        });
        $('#confirm').html('<div id="loading" style="text-align:center;"><img src="image/data/checkoutPage/loading_large.gif" width="100" height="100"></div>');
        $('#confirmLoader').show();
        $.ajax({
            type: "POST",
            url: "index.php?route=supercheckout/supercheckout/validateVoucher",
            data: 'voucher='+code,
            success: function(json) {
                var obj = jQuery.parseJSON( json );

                if (obj.warning) {
                $.gritter.add({
                        title: 'Notification!',
                        text: obj.warning,
                //	image: '',
                        class_name:'gritter-warning',
                        sticky: false,
                        time: '2000'
                });
//                    $('#confirmCheckout .checkout-content').html("");
//                    $('#confirmCheckout .checkout-content').prepend('<div class="warning" style="display: none;">' + obj.warning + '</div>');
//                    $('.checkout-content').show();
//                    $('.warning').fadeIn('slow');
                    $('#confirmLoader').hide();
                }                                            
                else{
                    $.gritter.add({
                        title: 'Notification!',
                        text: '<?php echo $text_voucher; ?>',
                //	image: '',
                        class_name:'gritter-success',
                        sticky: false,
                        time: '2000'
                    });
                    validatePaymentMethodRefresh();
                }

            }
   
        });
    }
}
//    redeeming coupon and voucher
function redeem(id){        
    $('#confirm').html('<div id="loading" style="text-align:center;"><img src="image/data/checkoutPage/loading_large.gif" width="100" height="100"></div>');
    $('#confirmLoader').show();
    $.ajax({
        type: "POST",
        url: "index.php?route=supercheckout/supercheckout/redeem",            
        data: 'redeem='+id,
        success: function() {                
            $.ajax({
                url: 'index.php?route=supercheckout/confirm',
                dataType: 'html',
                success: function(html) {
                    $('#confirmCheckout').html(html);
//                    $('#paymentDisable').html("");
//                    $('#confirmCheckout .checkout-content').prepend('<div class="success"><?php echo $text_remove; ?></div>');
//                    $('.checkout-content').show();
                $.gritter.add({
                        title: 'Notification!',
                        text: 'Your '+id+' has been redeemed Successfully!',
                //	image: '',
                        class_name:'gritter-success',
                        sticky: false,
                        time: '2000'
                });
                    $('#confirmLoader').hide();
                    $.ajax({
                        url: 'index.php?route=supercheckout/payment_display',
                        dataType: 'html',
                        success: function(html) {
                            $('#display_payment').html(html);
//                            validatePaymentMethodRefresh();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });	

                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }

            });
        }
   
    });
}
</script>
<script>
//EDITING CART LIKE REMOVING PRODUCT AND UPDATING QUANTITY
    function removeProduct(id){
        var id=id;
        $('#confirmLoader').show();
        $.ajax({
            type: "POST",
            url: "index.php?route=supercheckout/supercheckout/cart",
            data: 'remove='+id,
            success: function(msg){
                $.ajax({
                    url: 'index.php?route=supercheckout/confirm',
                    dataType: 'html',
                    success: function(html) {
                    
                       $('#confirmCheckout').html(html);
                       $.gritter.add({
                        title: 'Notification!',
                        text: '<?php echo $text_remove; ?>',
                //	image: '',
                        class_name:'gritter-success',
                        sticky: false,
                        time: '2000'
                });
                $.ajax({
                    url: 'index.php?route=supercheckout/shipping_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#shipping-method').html(html);
                        $('#shippingMethodLoader').hide();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
//                            $('#paymentDisable').html("");
//                            $('#confirmCheckout .checkout-content').prepend('<div class="success"><?php echo $text_remove; ?></div>');
//                            $('.checkout-content').show();
                            $('#confirmLoader').hide();
                            
                            $.ajax({
                                url: 'index.php?route=supercheckout/payment_display',
                                dataType: 'html',
                                success: function(html) {
                                    $('#display_payment').html(html);
                                    validatePaymentMethodRefresh();
                                },
                            error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                            });	
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        });
    }
    function updateQuantity(id){
        var id=id;
        $('#confirmLoader').show();
        $.ajax({
            type: "POST",
            url: "index.php?route=supercheckout/supercheckout/cart&quantity",
            data: $('#confirmCheckout input[type=\'text\']'),
            success: function(msg){
                $.ajax({
                    url: 'index.php?route=supercheckout/confirm',
                    dataType: 'html',
                    success: function(html) {
                        $('#confirmCheckout').html(html);
                        $.gritter.add({
                        title: 'Notification!',
                        text: '<?php echo $text_remove; ?>',
                //	image: '',
                        class_name:'gritter-success',
                        sticky: false,
                        time: '2000'
                });
//                            $('#paymentDisable').html("");
//                            $('#confirmCheckout .checkout-content').prepend('<div class="success"><?php echo $text_remove; ?></div>');
//                            $('.checkout-content').show();
                            $('#confirmLoader').hide();
                            
                            $.ajax({
                                url: 'index.php?route=supercheckout/payment_display',
                                dataType: 'html',
                                success: function(html) {
                                    $('#display_payment').html(html);
                                    validatePaymentMethodRefresh();
                                },
                            error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                            });	
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        });
    }
</script>
<script>
// FACEBOOK LOGIN & REGISTERING SCRIPT
var facebookEnable="<?php echo $settings['step']['facebook_login']['display']; ?>";
    if('<?php echo $logged; ?>'=='' && facebookEnable==1){
        var button;
        var userInfo;
        window.fbAsyncInit = function() {
            FB.init({
                appId: '<?php echo $appId; ?>', //change the appId to your appId
                status: true, 
                cookie: true,
                xfbml: true,
                oauth: true
            });
            function updateButton(response) {
                button       =   document.getElementById('fb-auth');
                userInfo     =   document.getElementById('user-info');
                if (response.authResponse) {
                    button.onclick = function() {
                        FB.logout(function(response) {
                            logout(response);
                            showLoader(true);
                            FB.login(function(response) {
                                if (response.authResponse) {
                                    FB.api('/me', function(info) {
                                        login(response, info);
                                    });	   
                                } else {
                                    //user cancelled login or did not grant authorization
                                    showLoader(false);
                                }
                            }, {
                                scope:'email,user_birthday,user_about_me'
                            });  	
                        });
                    };
                } else {
                    //user is not connected to your app or logged out
                    button.innerHTML = '';
                    button.onclick = function() {
                        showLoader(true);
                        FB.login(function(response) {
                            if (response.authResponse) {
                                FB.api('/me', function(info) {
                                    login(response, info);
                                });	   
                            } else {
                                //user cancelled login or did not grant authorization
                                showLoader(false);
                            }
                        }, {
                            scope:'email,user_birthday,user_about_me'
                        });  	
                    }
                }
            }
                
            // run once with current status and whenever the status changes
            FB.getLoginStatus(updateButton);
            FB.Event.subscribe('auth.statusChange', updateButton);	
        };
        (function() {
            var e = document.createElement('script');
            e.async = true;
            e.src = document.location.protocol 
                + '//connect.facebook.net/en_US/all.js';
            document.getElementById('fb-root').appendChild(e);
        }());
            
            
        function login(response, info){
            if (response.authResponse) {

                showLoader(false);                
                    fqlQuery();                
            }
        }
        function logout(response){
            showLoader(false);
        }
        function fqlQuery(){
            showLoader(true);
            FB.api('/me', function(response) {
                showLoader(false);
                var query       =  FB.Data.query('select name,first_name,last_name,email, profile_url, sex, pic_small,contact_email from user where uid={0}', response.id);
                query.wait(function(rows) {
                    $.ajax({                
                        url: 'index.php?route=supercheckout/supercheckout/checkUser/&email='+rows[0].email,
                        success: function(response2) {
                            if(response2=="registered"){
                                showLoader(true);
                                $.ajax({                
                                    url: 'index.php?route=supercheckout/supercheckout/doLogin&emailLogin='+rows[0].email,
                                    success: function(response3) {
                                        window.location='index.php?route=supercheckout/'+response3
                                    },
                                    complete: function(){
                                        showLoader(false);
                                    }
                                });
                            }
                            else{
                                showLoader(true);
                                $.ajax({  

                                    url: 'index.php?route=supercheckout/supercheckout/getvalue&firstname='+rows[0].first_name+'&last_name='+rows[0].last_name+'&useremail='+rows[0].email,
                                    success: function(response4) {
                                        window.location='index.php?route=supercheckout/'+response4
                                    },
                                    complete: function(){
                                        showLoader(false);
                                    }
                                });
                            }
                        }
                    });

                });
            });
        }
        function showLoader(status){
            if (status){
                $('#loading-image').show();
            }                    
            else
                $('#loading-image').hide();
        }
            
    }
</script>
<script>
// FOR REFRESHING ALL AT ONCE i.e. PAYMENT METHOD, SHIPPING METHOD, CART AND PAYMENT GATEWAY
function refreshAll(){
    $('#shippingMethodLoader').show();
    $.ajax({
        url: 'index.php?route=supercheckout/shipping_method',
        dataType: 'html',
        success: function(html) {
            $('#shipping-method').html(html);
            $('#shippingMethodLoader').hide();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
    $('#paymentMethodLoader').show();
    $.ajax({
        url: 'index.php?route=supercheckout/payment_method',
        dataType: 'html',
        success: function(html) {
            $('#payment-method').html(html);
            $('#paymentMethodLoader').hide();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
    $('#confirmLoader').show();
    $.ajax({
        url: 'index.php?route=supercheckout/confirm',
        dataType: 'html',
        success: function(html) {            
            $('#confirmLoader').hide();
            $('#confirmCheckout').html(html);
            $('#paymentDisable').html("");
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
    $.ajax({
        url: 'index.php?route=supercheckout/payment_display',
        dataType: 'html',
        success: function(html) {
                                            
            $('#display_payment').html(html);
//            validatePaymentMethodRefresh();
                   
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });	
        
}
</script>

<script>

//FOR REFRESHING CART AND PAYMENT GATEWAY IF CHANGE IS MADE IN CART ON BILLING ADDRESS
    $('#checkoutBillingAddress #payment-new input[type=\'text\']').blur(function () {
        cartPaymentRefresh();
    });
    function cartPaymentRefresh(){
//    var loginEnable="<?php echo $settings['step']['login']['option']['login']['display']; ?>";
    var guestEnable="<?php echo $settings['step']['login']['option']['guest']['display']; ?>";
    var loggedIn="<?php echo $logged; ?>";//271
    
    if(guestEnable==1)
    {    
        if(loggedIn!=""){
            LoginPaymentAddressRefresh();
        }else{
            GuestPaymentAddressRefresh();
        }
    }        
    else
    {    
        if(loggedIn!=""){
            LoginPaymentAddressRefresh();
        }else{
            $('#checkoutLogin .checkout-content').html('<div class="warning" style="display: none;">' + 'Please Login' + '</div>');
            $('#checkoutLogin .checkout-content').show();
            $('.warning').fadeIn('slow');
            $('html, body').animate({
                scrollTop: 0
            }, 'slow');
        }
    }
}
function LoginPaymentAddressRefresh(){
    var paymentAddressEnable="1";
    if(paymentAddressEnable==1){
        $.ajax({
            url: 'index.php?route=supercheckout/supercheckout/setValueForLoginPayment',
            type: 'post',
            dataType:'json',
            data: $('#checkoutBillingAddress input[type=\'text\'], #checkoutBillingAddress input[type=\'password\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #checkoutBillingAddress input[type=\'radio\']:checked, #checkoutBillingAddress input[type=\'hidden\'], #checkoutBillingAddress select, #checkoutBillingAddress input[type=\'checkbox\']:checked'),            
            beforeSend: function() {
                $('#button-payment-address').attr('disabled', true);
                $('#button-payment-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },	
            complete: function() {
                $('#button-payment-address').attr('disabled', false);
                $('.wait').remove();
            },			
            success: function(json) {
                $('.warning, .errorsmall').remove();
                if (json['error']){
                    if (json['error']['firstname']) {
                        $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                    }

                    if (json['error']['lastname']) {
                        $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                    }	

                    if (json['error']['email']) {
                        $('#payment-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                    }

                    if (json['error']['telephone']) {
                        $('#payment-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                    }	
                    if (json['error']['company']) {
                        $('#payment-new input[name=\'company\']').after('<span class="errorsmall">' + json['error']['company'] + '</span>');
                    }
                    if (json['error']['company_id']) {
                        $('#payment-new input[name=\'company_id\']').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                    }	

                    if (json['error']['tax_id']) {
                        $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                    }	

                    if (json['error']['address_1']) {
                        $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                    }	
                    if (json['error']['address_2']) {
                        $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                    }
                    if (json['error']['city']) {
                        $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                    }	

                    if (json['error']['postcode']) {
                        $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                    }	

                    if (json['error']['country']) {
                        $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                    }	

                    if (json['error']['zone']) {
                        $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                    }
                }else{
                    RefreshCart();
                }
            }
        });
    }
    else{
        RefreshCart();
    }
    
}
function GuestPaymentAddressRefresh(){
    var paymentGuestAddressEnable="1";
    var useforShippingEnable="<?php echo $settings['option']['guest']['payment_address']['fields']['shipping']['display']; ?>";
    if(paymentGuestAddressEnable==1){
        if(useforShippingEnable==1){
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/setValueForGuestPayment',
                type: 'post',
                dataType:'json',
                data: $('#payment-new  input[type=\'text\'], #checkoutBillingAddress input[type=\'checkbox\']:checked, #payment-new select, #checkoutLogin input[name=\'email\'] '),                
                beforeSend: function() {
                    $('#button-guest').attr('disabled', true);
                    $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },	
                complete: function() {
                    $('#button-guest').attr('disabled', false); 
                    $('.wait').remove();
                },			
                success: function(json) {
                    
                    $('.warning, .errorsmall').remove();
                if (json['error']){
                    if (json['error']['firstname']) {
                        $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                    }

                    if (json['error']['lastname']) {
                        $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                    }	

                    if (json['error']['email']) {
                        $('#payment-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                    }

                    if (json['error']['telephone']) {
                        $('#payment-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                    }	
                    if (json['error']['company']) {
                        $('#payment-new input[name=\'company\']').after('<span class="errorsmall">' + json['error']['company'] + '</span>');
                    }
                    if (json['error']['company_id']) {
                        $('#payment-new input[name=\'company_id\']').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                    }	

                    if (json['error']['tax_id']) {
                        $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                    }	

                    if (json['error']['address_1']) {
                        $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                    }	
                    if (json['error']['address_2']) {
                        $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                    }
                    if (json['error']['city']) {
                        $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                    }	

                    if (json['error']['postcode']) {
                        $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                    }	

                    if (json['error']['country']) {
                        $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                    }	

                    if (json['error']['zone']) {
                        $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                    }
                    }else{
                    
                        RefreshCart();
                    }
                }
            });
        }
        else{
            $.ajax({
                url: 'index.php?route=supercheckout/supercheckout/setValueForGuestPayment',
                type: 'post',
                dataType:'json',
                data: $('#payment-new  input[type=\'text\'],  #payment-new select'),                
                beforeSend: function() {
                    $('#button-guest').attr('disabled', true);
                    $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },	
                complete: function() {
                    $('#button-guest').attr('disabled', false); 
                    $('.wait').remove();
                },			
                success: function(json) {
                $('.warning, .errorsmall').remove();
                if (json['error']){
                    if (json['error']['firstname']) {
                        $('#payment-new input[name=\'firstname\']').after('<span class="errorsmall">' + json['error']['firstname'] + '</span>');
                    }

                    if (json['error']['lastname']) {
                        $('#payment-new input[name=\'lastname\']').after('<span class="errorsmall">' + json['error']['lastname'] + '</span>');
                    }	

                    if (json['error']['email']) {
                        $('#payment-new input[name=\'email\']').after('<span class="errorsmall">' + json['error']['email'] + '</span>');
                    }

                    if (json['error']['telephone']) {
                        $('#payment-new input[name=\'telephone\']').after('<span class="errorsmall">' + json['error']['telephone'] + '</span>');
                    }	
                    if (json['error']['company']) {
                        $('#payment-new input[name=\'company\']').after('<span class="errorsmall">' + json['error']['company'] + '</span>');
                    }
                    if (json['error']['company_id']) {
                        $('#payment-new input[name=\'company_id\']').after('<span class="errorsmall">' + json['error']['company_id'] + '</span>');
                    }	

                    if (json['error']['tax_id']) {
                        $('#payment-new input[name=\'tax_id\']').after('<span class="errorsmall">' + json['error']['tax_id'] + '</span>');
                    }	

                    if (json['error']['address_1']) {
                        $('#payment-new input[name=\'address_1\']').after('<span class="errorsmall">' + json['error']['address_1'] + '</span>');
                    }	
                    if (json['error']['address_2']) {
                        $('#payment-new input[name=\'address_2\']').after('<span class="errorsmall">' + json['error']['address_2'] + '</span>');
                    }
                    if (json['error']['city']) {
                        $('#payment-new input[name=\'city\']').after('<span class="errorsmall">' + json['error']['city'] + '</span>');
                    }	

                    if (json['error']['postcode']) {
                        $('#payment-new input[name=\'postcode\']').after('<span class="errorsmall">' + json['error']['postcode'] + '</span>');
                    }	

                    if (json['error']['country']) {
                        $('#payment-new select[name=\'country_id\']').after('<span class="errorsmall">' + json['error']['country'] + '</span>');
                    }	

                    if (json['error']['zone']) {
                        $('#payment-new select[name=\'zone_id\']').after('<span class="errorsmall">' + json['error']['zone'] + '</span>');
                    }
                    }else{
                    
                        RefreshCart();
                    }
                }
            });
        }
    }else{

        RefreshCart();
    }
}
function RefreshCart(){
    $.ajax({
        url: 'index.php?route=supercheckout/confirm',
        dataType: 'html',
        success: function(html) {
            $('#confirmCheckout').html(html);
//            $('#paymentDisable').html("");
//            $('#confirmCheckout .checkout-content').prepend('<div class="success"><?php echo $text_remove; ?></div>');
//            $('.checkout-content').show();
            $('#confirmLoader').hide();
                            
            $.ajax({
                url: 'index.php?route=supercheckout/payment_display',
                dataType: 'html',
                success: function(html) {
                    $('#display_payment').html(html);                                    
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });	
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}
</script>


<script>
// FOR SUBMITTING ON PRESSING ENTER LIKE LOGIN, COUPON, VOUCHER
$('#email').keypress(function(event){
    var loginCheck= $("input:radio[name=account]:checked").val();
    if(event.keyCode == 13 && loginCheck=='register'){
        $('#button-login').click();
    }
});
$('#password').keypress(function(event){
    var loginCheck= $("input:radio[name=account]:checked").val();
    if(event.keyCode == 13 && loginCheck=='register'){
        $('#button-login').click();
    }
});
$('#coupon_code').keypress(function(event){
    if(event.keyCode == 13){
        $('#button-coupon').click();
    }
});
$('#voucher_code').keypress(function(event){
    if(event.keyCode == 13){
        $('#button-voucher').click();
    }
});
</script>
<script>
<?php if($settings['general']['layout']=='3-Column'){ ?>
// FOR SORTING BLOCK AND FIELDS IN SUPERCHECKOUT PAGE
$(document).ready(function(){
    //payment address sorting
    $('#button-confirm').unbind('click');
    $('.columnleftsort > .supercheckout-blocks').tsort({
        attr:'data-row'
    });
    $('.columnleftsort > .supercheckout-blocks').each(function(){
        $(this).appendTo('#columnleft-' + $(this).attr('data-column'));

    });
    
    var $wrapper = $('#payment_address_table');
    $wrapper.find('.sort_data').sort(function (a, b) {
        return +$(a).data("percentage") - + $(b).data("percentage");
    })
    .appendTo( $wrapper );

    //shippping address sorting
    var $wrapper = $('#shipping_address_table');
    $wrapper.find('.sort_data').sort(function (a, b) {
        return +$(a).data("percentage") - + $(b).data("percentage");
    })
    .appendTo( $wrapper );
    //block sorting
//    $('#button-confirm').unbind('click');
    $('.columnleftsort > .supercheckout-blocks').tsort({
        attr:'data-row'
    });
    $('.columnleftsort > .supercheckout-blocks').each(function(){
        $(this).appendTo('#columnleft-' + $(this).attr('data-column'));

    });
    
    
});
<?php }elseif($settings['general']['layout']=='2-Column'){ ?>
$('.columnleftsort > .supercheckout-blocks').tsort({attr:'col-inside-data'});
    $('.columnleftsort > .supercheckout-blocks').each(function(){
//    alert('hi1');
    if($(this).attr('data-column-inside')=="4"){    
        $(this).appendTo('#column-2-lower' );
    }
    else if($(this).attr('data-column-inside')=="3"){    
        $(this).appendTo('#column-1-inside' );
    }else if($(this).attr('data-column-inside')=="2"){
        $(this).appendTo('#column-2-upper');
    }else{
        $(this).appendTo('#columnleft-1');
    }
        
    })
    $('#columnleft-1 > .supercheckout-blocks').tsort({attr:'data-row'});
    $('#columnleft-1 > .supercheckout-blocks').each(function(){
    
        $(this).appendTo('#columnleft-' + $(this).attr('data-column') );    
        
    })
    $('#column-2-upper > .supercheckout-blocks').tsort({attr:'data-row'});
    $('#column-2-upper > .supercheckout-blocks').each(function(){
//    alert('hi');
        $(this).appendTo('#column-2-upper' );    
        
    })
    $('#column-2-lower > .supercheckout-blocks').tsort({attr:'data-row'});
    $('#column-2-lower > .supercheckout-blocks').each(function(){
//    alert('hi');
        $(this).appendTo('#column-2-lower' );    
        
    })
    $('#column-1-inside > .supercheckout-blocks').tsort({attr:'data-row'});
    $('#column-1-inside > .supercheckout-blocks').each(function(){
//    alert('hi');
        $(this).appendTo('#column-' + $(this).attr('data-column')+'-inside' );    
        
    })
// FOR SORTING BLOCK AND FIELDS IN SUPERCHECKOUT PAGE
//$(document).ready(function(){
//    //payment address sorting
//    $('#button-confirm').unbind('click');
//    $('.columnleftsort > .supercheckout-blocks').tsort({
//        attr:'data-row'
//    });
//    $('.columnleftsort > .supercheckout-blocks').each(function(){
//        $(this).appendTo('#columnleft-' + $(this).attr('data-column'));
//
//    });
//    
    var $wrapper = $('#payment_address_table');
    $wrapper.find('.sort_data').sort(function (a, b) {
        return +$(a).data("percentage") - + $(b).data("percentage");
    })
    .appendTo( $wrapper );

    //shippping address sorting
    var $wrapper = $('#shipping_address_table');
    $wrapper.find('.sort_data').sort(function (a, b) {
        return +$(a).data("percentage") - + $(b).data("percentage");
    })
    .appendTo( $wrapper );
//    //block sorting
////    $('#button-confirm').unbind('click');
//    $('.columnleftsort > .supercheckout-blocks').tsort({
//        attr:'data-row'
//    });
//    $('.columnleftsort > .supercheckout-blocks').each(function(){
//        $(this).appendTo('#columnleft-' + $(this).attr('data-column'));
//
//    });
//    
//    
//});


<?php }elseif($settings['general']['layout']=='1-Column'){ ?>
$('#columnleft-1 > .supercheckout-blocks').tsort({attr:'data-row'});
    $('#columnleft-1 > .supercheckout-blocks').each(function(){
    
        $(this).appendTo('#columnleft-1' );    
        
    })
<?php } ?>
</script>
<script>
var a= $('#supercheckout-columnleft').height();
var b= $('#column-1-inside').height();
var c= $('#column-2-inside').height();
$('#columnleft-1').css('min-height', a+'px');
$('#columnleft-3').css('min-height', a+'px');
if(c>b){
    $('#column-1-inside').css('min-height', c+'px');
}else{
    $('#column-2-inside').css('min-height', b+'px');
}
//$('#columnleft-1').height(a);
</script>
