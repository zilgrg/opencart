<?php
class ModelJournal2Search extends Model {

    public function search($data) {
        $data = utf8_strtolower($data);

        if ($this->customer->isLogged()) {
            $customer_group_id = $this->customer->getCustomerGroupId();
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $sql = "SELECT p.product_id, (SELECT AVG(rating) AS total FROM " . DB_PREFIX . "review r1 WHERE r1.product_id = p.product_id AND r1.status = '1' GROUP BY r1.product_id) AS rating, (SELECT price FROM " . DB_PREFIX . "product_discount pd2 WHERE pd2.product_id = p.product_id AND pd2.customer_group_id = '" . (int)$customer_group_id . "' AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW()) AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW())) ORDER BY pd2.priority ASC, pd2.price ASC LIMIT 1) AS discount, (SELECT price FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$customer_group_id . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW()) AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW())) ORDER BY ps.priority ASC, ps.price ASC LIMIT 1) AS special";

        $sql .= " FROM " . DB_PREFIX . "product p";

        $sql .= " LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

        $sql .= " AND ( ( ";

        if (utf8_strlen($data) === 1) {
            $sql .= " LCASE(pd.name) LIKE '" . $this->db->escape($data) . "%'";
        } else if (utf8_strlen($data) > 1) {
            $sql .= " LCASE(pd.name) LIKE '%" . $this->db->escape($data) . "%'";
        }

        $sql .= " ) OR ( ";

        if (utf8_strlen($data) === 1) {
            $sql .= " LCASE(p.model) LIKE '" . $this->db->escape($data) . "%'";
        } else if (utf8_strlen($data) > 1) {
            $sql .= " LCASE(p.model) LIKE '%" . $this->db->escape($data) . "%'";
        }

        $sql .= " ) ) ";

        $sql .= " GROUP BY p.product_id";

        $sql .= " ORDER BY LCASE(pd.name) ASC";

        $query = $this->db->query($sql);

        return $query->rows;
    }
}
?>