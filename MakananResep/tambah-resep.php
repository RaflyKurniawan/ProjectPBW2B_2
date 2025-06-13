<?php
include 'koneksi.php';

$error = '';
$success = '';

if (isset($_POST['submit'])) {
    $judul = trim($_POST['judul']);
    $deskripsi = trim($_POST['deskripsi']);
    $bahan = trim($_POST['bahan']);
    $langkah = trim($_POST['langkah']);
    $id_kategori = isset($_POST['id_kategori']) ? (int)$_POST['id_kategori'] : 0;
    $gambar = $_FILES['gambar'];

    // Validasi form
    if (empty($judul) || empty($deskripsi) || empty($bahan) || empty($langkah) || empty($gambar['name']) || $id_kategori == 0) {
        $error = "Semua field wajib diisi!";
    } else {
        $gambarName = time() . '-' . basename($gambar['name']);
        $gambarPath = 'images/' . $gambarName;

        if (move_uploaded_file($gambar['tmp_name'], $gambarPath)) {
            $stmt = $koneksi->prepare("INSERT INTO resep (judul, deskripsi, id_kategori, bahan, langkah, gambar) VALUES (?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssisss", $judul, $deskripsi, $id_kategori, $bahan, $langkah, $gambarName);

            if ($stmt->execute()) {
                $success = "Resep berhasil ditambahkan!";
            } else {
                $error = "Gagal menambahkan resep.";
            }
            $stmt->close();
        } else {
            $error = "Gagal mengupload gambar.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Tambah Resep - ResepMakanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff;
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            background-color: #FFA07A;
        }
        .navbar-brand {
            font-weight: bold;
            color: white !important;
        }
        .btn-orange {
            background-color: #ffa500;
            color: white;
        }
        .btn-orange:hover {
            background-color: #e59400;
        }
        .section-title {
            color: #2e8b57;
            font-weight: bold;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg shadow-lg">
  <div class="container">
    <a class="navbar-brand" href="index.php">ResepMakanan</a>
  </div>
</nav>

<div class="container mt-5 mb-5">
    <h3 class="section-title mb-4">Tambah Resep Baru</h3>

    <?php if (!empty($error)): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
    <?php elseif (!empty($success)): ?>
        <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
    <?php endif; ?>

    <form method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Judul Resep</label>
            <input type="text" name="judul" class="shadow-sm form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Deskripsi Singkat</label>
            <textarea name="deskripsi" class="form-control shadow-sm " rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Kategori Resep</label>
            <select name="id_kategori" class="form-select shadow-sm " required>
                <option value="">-- Pilih Kategori --</option>
                <?php
                $result = $koneksi->query("SELECT id, nama_kategori FROM kategori");
                while ($row = $result->fetch_assoc()) {
                    echo "<option value='" . $row['id'] . "'>" . htmlspecialchars($row['nama_kategori']) . "</option>";
                }
                ?>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Bahan-Bahan (pisahkan per baris)</label>
            <textarea name="bahan" class="form-control shadow-sm " rows="5" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Langkah-Langkah (pisahkan per baris)</label>
            <textarea name="langkah" class="form-control shadow-sm " rows="6" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Gambar Resep</label>
            <input type="file" name="gambar" class="form-control shadow-sm " accept="image/*" required>
        </div>
        <button type="submit" name="submit" class="btn btn-orange shadow-sm ">Tambah Resep</button>
        <a href="index.php" class="btn btn-secondary ms-2 shadow-sm ">Kembali</a>
    </form>
</div>

</body>
</html>
