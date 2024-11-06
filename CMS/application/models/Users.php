<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends CI_Model {

    public function getUser($name = NULL) {
        $name = $name != NULL ? $name : $this->session->userdata('Name');
        $user = $this->db->select('*')->from('users')->where(['Name' => $name])->get()->row();
        return $user;
    }

    public function getUserById($id) {
        $user = $this->db->select('*')->from('users')->where(['id' => $id])->get()->row();
        return $user;
    }

    public function getLoginData($name) {
        $user = $this->db
                     ->select(['1 AS bSuccess', 'id AS userid', 'Access AS iAccess'])
                     ->select('CASE WHEN UpgradeDays >= 0 THEN 1 ELSE 0 END AS iUpg', false)
                     ->select('CASE WHEN Age > 13 THEN Age ELSE 13 END AS iAge', false)
                     ->select('Level as iLevel')
                     ->select([
                        'UpgradeDays AS iUpgDays', '0 AS bCCOnly', '0 AS intHours', 'Hash AS sToken',
                        'Email AS strEmail', 'Country AS strCountryCode', 'Name AS unm',
                        'REPLACE(UpgradeExpire, " ", "T") AS dUpgExp', 'REPLACE(DateCreated, " ", "T") AS dCreated'
                     ])
                     ->select('ActivationFlag as iEmailStatus')
                     ->select("'success' AS sMsg", false)
                     ->from('users')
                     ->where(['Name' => $name])
                     ->get()
                     ->row();
        return $user;
    }

	public function encryptPassword($x, $y) {
        return strrev(strtoupper(substr(hash('sha512', $y . strtolower($x)), strlen($x), 17))); 
	}

	public function addUser($data) {
        $this->db->set('DateCreated', 'NOW()', FALSE);
        $this->db->set('LastLogin', 'NOW()', FALSE);
		return $this->db->insert('users', $data);
	}

    public function addItem($item) {
        return $this->db->insert('users_items', $item);
    }

}