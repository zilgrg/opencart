<?php
class ModelBlogComment extends Model {
	public function getComment($comment_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "blog_comment WHERE comment_id = '" . (int)$comment_id . "'");
		
		return $query->row;
	}
	
	public function getParentComment($comment_id) {
		$query = $this->db->query("SELECT parent_id FROM " . DB_PREFIX . "blog_comment WHERE comment_id = '" . (int)$comment_id . "'");
		
		$comment = $this->getComment($query->row['parent_id']);
		
		return $comment;
	}
	
	public function getComments($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "blog_comment";
		
		if (isset($data['art_id']) || isset($data['status'])) {
			$sql .= " WHERE ";	
		}
		
		if (isset($data['art_id']) && ($data['art_id'] != 0)) {
			$sql .= " article_id = '" . (int)$data['art_id'] . "'";
		} else {
			$sql .= " article_id != '0'";
		}
		
      if (!empty($data['email'])) {
			$sql .= " AND email = '" . $this->db->escape($data['email']) . "'";
		}
      
		if (!empty($data['name'])) {
         if (ceil($data['name'])) {
			$sql .= " AND staff_id = '" . (int)$data['name'] . "'";
         } else {
			$sql .= " AND name = '" . $this->db->escape($data['name']) . "'";
         }
		}
      
		if ($data['status'] == 1 || $data['status'] == 0) {
			$sql .= " AND status = '" . (int)$data['status'] . "'";
		}
      
      $sql .= "ORDER BY created DESC";
      
		if (isset($data['limit'])) {
         if ($data['limit'] < 1) {
            $data['limit'] = 12;
         }
         $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
      }
      
		$query = $this->db->query($sql);
		
		return $query->rows;
	}
	
	public function editComment($comment_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_comment SET name = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', website = '" . $this->db->escape($data['website']) . "', content = '" . $this->db->escape($data['content']) . "', status = '" . (int)$data['status'] . "' WHERE comment_id = '" . (int)$comment_id . "'");
	}
	
	public function replyComment($parent_id, $data, $date) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "blog_comment SET parent_id = '" . (int)$parent_id . "', article_id = '" . (int)$data['article_id'] . "', name = '" . $this->db->escape($data['name']) . "', email = '" . $this->db->escape($data['email']) . "', website = '" . $this->db->escape($data['website']) . "', content = '" . $this->db->escape($data['content']) . "', status = '1', staff_id = '" . (int)$this->user->getId() . "', created = '" . $this->db->escape($date) . "'");
	}
	
	public function deleteComment($comment_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_comment WHERE comment_id = '" . (int)$comment_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "blog_comment WHERE parent_id = '" . (int)$comment_id . "'");
	}
	
	public function commentStatus($comment_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_comment SET status = '" . (int)$status . "' WHERE comment_id = '" . (int)$comment_id . "'");
	}
	
	public function getTotalComments($data = array()) {
      $sql = "SELECT COUNT(DISTINCT comment_id) AS total FROM " . DB_PREFIX . "blog_comment";
		
		
		if (isset($data['art_id']) && ($data['art_id'] != 0)) {
			$sql .= " WHERE article_id = '" . (int)$data['art_id'] . "'";
		} else {
			$sql .= " WHERE article_id != '0'";
		}
		
      if (!empty($data['email'])) {
			$sql .= " AND email = '" . $this->db->escape($data['email']) . "'";
		}
      
		if (!empty($data['name'])) {
         if (ceil($data['name'])) {
			$sql .= " AND staff_id = '" . (int)$data['name'] . "'";
         } else {
			$sql .= " AND name = '" . $this->db->escape($data['name']) . "'";
         }
		}
      
		if ($data['status'] == 1 || $data['status'] == 0) {
			$sql .= " AND status = '" . (int)$data['status'] . "'";
		}

      $query = $this->db->query($sql);

		return $query->row['total'];
	}
	
	public function getCustomerGroup($customer_id) {
      $this->load->model('blog/setting');
      
      if ($this->model_blog_setting->checkDbColumn('customer_group', 'name')) {
			// if exist mean <= 1.5.2.x
			$query = $this->db->query("SELECT cg.customer_group_id as groupId, cg.name as groupName FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id) WHERE c.customer_id = '" . (int)$customer_id . "'");
		} else {
			// if NOT exist mean >= 1.5.3
			$query = $this->db->query("SELECT cgd.customer_group_id as groupId, cgd.name as groupName FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (c.customer_group_id = cgd.customer_group_id) WHERE c.customer_id = '" . (int)$customer_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
		}
		
		if (isset($query->row)) {
			return $query->row;
		} else {
			return 0;
		}
	}
	
	public function getStaffGroup($user_id) {
		$query = $this->db->query("SELECT ug.name as groupName FROM " . DB_PREFIX . "user u LEFT JOIN " . DB_PREFIX . "user_group ug ON (u.user_id = ug.user_group_id) WHERE u.user_id = '" . (int)$user_id . "'");
		
		if (isset($query->row)) {
			return $query->row['groupName'];
		} else {
			return 0;
		}
	}
   
   public function getAuthorName($user_id) {
      $query = $this->db->query("SELECT name FROM `" . DB_PREFIX . "blog_author` WHERE user_id = '" . (int)$user_id . "'");
      
      return $query->row['name'];
   }
   
   public function getReplyAdminName($comment_id) {
      $query = $this->db->query("SELECT a.name as adminName, a.user_id as staffId FROM " . DB_PREFIX . "blog_comment c LEFT JOIN " . DB_PREFIX . "blog_author a ON (c.staff_id = a.user_id) WHERE c.comment_id = '" . (int)$comment_id . "'");
      if (isset($query->row)) {
         return $query->row;
      } else {
         return 0;
      }
   }
	
	public function updateCommentStatus($comment_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "blog_comment SET status = '" . (int)$status . "' WHERE comment_id = '" . (int)$comment_id . "'");				
	}
}
?>