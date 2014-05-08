<?php

class Journal2Cache {

    public static $path;
    public static $dir = 'journal-cache/';

    private $skin_id = '1';
    private $store_id = '1';
    private $language_id = '1';
    private $currency_id = '1';
    private $device = 'desktop';
    private $price = '';
    private $logged_in = '0';
    private $developer_mode = '1';
    private $hostname = '';

    public function __construct($registry) {
        $config = $registry->get('config');
        $currency = $registry->get('currency');
        $device = $registry->get('journal2')->mobile_detect;

        $this->store_id = $config->get('config_store_id');
        $this->language_id = $config->get('config_language_id');
        $this->currency_id = $currency->getCode();

        if ($device->isMobile()) {
            if ($device->isTablet()) {
                $this->device = 'tablet';
            } else {
                $this->device = 'mobile';
            }
        }

        $this->logged_in = (int)$registry->get('customer')->isLogged();
        $this->price = ($config->get('config_customer_price') && $registry->get('customer')->isLogged()) || !$config->get('config_customer_price') ? 'price' : 'noprice';

        $this->hostname = md5(Journal2Utils::getHostName());
    }

    public function getJournalAssetsFileName($extension) {
        return "journal-{$this->device}.{$extension}";
    }

    public function setDeveloperMode($mode) {
        $this->developer_mode = self::canCache() ? $mode : false;
    }

    public function getDeveloperMode() {
        if (self::canCache()) {
            return $this->developer_mode;
        }
        return true;
    }

    public function setSkinId($skin_id) {
        $this->skin_id = $skin_id;
    }

    public function get($property) {
        if ($this->developer_mode) {
            return null;
        }
        $file_name = $this->getFileName($property);

        if (file_exists($file_name)) {
            return file_get_contents($file_name);
        }

        return null;
    }

    public function set($property, $value) {
        if (!$this->developer_mode && self::canCache()) {
            file_put_contents($this->getFileName($property), $value, LOCK_EX);
        }
        return $value;
    }

    private function getFileName($property) {
        return self::getCachePath() . "j2_{$property}_sk{$this->skin_id}_s{$this->store_id}_l{$this->language_id}_c{$this->currency_id}_u{$this->logged_in}_{$this->device}_{$this->price}_" . JOURNAL_VERSION . "_{$this->hostname}.cache.html";
    }

    public static function getCachePath() {
        return self::$path . DIRECTORY_SEPARATOR . self::$dir;
    }

    public static function getCacheDir() {
        return self::$dir;
    }

    public static function canCache() {
        $cache_path = self::getCachePath();

        /* if folder exists and it's writable */
        if (file_exists($cache_path) && is_writable($cache_path)) {
            return true;
        }

        /* try to create folder */
        if (is_writable(self::$path) && @mkdir($cache_path)) {
            return true;
        }

        /* can't use cache */
        return false;
    }

    public static function deleteCache($pattern = '*') {
        $path = self::getCachePath();
        if (!$path) return;
        $files = glob($path . $pattern);
        if ($files) {
            foreach ($files as $file) {
                if (file_exists($file)) {
                    unlink($file);
                }
            }
        }
    }

    public static function deleteModuleCache($pattern) {
        self::deleteCache("j2_{$pattern}*.cache.html");
        self::deleteSettingsCache();
    }

    public static function deleteSettingsCache() {
        self::deleteCache('salt');
        self::deleteCache('journal-*.css');
        self::deleteCache('journal-*.js');
        self::deleteCache('_*.css');
        self::deleteCache('_*.js');
    }

}

Journal2Cache::$path = realpath(DIR_SYSTEM . '../');
