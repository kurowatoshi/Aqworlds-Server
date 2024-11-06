<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Data extends CI_Controller {

    public function __construct() {
        parent::__construct();

        // Set the content type header to application/json
        $this->output->set_content_type('application/json');

        $this->load->model('Servers');
        $this->load->model('SettingsLogin');
    }

	public function clientvars()
	{
        $this->output->set_output(json_encode($this->SettingsLogin->getClientvars(), JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
	}

	public function gameversion()
	{
        $this->output->set_output(json_encode($this->SettingsLogin->getGameversion(), JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
	}

	public function servers()
	{
        $this->output->set_output(json_encode($this->Servers->getServers(), JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
	}

}
