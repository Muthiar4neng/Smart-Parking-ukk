<?php
require __DIR__ . '/../config/koneksi.php';

error_reporting(E_ALL);
ini_set('display_errors', 1);

$id = $_GET['id'] ?? 0;

$query = mysqli_query($koneksi, "SELECT * FROM transaksi WHERE id='$id'");

if (!$query) {
    die("Query error: " . mysqli_error($koneksi));
}

$data = mysqli_fetch_assoc($query);

if (!$data) {
    die("Data transaksi tidak ditemukan");
}
$menit = (int)$data['duration'];
$jam = floor($menit / 60);
$sisa_menit = $menit % 60;

$durasi_format = '';

if ($id == 0) {
    die("ID tidak ditemukan");
}

$durasi_format .= $sisa_menit . ' menit';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Struk Parkir</title>
    <style>
        body { font-family: monospace; width: 300px; }
        h2 { text-align: center; }
    </style>
</head>
<body onload="window.print()">
<h2>SMART PARKING</h2>
<hr>
Card ID : <?= $data['card_id'] ?><br>
No Pol  : <?= $data['nopol'] ?? '-' ?><br>
<hr>
Masuk   : <?= date('d-m-Y H:i', strtotime($data['checkin_time'])) ?><br>
Keluar  : <?= date('d-m-Y H:i', strtotime($data['checkout_time'])) ?><br>
Durasi  : <?= $durasi_format ?><br>
<hr>
Biaya   : Rp<?= number_format($data['fee'],0,',','.') ?><br>
<hr>
THANK YOU FOR PARKING HERE HELL YEAH!
</body>
</html>