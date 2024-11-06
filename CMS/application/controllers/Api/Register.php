<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Register extends CI_Controller {

    protected $starterWeapon;
    protected $starterClass;

    public function __construct()
    {
        parent::__construct();

        $this->load->model('Atheros');
        $this->load->model('Users');

        $this->starterWeapon = 1;
        $this->starterClass = [2];

        $this->output->set_content_type('application/json');
    }

	public function now()
	{
        $this->form_validation->set_rules('username', 'Username', 'required|min_length[3]');
        $this->form_validation->set_rules('password', 'Password', 'required|min_length[7]');
        $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
        $this->form_validation->set_rules('gender', 'Gender', 'required');
        $this->form_validation->set_rules('classes', 'Classes', 'required');

        $this->output->set_status_header(400);

        if ($this->form_validation->run() == FALSE)
            return $this->output->set_output(json_encode(['bSuccess' => 0, 'sMsg' => validation_errors('<a>', '</a>')]));

        if ($this->Users->getUser($this->input->post('username')) != NULL)
            return $this->output->set_output(json_encode(['bSuccess' => 0, 'sMsg' => 'Username is already used.']));

        if (!in_array($this->input->post('classes'), $this->starterClass))
            return $this->output->set_output(json_encode(['bSuccess' => 0, 'sMsg' => 'The selected class is not in the starter class.']));

        $user = $this->Users->addUser([
            'Name' => $this->input->post('username'),
            'Gender' => (($this->input->post('gender') == "M") ? "M" : "F"),
            'Email' => $this->input->post('email'),
            'Hash' => $this->Users->encryptPassword($this->input->post('username'), $this->input->post('password')),
            'Age' => 13,
            'Level' => 1,
            'Gold' => 0,
            'Coins' => 0,
            'Access' => 1,
            'HairID' => (($this->input->post('gender') == "M") ? 52 : 83),
            'ColorSkin' => 'FFCC99'
        ]);
        if ($user) {
            $userid = $this->db->insert_id();
            $this->Users->addItem(['UserID' => $userid, 'ItemID' => $this->input->post('classes'), 'Equipped' => 1, 'EnhID' => 1957]); //Add Class
            $this->Users->addItem(['UserID' => $userid, 'ItemID' => $this->starterWeapon, 'Equipped' => 1, 'EnhID' => 1957]); //Add Weapon
            $this->output->set_status_header(200);
            return $this->output->set_output(json_encode(['bSuccess' => 1, 'sMsg' => "User successfully created with username: {$this->Users->getUserById($userid)->Name}"]));
        } else
            return $this->output->set_output(json_encode(['bSuccess' => 0, 'sMsg' => $this->db->error()]));
    }

}