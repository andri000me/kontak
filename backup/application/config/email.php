<?php defined('BASEPATH') OR exit('No direct script access allowed');

// Add custom values by settings them to the $config array.
// Example: $config['smtp_host'] = 'smtp.gmail.com'; 
// @link https://codeigniter.com/user_guide/libraries/email.html

//$config['useragent'] = 'protokoler.ptbdg@gmail.com';
$config['protocol'] = 'smtp'; // or 'smtp'
$config['mailtype'] = 'html'; // or 'text'
$config['smtp_host'] = 'ssl://smtp.gmail.com';
$config['smtp_user'] = 'protokoler.ptbdg@gmail.com'; 
$config['smtp_pass'] = 'C!munc4ng';
$config['smtp_crypto'] = 'ssl'; // or 'tls'
$config['smtp_port'] = 465;
