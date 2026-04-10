<?php
session_start();

require_once __DIR__ . '/../model/checkoutModel.php';

header('Content-Type: application/json');

// ================= VALIDASI USER =================
if (!isset($_SESSION['username']) || $_SESSION['level'] != 'pegawai') {
    echo json_encode(['status' => 'error', 'message' => 'Unauthorized']);
    exit;
}

// ================= AMBIL INPUT =================
$card_id = trim($_POST['card_id'] ?? '');

if (empty($card_id)) {
    echo json_encode(['status' => 'error', 'message' => 'Card ID tidak boleh kosong']);
    exit;
}

$model = new checkoutModel();

// ================= CEK TRANSAKSI AKTIF =================
$query = $model->getTransaksiAktif($card_id);

if ($query->num_rows == 0) {
    echo json_encode(['status' => 'error', 'message' => 'Kendaraan tidak ditemukan atau belum check-in']);
    exit;
}

$row          = $query->fetch_assoc();
$transaksi_id = $row['id'];
$checkin_time = $row['checkin_time'];

// ================= HITUNG DURASI & FEE =================
$dataHitung       = $model->hitungDurasiDanFee($checkin_time);
$checkout_time    = $dataHitung['checkout_time'];
$duration_minutes = $dataHitung['duration_minutes'];
$duration_hours   = $dataHitung['duration_hours'];  // ✅ pakai dari model
$fee              = $dataHitung['fee'];

// ================= UPDATE DB =================
$update = $model->updateCheckout($transaksi_id, $checkout_time, $duration_minutes, $fee);

if ($update) {

    $user_id     = $_SESSION['user_id'] ?? NULL;
    $log_message = "Check-out kartu $card_id | {$duration_hours} jam | Rp{$fee}";

    $model->insertLog($transaksi_id, $log_message, $user_id);

    echo json_encode([
        'status'           => 'success',
        'message'          => 'Silakan lakukan pembayaran',
        'transaksi_id'     => $transaksi_id,
        'card_id'          => $card_id,
        'checkin_time'     => $checkin_time,
        'checkout_time'    => $checkout_time,
        'duration_minutes' => $duration_minutes,
        // ✅ Tampilkan jam yang benar
        'duration_display' => "{$duration_hours} jam",
        'fee'              => $fee,
        'fee_display'      => 'Rp' . number_format($fee, 0, ',', '.'),
    ]);

} else {
    echo json_encode([
        'status'  => 'error',
        'message' => 'Gagal update data',
    ]);
}