<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Game extends CI_Controller {

	public function index()
	{
		$data = ['swf' => 'Loader3.swf'];
		$this->load->view('atheros/default', $data);
	}

}
