<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class SettingsLogin extends CI_Model {

    public function getClientvars() {
        $slotSettings = json_decode(json_encode([
            ['name' => 'iMaxBagSlots', 'value' => '425'],
            ['name' => 'iMaxBankSlots', 'value' => '600'],
            ['name' => 'iMaxFriends', 'value' => '225'],
            ['name' => 'iMaxGuildMembers', 'value' => '300'],
            ['name' => 'iMaxHouseSlots', 'value' => '250'],
        ]));

        $settings = $this->db->select('*')
                          ->where_in('name', ['gMenu', 'sAssets', 'sBook', 'sMap', 'sNews', 'sVersion', 'iMaxBagSlots', 'iMaxBankSlots', 'iMaxFriends', 'iMaxGuildMembers', 'iMaxHouseSlots'])
                          ->from('settings_login')
                          ->get()
                          ->result();
        return Servers::formatArray($this->build(array_merge($slotSettings, $settings)));
    }

    public function getGameversion() {
        $settings = $this->db->select('*')
                          ->where_in('name', ['sBG', 'sFile', 'sLoader', 'sTitle', 'sVersion'])
                          ->from('settings_login')
                          ->get()
                          ->result();
        return $this->build($settings);
    }

    public static function build($settings) {
        $formattedSettings = array();

        foreach ($settings as $data)
            $formattedSettings[$data->name] = $data->value;
        if (!isset($formattedSettings['sVersion']))
            $formattedSettings['sVersion'] = 'R0031';

        return $formattedSettings;
    }

}