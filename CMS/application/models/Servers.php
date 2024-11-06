<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Servers extends CI_Model {

    public function getServers() {
        $settings = $this->db->select([
                            'Name as sName', 'IP as sIP', 'Count as iCount', 'Max as iMax', 'Online as bOnline',
                            'Chat as iChat', 'Upgrade as bUpg', '"it" as sLang', '5588 as iPort', '0 as iLevel'
                          ])
                          ->from('servers')
                          ->get()
                          ->result();
        return $settings;
    }

    public static function formatJsonData($data)
    {
        if (!is_array($data)) return false;
        foreach ($data as $key => $value)
            if (!is_int($key)) return self::formatArray($data);

        return self::formatArrayObject($data);
    }

    public static function formatArrayObject($data) {
        $formattedData = [];
        foreach ($data as $item) {
            $formattedData[] = self::formatArray($item);
        }
        return $formattedData;
    }

    public static function formatArray($data) {
        foreach ($data as $key => $val) {
            if (substr($key, 0, 1) === 'i' && ctype_lower(substr($key, 0, 1)))
                $data[$key] = (int) $val;
            else if (substr($key, 0, 1) === 'b' && ctype_lower(substr($key, 0, 1)))
                $data[$key] = (boolean) $val;
            else if (substr($key, 0, 1) === 's' && ctype_lower(substr($key, 0, 1)))
                $data[$key] = (string) $val;
            else if (strtolower(substr($key, -2)) === "id")
                $data[$key] = (int) $val;
            else if (substr($key, 0, 3) === 'Enh')
                $data[$key] = (int) $val;
        }
        return $data;
    }

}