<?php
session_start();
include 'koneksi.php';

if (!isset($_GET['id'])) {
    echo "<script>alert('Resep tidak ditemukan!'); window.location='index.php';</script>";
    exit();
}

$id = (int) $_GET['id'];
$stmt = $koneksi->prepare("SELECT * FROM resep WHERE id = ?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows < 1) {
    echo "<script>alert('Resep tidak ditemukan!'); window.location='index.php';</script>";
    exit();
}

$resep = $result->fetch_assoc();

// Ambil komentar resep
$stmt_kom = $koneksi->prepare("SELECT komentar.*, users.username FROM komentar 
    JOIN users ON komentar.id_user = users.id
    WHERE komentar.id_resep = ? ORDER BY komentar.tanggal DESC");
$stmt_kom->bind_param("i", $id);
$stmt_kom->execute();
$komentar_result = $stmt_kom->get_result();
$komentars = $komentar_result->fetch_all(MYSQLI_ASSOC);
$stmt_kom->close();
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($resep['judul']) ?> - Detail Resep</title>
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
        .footer {
            background-color: #FFA07A;
            padding: 20px 0;
            margin-top: 60px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg shadow-lg">
  <div class="container">
    <a class="navbar-brand" href="index.php">ResepMakanan</a>
  </div>
</nav>

<div class="container my-5">
    <div class="row">
        <div class="col-md-6">
            <img src="images/<?= htmlspecialchars($resep['gambar']) ?>" class="img-fluid rounded shadow" alt="<?= htmlspecialchars($resep['judul']) ?>">
        </div>
        <div class="col-md-6">
            <h2 class="section-title"><?= htmlspecialchars($resep['judul']) ?></h2>
            <p><strong>Deskripsi:</strong></p>
            <p><?= nl2br(htmlspecialchars($resep['deskripsi'])) ?></p>
            <p><strong>Bahan-bahan:</strong></p>
            <ul>
                <?php
                $bahan = explode("\n", $resep['bahan']);
                foreach ($bahan as $item) {
                    echo "<li>" . htmlspecialchars($item) . "</li>";
                }
                ?>
            </ul>
            <p><strong>Cara Membuat:</strong></p>
            <ol>
                <?php
                $langkah = explode("\n", $resep['langkah']);
                foreach ($langkah as $step) {
                    echo "<li>" . htmlspecialchars($step) . "</li>";
                }
                ?>
            </ol>
            <a href="index.php" class="btn btn-success mt-3">Kembali ke Beranda</a>
        </div>
    </div>

    <!-- Komentar -->
    <div class="mt-5">
        <h4>Komentar</h4>

        <?php if (isset($_SESSION['user_id'])): ?>
        <form action="proses-komentar.php" method="post" class="mb-4 ">
            <input type="hidden" name="id_resep" value="<?= $resep['id'] ?>">
            <div class="mb-2">
                <textarea name="isi" rows="3" class=" form-control shadow-sm" placeholder="Tulis komentar Anda..." required></textarea>
            </div>
            <button type="submit" class="btn btn-success shadow-sm">Kirim</button>
        </form>
        <?php else: ?>
        <p><a href="login.php">Login</a> untuk menulis komentar.</p>
        <?php endif; ?>

        <?php if (empty($komentars)): ?>
            <p class="text-muted">Belum ada komentar.</p>
        <?php else: ?>
            <?php foreach ($komentars as $kom): ?>
                <div class="border rounded p-2 mb-2 shadow-sm">
                    <strong><?= htmlspecialchars($kom['username']) ?></strong>
                    <span class="text-muted small"><?= $kom['tanggal'] ?></span>
                    <p><?= nl2br(htmlspecialchars($kom['isi'])) ?></p>
                    <?php if (isset($_SESSION['user_id']) && $_SESSION['user_id'] == $kom['id_user']): ?>
                        <form action="hapus-komentar.php" method="post" style="display:inline;" onsubmit="return confirm('Hapus komentar ini?')">
                            <input type="hidden" name="id_komentar" value="<?= $kom['id'] ?>">
                            <input type="hidden" name="id_resep" value="<?= $resep['id'] ?>">
                            <button class="btn btn-sm btn-danger">Hapus</button>
                        </form>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</div>

<!-- Footer -->
<footer class="footer mt-auto text-center text-white">
  <div class="container">
    <p class="mb-0">© <?= date('Y') ?> ResepMakanan. Dibuat untuk pembelajaran web PHP, Bootstrap, dan MySQL.</p>
  </div>
</footer>

</body>
</html>
