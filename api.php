<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$data = $_REQUEST['first_letter'];
$data .= "\n".$_REQUEST['second_letter'];
$data .= "\n".$_REQUEST['third_letter'];
$data .= "\n".$_REQUEST['numbers'];
$filename = time().".txt";
file_put_contents($filename, $data);
$result = `perl mroor-scraping.pl $filename`;
unlink($filename);
http_response_code(200);
echo json_encode(["result" => $result]);