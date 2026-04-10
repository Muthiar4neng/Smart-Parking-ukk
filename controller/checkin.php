<?php
session_start();

require_once __DIR__ . '/../model/checkinModel.php';
require __DIR__ . '/../vendor/autoload.php';

use PhpMqtt\Client\MqttClient;

header('Content-Type: application/json');

// ================= VALIDASI USER =================
if (!isset($_SESSION['username']) || $_SESSION['level'] != 'pegawai') {
    echo json_encode(['status' => 'error', 'message' => 'Unauthorized']);
    exit;
}

// ================= AMBIL INPUT =================
$card_id = isset($_POST['card_id']) ? trim($_POST['card_id']) : '';
$nopol   = isset($_POST['nopol']) ? trim($_POST['nopol']) : '';

if (empty($card_id)) {
    echo json_encode(['status' => 'error', 'message' => 'Card ID kosong']);
    exit;
}

$model = new checkinModel();

// ================= CEK KARTU =================
$cek = $model->cekKartuAktif($card_id);

if ($cek->num_rows > 0) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Kartu masih aktif (belum checkout)'
    ]);
    exit;
}

// ================= INSERT =================
$checkin_time = date('Y-m-d H:i:s');
$transaksi_id = $model->insertCheckin($card_id, $nopol, $checkin_time);

if ($transaksi_id) {

    // ================= MQTT =================
    try {
        $mqtt = new MqttClient('broker.hivemq.com', 1883, 'php-checkin-' . uniqid());
        $mqtt->connect();

        $mqtt->publish(
            'parking/muthi/lcd',
            'Selamat Datang|Silakan Masuk',
            0
        );

        usleep(300000);
        $mqtt->disconnect();

    } catch (Exception $e) {
        error_log("MQTT ERROR: " . $e->getMessage());
    }

    echo json_encode([
        'status' => 'success',
        'message' => 'Check-in berhasil',
        'card_id' => $card_id
    ]);

} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Gagal check-in'
    ]);
}