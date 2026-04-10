<?php

require_once __DIR__ . '/../config/koneksi.php';

class checkoutModel {

    private $koneksi;

    public function __construct() {
        global $koneksi;
        $this->koneksi = $koneksi;
    }

    // Ambil transaksi aktif (status IN)
    public function getTransaksiAktif($card_id) {

        $stmt = $this->koneksi->prepare(
            "SELECT id, checkin_time, status 
             FROM transaksi 
             WHERE card_id = ? AND status = 'IN' 
             ORDER BY id DESC
             LIMIT 1"
        );

        $stmt->bind_param('s', $card_id);
        $stmt->execute();

        return $stmt->get_result();
    }

    // ✅ Hitung durasi & fee — per jam, ceil, minimal 1 jam, tarif 2000
    public function hitungDurasiDanFee($checkin_time) {

        $checkout_time     = date('Y-m-d H:i:s');
        $checkin_datetime  = new DateTime($checkin_time);
        $checkout_datetime = new DateTime($checkout_time);
        $interval          = $checkin_datetime->diff($checkout_datetime);

        // Total menit
        $duration_minutes = ($interval->days * 24 * 60)
                          + ($interval->h * 60)
                          + $interval->i;

        // Minimal 1 menit
        $duration_minutes = max(1, $duration_minutes);

        // ✅ ceil → 1 jam 1 menit = 2 jam | minimal 1 jam
        $duration_hours = max(1, (int) ceil($duration_minutes / 60));

        // ✅ Tarif sesuai soal Rp2.000/jam
        $fee = $duration_hours * 2000;

        return [
            'checkout_time'    => $checkout_time,
            'duration_minutes' => $duration_minutes,
            'duration_hours'   => $duration_hours,
            'fee'              => $fee,
        ];
    }

    // Update transaksi ke status OUT
    public function updateCheckout($transaksi_id, $checkout_time, $duration_minutes, $fee) {

        $stmt = $this->koneksi->prepare(
            "UPDATE transaksi 
             SET checkout_time = ?, 
                 duration      = ?, 
                 fee           = ?, 
                 status        = 'OUT' 
             WHERE id = ?"
        );

        $stmt->bind_param('siii', $checkout_time, $duration_minutes, $fee, $transaksi_id);

        return $stmt->execute();
    }

    // Insert log checkout
    public function insertLog($transaksi_id, $message, $user_id) {

        $stmt = $this->koneksi->prepare(
            "INSERT INTO logs (transaksi_id, action, message, user_id) 
             VALUES (?, 'CHECKOUT', ?, ?)"
        );

        $stmt->bind_param('isi', $transaksi_id, $message, $user_id);

        return $stmt->execute();
    }
}