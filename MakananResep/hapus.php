<?php
include 'koneksi.php';
$resep = [];
if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $query = "SELECT * FROM resep WHERE id=$id";
    $result = mysqli_query($conn, $query);
    if ($result) {
        $resep = mysqli_fetch_assoc($result);
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <title>Detail Resep - ResepKoki</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #ffffff;
      font-family: Arial, sans-serif;
    }
    .navbar {
      background-color: #28a745;
    }
    .navbar-brand {
      color: white;
      font-weight: bold;
    }
    .btn-orange {
      background-color: #ffa500;
      color: white;
    }
    .btn-orange:hover {
      background-color: #e59400;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.php">ResepKoki</a>
  </div>
</nav>

<div class="container my-5">
  <?php if (!empty($resep)): ?>
    <div class="card">
      <img src="<?= htmlspecialchars($resep['gambar']) ?>" class="card-img-top" alt="<?= htmlspecialchars($resep['judul']) ?>">
      <div class="card-body">
        <h3 class="card-title text-success"><?= htmlspecialchars($resep['judul']) ?></h3>
        <p><strong class="text-orange">Bahan:</strong><br><?= nl2br(htmlspecialchars($resep['bahan'])) ?></p>
        <p><strong class="text-orange">Langkah:</strong><br><?= nl2br(htmlspecialchars($resep['langkah'])) ?></p>
        <a href="index.php" class="btn btn-secondary">Kembali</a>
      </div>
    </div>
  <?php else: ?>
    <div class="alert alert-warning text-center">Resep tidak ditemukan.</div>
  <?php endif; ?>
</div>

</body>
</html>
