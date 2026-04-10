<?php

require __DIR__ . '/vendor/autoload.php';

use PhpMqtt\Client\MqttClient;

$server = 'broker.hivemq.com';
$port = 1883;
$clientId = 'php-client-' . rand(1, 1000);

$mqtt = new MqttClient($server, $port, $clientId);

$mqtt->connect();

$mqtt->publish('parkir/masuk', 'RFID123456');

echo "Pesan berhasil dikirim ke HiveMQ!";

$mqtt->disconnect();
?>