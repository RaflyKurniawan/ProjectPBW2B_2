<?php
session_start();
include 'koneksi.php';

// Ambil semua resep
$whereKategori = "";
if (isset($_GET['kategori']) && is_numeric($_GET['kategori'])) {
  $kategoriId = (int)$_GET['kategori'];
  $whereKategori = "WHERE r.id_kategori = $kategoriId";
}

$result = $koneksi->query("
  SELECT r.*, k.nama_kategori 
  FROM resep r 
  LEFT JOIN kategori k ON r.id_kategori = k.id 
  $whereKategori
  ORDER BY r.id DESC
");
$reseps = $result->fetch_all(MYSQLI_ASSOC); // Tambahkan baris ini agar $reseps tersedia

// Ambil semua komentar
$komentarResult = $koneksi->query("SELECT k.*, u.username FROM komentar_web k JOIN users u ON k.user_id = u.id ORDER BY k.created_at DESC");
$komentars = $komentarResult->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>ResepMakanan - Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: white;
      font-family: 'Segoe UI', sans-serif;
    }
    .navbar {
      background-color: #FFA07A;
    }
    .navbar-brand, .nav-link {
      color: white !important;
      font-weight: bold;
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
    .card-title {
      font-weight: bold;
      color: #2e8b57;
    }
    .footer {
      background-color: #FFA07A;
      color: white;
      padding: 10px 0;
      margin-top: 50px;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg shadow-lg">
  <div class="container ">
    <a class="navbar-brand " href="index.php">ResepMakanan</a>
    <div class="d-flex">
      <?php if (isset($_SESSION['username'])): ?>
        <a href="dashboard.php" class="btn btn-success me-2 shadow-sm">🏠 Dashboard</a>
        <a href="tambah-resep.php" class="btn btn-light me-2 shadow-sm">+ Tambah Resep</a>
        <a href="logout.php" class="btn btn-danger shadow-sm">Logout</a>
      <?php else: ?>
        <a href="login.php" class="btn btn-primary shadow-sm">Login</a>
      <?php endif; ?>
    </div>
  </div>
</nav>

<!-- Carousel -->
<?php if (!empty($reseps)): ?>
<div id="carouselResep" class="carousel slide shadow-lg" data-bs-ride="carousel">
  <div class="carousel-inner">
    <?php foreach ($reseps as $i => $r): ?>
      <div class="carousel-item <?= $i === 0 ? 'active' : '' ?>">
        <img src="images/<?= htmlspecialchars($r['gambar']) ?>" class="d-block w-100" style="height: 400px; object-fit: cover;" alt="<?= htmlspecialchars($r['judul']) ?>">
        <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 p-2 rounded">
          <h5><?= htmlspecialchars($r['judul']) ?></h5>
          <a href="detail-resep.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-orange">Lihat Resep</a>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselResep" data-bs-slide="prev">
    <span class="carousel-control-prev-icon bg-dark rounded-circle"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselResep" data-bs-slide="next">
    <span class="carousel-control-next-icon bg-dark rounded-circle"></span>
  </button>
</div>
<?php endif; ?>

<!-- Filter Form -->
<div class="container mt-4">
  <form method="GET" class="mb-3">
    <div class="input-group">
      <select name="kategori" class="form-select">
        <option value="">Semua Kategori</option>
        <?php
          $kategoriResult = $koneksi->query("SELECT * FROM kategori");
          while ($k = $kategoriResult->fetch_assoc()):
        ?>
          <option value="<?= $k['id'] ?>" <?= isset($_GET['kategori']) && $_GET['kategori'] == $k['id'] ? 'selected' : '' ?>>
            <?= htmlspecialchars($k['nama_kategori']) ?>
          </option>
        <?php endwhile; ?>
      </select>
      <button class="btn btn-orange" type="submit">Filter</button>
    </div>
  </form>
</div>

<!-- Daftar Resep -->
<div class="container mt-4 ">
  <h3 class="section-title mb-4">Daftar Resep</h3>
  <?php if (!empty($reseps)): ?>
    <p class="text-muted">Kategori: <?= htmlspecialchars($reseps[0]['nama_kategori']) ?></p>
  <?php endif; ?>

  <div class="row">
    <?php if (empty($reseps)): ?>
      <p class="text-muted">Belum ada resep ditemukan.</p>
    <?php else: ?>
      <?php foreach ($reseps as $r): ?>
        <div class="col-md-4 mb-4 ">
          <div class="card h-100 shadow-lg">
            <img src="images/<?= htmlspecialchars($r['gambar']) ?>" class="card-img-top" style="height: 200px; object-fit: cover;" alt="<?= htmlspecialchars($r['judul']) ?>">
            <div class="card-body">
              <h5 class="card-title"><?= htmlspecialchars($r['judul']) ?></h5>
              <p class="card-text"><?= substr(strip_tags($r['deskripsi']), 0, 100) ?>...</p>
              <a href="detail-resep.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-success">Detail</a>
              <?php if (isset($_SESSION['username'])): ?>
                <a href="edit-resep.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-warning">Edit</a>
                <a href="hapus-resep.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus resep ini?')">Hapus</a>
              <?php endif; ?>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    <?php endif; ?>
  </div>
</div>

<!-- Komentar Umum -->
<div class="container mt-5">
  <h3 class="section-title mb-3">Komentar Pengunjung</h3>

  <?php if (isset($_SESSION['username'])): ?>
  <form action="proses-komentar-web.php" method="POST" class="mb-4">
    <div class="mb-3">
      <textarea name="komentar" class="form-control shadow-sm" placeholder="Tulis komentar Anda..." rows="3" required></textarea>
    </div>
    <button type="submit" class="btn btn-orange shadow-sm">Kirim Komentar</button>
  </form>
  <?php else: ?>
    <p><a href="login.php">Login</a> untuk menulis komentar.</p>
  <?php endif; ?>

  <?php if (empty($komentars)): ?>
    <p class="text-muted">Belum ada komentar.</p>
  <?php else: ?>
    <?php foreach ($komentars as $k): ?>
      <div class="border rounded p-2 mb-2 shadow-sm">
        <strong><?= htmlspecialchars($k['username']) ?></strong><br>
        <small class="text-muted"><?= $k['created_at'] ?></small>
        <p><?= nl2br(htmlspecialchars($k['komentar'])) ?></p>
      </div>
    <?php endforeach; ?>
  <?php endif; ?>
</div>

<!-- Footer -->
<footer class="footer text-center">
  <div class="container">
    <p class="mb-0">© <?= date('Y') ?> ResepMakanan. Website ini disusun untuk keperluan pembelajaran</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
