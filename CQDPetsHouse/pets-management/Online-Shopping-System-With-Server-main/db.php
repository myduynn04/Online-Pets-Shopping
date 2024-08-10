<?php
$serverName = "NGUYEN-MY-DUYEN\SQLEXPRESS";
$database = "CDQ2";


$connection = [
    "Database" => $database,
    "Encrypt" => "no",  // Disable connection encryption
    "TrustServerCertificate" => "yes"  // Trust the server certificate
]; 

$con = sqlsrv_connect($serverName, $connection);

if (!$con) {
    die(print_r(sqlsrv_errors(), true));
} 
?>