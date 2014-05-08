<?php

class Journal2Newsletter {

    private $registry;
    private $email;

    public function __construct($registry, $email) {
        $this->registry = $registry;
        $this->email = $email;

        /* create table if not exists */
        if ($this->registry->get('db')->query('show tables like "' . DB_PREFIX . 'journal2_newsletter"')->num_rows === 0) {
            $this->registry->get('db')->query('CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'journal2_newsletter` (
                `email` varchar(128) NOT NULL,
                `token` varchar(64) NOT NULL,
                PRIMARY KEY `pk` (`email`)
            ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');
        }
    }

    public function isSubscribed() {
        return false;
    }

    public function subscribe() {

    }

    public function unsubscribe() {

    }

}