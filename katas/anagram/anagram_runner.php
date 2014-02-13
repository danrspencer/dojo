<?php

$scriptName = $argv[1];
$scriptNameParts = explode('/', $scriptName);
$scriptWithExt = end($scriptNameParts);
$className = substr($scriptWithExt, 0, -4);

$word = $argv[2];

$wordlist = file_get_contents('wordlist.txt');

include $scriptName;

$class = new $className($wordlist);
echo "\n" . $class->getAnagrams($word) . "\n\n";