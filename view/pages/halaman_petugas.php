<?php

if (!isset($_SESSION['username']) || $_SESSION['level'] != 'pegawai') {
    header("Location: index.php?page=login&pesan=gagal");
    exit;
}

require 'config/koneksi.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Petugas - Smart Parking</title>
    <link rel="stylesheet" href="assets/css/style.css?v=3">
    <style>
        .table-wrapper {
            max-height: 300px;
            overflow-y: auto;
            overflow-x: auto;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<div class="container">

    <div class="header">
        <div>
            <h1>🅿️ Smart Parking Dashboard</h1>
            <p style="margin:5px 0; opacity:0.9;">Sistem Manajemen Parkir Motor</p>
        </div>
        <div class="user-info">
            <p style="margin:0 0 10px 0;">Selamat datang,<br>
                <strong><?php echo htmlspecialchars($_SESSION['username']); ?></strong>
            </p>
            <a href="index.php?page=logout" class="logout-btn"
               onclick="return confirm('Apakah Anda yakin ingin logout?')">Logout</a>
        </div>
    </div>

    <!-- Alert Global -->
    <div id="alertBox" class="alert" style="display:none;"></div>

    <!-- Statistik -->
    <div class="stats" id="statsContainer">
        <div class="stat-card active">
            <div class="stat-label">Sedang Parkir</div>
            <div class="stat-number" id="countActive">0</div>
        </div>
        <div class="stat-card pending">
            <div class="stat-label">Menunggu Pembayaran</div>
            <div class="stat-number" id="countPending">0</div>
        </div>
        <div class="stat-card done">
            <div class="stat-label">Transaksi Selesai</div>
            <div class="stat-number" id="countDone">0</div>
        </div>
    </div>

    <!-- TABEL IN -->
    <div class="section">
        <h2>🚗 Kendaraan Sedang Parkir (Status: IN)</h2>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Card ID</th>
                        <th>No Polisi</th>
                        <th>Waktu Masuk</th>
                        <th>Durasi Parkir</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="activeTableBody">
                    <tr><td colspan="6" class="empty-message">Belum ada kendaraan yang parkir</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- TABEL OUT / PEMBAYARAN -->
    <div class="section">
        <h2>💳 Kendaraan Siap Keluar - Pembayaran (Status: OUT)</h2>
        <p style="color:#7f8c8d; margin-top:0;">Proses pembayaran dan buka gerbang</p>
        <div id="pendingTableWrapper" class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Card ID</th>
                        <th>No Polisi</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Durasi</th>
                        <th>Biaya</th>
                        <th>Pembayaran</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody id="pendingTableBody">
                    <tr><td colspan="9" class="empty-message">Tidak ada kendaraan yang siap keluar</td></tr>
                </tbody>
            </table>
        </div>
        <div id="paymentAlert" class="alert" style="display:none;"></div>
    </div>

    <!-- TABEL HISTORY -->
    <div class="section">
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <h2>📋 Riwayat Transaksi Selesai (Status: DONE)</h2>
            <a href="controller/export_pdf.php" target="_blank"
               style="background:#e74c3c; color:white; padding:8px 15px; border-radius:5px; text-decoration:none;">
               Export PDF
            </a>
        </div>
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Card ID</th>
                        <th>No Polisi</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Durasi</th>
                        <th>Biaya</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="historyTableBody">
                    <tr><td colspan="8" class="empty-message">Belum ada transaksi selesai</td></tr>
                </tbody>
            </table>
        </div>
    </div>

</div><!-- end .container -->

<script>
// ================================================================
// HELPER
// ================================================================
function showAlert(elementId, message, type = 'info') {
    const el = document.getElementById(elementId);
    if (!el) return;
    el.textContent  = message;
    el.className    = 'alert ' + type;
    el.style.display = 'block';
}

function clearAlert(elementId) {
    const el = document.getElementById(elementId);
    if (!el) return;
    el.className     = 'alert';
    el.style.display = 'none';
}

function formatDateTime(dateString) {
    if (!dateString) return '-';
    const d = new Date(dateString);
    return d.toLocaleDateString('id-ID', {
        year:'numeric', month:'2-digit', day:'2-digit',
        hour:'2-digit', minute:'2-digit', second:'2-digit'
    });
}

function calculateDuration(checkinTime) {
    const now  = new Date();
    const diff = now - new Date(checkinTime);
    const h    = Math.floor(diff / 3600000);
    const m    = Math.floor((diff % 3600000) / 60000);
    return h + ' jam ' + m + ' menit';
}

// ✅ Hitung tampilan durasi dari menit — konsisten dengan backend
function durasiDisplay(durasiMenit) {
    const jam   = Math.floor(durasiMenit / 60);
    const menit = durasiMenit % 60;
    if (jam === 0) return menit + ' menit';
    if (menit === 0) return jam + ' jam';
    return jam + ' jam ' + menit + ' menit';
}

// ================================================================
// LOAD DATA
// ================================================================
function loadAllData() {
    loadActive();
    loadHistory();

    // ✅ Hanya reload pending jika tidak ada input pembayaran yang sedang diisi
    const focused = document.activeElement;
    const isPaymentFocused = focused && focused.id && focused.id.startsWith('amount_');
    if (!isPaymentFocused) {
        loadPending();
    }
}

function loadActive() {
    fetch('controller/get_transaksi.php?type=active')
        .then(r => r.json())
        .then(data => {
            const tbody = document.getElementById('activeTableBody');
            if (data.status !== 'success' || data.data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6" class="empty-message">Belum ada kendaraan yang parkir</td></tr>';
                document.getElementById('countActive').textContent = '0';
                return;
            }

            let html = '';
            data.data.forEach((row, idx) => {
                html += `
                    <tr>
                        <td>${idx + 1}</td>
                        <td><strong>${row.card_id}</strong></td>
                        <td><strong>${row.nopol ?? '-'}</strong></td>
                        <td>${formatDateTime(row.checkin_time)}</td>
                        <td>${calculateDuration(row.checkin_time)}</td>
                        <td><span class="status-badge status-in">${row.status}</span></td>
                    </tr>`;
            });

            tbody.innerHTML = html;
            document.getElementById('countActive').textContent = data.data.length;
        })
        .catch(err => console.error('loadActive error:', err));
}

function loadPending() {
    fetch('controller/get_transaksi.php?type=pending')
        .then(r => r.json())
        .then(data => {
            const tbody = document.getElementById('pendingTableBody');
            if (data.status !== 'success' || data.data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="9" class="empty-message">Tidak ada kendaraan yang siap keluar</td></tr>';
                document.getElementById('countPending').textContent = '0';
                return;
            }

            let html = '';
            data.data.forEach((row, idx) => {
                // ✅ Gunakan duration dari DB (dalam menit), tampilkan jam + menit
                const dur = parseInt(row.duration) || 0;

                html += `
                    <tr>
                        <td>${idx + 1}</td>
                        <td><strong>${row.card_id}</strong></td>
                        <td><strong>${row.nopol ?? '-'}</strong></td>
                        <td>${formatDateTime(row.checkin_time)}</td>
                        <td>${formatDateTime(row.checkout_time)}</td>
                        <td>${durasiDisplay(dur)}</td>
                        <td><strong>${row.fee_display}</strong></td>
                        <td>
                            <input type="number"
                                   id="amount_${row.id}"
                                   placeholder="Masukkan nominal"
                                   min="${row.fee}"
                                   style="width:140px; padding:8px; border:1px solid #bdc3c7; border-radius:4px;">
                        </td>
                        <td>
                            <button onclick="handlePayment(${row.id}, ${row.fee})"
                                    class="btn btn-danger"
                                    style="width:auto; padding:8px 12px; white-space:nowrap;">
                                💳 Bayar & Buka Palang
                            </button>
                        </td>
                    </tr>`;
            });

            tbody.innerHTML = html;
            document.getElementById('countPending').textContent = data.data.length;
        })
        .catch(err => console.error('loadPending error:', err));
}

function loadHistory() {
    fetch('controller/get_transaksi.php?type=history')
        .then(r => r.json())
        .then(data => {
            const tbody = document.getElementById('historyTableBody');
            if (data.status !== 'success' || data.data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="8" class="empty-message">Belum ada transaksi selesai</td></tr>';
                document.getElementById('countDone').textContent = '0';
                return;
            }

            let html = '';
            data.data.forEach((row, idx) => {
                html += `
                    <tr>
                        <td>${idx + 1}</td>
                        <td><strong>${row.card_id}</strong></td>
                        <td><strong>${row.nopol ?? '-'}</strong></td>
                        <td>${formatDateTime(row.checkin_time)}</td>
                        <td>${formatDateTime(row.checkout_time)}</td>
                        <td>${row.duration_display}</td>
                        <td><strong>${row.fee_display}</strong></td>
                        <td><span class="status-badge status-done">${row.status}</span></td>
                    </tr>`;
            });

            tbody.innerHTML = html;
            document.getElementById('countDone').textContent = data.data.length;
        })
        .catch(err => console.error('loadHistory error:', err));
}

// ================================================================
// HANDLE PAYMENT — ✅ kirim fee dari DB bukan hitung ulang di JS
// ================================================================
function handlePayment(transaksiId, requiredFee) {
    const amountInput = document.getElementById('amount_' + transaksiId);

    if (!amountInput || amountInput.value.trim() === '') {
        showAlert('paymentAlert', '⚠️ Masukkan nominal pembayaran terlebih dahulu', 'error');
        amountInput.focus();
        return;
    }

    const amountPaid = parseInt(amountInput.value);

    if (isNaN(amountPaid) || amountPaid <= 0) {
        showAlert('paymentAlert', '⚠️ Nominal pembayaran tidak valid', 'error');
        return;
    }

    // ✅ Validasi di sisi client — biar cepat, tidak perlu tunggu server
    if (amountPaid < requiredFee) {
        showAlert('paymentAlert',
            '⚠️ Pembayaran kurang! Biaya: Rp' + requiredFee.toLocaleString('id-ID') +
            ' | Dibayar: Rp' + amountPaid.toLocaleString('id-ID') +
            ' | Kurang: Rp' + (requiredFee - amountPaid).toLocaleString('id-ID'),
            'error');
        return;
    }

    // Buka struk dulu sebelum fetch (biar tidak diblokir popup blocker)
    window.open('controller/struk.php?id=' + transaksiId, '_blank');

    fetch('controller/handle_payment.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'transaksi_id=' + transaksiId + '&amount_paid=' + amountPaid
    })
    .then(r => r.json())
    .then(data => {
        if (data.status === 'success') {
            const kembalian = data.kembalian ?? 0;
            showAlert('paymentAlert',
                '✅ Pembayaran berhasil! ' +
                'Biaya: Rp' + (data.fee ?? requiredFee).toLocaleString('id-ID') + ' | ' +
                'Kembalian: Rp' + kembalian.toLocaleString('id-ID'),
                'success');
            loadAllData();
        } else {
            showAlert('paymentAlert', '❌ ' + data.message, 'error');
        }
    })
    .catch(err => showAlert('paymentAlert', '❌ Error koneksi: ' + err, 'error'));
}

// ================================================================
// INIT
// ================================================================
document.addEventListener('DOMContentLoaded', function () {
    loadAllData();

    // ✅ Auto-reload tiap 5 detik (dinaikkan dari 3 agar tidak terlalu agresif)
    setInterval(function () {
        if (!document.hidden) loadAllData();
    }, 5000);
});
</script>
</body>
</html>