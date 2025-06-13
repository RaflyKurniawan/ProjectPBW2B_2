<?php
session_start();
include 'koneksi.php';

if (!isset($_SESSION['user_id']) || empty($_POST['komentar'])) {
    header("Location: index.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$komentar = trim($_POST['komentar']);

$stmt = $koneksi->prepare("INSERT INTO komentar_web (user_id, komentar) VALUES (?, ?)");
$stmt->bind_param("is", $user_id, $komentar);
$stmt->execute();

header("Location: index.php");
exit;
