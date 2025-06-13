<?php
session_start();
include("koneksi.php");

// Ambil semua kategori
$kategori_result = $koneksi->query("SELECT * FROM kategori ORDER BY nama ASC");
$kategoris = $kategori_result->fetch_all(MYSQLI_ASSOC);

// Ambil resep berdasarkan kategori (jika ada ID kategori yang dikirim)
$reseps = [];
$nama_kategori = 'Semua Resep';

if (isset($_GET['kategori_id']) && is_numeric($_GET['kategori_id'])) {
    $kategori_id = intval($_GET['kategori_id']);
    $stmt = $koneksi->prepare("SELECT r.*, k.nama AS nama_kategori FROM resep r JOIN kategori k ON r.kategori_id = k.id WHERE r.kategori_id = ?");
    $stmt->bind_param("i", $kategori_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $reseps = $result->fetch_all(MYSQLI_ASSOC);

    // Ambil nama kategori
    $kategori_nama_result = $koneksi->query("SELECT nama FROM kategori WHERE id = $kategori_id");
    if ($kategori_nama_result->num_rows > 0) {
        $nama_kategori = $kategori_nama_result->fetch_assoc()['nama'];
    }
} else {
    $result = $koneksi->query("SELECT r.*, k.nama AS nama_kategori FROM resep r LEFT JOIN kategori k ON r.kategori_id = k.id ORDER BY r.id DESC");
    $reseps = $result->fetch_all(MYSQLI_ASSOC);
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Kategori Resep - ResepMakanan</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background-color: #ffffff; font-family: 'Segoe UI', sans-serif; }
    .navbar { background-color: #28a745; }
    .navbar-brand, .nav-link { color: white !important; font-weight: bold; }
    .btn-orange { background-color: #ffa500; color: white; }
    .btn-orange:hover { background-color: #e59400; }
    .section-title { color: #2e8b57; font-weight: bold; }
    .footer { background-color: #2e8b57; color: white; padding: 20px 0; margin-top: 50px; }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="index.php">ResepMakanan</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <?php if (isset($_SESSION['username'])): ?>
          <li class="nav-item"><a class="nav-link" href="dashboard.php">Dashboard</a></li>
          <li class="nav-item"><a class="nav-link" href="logout.php">Logout</a></li>
        <?php else: ?>
          <li class="nav-item"><a class="nav-link" href="login.php">Login</a></li>
        <?php endif; ?>
      </ul>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <h3 class="section-title mb-3">Kategori Resep</h3>

  <div class="mb-4">
    <?php foreach ($kategoris as $kat): ?>
      <a href="kategori.php?kategori_id=<?= $kat['id'] ?>" class="btn btn-sm btn-outline-success me-2 mb-2"><?= htmlspecialchars($kat['nama']) ?></a>
    <?php endforeach; ?>
    <a href="kategori.php" class="btn btn-sm btn-outline-secondary mb-2">Semua Resep</a>
  </div>

  <h4 class="mb-4"><?= htmlspecialchars($nama_kategori) ?></h4>

  <div class="row">
    <?php if (empty($reseps)): ?>
      <p class="text-muted">Tidak ada resep untuk kategori ini.</p>
    <?php else: ?>
      <?php foreach ($reseps as $r): ?>
        <div class="col-md-4 mb-4">
          <div class="card h-100 shadow-sm">
            <img src="images/<?= htmlspecialchars($r['gambar']) ?>" class="card-img-top" style="height: 200px; object-fit: cover;" alt="<?= htmlspecialchars($r['judul']) ?>">
            <div class="card-body">
              <h5 class="card-title"><?= htmlspecialchars($r['judul']) ?></h5>
              <p class="card-text"><?= substr(strip_tags($r['deskripsi']), 0, 100) ?>...</p>
              <a href="detail-resep.php?id=<?= $r['id'] ?>" class="btn btn-sm btn-orange">Lihat Resep</a>
            </div>
          </div>
        </div>
      <?php endforeach; ?>
    <?php endif; ?>
  </div>
</div>

<!-- Footer -->
<footer class="footer text-center mt-5">
  <div class="container">
    <p class="mb-0">© <?= date('Y') ?> ResepMakanan. Dibuat untuk pembelajaran web PHP, Bootstrap, dan MySQL.</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
