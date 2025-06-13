<?php
session_start();
include 'koneksi.php';

if (!isset($_SESSION['user_id'])) {
    die("Akses ditolak. Silakan login.");
}

// Pastikan data dikirim via POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    die("Metode tidak diizinkan.");
}

$id_komentar = $_POST['id_komentar'] ?? null;
$id_resep = $_POST['id_resep'] ?? null;

if (!$id_komentar || !$id_resep) {
    die("Komentar tidak ditemukan.");
}

// Periksa apakah komentar milik user yang sedang login
$stmt = $koneksi->prepare("SELECT * FROM komentar WHERE id = ? AND id_user = ?");
$stmt->bind_param("ii", $id_komentar, $_SESSION['user_id']);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows < 1) {
    die("Komentar tidak ditemukan.");
}

// Hapus komentar
$delete = $koneksi->prepare("DELETE FROM komentar WHERE id = ?");
$delete->bind_param("i", $id_komentar);
$delete->execute();

header("Location: detail-resep.php?id=" . $id_resep);
exit;
?>
