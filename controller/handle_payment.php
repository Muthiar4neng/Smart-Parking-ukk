<?php
session_start();

require_once __DIR__ . '/../model/transaksiModel.php';
require __DIR__ . '/../vendor/autoload.php';

use PhpMqtt\Client\MqttClient;

header('Content-Type: application/json');

// ================= VALIDASI USER =================
if (!isset($_SESSION['username']) || $_SESSION['level'] != 'pegawai') {
    echo json_encode(['status' => 'error', 'message' => 'Unauthorized']);
    exit;
}

// ================= AMBIL INPUT =================
$transaksi_id = intval($_POST['transaksi_id'] ?? 0);
$amount_paid  = intval($_POST['amount_paid'] ?? 0);

if ($transaksi_id <= 0) {
    echo json_encode(['status' => 'error', 'message' => 'Transaksi ID tidak valid']);
    exit;
}

$model = new transaksiModel();

// ================= AMBIL DATA =================
$transaksi = $model->getTransaksiOutById($transaksi_id);

if (!$transaksi) {
    echo json_encode(['status' => 'error', 'message' => 'Transaksi tidak ditemukan']);
    exit;
}

$card_id = $transaksi['card_id'];

// ================= HITUNG DURASI =================
$checkin  = strtotime($transaksi['checkin_time']);
$checkout = strtotime($transaksi['checkout_time']);

$durasi_detik = $checkout - $checkin;

// ✅ Per jam, dibulatkan ke atas, minimal 1 jam (sesuai soal)
$durasi_jam = max(1, (int) ceil($durasi_detik / 3600));

$tarif_per_jam = 2000;
$required_fee  = $durasi_jam * $tarif_per_jam;

// ================= VALIDASI PEMBAYARAN =================
if ($amount_paid < $required_fee) {
    echo json_encode([
        'status'  => 'error',
        'message' => 'Pembayaran kurang',
        'balance' => $required_fee - $amount_paid
    ]);
    exit;
}

$kembalian = $amount_paid - $required_fee;

// ================= UPDATE DATABASE =================
$update = $model->updateToDone($transaksi_id, $amount_paid, $kembalian);

if ($update) {

    $user_id = $_SESSION['user_id'] ?? NULL;

    // ================= LOG =================
    $model->insertLog(
        $transaksi_id,
        'PAYMENT',
        "Durasi {$durasi_jam} jam | Bayar Rp{$amount_paid} | Fee Rp{$required_fee} | Kembalian Rp{$kembalian}",
        $user_id
    );

    $model->insertLog(
        $transaksi_id,
        'GATE_OPEN',
        "Gerbang dibuka untuk kartu {$card_id}",
        $user_id
    );

    // ================= MQTT =================
    try {
        $clientId = 'php-publisher-' . uniqid();
        $mqtt     = new MqttClient('broker.hivemq.com', 1883, $clientId);
        $mqtt->connect();

        // ✅ Buka palang exit
        $mqtt->publish('parking/muthi/exit/servo', 'OPEN', 0);

        // ✅ LCD sesuai soal: "Terima Kasih Selamat Jalan"
        $mqtt->publish('parking/muthi/lcd', 'Terima Kasih|Selamat Jalan', 0);

        usleep(500000); // tunggu 0.5 detik biar pesan terkirim
        $mqtt->disconnect();

    } catch (Exception $e) {
        error_log("MQTT ERROR: " . $e->getMessage());
    }

    ob_clean();
    echo json_encode([
        'status'     => 'success',
        'message'    => 'Pembayaran berhasil',
        'kembalian'  => $kembalian,
        'fee'        => $required_fee,
        'durasi_jam' => $durasi_jam
    ]);

} else {
    echo json_encode([
        'status'  => 'error',
        'message' => 'Gagal update'
    ]);
}