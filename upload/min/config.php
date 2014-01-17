<?php
/**
 * Configuration for "min", the default application built with the Minify library
 * @package Minify
 */

// Set the document root to be the path of the "site root"
$min_documentRoot = substr(__FILE__, 0, -15);

// Set $sitePrefix to the path of the site from the webserver's real docroot
list($sitePrefix) = explode($min_documentRoot, $_SERVER['SCRIPT_NAME'], 2);

// Prepend $sitePrefix to the rewritten URIs in CSS files
$min_symlinks['//' . ltrim($sitePrefix, '/')] = $min_documentRoot;

/**
 * Allow use of the Minify URI Builder app. Only set this to true while you need it.
 **/
$min_enableBuilder = false;
$min_errorLogger = true;
$min_allowDebugFlag = true;
$min_serveOptions['maxAge'] = 8640000;
/* To use APC/Memcache/ZendPlatform for cache storage, require the class and set $min_cachePath to an instance. Example below: */
//require dirname(__FILE__) . '/lib/Minify/Cache/APC.php';
//$min_cachePath = new Minify_Cache_APC();
$min_cachePath      = '../system/cache/min';


/**
 * Leave an empty string to use PHP's $_SERVER['DOCUMENT_ROOT'].
 */
$min_documentRoot = '';
//$min_documentRoot = substr(__FILE__, 0, -15);
//$min_documentRoot = $_SERVER['SUBDOMAIN_DOCUMENT_ROOT'];


/* Cache file locking. Set to false if filesystem is NFS. On at least one NFS system flock-ing attempts stalled PHP for 30 seconds! */
$min_cacheFileLocking = true;
$min_serveOptions['bubbleCssImports'] = false;
$min_serveOptions['minApp']['groupsOnly'] = false;
$min_serveOptions['minApp']['noMinPattern'] = null;
$min_symlinks = array();
$min_uploaderHoursBehind = 0;
$min_libPath = dirname(__FILE__) . '/lib';
ini_set('zlib.output_compression', '0');
