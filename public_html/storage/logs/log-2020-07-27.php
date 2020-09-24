<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

ERROR - 2020-07-27 00:12:59 --> Email could not been sent. Mailer Error (Line 194): SMTP connect() failed. https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting
ERROR - 2020-07-27 00:12:59 --> #0 /home/kontak.pt-bandung.go.id/public_html/application/controllers/Appointments.php(624): EA\Engine\Notifications\Email->sendAppointmentDetails(Array, Array, Array, Array, Array, Object(EA\Engine\Types\Text), Object(EA\Engine\Types\Text), Object(EA\Engine\Types\Url), Object(EA\Engine\Types\Email), Object(EA\Engine\Types\Text))
#1 [internal function]: Appointments->ajax_register_appointment()
#2 /home/kontak.pt-bandung.go.id/public_html/system/core/CodeIgniter.php(532): call_user_func_array(Array, Array)
#3 /home/kontak.pt-bandung.go.id/public_html/index.php(355): require_once('/home/kontak.pt...')
#4 {main}
