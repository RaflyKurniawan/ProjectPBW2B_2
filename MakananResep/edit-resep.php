<?php
include 'koneksi.php';

$error = '';
$success = '';

if (!isset($_GET['id'])) {
    header("Location: index.php");
    exit();
}

$id = $_GET['id'];

// Ambil data resep
$stmt = $koneksi->prepare("SELECT * FROM resep WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
$resep = $result->fetch_assoc();

if (!$resep) {
    die("Resep tidak ditemukan!");
}

// Ambil semua kategori
$kategori_result = $koneksi->query("SELECT * FROM kategori");

// Proses update
if (isset($_POST['update'])) {
    $judul = $_POST['judul'];
    $deskripsi = $_POST['deskripsi'];
    $bahan = $_POST['bahan'];
    $langkah = $_POST['langkah'];
    $id_kategori = $_POST['id_kategori'];

    if (empty($judul) || empty($deskripsi) || empty($bahan) || empty($langkah) || empty($id_kategori)) {
        $error = "Semua field wajib diisi!";
    } else {
        if (!empty($_FILES['gambar']['name'])) {
            $gambarName = time() . '-' . basename($_FILES['gambar']['name']);
            $gambarPath = 'images/' . $gambarName;

            if (move_uploaded_file($_FILES['gambar']['tmp_name'], $gambarPath)) {
                $stmt = $koneksi->prepare("UPDATE resep SET judul = ?, deskripsi = ?, id_kategori = ?, bahan = ?, langkah = ?, gambar = ? WHERE id = ?");
                $stmt->bind_param("ssisssi", $judul, $deskripsi, $id_kategori, $bahan, $langkah, $gambarName, $id);
                $resep['gambar'] = $gambarName;
            } else {
                $error = "Gagal upload gambar baru.";
            }
        } else {
            $stmt = $koneksi->prepare("UPDATE resep SET judul = ?, deskripsi = ?, id_kategori = ?, bahan = ?, langkah = ? WHERE id = ?");
            $stmt->bind_param("ssissi", $judul, $deskripsi, $id_kategori, $bahan, $langkah, $id);
        }

        if (empty($error) && $stmt->execute()) {
            $success = "Resep berhasil diperbarui!";
            $resep['judul'] = $judul;
            $resep['deskripsi'] = $deskripsi;
            $resep['bahan'] = $bahan;
            $resep['langkah'] = $langkah;
            $resep['id_kategori'] = $id_kategori;
        } elseif (empty($error)) {
            $error = "Gagal memperbarui resep.";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Edit Resep - ResepMakanan</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #fff;
      font-family: 'Segoe UI', sans-serif;
    }
    .navbar {
      background-color: #ffa500;
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

<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="index.php">ResepMakanan</a>
  </div>
</nav>

<div class="container mt-5 mb-5">
  <h3 class="section-title mb-4">Edit Resep: <?= htmlspecialchars($resep['judul']) ?></h3>

  <?php if (!empty($error)): ?>
      <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
  <?php elseif (!empty($success)): ?>
      <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
  <?php endif; ?>

  <form method="post" enctype="multipart/form-data">
    <div class="mb-3">
      <label class="form-label">Judul Resep</label>
      <input type="text" name="judul" class="form-control" value="<?= htmlspecialchars($resep['judul']) ?>" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Deskripsi</label>
      <textarea name="deskripsi" class="form-control" rows="3" required><?= htmlspecialchars($resep['deskripsi']) ?></textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Kategori</label>
      <select name="id_kategori" class="form-select" required>
        <option value="">-- Pilih Kategori --</option>
        <?php while ($kat = $kategori_result->fetch_assoc()): ?>
          <option value="<?= $kat['id'] ?>" <?= (int)$kat['id'] === (int)$resep['id_kategori'] ? 'selected' : '' ?>>
            <?= htmlspecialchars($kat['nama_kategori']) ?>
          </option>
        <?php endwhile; ?>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Bahan-Bahan</label>
      <textarea name="bahan" class="form-control" rows="5" required><?= htmlspecialchars($resep['bahan']) ?></textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Langkah-Langkah</label>
      <textarea name="langkah" class="form-control" rows="6" required><?= htmlspecialchars($resep['langkah']) ?></textarea>
    </div>
    <div class="mb-3">
      <label class="form-label">Gambar Resep Saat Ini</label><br>
      <img src="images/<?= htmlspecialchars($resep['gambar']) ?>" alt="Gambar Resep" width="200">
    </div>
    <div class="mb-3">
      <label class="form-label">Ganti Gambar (opsional)</label>
      <input type="file" name="gambar" class="form-control" accept="image/*">
    </div>
    <button type="submit" name="update" class="btn btn-orange">Simpan Perubahan</button>
    <a href="index.php" class="btn btn-secondary ms-2">Kembali</a>
  </form>
</div>

</body>
</html>
