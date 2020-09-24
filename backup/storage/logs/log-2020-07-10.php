<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

ERROR - 2020-07-10 17:38:22 --> Email could not been sent. Mailer Error (Line 179): SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting
ERROR - 2020-07-10 17:38:22 --> #0 /var/www/html/kontak/application/controllers/Appointments.php(576): EA\Engine\Notifications\Email->sendAppointmentDetails(Array, Array, Array, Array, Array, Object(EA\Engine\Types\Text), Object(EA\Engine\Types\Text), Object(EA\Engine\Types\Url), Object(EA\Engine\Types\Email), Object(EA\Engine\Types\Text))
#1 [internal function]: Appointments->ajax_register_appointment()
#2 /var/www/html/kontak/system/core/CodeIgniter.php(532): call_user_func_array(Array, Array)
#3 /var/www/html/kontak/index.php(353): require_once('/var/www/html/k...')
#4 {main}
