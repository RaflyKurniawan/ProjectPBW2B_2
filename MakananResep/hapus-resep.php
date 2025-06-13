<?php
include 'koneksi.php';

if (isset($_GET['id'])) {
    $id = intval($_GET['id']);

    // Ambil nama file gambar sebelum dihapus
    $stmt = $koneksi->prepare("SELECT gambar FROM resep WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $resep = $result->fetch_assoc();
        $gambar = $resep['gambar'];

        // Hapus data dari database
        $delStmt = $koneksi->prepare("DELETE FROM resep WHERE id = ?");
        $delStmt->bind_param("i", $id);
        if ($delStmt->execute()) {
            // Hapus gambar dari folder jika ada
            if (!empty($gambar) && file_exists("images/$gambar")) {
                unlink("images/$gambar");
            }
        }

        $delStmt->close();
    }

    $stmt->close();
}

// Redirect kembali ke index
header("Location: index.php");
exit();
