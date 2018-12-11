<?php

error_reporting(E_ALL);

$config = parse_ini_file('../config.ini');
$db_connection = mysqli_connect($config['mysql_hostname'], $config['mysql_username'], $config['mysql_password'], $config['mysql_table']);