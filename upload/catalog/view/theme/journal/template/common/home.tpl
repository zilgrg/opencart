<?php echo $header; ? >
<?php echo $column_left; ?>
<?php echo $column_right; ?>

<div id="content" class="home">
<script>
$(document).ready(function(){
    $('header').addClass('home-header');
});
</script>
<?php if(isset($this->document->journal_welcome_text) && $this->document->journal_welcome_text === 'center'):?>
<style>
#content .welcome, #content .welcome + p {
  text-align: center;
}

</style>
<?php unset($this->document->journal_welcome_text); endif; ?>

<?php if(isset($this->document->journal_welcome_text) && $this->document->journal_welcome_text === 'right'):?>
<style>
#content .welcome, #content .welcome + p {
  text-align: right;
}
</style>
<?php unset($this->document->journal_welcome_text); endif; ?>

<?php if (isset($this->document->journal_extended_filter) && $this->document->journal_extended_filter === 'yes'): ?>

<style>

#container{
  background-color: transparent;
}

#content{
  padding: 0;
}

.home-container .side-shade,
.home-container .side-shade2{
  top: 0;
} 
.home-container #column-right,
.home-container #column-left{
  position: relative;
  top: 0;
}

.home-container #content .welcome{
  margin-top: 15px;
}

.home-container .product-grid > div, 
.home-container #content .box-product > div{
  width: 230px;
  margin-right: 17px;
}

.home-container .journal-filter .product-grid > div {
  margin-right: 20px;
}

.home-container #column-right + #content .product-grid > div, 
.home-container #column-right + #content .box-product > div,
.home-container #column-left + #content .product-grid > div, 
.home-container #column-left + #content .box-product > div{
  width: 240px;
  margin-right: 17px;
}

.home-container #column-right + #content .journal-filter .product-grid > div,
.home-container #column-left + #content .journal-filter .product-grid > div{
  width: 239px;
  margin-right: 21px;
}

.home-container #column-left + #content .product-grid,
.home-container #column-left + #content .box-product{
  margin-left: 20px;
}

.home-container #column-left + #content .journal-boxes{
  margin-left: 20px;
}



/*Photo Gallery*/

.journal-gallery a img{
   max-width: 150px;
}

@media only screen and (max-width: 980px) {
    .journal-gallery a img{
        max-width: 141px;
    } 
}

@media only screen and (max-width: 760px) {
    .journal-gallery a img{
        max-width: 149px;
    } 
}

@media only screen and (max-width: 470px) {
    .journal-gallery a img{
        max-width: 152px;
    } 
}

/*Side + Center*/

#column-left + #content .journal-gallery .box-content{
   padding-left: 20px;
}

#column-left + #content .journal-gallery a img,
#column-right + #content .journal-gallery a img{
   max-width: 139px;
}


@media only screen and (max-width: 980px) {
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 125px;
    } 
}
@media only screen and (max-width: 760px) {
  #column-left + #content .journal-gallery .box-content{
   padding-left: 0;
}
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 149px;
    } 
}

@media only screen and (max-width: 470px) {
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 152px;
    } 
}

<?php if (isset($this->document->journal_wide_layout) && $this->document->journal_wide_layout === 'yes'): ?>

/*Photo Gallery*/

.journal-gallery a img{
   max-width: 156px;
}

@media only screen and (max-width: 1220px) {
    .journal-gallery a img{
        max-width: 150px;
    } 
}

@media only screen and (max-width: 980px) {
    .journal-gallery a img{
        max-width: 142px;
    } 
}

@media only screen and (max-width: 760px) {
    .journal-gallery a img{
        max-width: 149px;
    } 
}

@media only screen and (max-width: 470px) {
    .journal-gallery a img{
        max-width: 152px;
    } 
}

/*Side + Center*/

#column-left + #content .journal-gallery .box-content{
   padding-left: 20px;
}

#column-left + #content .journal-gallery a img,
#column-right + #content .journal-gallery a img{
   max-width: 149px;
}

@media only screen and (max-width: 1220px) {
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 139px;
    } 
}
@media only screen and (max-width: 980px) {
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 125px;
    } 
}
@media only screen and (max-width: 760px) {
  #column-left + #content .journal-gallery .box-content{
   padding-left: 0;
}
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 149px;
    } 
}

