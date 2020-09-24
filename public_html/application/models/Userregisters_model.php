<?php defined('BASEPATH') OR exit('No direct script access allowed');

/* ----------------------------------------------------------------------------
 * Easy!Appointments - Open Source Web Scheduler
 *
 * @package     EasyAppointments
 * @author      A.Tselegidis <alextselegidis@gmail.com>
 * @copyright   Copyright (c) 2013 - 2018, Alex Tselegidis
 * @license     http://opensource.org/licenses/GPL-3.0 - GPLv3
 * @link        http://easyappointments.org
 * @since       v1.0.0
 * ---------------------------------------------------------------------------- */

/**
 * User Model
 *
 * Contains current user's methods.
 *
 * @package Models
 */
class Userregisters_Model extends CI_Model {
    
    public function add($user_register)
    {
        // :: INSERT OR UPDATE CUSTOMER RECORD
        if ( ! isset($user_register['id']))
        {
            $user_register['id'] = $this->_insert($user_register);
        }
        else
        {
            $this->_update($user_register);
        }

        return $user_register['id'];
    }

    /**
     * Check if a particular customer record already exists.
     *
     * This method checks whether the given customer already exists in the database. It doesn't search with the id, but
     * with the following fields: "email"
     *
     * @param array $user_register Associative array with the customer's data. Each key has the same name with the database
     * fields.
     *
     * @return bool Returns whether the record exists or not.
     *
     * @throws Exception If customer email property is missing.
     */
    public function exists($user_register)
    {
        if ( ! isset($user_register['email']))
        {
            throw new Exception('User register\'s email is not provided.');
        }

        // This method shouldn't depend on another method of this class.
        $num_rows = $this->db
            ->select('*')
            ->from('user_registers')
            ->where('user_registers.username', $user_register['username'])
            ->get()->num_rows();

        return ($num_rows > 0) ? TRUE : FALSE;
    }

    /**
     * Insert a new customer record to the database.
     *
     * @param array $user_register Associative array with the customer's data. Each key has the same name with the database
     * fields.
     *
     * @return int Returns the id of the new record.
     *
     * @throws Exception If customer record could not be inserted.
     */
    protected function _insert($user_register)
    {
        // Before inserting the customer we need to get the customer's role id
        // from the database and assign it to the new record as a foreign key.
        if ( ! $this->db->insert('user_registers', $user_register))
        {
            throw new Exception('Could not insert customer to the database.');
        }

        return (int)$this->db->insert_id();
    }

    /**
     * Update an existing customer record in the database.
     *
     * The customer data argument should already include the record ID in order to process the update operation.
     *
     * @param array $user_register Associative array with the customer's data. Each key has the same name with the database
     * fields.
     *
     * @return int Returns the updated record ID.
     *
     * @throws Exception If customer record could not be updated.
     */
    protected function _update($user_register)
    {
        // Do not update empty string values.
        $this->db->where('id', $user_register['id']);
        if ( ! $this->db->update('user_registers', $user_register))
        {
            throw new Exception('Could not update customer to the database.');
        }

        return (int)$user_register['id'];
    }

    /**
     * Find the database id of a customer record.
     *
     * The customer data should include the following fields in order to get the unique id from the database: "email"
     *
     * IMPORTANT: The record must already exists in the database, otherwise an exception is raised.
     *
     * @param array $user_register Array with the customer data. The keys of the array should have the same names as the
     * database fields.
     *
     * @return int Returns the ID.
     *
     * @throws Exception If customer record does not exist.
     */
    public function find_record_id($user_register)
    {
        if ( ! isset($user_register['email']))
        {
            throw new Exception('Customer\'s email was not provided: '
                . print_r($user_register, TRUE));
        }

        // Get customer's role id
        $result = $this->db
            ->select('ea_users.id')
            ->from('ea_users')
            ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
            ->where('ea_users.email', $user_register['email'])
            ->where('ea_roles.slug', DB_SLUG_CUSTOMER)
            ->get();

        if ($result->num_rows() == 0)
        {
            throw new Exception('Could not find customer record id.');
        }

        return $result->row()->id;
    }

    public function get($id = null){

        if ($id != null) {
            $this->db->where('id', $id);
            return $this->db->get('user_registers')->row();
        }else {
            return $this->db->get('user_registers')->result();
        }
    }

    public function get_where($where, $single = null){

        $this->db->where($where);
        
        if ($single != null) {
            return $this->db->get('user_registers')->row();
        } else {
            return $this->db->get('user_registers')->result();
        }
    }

