<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
    <h1 class="heading-title"><?php echo $heading_title; ?></h1><?php echo $content_top; ?>
    <?php if ($this->journal2->settings->get('blog_blog_feed_url')): ?>
    <a class="journal-blog-feed" href="<?php echo $this->journal2->settings->get('blog_blog_feed_url'); ?>" target="_blank"><span class="feed-text"><?php echo $this->journal2->settings->get("feed_text"); ?></span></a>
    <?php endif; ?>
    <?php if (isset($category_description) && $category_description): ?>
    <div><?php echo $category_description; ?></div>
    <?php endif; ?>
    <?php if ($posts): ?>
    <div class="posts main-posts blog-<?php echo $this->journal2->settings->get("config_blog_settings.posts_display", "grid"); ?>-view">
        <?php foreach ($posts as $post): ?>
        <div class="<?php echo $grid_classes; ?>">
            <div class="post-wrapper">
                <?php if ($post['image']): ?>
                <a class="post-image" href="<?php echo $post['href']; ?>"><img src="<?php echo $post['image']; ?>" alt="<?php echo $post['name']; ?>"/></a>
                <?php endif; ?>
                <div class="post-item-details">
                    <h2><a href="<?php echo $post['href']; ?>"><span><?php echo $post['name']; ?></span></a></h2>
                    <div class="comment-date">
                        <span class="p-author"><?php echo $post['author']; ?></span>
                        <span class="p-date"><?php echo $post['date']; ?></span>
                        <span class="p-comment"><?php echo $post['comments']; ?></span>
                    </div>
                    <div class="post-text"><span><?php echo $post['description']; ?></span></div>
                    <a class="post-view-more button" href="<?php echo $post['href']; ?>"><i class="post-button-left-icon"></i><?php echo $this->journal2->settings->get('blog_button_read_more', 'Read More'); ?><i class="post-button-right-icon"></i></a>
                </div>
            </div>
        </div>
        <?php endforeach; ?>
    </div>
    <div class="pagination"><?php echo $pagination; ?></div>
    <?php else: ?>
    <div class="buttons">
        <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
    </div>
    <?php endif; ?>
    <?php echo $content_bottom; ?>
</div>
<script>
    Journal.equalHeight($(".posts .post-wrapper"), '.post-item-details h2 a');
    Journal.equalHeight($(".posts .post-wrapper"), '.post-text span');
</script>
<?php echo $footer; ?>