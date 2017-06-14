<?php

parse_str(implode('&', array_slice($argv, 1)), $_GET);
$a=$_GET['a'];
$b=$_GET['b'];
echo "a = $a\n";
echo "b = $b\n";
?>
