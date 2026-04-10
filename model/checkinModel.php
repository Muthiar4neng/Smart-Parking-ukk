<?php

require_once __DIR__ . '/../config/koneksi.php';

class checkinModel {

    private $koneksi;

    public function __construct() {
        global $koneksi;
        $this->koneksi = $koneksi;
    }

    // ===============================
    // Cek apakah kartu masih aktif
    // ===============================
    public function cekKartuAktif($card_id) {

        $stmt = $this->koneksi->prepare(
            "SELECT id 
             FROM transaksi 
             WHERE card_id = ? 
             AND status IN ('IN','OUT') 
             LIMIT 1"
        );

        if (!$stmt) {
            error_log("Prepare error cekKartuAktif: " . $this->koneksi->error);
            return false;
        }

        $stmt->bind_param('s', $card_id);
        $stmt->execute();

        return $stmt->get_result();
    }

    // ===============================
    // Insert transaksi check-in
    // ===============================
    public function insertCheckin($card_id, $nopol, $checkin_time) {

        $stmt = $this->koneksi->prepare(
            "INSERT INTO transaksi (card_id, nopol, checkin_time, status) 
             VALUES (?, ?, ?, 'IN')"
        );

        if (!$stmt) {
            error_log("Prepare error insertCheckin: " . $this->koneksi->error);
            return false;
        }

        $stmt->bind_param('sss', $card_id, $nopol, $checkin_time);

        if ($stmt->execute()) {
            return $this->koneksi->insert_id;
        }

        error_log("Execute error insertCheckin: " . $stmt->error);
        return false;
    }

    // ===============================
    // Insert log aktivitas
    // ===============================
    public function insertLog($transaksi_id, $message, $user_id) {

        $stmt = $this->koneksi->prepare(
            "INSERT INTO logs (transaksi_id, action, message, user_id) 
             VALUES (?, 'CHECKIN', ?, ?)"
        );

        if (!$stmt) {
            error_log("Prepare error insertLog: " . $this->koneksi->error);
            return false;
        }

        $stmt->bind_param('isi', $transaksi_id, $message, $user_id);

        return $stmt->execute();
    }
}
?>