@media only screen and (max-width: 470px) {
    #column-left + #content .journal-gallery a img,
    #column-right + #content .journal-gallery a img{
        max-width: 152px;
    } 
}



.home-container .product-grid > div, 
.home-container #content .box-product > div{
  width: 227px;
  margin-right: 17px;
}

.home-container .journal-filter .product-grid > div {
  margin-right: 21px;
}

.home-container #column-right + #content .product-grid > div, 
.home-container #column-right + #content .box-product > div,
.home-container #column-left + #content .product-grid > div, 
.home-container #column-left + #content .box-product > div{
  width: 234px;
  margin-right: 17px;
}
.home-container #column-right + #content .journal-filter .product-grid > div,
.home-container #column-left + #content .journal-filter .product-grid > div{
  width: 234px;
  margin-right: 21px;
}
<?php endif;?>


<?php if ($this->document->journal_responsive_design === 'yes'): ?>

@media only screen and (max-width: 1220px){
  .home .journal-filter .product-grid > div,
  .home-container #content .box-product > div{
    width: 230px;
    margin-right: 20px;
  }

  .home-container #content .box-product > div{
    margin-right: 17px;
  }

  .home-container #column-right + #content .product-grid > div, 
  .home-container #column-right + #content .box-product > div,
  .home-container #column-left + #content .product-grid > div, 
  .home-container #column-left + #content .box-product > div{
    width: 239px;
  }
  .home-container #column-right + #content .journal-filter .product-grid > div,
  .home-container #column-left + #content .journal-filter .product-grid > div{
    width: 239px;
  }
}

@media only screen and (max-width: 980px){

.home-container .journal-filter .product-grid > div, 
.home-container #content .box-product > div{
      width: 243px;
  }
.home-container #column-right + #content .product-grid > div, 
.home-container #column-right + #content .box-product > div,
.home-container #column-left + #content .product-grid > div, 
.home-container #column-left + #content .box-product > div{
    width: 263px;
  }
.home-container #column-right + #content .journal-filter .product-grid > div,
.home-container #column-left + #content .journal-filter .product-grid > div{
    width: 263px;
  }
.home-container #column-left + #content .journal-filter ul,
.home-container #column-left + #content .box .box-heading,
.home-container #column-left + #content .journal-boxes{
  margin-left: 0;
}
}

@media only screen and (max-width: 760px){

  .home-container .journal-filter .product-grid > div, .home-container #content .box-product > div{
      width: 230px;
    }
  .home-container #column-right + #content .product-grid > div, 
  .home-container #column-right + #content .box-product > div,
  .home-container #column-left + #content .product-grid > div, 
  .home-container #column-left + #content .box-product > div{
    margin-right: 17px;
    width: 230px;
  }
  .home-container #column-right + #content .journal-filter .product-grid > div,
  .home-container #column-left + #content .journal-filter .product-grid > div{
    width: 229px;
  }
  .home-container #column-left + #content .product-grid,
  .home-container #column-left + #content .box-product{
    margin-left: 0;
  }
}

@media only screen and (max-width: 470px){
.home-container .journal-filter .product-grid > div, .home-container #content .box-product > div{
    width: 280px;
    margin-left: 20px;
  }

  .home-container .journal-filter ul{
    width: 320px;
  }  
  .home-container .journal-filter ul li{
    width: 79px;
  }
  .home-container #column-right + #content .product-grid > div, 
  .home-container #column-right + #content .box-product > div,
  .home-container #column-left + #content .product-grid > div, 
  .home-container #column-left + #content .box-product > div{
    width: 280px;
  }
  .home-container #column-right + #content .journal-filter .product-grid > div,
  .home-container #column-left + #content .journal-filter .product-grid > div{
    width: 280px;
  }
  .home-container #column-left + #content .product-grid,
  .home-container #column-left + #content .box-product{
    margin-left: 0;
  }
}
<?php endif; ?>

</style> 
<?php endif;?>

	<?php echo $content_top; ?>
	<?php echo $content_bottom; ?>
</div>

<?php echo $footer; ?>
