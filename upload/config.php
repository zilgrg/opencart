<?php
// FRONTEND CONFIG

// HTTP
define('HTTP_SERVER', 'http://yama.lt/');
define('HTTP_CATALOG', 'http://yama.lt/');
define('HTTP_IMAGE', 'http://yama.lt/image/');
define('HTTP_ADMIN', 'http://yama.lt/admin/');

// HTTPS
define('HTTPS_SERVER', HTTP_SERVER);
define('HTTPS_IMAGE', HTTP_IMAGE);

// DIR
define('DIR_CATALOG', '/home/yamahace/domains/yama.lt/public_html/catalog/');
define('DIR_APPLICATION', DIR_CATALOG);
define('DIR_SYSTEM', '/home/yamahace/domains/yama.lt/public_html/system/');
define('DIR_DATABASE', DIR_SYSTEM.'database/');
define('DIR_LANGUAGE', DIR_APPLICATION.'language/');
define('DIR_TEMPLATE', DIR_APPLICATION.'view/theme/');
define('DIR_CONFIG', DIR_SYSTEM.'config/');
define('DIR_IMAGE', '/home/yamahace/domains/yama.lt/public_html/image/');
define('DIR_CACHE', DIR_SYSTEM.'cache/');
define('DIR_DOWNLOAD', '/home/yamahace/domains/yama.lt/public_html/download/');
define('DIR_LOGS', DIR_SYSTEM.'logs/');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'yamahace_oc3');
define('DB_PASSWORD', 'N|QaU|i0P&@@8');
define('DB_DATABASE', 'yamahace_oc3');
define('DB_PREFIX', 'oc_');
?>