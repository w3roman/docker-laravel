<?php

// .env

const PATH_TO_ENV = '.env';

$config = file_get_contents(PATH_TO_ENV);

$config = preg_replace('=APP_URL\=http://localhost=', 'APP_URL=http://localhost:${NGINX_PORT}', $config);

file_put_contents(PATH_TO_ENV, $config);

// package.json

$packageJsonContent = json_decode(file_get_contents('package.json'), true);
$packageJsonContent['scripts']['dev'] = 'vite --host --port=${VITE_PORT}';
file_put_contents('package.json', json_encode($packageJsonContent, JSON_PRETTY_PRINT));
