<?php

$makefileContent = file_get_contents('Makefile');

$makefileContent = preg_replace('=(.+?\n# ---.+?\n).+=s', '$1', $makefileContent);

file_put_contents('Makefile', $makefileContent);
