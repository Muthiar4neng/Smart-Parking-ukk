<?php

require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/config/koneksi.php';

use PhpMqtt\Client\MqttClient;

$server   = 'broker.hivemq.com';
$port     = 1883;
$clientId = 'php-subscriber-' . rand(1, 1000);

$mqtt = new MqttClient($server, $port, $clientId);

try {
    $mqtt->connect();
    echo "Terhubung ke MQTT Broker...\n";
} catch (Exception $e) {
    die("Gagal konek ke MQTT: " . $e->getMessage());
}

/* -------------------------------------------------------
 | Helper: ambil card_id — support plain string & JSON
 ------------------------------------------------------- */
function parseCardId(string $message): string {
    $message = trim($message);
    $decoded = json_decode($message, true);
    if (json_last_error() === JSON_ERROR_NONE && isset($decoded['rfid'])) {
        return strtoupper(trim($decoded['rfid']));
    }
    return strtoupper($message);
}

/* -------------------------------------------------------
 | Helper: publish pesan ke LCD via koneksi MQTT terpisah
 ------------------------------------------------------- */
function publishLCD(string $pesan): void {
    try {
        $pub = new MqttClient('broker.hivemq.com', 1883, 'php-pub-' . rand(1000, 9999));
        $pub->connect();
        $pub->publish('parking/muthi/lcd', $pesan, 0);
        usleep(400000);
        $pub->disconnect();
        echo "LCD >> $pesan\n";
    } catch (Exception $e) {
        echo "MQTT publish error: " . $e->getMessage() . "\n";
    }
}

/*
|--------------------------------------------------------------------------
| SUBSCRIBE: ENTRY — insert transaksi baru
|--------------------------------------------------------------------------
*/
$mqtt->subscribe('parking/muthi/entry/rfid', function ($topic, $message) use ($koneksi) {

    echo "\n=== ENTRY DITERIMA ===\n";
    echo "Raw    : $message\n";

    $card_id = parseCardId($message);
    echo "Card ID: $card_id\n";

    if (empty($card_id)) {
        echo "Card ID kosong, skip.\n";
        return;
    }

    // Cek apakah kartu masih aktif (status IN)
    $stmt = $koneksi->prepare(
        "SELECT id FROM transaksi WHERE card_id = ? AND status = 'IN' LIMIT 1"
    );
    $stmt->bind_param("s", $card_id);
    $stmt->execute();

    if ($stmt->get_result()->num_rows > 0) {
        echo "Card masih parkir: $card_id\n";
        publishLCD('Kartu masih|terdaftar!');
        return;
    }

    // Generate nopol otomatis
    $angka = rand(1000, 9999);
    $huruf = chr(rand(65, 90)) . chr(rand(65, 90)) . chr(rand(65, 90));
    $nopol        = "B $angka $huruf";
    $checkin_time = date('Y-m-d H:i:s');

    $stmt_insert = $koneksi->prepare(
        "INSERT INTO transaksi (card_id, nopol, checkin_time, status) VALUES (?, ?, ?, 'IN')"
    );
    $stmt_insert->bind_param("sss", $card_id, $nopol, $checkin_time);

    if ($stmt_insert->execute()) {
        echo "Check-in berhasil: $card_id | NOPOL: $nopol\n";
        // LCD "Selamat Datang | Silakan Masuk" sudah ditampilkan dari ESP32
    } else {
        echo "Gagal insert: " . $stmt_insert->error . "\n";
    }

}, 0);

/*
|--------------------------------------------------------------------------
| SUBSCRIBE: EXIT — UPDATE status IN → OUT + kirim biaya ke LCD
|--------------------------------------------------------------------------
*/
$mqtt->subscribe('parking/muthi/exit/rfid', function ($topic, $message) use ($koneksi) {

    echo "\n=== EXIT DITERIMA ===\n";
    echo "Raw    : $message\n";

    $card_id = parseCardId($message);
    echo "Card ID: $card_id\n";

    if (empty($card_id)) {
        echo "Card ID kosong, skip.\n";
        return;
    }

    // Cari transaksi aktif (status IN)
    $stmt = $koneksi->prepare(
        "SELECT id, checkin_time FROM transaksi
         WHERE card_id = ? AND status = 'IN'
         ORDER BY id DESC LIMIT 1"
    );
    $stmt->bind_param("s", $card_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 0) {
        echo "Tidak ada transaksi aktif untuk: $card_id\n";
        publishLCD('Kartu tidak|terdaftar!');
        return;
    }

    $row          = $result->fetch_assoc();
    $transaksi_id = $row['id'];
    $checkin_time = $row['checkin_time'];

    // Hitung durasi & biaya
    $checkin_ts    = strtotime($checkin_time);
    $checkout_ts   = time();
    $selisih_detik = $checkout_ts - $checkin_ts;

    // Durasi menit → disimpan ke kolom duration
    $durasi_menit  = max(1, (int) ceil($selisih_detik / 60));

    // Durasi jam → untuk hitung biaya (minimal 1 jam, dibulatkan atas)
    $durasi_jam    = max(1, (int) ceil($selisih_detik / 3600));

    $total_bayar   = $durasi_jam * 2000;  // Rp2.000/jam sesuai soal
    $checkout_time = date('Y-m-d H:i:s', $checkout_ts);

    // ✅ UPDATE status IN → OUT
    $stmt_update = $koneksi->prepare(
        "UPDATE transaksi
         SET checkout_time = ?,
             duration      = ?,
             fee           = ?,
             status        = 'OUT'
         WHERE id = ?"
    );
    $stmt_update->bind_param("siii", $checkout_time, $durasi_menit, $total_bayar, $transaksi_id);

    if ($stmt_update->execute()) {
        echo "Checkout OK: $card_id | {$durasi_jam} jam | Rp{$total_bayar}\n";

        // ✅ Tampilkan total biaya di LCD
        $fee_text = 'Rp' . number_format($total_bayar, 0, ',', '.');
        publishLCD("Total:$fee_text|Harap tunggu...");

    } else {
        echo "Gagal UPDATE: " . $stmt_update->error . "\n";
    }

}, 0);

/*
|--------------------------------------------------------------------------
| Loop utama dengan auto-reconnect
|--------------------------------------------------------------------------
*/
echo "MQTT Listener aktif...\n";
echo "Menunggu scan RFID...\n\n";

while (true) {
    try {
        if (!$mqtt->isConnected()) {
            echo "Reconnect MQTT...\n";
            $mqtt->connect();
        }
        $mqtt->loop(true);
    } catch (Exception $e) {
        echo "Koneksi terputus: " . $e->getMessage() . "\n";
        echo "Reconnect dalam 3 detik...\n";
        sleep(3);
        try {
            $mqtt->connect();
        } catch (Exception $e) {
            echo "Reconnect gagal: " . $e->getMessage() . "\n";
        }
    }
}