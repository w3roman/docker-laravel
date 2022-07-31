<?php

const PATH_TO_ENV = '.env';

$config = file_get_contents(PATH_TO_ENV);

$config = preg_replace('=DB_HOST\=127\.0\.0\.1=', 'DB_HOST=mysql', $config);
$config = preg_replace('=DB_DATABASE\=laravel=', 'DB_DATABASE=' . getenv('MYSQL_DATABASE'), $config);
$config = preg_replace('=DB_USERNAME\=root=', 'DB_USERNAME=' . getenv('MYSQL_USER'), $config);
$config = preg_replace('=DB_PASSWORD\==', 'DB_PASSWORD=' . getenv('MYSQL_PASSWORD'), $config);

file_put_contents(PATH_TO_ENV, $config);
