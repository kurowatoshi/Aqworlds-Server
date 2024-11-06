<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login extends CI_Controller {

    public function __construct() {
        parent::__construct();

        // Set the content type header to application/json
        $this->output->set_content_type('application/json');

        $this->load->model('Atheros');
        $this->load->model('Servers');
        $this->load->model('Users');
    }

	public function now()
	{
        if ($this->input->post('user') === NULL || $this->input->post('pass') === NULL) die();
        $servers = array();
        $setting = array();
        $setting['bSuccess'] = 0;

        $user = $this->Users->getLoginData($this->input->post('user'));
        $hash = $this->Users->encryptPassword($this->input->post('user'), $this->input->post('pass'));

        if ($user == null || $hash != $user->sToken)
            $setting['sMsg'] = "The username and password you entered did not match.<br/>Please check the spelling and try again.";
        else if ($user->iAccess == 0)
            $setting['sMsg'] = "Your account has been disabled.";

        if (isset($setting['sMsg']) && $setting['sMsg'] != null)
            return $this->output->set_output(json_encode($setting, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));

        $this->db->where('id', $user->userid);
        $this->db->update('users', array(
            'Country' => $this->Atheros->getCountryCode(),
            'LastLogin' => date('Y-m-d H:i:s')
        ));

        return $this->output->set_output(json_encode(['login' => $user, 'servers' => $this->Servers->getServers()], JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
	}

}
