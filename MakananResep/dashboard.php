<?php
session_start();
include 'koneksi.php';

if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit;
}

$role = $_SESSION['role'] ?? 'user';

// Ambil beberapa gambar resep untuk carousel
$res = $koneksi->query("SELECT id, judul, gambar FROM resep ORDER BY RAND() LIMIT 5");
$resepList = $res->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Dashboard <?= ucfirst($role) ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
            background-color:white;
            font-family: 'Segoe UI', sans-serif;
        }
        .content {
            flex: 1;
        }
        .navbar {
            background-color: #28a745;
        }
        .navbar-brand, .nav-link, .text-white {
            color: white !important;
        }
        .btn-orange {
            background-color: #ffa500;
            color: white;
        }
        .btn-orange:hover {
            background-color: #e59400;
        }
        .footer {
            background-color: #2e8b57;
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        .navbar-brand, .nav-link {
            color: white !important;
            font-weight: bold;
        }
        .carousel-item img {
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg shadow-lg" style="color: white !important; font-weight: bold;">
  <div class="container">
    <a class="navbar-brand" href="#">ResepMakanan</a>
    <div class="collapse navbar-collapse">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><span class="nav-link">👤 <?= htmlspecialchars($_SESSION['username']) ?></span></li>
        <li class="nav-item"><a class="nav-link text-white" href="logout.php">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Konten Utama -->
<div class="container mt-5 content text-center">
    <h3 class="mb-4 ">Selamat datang, <?= htmlspecialchars($_SESSION['username']) ?>!</h3>

    <!-- Carousel Resep -->
    <?php if (!empty($resepList)): ?>
    <div id="carouselResep" class="carousel slide mb-5 shadow-lg rounded-3" data-bs-ride="carousel">
        <div class="carousel-inner">
            <?php foreach ($resepList as $index => $resep): ?>
            <div class="carousel-item <?= $index === 0 ? 'active' : '' ?>">
                <img src="images/<?= htmlspecialchars($resep['gambar']) ?>" class="d-block w-100" alt="<?= htmlspecialchars($resep['judul']) ?>">
                <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded">
                    <h5><?= htmlspecialchars($resep['judul']) ?></h5>
                </div>
            </div>
            <?php endforeach; ?>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselResep" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselResep" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
    <?php endif; ?>

    <?php if ($role === 'admin'): ?>
        <a href="kelola_resep.php" class="btn btn-orange">Kelola Resep</a>
    <?php else: ?>
        <a href="index.php" class="btn btn-orange">Lihat Daftar Resep</a>
    <?php endif; ?>
</div>

<!-- Footer -->
<footer class="footer mt-auto">
  <div class="container">
    <p class="mb-0">© <?= date('Y') ?> ResepMakanan. Website ini disusun untuk keperluan pembelajaran</p>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
