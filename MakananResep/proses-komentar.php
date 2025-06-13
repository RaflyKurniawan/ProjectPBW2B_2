<?php
session_start();
include 'koneksi.php';

if (!isset($_SESSION['user_id'])) {
    echo "<script>alert('Anda harus login untuk berkomentar!'); window.location='login.php';</script>";
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_resep = (int) $_POST['id_resep'];
    $id_user = $_SESSION['user_id'];
    $isi = trim($_POST['isi']);

    if (!empty($isi)) {
        $stmt = $koneksi->prepare("INSERT INTO komentar (id_resep, id_user, isi) VALUES (?, ?, ?)");
        $stmt->bind_param("iis", $id_resep, $id_user, $isi);
        $stmt->execute();
        $stmt->close();
    }

    header("Location: detail-resep.php?id=" . $id_resep);
    exit();
}
?>

