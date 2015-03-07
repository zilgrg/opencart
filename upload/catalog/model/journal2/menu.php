<?php
class ModelJournal2Menu extends Model {

    public function getMenuName($page) {
        $this->language->load('common/header');
        $text_wishlist = $this->language->get('text_wishlist');
        $this->language->load('common/footer');
        $text_manufacturer = $this->language->get('text_manufacturer');
        $this->language->load('account/login');
        $this->language->load('account/logout');
        $this->language->load('account/register');
        $this->language->load('product/category');

        $menus = array(
            'common/home'                   => 'text_home',
            'account/wishlist'              => sprintf($text_wishlist, '<span class="product-count">{{_wishlist_}}</span>'),
            'product/compare'               => sprintf($this->language->get('text_compare'), '<span class="product-count">{{_compare_}}</span>'),
            'account/account'               => 'text_account',
            'checkout/cart'                 => 'text_shopping_cart',
            'checkout/checkout'             => 'text_checkout',

            'information/contact'           => 'text_contact',
            'account/return/insert'         => 'text_return',
            'account/return/add'            => 'text_return',
            'information/sitemap'           => 'text_sitemap',
            'product/manufacturer'          => $text_manufacturer,
            'account/voucher'               => 'text_voucher',
            'affiliate/account'             => 'text_affiliate',
            'product/special'               => 'text_special',
            'product/search'                => 'text_search',
            'account/order'                 => 'text_order',
            'account/newsletter'            => 'text_newsletter',

            'account/login'                 => $this->language->get('text_login'),
            'account/register'              => $this->language->get('text_register'),
            'account/logout'                => $this->language->get('text_logout'),
        );
        return (isset($menus[$page])) ? $this->language->get($menus[$page]) : $page;
    }

    public function getLink($link) {
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/information');
        $href = null;
        /* menu type */
        switch ($link['menu_type']) {
            case 'category':
                $category_info = $this->model_catalog_category->getCategory(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$category_info) continue;
                $href = $this->url->link('product/category', 'path=' . $category_info['category_id']);
                break;
            case 'product':
                $product_info = $this->model_catalog_product->getProduct(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$product_info) continue;
                $href = $this->url->link('product/product', 'product_id=' . $product_info['product_id']);
                break;
            case 'manufacturer':
                $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$manufacturer_info) continue;
                $href = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer_info['manufacturer_id']);
                break;
            case 'information':
                $information_info = $this->model_catalog_information->getInformation(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$information_info) continue;
                $href = $this->url->link('information/information', 'information_id=' .  $information_info['information_id']);
                break;
            case 'popup':
                $href = "javascript:Journal.openPopup('{$link['menu_item']}')";
                break;
            case 'opencart':
                switch ($link['menu_item']['page']) {
                    case 'login':
                        $link['menu_item']['page'] = $this->customer->isLogged() ? 'account/account' : 'account/login';
                        break;
                    case 'register':
                        $link['menu_item']['page'] = $this->customer->isLogged() ? 'account/logout' : 'account/register';
                        break;
                    case 'account/wishlist':
                        break;
                    default:
                }
                $href = $this->link($link['menu_item']['page']);
                break;
            case 'blog_home':
                $href = $this->url->link('journal2/blog');
                break;
            case 'blog_category':
                $category_info = $this->model_journal2_blog->getCategory(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$category_info) continue;
                $href = $this->url->link('journal2/blog', 'journal_blog_category_id=' . $category_info['category_id']);
                break;
            case 'blog_post':
                $post_info = $this->model_journal2_blog->getPost(Journal2Utils::getProperty($link, 'menu_item.id', -1));
                if (!$post_info) continue;
                $href = $this->url->link('journal2/blog/post', 'journal_blog_post_id=' . $post_info['post_id']);
                break;
            case 'custom':
                $href = Journal2Utils::getProperty($link, 'menu_item.url');
                break;
        }

        return $href;
    }

    public function link($page) {
        if ($page === 'common/home') {
            return $this->journal2->config->base_url;
        }
        if (Front::$IS_OC2 && $page === 'account/return/insert') {
            $page = 'account/return/add';
        }
        return $this->url->link($page, '', 'SSL');
    }

    public function replaceCacheVars($cache) {
        $cache = str_replace('{{_wishlist_}}', isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0, $cache);
        $cache = str_replace('{{_compare_}}', isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0, $cache);
        if ($this->customer->isLogged()) {
            $cache = str_replace('{{_customer_}}', $this->customer->getFirstName(), $cache);
        }
        return $cache;
    }

}
?>