    public function get_row($customer_id)
    {
        if ( ! is_numeric($customer_id))
        {
            throw new Exception('Invalid argument provided as $customer_id : ' . $customer_id);
        }
        return $this->db->get_where('user_registers', ['ea_user_id' => $customer_id])->row_array();
    }

    /**
     * Returns the user from the database for the "settings" page.
     *
     * @param int $user_id User record id.
     *
     * @return array Returns an array with user data.
     *
     * @todo Refactor this method as it does not do as it states.
     */
    public function get_settings($user_id)
    {
        $user = $this->db->get_where('ea_users', ['id' => $user_id])->row_array();
        $user['settings'] = $this->db->get_where('ea_user_settings', ['id_users' => $user_id])->row_array();
        unset($user['settings']['id_users']);
        return $user;
    }

    /**
     * This method saves the user record into the database (used in backend settings page).
     *
     * @param array $user Contains the current users data.
     *
     * @return bool Returns the operation result.
     *
     * @todo Refactor this method as it does not do as it states.
     */
    public function save_settings($user)
    {
        $user_settings = $user['settings'];
        $user_settings['id_users'] = $user['id'];
        unset($user['settings']);

        // Prepare user password (hash).
        if (isset($user_settings['password']))
        {
            $this->load->helper('general');
            $salt = $this->db->get_where('ea_user_settings', ['id_users' => $user['id']])->row()->salt;
            $user_settings['password'] = hash_password($salt, $user_settings['password']);
        }

        if ( ! $this->db->update('ea_users', $user, ['id' => $user['id']]))
        {
            return FALSE;
        }

        if ( ! $this->db->update('ea_user_settings', $user_settings, ['id_users' => $user['id']]))
        {
            return FALSE;
        }

        return TRUE;
    }

    /**
     * Retrieve user's salt from database.
     *
     * @param string $username This will be used to find the user record.
     *
     * @return string Returns the salt db value.
     */
    public function get_salt($username)
    {
        $user = $this->db->get_where('user_settings', ['username' => $username])->row_array();
        return ($user) ? $user['salt'] : '';
    }

    /**
     * Performs the check of the given user credentials.
     *
     * @param string $username Given user's name.
     * @param string $password Given user's password (not hashed yet).
     *
     * @return array|null Returns the session data of the logged in user or null on failure.
     */
    public function check_login($username, $password)
    {
        $this->load->helper('general');
        $salt = $this->user_model->get_salt($username);
        $password = hash_password($salt, $password);

        $user_data = $this->db
            ->select('ea_users.id AS user_id, ea_users.email AS user_email, '
                . 'ea_roles.slug AS role_slug, ea_user_settings.username')
            ->from('ea_users')
            ->join('ea_roles', 'ea_roles.id = ea_users.id_roles', 'inner')
            ->join('ea_user_settings', 'ea_user_settings.id_users = ea_users.id')
            ->where('ea_user_settings.username', $username)
            ->where('ea_user_settings.password', $password)
            ->get()->row_array();

        return ($user_data) ? $user_data : NULL;
    }

    /**
     * Get the given user's display name (first + last name).
     *
     * @param int $user_id The given user record id.
     *
     * @return string Returns the user display name.
     *
     * @throws Exception If $user_id argument is invalid.
     */
    public function get_user_display_name($user_id)
    {
        if ( ! is_numeric($user_id))
        {
            throw new Exception ('Invalid argument given: ' . $user_id);
        }

        $user = $this->db->get_where('ea_users', ['id' => $user_id])->row_array();

        return $user['first_name'] . ' ' . $user['last_name'];
    }

    /**
     * If the given arguments correspond to an existing user record, generate a new
     * password and send it with an email.
     *
     * @param string $username User's username.
     * @param string $email User's email.
     *
     * @return string|bool Returns the new password on success or FALSE on failure.
     */
    public function regenerate_password($username, $email)
    {
        $this->load->helper('general');

        $result = $this->db
            ->select('ea_users.id')
            ->from('ea_users')
            ->join('ea_user_settings', 'ea_user_settings.id_users = ea_users.id', 'inner')
            ->where('ea_users.email', $email)
            ->where('ea_user_settings.username', $username)
            ->get();

        if ($result->num_rows() == 0)
        {
            return FALSE;
        }

        $user_id = $result->row()->id;

        // Create a new password and send it with an email to the given email address.
        $new_password = generate_random_string();
        $salt = $this->db->get_where('ea_user_settings', ['id_users' => $user_id])->row()->salt;
        $hash_password = hash_password($salt, $new_password);
        $this->db->update('ea_user_settings', ['password' => $hash_password], ['id_users' => $user_id]);

        return $new_password;
    }
}
