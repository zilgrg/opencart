[33mcommit 06ce3ae39896191d6c0460c67d06a7b19f60c08a[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 19:41:01 2014 +0200

    Remove Wishlist and Compare
    
    This can be done via Journal template setting, but when turned off it
    also removes minimum purchase notification "Minimalus užsakomas kiekis 3
    vnt., kas atitinka vieną pakuotę. Didesni kiekiai užsakomi minimalų
    kiekį dauginant iš reikalingų pakuočių skaičiaus. Pvz. jei min. kiekis 5
    vnt. užsakoma arba 5, arba 10, arba 15 ir t.t. vnt."
    
    PROBABLY A BUG IN JOURNAL TEMPLATE
    
    if that bug is fixed in template this vqmod module is not needed
    
    It doesn't disable URLs to compare and wishlist whcih are
    route=product/compare and route=account/wishlist
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=11879

[33mcommit cd62a38ab7d4ef681192fce0866cddc016598afd[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 16:49:18 2014 +0200

    Product Display Setting update to display link to updated product
    
    Bandymas daryti linka i atnaujinta preke, pavyko

[33mcommit e8c0bf5c542af4380de768dbf2b491a3045c840b[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 16:29:04 2014 +0200

    Revert "Paieskos rezulttatuose idetas prekes kodas (model) ir produkto atvaizdavime bandyta ideti link'a i superseedinta koda"
    
    This reverts commit babfc4e4f13cdc59aea1f750e2f5c6e045685c8b.

[33mcommit d83d9ee1df08c1a58f8d0c28f7afdf2d2cba4bed[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 15:51:36 2014 +0200

    Product Display Settings vqmod
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=5169
    
    this vqmod allowes you to set from admin if you want to display in
    product listing(category page, manufacturer page, search , specials)
    and/or product page the following:
    -model;
    -manufacturer;
    -sku;
    -upc;
    -stock/stock status depending on how you set to display;
    -location;
    
    ADDED lithuanian language file by  ZG

[33mcommit bae9dc34bfe1ee6e497d06aed469079de07d8293[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 14:35:21 2014 +0200

    Ismesta (removed) removerewardlink vqmod
    
    Ismesta (removed) removerewardlink vqmod, because it is possible to
    disable reward points using config:
    Extensions -> Order totals -> Reward Points -> Disable

[33mcommit 3d7b25ece9ee26fda1ed29a70935cefe84b5eaf8[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 14:20:46 2014 +0200

    Free Shipping Alert Qualifier on Cart page and Checkout page - NOT COMPLIETED
    
    Free Shipping Alert Qualifier on Cart page and Checkout page
    based on
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=11265
    
    reikia ideti lietuviu kalba, gal pamodifikuoti kalbos failus tiesiogiai

[33mcommit 54df056f6e0554c8f66307b8f5de43dcd6b37348[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 00:34:15 2014 +0200

    Quick Checkout - Efficient One Page Checkout Solution
    
    Quick Checkout - Efficient One Page Checkout Solution
    
    https://www.opencart.com/index.php?route=account/download/info&order_id=412852
    
    PIRKTA 2014-01-10 uz 17.5 USD

[33mcommit a7c20acbc7d35b771afb92088d60e4b027209bd8[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 00:18:16 2014 +0200

    CSV Product Import update from 3.5.0 to 3.5.1  - second attempt
    
    CSV Product Import update from 3.5.0 to 3.5.1  - second attempt, not all
    files were commited with first commit
    
    https://www.opencart.com/index.php?route=account/download/info&order_id=406445

[33mcommit 529bd490fad31991295b10ad99be7b412289a485[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Sat Jan 11 00:16:39 2014 +0200

    CSV Product Import update fromn 3.5.0 to 3.5.1
    
    CSV Product Import update fromn 3.5.0 to 3.5.1
    
    https://www.opencart.com/index.php?route=account/download/info&order_id=406445

[33mcommit 0503c653173e5acacb7becbf25910245fb54c458[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 22:51:50 2014 +0200

    Flat or Free Shipment
    
    Flat or Free Shipment is a great replacement for your flat rate
    shipment.
    Now you can set up minimum order for free shipment within flat rate
    shipment module.
    
    If You already use separate flat rate and free shipment module then this
    module will solve your problem with flat rate and free shipment options
    displaying both at once at the checkout.
    
    ZG: ADDED lithuanian language
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=10867

[33mcommit b9a7188ee080dc010985606621ede76e897d3ca9[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 22:10:05 2014 +0200

    post24 lithuanian language file
    
    added  post24 lithuaniina language file

[33mcommit 82583b496a7a3d124ee47e16cbd69bdfe4807a27[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 22:04:54 2014 +0200

    post24 shipping budas (nemokamas) instaliuotas
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=14742&filter_search=shipping&filter_license=0&filter_download_id=32&page=1
    
    https://www.post24.lt/
    
    parsisiunciau LT_Pastomatu_sarasas.csv is
    https://www.post24.lt/Pastomatu_vietu_sarasas
    
    YRA MOKAMA VERSIJA is oficialaus post24 puslapio
    
    http://en.e-abi.ee/post24-lithuania-shipping-extension-for-opencart.html

[33mcommit cc73a2d3e00fce5d1daabd333eed67ae86cf34e0[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 17:28:42 2014 +0200

    Allow giftvoucher and specislds URL
    
    Instead of disabling all URL's from EXTRA column, following changes
    made:
    
    DISABLED
    http://yama.lt/index.php?route=product/manufacturer
    http://yama.lt/index.php?route=affiliate/login
    
    ALLOWED
    http://yama.lt/index.php?route=account/voucher
    http://yama.lt/index.php?route=product/special

[33mcommit c1a9b64186558b30afe1eafedc21042e7790c09e[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 17:25:16 2014 +0200

    Remove EXTRA column in footer disable URL access for affiliate, specials, giftvoucher, manufacturer
    
    Remove EXTRA column in footer disable URL access for affiliate,
    specials, giftvoucher, manufacturer
    
    http://www.opencart.com/index.php?route=extension/extension&filter_username=rockambole

[33mcommit 6844567a7590d3b8493bf4b14d0cea82f83444c6[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Fri Jan 10 11:30:56 2014 +0200

    remove: Recurring, reward, affiliate links
    
    vQmod to remove the Recurring payments links from the My Account page
    (does not remove the page or funciotonality, only the links to it)
    
    www.opencart.com/index.php?route=extension/extension/info&extension_id=13726
    
    removes the reward link in the accounts area by commenting out the
    reward link. It does not disable the reward functionality of Opencart.
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=10706
    
    This <VQMod> removes the 'Affiliate' link from your OpenCart footer
    and
    disables direct access by URL to the page. Get support by emailing:
    support@inmuto.co.uk
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=11080

[33mcommit 5262013fdbd89bf33238877b4b6a8fcf8abaa6d4[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Thu Jan 9 20:33:54 2014 +0200

    hides the Affiliate link from the page footer and also disables access to the affiliate page through typing its URL into the address bar
    
    Extension Name Hide Affiliate Rating 12345
    
    License Free Votes 10
    Developer iNmuto Views 3081
    Date Added 22 March 2013 Downloads 1145
    Date Modified 18 September 2013
    
    http://www.opencart.com/index.php?route=extension/extension/info&extension_id=11080
    
    You can also confirm that the direct url to the affiliate page come up
    as 'Page Not Found':-
    
    http://<yoursite>/index.php?route=affiliate/account

[33mcommit 170672272d9e85078ebecc11bf090c02cfc40754[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Wed Jan 8 00:46:05 2014 +0200

    removed play reference from upload/index.php and  from upload/admin/index.php ZG

[33mcommit db8d9296a8eb456b1885d35420bdbbe94c509984[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:44:37 2014 +0200

    webtopay folder recopied after delete from server to local git ZG
    
    webtopay folder recopied after delete from server to local git ZG

[33mcommit 577e5a1fbdb75ff0e7eeae582066c5edfe4d5c5f[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:41:32 2014 +0200

    webtopay folder deleted from local git ZG
    
    webtopay folder deleted from local git ZG

[33mcommit 59b91ce6f1152747f06b3f35758b4b390cf3a1a2[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:38:51 2014 +0200

    webtopay folders copied from server to local git 3rd attempt to commit

[33mcommit 6ef82f43273c8493bb4c561b83cd91b8533f15e8[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:31:26 2014 +0200

    webtopay folder copied from server to local git ZG

[33mcommit c914eba33b72075e0641ee946701c2189a9cdf72[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:29:36 2014 +0200

    Webtopay copy from server  to local git ZG

[33mcommit 4b24e3a230add5da75b74079fac22877b2ce85b3[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:11:03 2014 +0200

    gitignore modification to include vqmod/vqcache/index.html and vqmod/logs/index.html

[33mcommit a75f054a1dba0cb5784c47295902fe18b36ba703[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 23:07:21 2014 +0200

    Gitignore file modification to include vqmod folder vqcache and logs
    
    added blank index.html file to vqmod/logs and vqmod/vqcache

[33mcommit 9f872184e81a26a5d294964183f8672a7c1a7cdf[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 22:51:35 2014 +0200

    Install folder added by ZG
    
    Install folder added by ZG from opencart 1561 download

[33mcommit 72f06a69d0e6f6be8045982975e40e0b323535bc[m
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 21:44:11 2014 +0200

    2014-01-07 merge conflict fix
    
    2014-01-07 merge conflict fix

[33mcommit 144e06432f17151a3946943b142c7631c0f6cd50[m
Merge: babfc4e 3f5db74
Author: zilgrg <zilgrg@gmail.com>
Date:   Tue Jan 7 21:24:44 2014 +0200

    2013-01-07 opencart/v1.5.6.1 merge into zgv1.5.6.1
    
    2013-01-07 opencart/v1.5.6.1 merge into
    zgv1.5.6.1C:\Users\ZG\Documents\GitHub\opencart [zgv1.5.6.1]>
    C:\Users\ZG\Documents\GitHub\opencart [zgv1.5.6.1]> git remote -v
    origin  https://github.com/zilgrg/opencart.git (fetch)
    origin  https://github.com/zilgrg/opencart.git (push)
    upstream        https://github.com/opencart/opencart.git (fetch)
    upstream        https://github.com/opencart/opencart.git (push)
    C:\Users\ZG\Documents\GitHub\opencart [zgv1.5.6.1]> git pull upstream
    v1.5.6.1
    From https://github.com/opencart/opencart
    * branch            v1.5.6.1   -> FETCH_HEAD
    warning: LF will be replaced by CRLF in
    upload/admin/controller/common/ka_top.ph
    p.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/controller/tool/ka_import.p
    hp.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/language/english/feed/ka_im
    port.php.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/language/english/tool/ka_im
    port.php.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/model/tool/ka_import.php.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/view/template/tool/ka_impor
    t.tpl.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/admin/view/template/tool/ka_selec
    tor.tpl.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in upload/system/library/ka_db.php.
    The file will have its original line endings in your working directory.
    warning: LF will be replaced by CRLF in
    upload/system/library/ka_urlify.php.
    The file will have its original line endings in your working directory.
    Performing inexact rename detection: 100% (172847/172847), done.
    CONFLICT (modify/delete): upload/install/opencart.sql deleted in HEAD
    and modifi
    ed in 3f5db747dba935d9f570117dd00cdfba1bcccfbd. Version
    3f5db747dba935d9f570117d
    d00cdfba1bcccfbd of upload/install/opencart.sql left in tree.
    CONFLICT (modify/delete): upload/install/model/upgrade.php deleted in
    HEAD and m
    odified in 3f5db747dba935d9f570117dd00cdfba1bcccfbd. Version
    3f5db747dba935d9f57
    0117dd00cdfba1bcccfbd of upload/install/model/upgrade.php left in tree.
    Auto-merging upload/index.php
    CONFLICT (content): Merge conflict in upload/index.php
    Removing
    upload/catalog/view/theme/default/template/mail/ebay_stockreport.tpl
    Removing upload/catalog/model/play/product.php
    Removing upload/catalog/model/play/order.php
    Removing upload/catalog/model/play/customer.php
    Removing upload/catalog/language/english/ebay/stock_report.php
    Removing upload/catalog/controller/play/product.php
    Removing upload/catalog/controller/play/order.php
    Removing upload/admin/view/template/openbay/play_settings.tpl
    Removing upload/admin/view/template/openbay/play_report_price.tpl
    Removing upload/admin/view/template/openbay/play_main.tpl
    Removing upload/admin/view/template/openbay/play_listing.tpl
    Removing upload/admin/view/template/openbay/play_ajax_shippinginfo.tpl
    Removing upload/admin/view/template/openbay/play_ajax_refundinfo.tpl
    Removing upload/admin/view/template/openbay/ebay_stock_report.tpl
    Removing upload/admin/view/image/openbay/play_pending.png
    Removing upload/admin/view/image/openbay/play_ok.png
    Removing upload/admin/view/image/openbay/play_nolink.png
    Removing upload/admin/view/image/openbay/play_error.png
    Removing upload/admin/model/openbay/play_product.php
    Removing upload/admin/model/openbay/play_patch.php
    Removing upload/admin/model/openbay/play.php
    Removing upload/admin/language/english/openbay/play_settings.php
    Removing upload/admin/language/english/openbay/play_reportprice.php
    Removing upload/admin/language/english/openbay/play_product.php
    Removing upload/admin/language/english/openbay/play_main.php
    Removing upload/admin/language/english/openbay/play.php
    Removing upload/admin/language/english/openbay/ebay_reportstock.php
    Auto-merging upload/admin/index.php
    Removing upload/admin/controller/openbay/play.php
    Automatic merge failed; fix conflicts and then commit the result.
    C:\Users\ZG\Documents\GitHub\opencart [zgv1.5.6.1 +1 ~55 -30 !1 | +0 ~0
    -0 !3]>

[33mcommit 3f5db747dba935d9f570117dd00cdfba1bcccfbd[m
Author: James Allsup <james@allsup.eu>
Date:   Tue Jan 7 08:46:41 2014 +0000

    Added minor final patches to 1.5.6.1 branch.
    
    Changed array to assoc for MySQLi driver
    
    Renamed comment in upgrade script SQL file
    
    Added slashes function in JS html code function to allow for comma

[33mcommit 82fe479bf2d9bf5dd0dba0b835042002a63c52f7[m
Author: James Allsup <admin@ecommercehq.co.uk>
Date:   Fri Jan 3 13:07:25 2014 +0000

    Found issue where config setting is not set (doesnt exist) causing the incorrect layout ID for the product page. Also removed variables for info and category default but they were not affected Fixes #1117

[33mcommit 5a14a1e02987b772fb4451fea71d7b11c54ba223[m
Merge: 1fe99e7 3f3cf90
Author: James Allsup <james@allsup.eu>
Date:   Thu Jan 2 06:22:28 2014 -0800

    Merge pull request #1114 from openbaypro/v1.5.6
    
    V1.5.6.1 merge with latest OpenBay Pro version 2153
