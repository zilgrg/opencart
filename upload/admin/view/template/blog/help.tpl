<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>

<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>

<style>
html, body { height: 100%; }
body { margin: 0; }
</style>
</head>

<body>
    <div class="frame-wrapper">
        <iframe id="frame-help" src="<?php echo $help_page; ?>">
            <p>Your browser does not support iframes.</p>
        </iframe>
    </div>
</body>
</html>