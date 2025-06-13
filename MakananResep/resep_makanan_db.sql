-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 13 Jun 2025 pada 16.15
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `resep_makanan_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`) VALUES
(1, 'Makanan Berat'),
(2, 'Makanan Ringan'),
(3, 'Minuman'),
(4, 'Cemilan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_resep` int(11) NOT NULL,
  `isi` text NOT NULL,
  `tanggal` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `komentar`
--

INSERT INTO `komentar` (`id`, `id_user`, `id_resep`, `isi`, `tanggal`) VALUES
(1, 5, 7, 'asdfasdf', '2025-06-13 00:07:20'),
(2, 5, 7, 'Nasi goreng ini sangat enak', '2025-06-13 00:07:40'),
(15, 1, 11, 'Es coklat ini sangat bikin nagih', '2025-06-13 00:21:28'),
(19, 1, 7, 'Aku mau nasi goreng mawut lima', '2025-06-13 01:14:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `komentar_web`
--

CREATE TABLE `komentar_web` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `komentar` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `komentar_web`
--

INSERT INTO `komentar_web` (`id`, `user_id`, `komentar`, `created_at`) VALUES
(2, 1, 'aku mau lima', '2025-06-12 06:04:28'),
(6, 1, 'Aku mau es Lemon sepuluh', '2025-06-12 16:10:04'),
(7, 6, 'Aku mw es Coklat lima', '2025-06-12 18:01:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `resep`
--

CREATE TABLE `resep` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `kategori` varchar(100) DEFAULT NULL,
  `bahan` text NOT NULL,
  `langkah` text NOT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `resep`
--

INSERT INTO `resep` (`id`, `judul`, `deskripsi`, `kategori`, `bahan`, `langkah`, `gambar`, `id_kategori`) VALUES
(3, 'Mi ayam Bakso', 'Mie ayam Bakso khas Indonesia yang dibuat oleh Mbak Is', NULL, 'Bakso\r\nMie ayam\r\nSayur\r\nGaram\r\nMicin\r\nKuah', 'rebus mie selama 1 jam\r\ntambahkan bakso\r\nsiap disajikan', '1749707877-626b9789cdf4e.jpg', NULL),
(7, 'Nasi Goreng Mawut', 'Nasi goreng dengan mi yang enak', NULL, 'Nasi\r\nAyam Suwir\r\nGaram\r\nmicin\r\nKecap\r\nTelur', 'Potong bawang\r\nPanaskan minyak\r\nGoreng telur', '1749744111-066337300_1652629907-shutterstock_1642004404.jpg', 1),
(8, 'Terang Bulan', 'Terang Bulan adalah kudapan manis khas Indonesia yang terbuat dari adonan tepung terigu, gula, telur, dan ragi, kemudian dipanggang hingga mengembang dan empuk. Bagian dalamnya diberi aneka isian seperti cokelat, keju, kacang, atau susu kental manis, lalu dilipat menjadi setengah lingkaran. Rasanya lembut, manis, dan cocok disantap hangat sebagai camilan sore hari.', NULL, '250 gram tepung terigu protein sedang\r\n50 gram gula pasir\r\n1 butir telur\r\n1/2 sdt ragi instan\r\n1/2 sdt baking powder\r\n1/4 sdt garam\r\n300 ml air (bisa dicampur dengan susu cair jika ingin lebih gurih)\r\n1/2 sdt vanili (opsional)\r\nBahan Isian (sesuai selera)\r\nMargarin (untuk olesan)\r\nGula pasir\r\nMeses cokelat\r\nKeju parut\r\nKacang tanah sangrai cincang\r\nSusu kental manis', 'Campur bahan kering\r\nTambahkan telur dan air\r\nDiamkan adonan\r\nPanaskan wajan\r\nMasak hingga matang\r\nAngkat dan beri topping\r\nLipat dan sajikan', '1749744400-038150700_1621396050-shutterstock_1853131849.jpg', 4),
(9, 'Es Lemon Madu Segar', 'Minuman segar perpaduan lemon dan madu yang menyegarkan, cocok dinikmati saat cuaca panas untuk menyegarkan tenggorokan dan meningkatkan daya tahan tubuh.', NULL, '1 buah lemon\r\n2 sdm madu\r\n200 ml air dingin\r\nEs batu secukupnya', 'Peras air lemon ke dalam gelas.\r\nTambahkan madu dan aduk hingga larut.\r\nTuang air dingin dan aduk rata.\r\nTambahkan es batu, sajikan segera.', '1749744576-643635f945ff2.jpeg', 3),
(10, 'Stik Talas Renyah', 'Stik talas adalah camilan gurih dan renyah yang terbuat dari talas yang diiris tipis memanjang, cocok untuk teman santai atau suguhan tamu.', NULL, '500 gram talas\r\n1/2 sdt garam\r\n1/4 sdt bawang putih bubuk (opsional)\r\nMinyak untuk menggoreng', 'Kupas dan cuci talas, lalu iris tipis memanjang seperti korek api.\r\nRendam dalam air garam selama 10 menit, tiriskan dan keringkan.\r\nPanaskan minyak, goreng stik talas hingga kuning keemasan dan renyah.\r\nAngkat, tiriskan, dan biarkan dingin sebelum disimpan.', '1749745803-16533825311.jpg', 4),
(11, 'Es Cokelat Susu', 'Minuman manis dan menyegarkan dari perpaduan cokelat bubuk dan susu, cocok dinikmati dingin sebagai pelepas dahaga dan penambah semangat.', NULL, '2 sdm cokelat bubuk\r\n2 sdm susu kental manis\r\n200 ml air dingin\r\nEs batu secukupnya', 'Campurkan cokelat bubuk dan susu kental manis dalam gelas.\r\nTambahkan sedikit air hangat, aduk hingga larut.\r\nTuang air dingin, aduk rata.\r\nMasukkan es batu dan sajikan.', '1749746018-498208b211df5c0a3a1dd1a164343eb1.jpg', 3),
(12, 'Tteokbokki', 'Perpaduan kue beras dan saus gochujang', NULL, '300g tteok (kue beras)\r\n500ml air\r\n2 sdm gochujang (pasta cabai Korea)\r\n1 sdm gochugaru (bubuk cabai Korea)\r\n1 sdm kecap asin\r\n1 sdm gula pasir\r\n2 siung bawang putih (cincang)\r\n1 batang daun bawang (iris)\r\nFish cake (opsional)', 'Rebus air\r\nMasukkan gochujang, gochugaru, kecap asin, gula, dan bawang putih. kemudian Aduk rata\r\nTambahkan tteok dan masak selama 10-15 menit hingga empuk dan kuah mengental\r\nMasukkan fish cake dan daun bawang, masak 2-3 menit lagi\r\nSajikan panas.', '1749786565-IMG-20250613-WA0026.jpg', 2),
(13, 'Chicken Katsu', 'Ayam fillet yang digoreng dengan tepung roti', NULL, '2 dada ayam tanpa tulang\r\nGaram dan merica secukupnya\r\nTepung terigu, telur, dan tepung roti (panko)\r\nMinyak goreng', 'Iris ayam menjadi lebar dan pipihkan.\r\nBumbui dengan garam dan merica.\r\nBalur ayam ke tepung terigu, celup ke telur, lalu lumuri tepung roti.\r\nGoreng dalam minyak panas hingga keemasan.\r\nSajikan dengan nasi dan saus tonkatsu.', '1749786801-IMG-20250613-WA0027.jpg', 1),
(14, 'Chicken Popcorn', 'Ayam balur tepung krispy yang nikmat', NULL, '300g dada ayam fillet, potong kecil\r\n1 butir telur\r\n3 sdm tepung terigu\r\n2 sdm maizena\r\nBumbu: garam, merica, bawang putih bubuk, paprika bubuk', 'Campur ayam dengan bumbu dan telur.\r\nGulingkan ke campuran tepung terigu dan maizena.\r\nGoreng dalam minyak panas sampai garing dan matang.\r\nTiriskan dan sajikan hangat.', '1749786917-IMG-20250613-WA0024.jpg', 1),
(15, 'Rawon', 'Rawon Khas Jawa Timur', NULL, '500g daging sapi (sandung lamur)\r\n2 liter air\r\n4 butir keluak (ambil isinya)\r\n6 siung bawang merah\r\n4 siung bawang putih\r\n2 cm kunyit, jahe, dan lengkuas\r\n1 batang serai, daun jeruk\r\nGaram, gula, dan merica\r\nMinyak untuk menumis', 'Rebus daging sapi hingga empuk. \r\nKemudian Potong dadu.\r\nHaluskan bumbu: keluak, bawang merah, putih, kunyit, jahe, dll.\r\nTumis bumbu hingga harum \r\nMasukkan ke dalam kuah\r\nTambahkan serai, daun jeruk\r\nMasak hingga kuah menghitam dan beraroma.\r\nSajikan dengan nasi, tauge, telur asin, dan sambal.', '1749786989-IMG-20250613-WA0040.jpg', 1),
(16, 'Soto Lamongan', 'Soto yang nikmat khas dari lamongan', NULL, '1 ekor ayam (potong 4)\r\n2 liter air\r\n4 lembar daun jeruk, 2 batang serai, lengkuas geprek\r\n1 bungkus koya (bisa buat dari kerupuk udang dan bawang putih goreng)\r\nBumbu halus:\r\n8 bawang merah \r\n4 bawang putih\r\n3 kemiri sangrai\r\n2 cm kunyit bakar\r\n1 sdt merica\r\nGaram\r\nKaldu bubuk secukupnya', 'Rebus ayam\r\nAmbil kaldunya\r\nTumis bumbu halus hingga harum\r\nMasukkan ke dalam kaldu.\r\nTambahkan daun jeruk, serai, dan lengkuas.\r\nSuwir ayam dan sajikan dengan soun, kol, telur rebus, koya, dan sambal.', '1749787103-IMG-20250613-WA0036.jpg', 1),
(17, 'Spaghetti Bolognese', 'Makanan khas italia', NULL, '200g spaghetti\r\n300g daging cincang\r\n1 bawang bombay, 2 siung bawang putih\r\n4 tomat matang atau saus tomat\r\n1 sdm pasta tomat\r\nGula, garam, merica, oregano\r\nMinyak zaitun', 'Rebus spaghetti sampai al dente.\r\nTumis bawang bombay dan bawang putih.\r\nMasukkan daging, masak hingga berubah warna.\r\nTambahkan tomat, pasta tomat, dan bumbu. \r\nMasak hingga mengental.\r\nSajikan saus di atas spaghetti\r\n Taburi keju parmesan jika suka.', '1749787319-IMG-20250613-WA0025.jpg', 2),
(18, 'Kimbab', 'Nasi yang digulung dengan nori dengan berbagai macam isian', NULL, 'Nasi pulen + sedikit minyak wijen & garam\r\nNori (rumput laut kering)\r\nTelur dadar, timun, wortel, sosis atau crab stick, bayam', 'Tumis sayuran sebentar dan potong memanjang.\r\nLetakkan nori di atas makisu (alas gulung).\r\nRatakan nasi, beri isian, lalu gulung sambil ditekan.\r\nPotong dan sajikan.', '1749787462-IMG-20250613-WA0023.jpg', 2),
(19, 'Ayam Betutu Bali', 'Ayam bumbu yang berasal dari bali nikmat disajikan saat hangat', NULL, '1 ekor ayam utuh\r\n1 ikat daun singkong (opsional)\r\nBumbu halus:\r\n10 bawang merah, 6 bawang putih\r\n4 kemiri, 2 cm kunyit, jahe, lengkuas\r\nCabai rawit & merah sesuai selera\r\n1 sdt terasi, garam, gula, merica', 'Tumis bumbu hingga harum\r\nSisihkan sebagian untuk diisi ke dalam ayam.\r\nLumuri dan isi ayam dengan bumbu, tambahkan daun singkong.\r\nBungkus dengan daun pisang, kukus 1 jam, lalu panggang sampai matang.', '1749787560-IMG-20250613-WA0020.jpg', 1),
(20, 'Nasi Kebuli', 'Makanan khas timur dengan dengan bumbu yang kuat', NULL, '2 cup beras basmati\r\n300g daging kambing/ayam, potong kecil\r\n500 ml kaldu\r\n1 sdm bumbu kari/kebuli instan atau campuran rempah: kapulaga, kayu manis, cengkeh, jintan\r\nBumbu halus:\r\nBawang merah, bawang putih, ketumbar, kunyit, jahe', 'Tumis bumbu halus dan rempah hingga harum.\r\nMasukkan daging, aduk rata.\r\nTambahkan beras dan kaldu. Masak hingga air habis.\r\nKukus hingga nasi matang dan wangi.', '1749787761-IMG-20250613-WA0021.jpg', 1),
(21, 'Gudeg', 'Makanan khas jogja yang memiliki rasa agak manis', NULL, '500g nangka muda, potong-potong\r\n500 ml santan\r\n100g gula merah\r\n4 lembar daun salam, 2 lengkuas geprek\r\nBumbu halus:\r\n6 bawang meah\r\n3 bawang putih\r\n2 kemiri, ketumbar, garam', 'Rebus nangka setengah empuk.\r\nTumis bumbu hingga harum, masukkan nangka, gula merah, santan, dan daun salam.\r\nMasak dengan api kecil 3–4 jam sampai meresap dan kecokelatan.\r\nSajikan dengan sambal krecek, telur, dan ayam.', '1749787828-IMG-20250613-WA0019.jpg', 1),
(22, 'Chicken Cordon Bleu', 'Ayam tepung yang memiliki isian keju dan beef', NULL, '2 dada ayam fillet, pipihkan\r\n2 lembar keju cheddar\r\n2 lembar smoked beef\r\nTepung, telur, tepung roti', 'Isi ayam dengan keju dan smoked beef, gulung \r\nTusuk dengan tusuk gigi.\r\nBalur tepung, celup telur, dan tepung roti.\r\nGoreng dengan minyak agak banyak sampai matang.', '1749787921-IMG-20250613-WA0017.jpg', 1),
(23, 'Chicken Wings', 'ayam sayap dengan saus pedas manis', NULL, '500g chicken wings\r\nMarinasi: garam, merica, bawang putih bubuk\r\nSaus (opsi):\r\nSaus pedas manis: saus tomat + sambal + madu\r\nSaus BBQ: BBQ sauce + madu', 'Marinasi ayam minimal 1 jam.\r\nGoreng atau oven panggang sampai garing.\r\nBalurkan saus dan sajikan panas.', '1749788060-IMG-20250613-WA0016.jpg', 1),
(24, 'Nasi Padang', 'Nasi khas padang', NULL, '2 gelas beras\r\n3 gelas air\r\n1 batang serai, memarkan\r\n2 lembar daun pandan (opsional)\r\nSejumput garam\r\nGulai Ayam Padang\r\nBahan:\r\n500 gram ayam, potong sesuai selera\r\n500 ml santan sedang\r\n2 lembar daun salam\r\n2 lembar daun jeruk\r\n1 batang serai, memarkan\r\n1 ruas lengkuas, memarkan\r\nGaram dan gula secukupnya\r\nBumbu halus:\r\n5 siung bawang merah\r\n3 siung bawang putih\r\n3 buah cabai merah besar\r\n2 butir kemiri\r\n1 ruas kunyit\r\n1 ruas jahe\r\n1 sdt ketumbar', 'Cuci beras hingga bersih.\r\nMasukkan ke dalam rice cooker bersama serai, daun pandan, dan garam.\r\nMasak hingga matang dan harum.\r\nTumis bumbu halus bersama daun salam, daun jeruk, serai, dan lengkuas hingga harum.\r\nMasukkan ayam, aduk hingga ayam berubah warna.\r\nTuang santan, masak dengan api kecil sampai ayam empuk dan bumbu meresap.\r\nKoreksi rasa, masak hingga kuah mengental.', '1749788416-IMG-20250613-WA0037.jpg', 1),
(25, 'Ayam Goreng serai', 'Ayam yang digoreng dengan bumbu serai', NULL, '500g ayam, potong-potong\r\n3 batang serai, iris halus\r\nBumbu halus: bawang merah, bawang putih, ketumbar, kunyit, garam', 'Ungkep ayam dengan bumbu dan serai hingga empuk.\r\nGoreng ayam dan serainya sampai garing.\r\nSajikan dengan nasi hangat dan sambal.', '1749788634-IMG-20250613-WA0039.jpg', 1),
(26, 'Tempe Mendoan', 'Tempe yang diiris tipis dibalu tepung dan digoreng setengah matang', NULL, 'Tempe tipis\r\nTepung: 5 sdm terigu + 1 sdm tepung beras + air\r\nDaun bawang iris, bawang putih halus, ketumbar, garam', 'Campur semua bahan, buat adonan agak encer.\r\nCelupkan tempe dan goreng sebentar (setengah matang, lembek).\r\nSajikan dengan sambal kecap.', '1749788798-IMG-20250613-WA0038.jpg', 2),
(27, 'Ayam Suwir Pedas', 'Ayam yang disuwir kecil kemudian ditambah rempah', NULL, '300g dada ayam rebus, suwir\r\nBumbu ulek: cabai merah, bawang merah, bawang putih, tomat', 'Tumis bumbu sampai matang.\r\nMasukkan ayam suwir, aduk rata, bumbui gula garam.\r\nMasak hingga agak kering dan bumbu meresap.', '1749788862-IMG-20250613-WA0035.jpg', 1),
(28, 'Tamago sandwich', 'Roti lapis khas jepang yang dibalur telur dan mayones', NULL, '4 butir telur\r\n2 sdm mayones\r\nGaram, lada\r\nRoti tawar tanpa kulit', 'Rebus telur, kupas, hancurkan.\r\nCampur dengan mayones, garam, dan lada.\r\nOleskan pada roti, tutup, dan potong segitiga.', '1749789050-IMG-20250613-WA0015.jpg', 2),
(29, 'Puding Coklat Susu Lapis', 'puding rasa coklat dan vanila', NULL, '1 bungkus agar-agar coklat\r\n500ml susu cair\r\n100g gula\r\nLapisan susu:\r\n1 bungkus agar-agar putih\r\n500ml susu cair\r\n100g gula', 'Masak lapisan coklat, tuang ke cetakan, tunggu setengah mengeras.\r\nMasak lapisan susu, tuang perlahan di atas coklat.\r\nDinginkan dan sajikan.', '1749789120-IMG-20250613-WA0053.jpg', 4),
(30, 'Puding Mangga', 'Puding dengan rasa mangga yang manis', NULL, '1 buah mangga besar (blender)\r\n1 bungkus agar-agar bening\r\n500ml air\r\n100g gula', 'Masak semua bahan hingga mendidih.\r\nTuang ke cetakan, dinginkan hingga set.', '1749789169-IMG-20250613-WA0013.jpg', 4),
(31, 'Garlic Bread', 'Roti baquette dengan lapisan mentega dan bawang putih', NULL, 'Roti baguette/roti tawar tebal\r\n3 siung bawang putih (haluskan)\r\n50g mentega\r\n1 sdm parsley kering', 'Campur mentega, bawang, dan parsley.\r\nOleskan ke roti\r\nPanggang 10 menit di oven 180°C.', '1749789419-IMG-20250613-WA0011.jpg', 4),
(32, 'Tiramisu Cup', 'Camilan manis dengan paduan rasa kopi dan coklat', NULL, '200g cream cheese\r\n200ml whipped cream\r\n5 sdm gula\r\nLady finger\r\nKopi hitam + sedikit rum (opsional)\r\nCoklat bubuk', 'Kocok cream cheese, gula, dan whipped cream.\r\nCelup lady finger ke kopi\r\nKemuadian susun di cup.\r\nTambah cream, ulangi, taburi bubuk coklat.', '1749789543-IMG-20250613-WA0014.jpg', 4),
(33, 'Fudgy Brownies', 'Brownis panggang dengan rasa coklat yang otentik', NULL, '150g dark chocolate\r\n100g mentega\r\n150g gula\r\n2 telur\r\n50g tepung\r\n2 sdm coklat bubuk', 'Lelehkan coklat dan mentega.\r\nKocok telur dan gula \r\ncampur semua bahan.\r\nTuang ke loyang, panggang 170°C selama 25–30 menit.', '1749789792-1749789516-IMG-20250613-WA0050.jpg', 4),
(34, 'Blueberry Cheesecake (No Bake)', 'Camilan enak tanpa oven', NULL, 'Bahan dasar:\r\n150g biskuit + 50g mentega (hancur dan padatkan)\r\nIsi:\r\n250g cream cheese\r\n200ml whipped cream\r\n100g gula\r\n1 sdt gelatin + 2 sdm air panas\r\nBlueberry jam', 'Campur semua bahan isi\r\nKemudian tuang di atas dasar.\r\nDinginkan selama 4 jam\r\nDan beri topping blueberry.', '1749789908-IMG-20250613-WA0010.jpg', 4),
(35, 'Puding Karamel', 'Puding karamel khas jepang', NULL, '3 telur\r\n500ml susu cair\r\n100g gula\r\n1 sdt vanila\r\nKaramel:\r\n100g gula + 3 sdm air (masak hingga kecoklatan)', 'Tuang karamel ke cetakan.\r\nCampur bahan puding, tuang ke cetakan.\r\nKukus ±30 menit. Dinginkan.', '1749790021-IMG-20250613-WA0052.jpg', 4),
(36, 'Cookies and Cream Cupcake', 'Minuman dengan rasa oreo yang lezat', NULL, '150g tepung terigu\r\n100g gula\r\n2 telur\r\n100ml susu\r\n100g mentega cair\r\nOreo hancur', 'Campur semua bahan, tuang ke cup.\r\nPanggang 180°C selama 20–25 menit.', '1749790103-IMG-20250613-WA0051.jpg', 4),
(37, 'Chocolate Chip Cookies', 'Kukis dengan taburan choco chips menjadikan rasanya balance', NULL, '150g mentega\r\n100g gula pasir + 100g gula palem\r\n1 telur\r\n200g tepung\r\n1 sdt baking soda\r\n100g chocolate chips', 'Kocok mentega dan gula\r\ntambahkan telur \r\nlalu tepung dan choco chips.\r\nBentuk bulatan dan panggang 170°C selama 15 menit.', '1749790187-IMG-20250613-WA0012.jpg', 4),
(38, 'Es Kacang Hijau', 'Bubur kacang hijau yang disajikan dengan es', NULL, '250g kacang hijau (rendam semalam)\r\n150g gula\r\n1 liter air\r\nSantan + garam\r\nEs batu', 'Rebus kacang hijau hingga empuk, tambahkan gula.\r\nSajikan dengan es dan santan.', '1749790288-IMG-20250613-WA0033.jpg', 3),
(39, 'Roti Bakar', 'Roti dengan selai coklat yang manis dan dipanggang dengan margarin', NULL, 'Roti tawar\r\nMargarin\r\nTopping: selai coklat, susu kental manis', 'Olesi roti dengan margarin, panggang.\r\nTambahkan topping sesuai selera.', '1749790447-IMG-20250613-WA0029.jpg', 4),
(40, 'Dadar Gulung Coklat Pisang', 'Pisang dan coklat yang digulung', NULL, 'Kulit:\r\n100g tepung terigu, 1 sdm coklat bubuk, air, garam\r\nIsi:\r\nPisang kepok, potong dan goreng atau kukus', 'Buat kulit dadar tipis.\r\nBungkus pisang dan tambhakan coklat\r\nlipat seperti lumpia.', '1749790787-WhatsApp Image 2025-06-13 at 11.58.25_e039f4a0.jpg', 4),
(41, 'Strawberry Milk', 'susu dengan paduan selai strawberry', NULL, '100g stroberi, 2 sdm gula\r\n200ml susu cair dingin', 'Masak stroberi dan gula hingga menjadi selai.\r\nTuang ke gelas, tambahkan es dan susu.', '1749791007-IMG-20250613-WA0049.jpg', 3),
(42, 'Lemon Tea', 'es lemon segar dengan tambahan rasa lemon', NULL, '1 kantong teh\r\n200ml air panas\r\n1 sdm perasan lemon, gula sesuai selera', 'Seduh teh, dinginkan.\r\nTambahkan perasan lemon, gula, dan es.', '1749791082-IMG-20250613-WA0034.jpg', 3),
(43, 'Kopi Susu Gula Aren', 'Kopi dengan perpaduan susu dan gula aren', NULL, '1 shot espresso / 2 sdt kopi instan\r\n100ml susu cair\r\n2 sdm gula aren cair', 'Tuang gula aren ke gelas, tambahkan es.\r\nTambah susu dan kopi. Sajikan.', '1749792249-IMG-20250613-WA0057.jpg', 3),
(44, 'Oreo Smoothies', 'susu kocok dan toping oreo', NULL, '5 keping Oreo\r\n200ml susu\r\nEs batu', 'Blender semua bahan sampai halus.\r\nTambahkan topping oreo di atasnya', '1749791584-IMG-20250613-WA0063.jpg', 3),
(45, 'Jus Alpukat', 'jus alpukat yang manis dan segar', NULL, '1 buah alpukat matang\r\n150ml susu cair\r\nGula cair / susu kental manis, \r\nes batu', 'Blender semua bahan sampai lembut.\r\nSajikan dingin.', '1749791639-IMG-20250613-WA0062.jpg', 3),
(46, 'Chocolate Frappe', 'susu kocok rasa coklat', NULL, '200ml susu\r\n2 sdm coklat bubuk / coklat leleh\r\nEs batu, whipped cream (opsional)', 'Blender semua bahan hingga berbusa.\r\nSajikan dengan topping whipped cream.', '1749791682-IMG-20250613-WA0031.jpg', 3),
(47, 'Mojito (non-alkohol)', 'minuman sodan dengan jeruk nipi dan daun mint tanpa alkohol', NULL, 'Air soda\r\n jeruk nipis\r\n daun mint\r\ngula cair\r\n es batu', 'Tumbuk daun mint dan jeruk nipis dengan gula cair.\r\nTambahkan es dan air soda.', '1749791778-IMG-20250613-WA0056.jpg', 3),
(48, 'Blue Ocean Soda', 'Es soda segar dengan blue syrup', NULL, '2 sdm sirup blue curacao\r\nAir soda\r\nEs batu', 'Campurkan sirup dan es di gelas.\r\nTambahkan air soda. Aduk ringan.', '1749792161-IMG-20250613-WA0058.jpg', 3),
(49, 'Matcha Latte', 'Kopi latte dengan perpaduan rasa matcha', NULL, '1 sdt bubuk matcha\r\n50ml air panas, 150ml susu cair', 'Larutkan matcha dalam air panas.\r\nTambahkan susu hangat/dingin.', '1749792341-IMG-20250613-WA0047.jpg', 3),
(50, 'Bubur Ayam', 'bubur dengan toping ayam dan kacang', NULL, '300 gr beras\r\n2 liter air\r\n2 lembar daun salam\r\n2 batang serai\r\nKuah Kuning:\r\n500 ml air kaldu ayam\r\n2 siung bawang putih\r\n5 siung bawang merah\r\n2 butir kemiri\r\n1 sdt ketumbar\r\n1 ruas kunyit\r\nGaram, merica\r\nPelengkap:\r\nSuwiran ayam rebus\r\nKerupuk\r\nBawang goreng\r\nDaun seledri\r\nSambal', 'Masak beras dengan air, daun salam, dan serai hingga bubur halus.\r\nTumis bumbu halus hingga harum, masukkan ke dalam kaldu, masak.\r\nSajikan bubur, siram kuah, beri suwiran ayam, pelengkap, dan sambal.', '1749793258-IMG-20250613-WA0064.jpg', 2),
(51, 'Nasi Kuning', 'Nasi kuning adalah makanan khas nusantara', NULL, '500 gr beras\r\n400 ml santan\r\n2 lembar daun salam\r\n2 batang serai\r\n1 sdt kunyit bubuk / kunyit halus\r\nGaram\r\nPelengkap:\r\nTelur dadar iris\r\nAyam goreng suwir\r\nSambal\r\nBawang goreng', 'Cuci beras, kukus 20 menit.\r\nDidihkan santan, daun salam, serai, kunyit, dan garam.\r\nAduk beras setengah matang dengan santan, diamkan hingga santan terserap.\r\nKukus kembali sampai matang.\r\nSajikan dengan pelengkap', '1749793353-IMG-20250613-WA0065.jpg', 1),
(52, 'Pempek', 'pempek adalah makanan khas palembang', NULL, '500 gr ikan tenggiri giling\r\n300 gr tepung sagu\r\n2 sdt garam\r\n300 ml air es\r\nTelur (untuk isian pempek kapal selam)\r\n\r\nBahan Cuko:\r\n500 ml air\r\n200 gr gula merah\r\n5 siung bawang putih\r\n10 cabai rawit\r\n2 sdm asam jawa\r\nGaram', 'Campur ikan, garam, dan air es.\r\nMasukkan tepung sagu, aduk rata.\r\nBentuk adonan, beri isian telur untuk kapal selam, atau bentuk lenjer/bulat.\r\nRebus pempek hingga mengapung. Angkat.\r\nGoreng pempek hingga kecokelatan.\r\nBuat cuko: rebus semua bahan cuko, saring.\r\nSajikan pempek dengan cuko.', '1749793430-IMG-20250613-WA0066.jpg', 2),
(53, 'Kapurung', 'Makanan Khas Sulawesi Selatan', NULL, '150 gr sagu tani\r\n500 ml air panas\r\n200 gr ikan tongkol/ikan bandeng, kukus, suwir\r\n100 gr bayam, kangkung, kacang panjang\r\n2 sdm air asam jawa\r\n3 siung bawang merah\r\n2 siung bawang putih\r\n3 buah cabai rawit\r\nGaram dan penyedap', 'Larutkan sagu dengan air panas sedikit demi sedikit, aduk hingga kenyal, lalu bulatkan kecil-kecil.\r\nRebus air, masukkan bumbu halus (bawang, cabai, garam), lalu sayur-sayuran.\r\nMasukkan ikan suwir, air asam jawa.\r\n Terakhir masukkan bulatan sagu, masak sebentar.\r\nSajikan hangat.', '1749793484-IMG-20250613-WA0069.jpg', 2),
(54, 'Spagetti Carboara', 'Makanan yag berasal dari italia', NULL, '200 gr spaghetti\r\n100 gr smoked beef / bacon\r\n2 siung bawang putih, cincang\r\n2 butir kuning telur\r\n100 ml susu cair\r\n50 gr keju parut\r\n1 sdm margarin\r\nGaram & merica secukupnya', 'Rebus spaghetti sampai al dente, tiriskan.\r\nTumis bawang putih dengan margarin hingga harum.\r\nMasukkan smoked beef, masak sebentar.\r\nCampur kuning telur, susu cair, keju, garam, dan merica dalam wadah.\r\nMasukkan spaghetti ke tumisan, angkat dari api.\r\nTuang saus telur dan aduk cepat agar creamy tanpa pecah.\r\nSajikan dengan taburan keju.', '1749793541-IMG-20250613-WA0070.jpg', 2),
(55, 'Jasuke', 'Perpaduan jagung, susu dan keju', NULL, 'jagung\r\nsusu kental manis\r\nkeju', 'Rebus jagung manis \r\ntambahkan susu kental manis\r\ntaburkan keju diatasnya', '1749793871-WhatsApp Image 2025-06-13 at 12.49.03_9f0e66b2.jpg', 4),
(56, 'Mango Sticky rice', 'Perpaduan ketan ,mangga dan saus santan. merupakan makanan khas thailand', NULL, '200 gr ketan kukus\r\n200 ml santan\r\n3 sdm gula\r\n1/2 sdt garam\r\n1 buah mangga manis', 'Masak santan, gula, garam, sisihkan.\r\nSiram ke atas ketan.\r\nSajikan dengan irisan mangga.', '1749793973-WhatsApp Image 2025-06-13 at 12.49.04_ccdc6d88.jpg', 4),
(57, 'Gurame Bakar Pedas Manis', 'Ikan gurame dengan bumbu pedan dan sedikit manis', NULL, '1 ekor ikan gurame (ukuran 700-800 gr), bersihkan dan kerat-kerat badannya\r\n3 sdm kecap manis\r\n2 sdm margarin (lelehkan)\r\n1 sdt air jeruk nipis\r\nGaram secukupnya\r\nBumbu Halus:\r\n5 buah cabai merah besar\r\n10 buah cabai rawit (boleh ditambah kalau suka pedas)\r\n5 siung bawang merah\r\n3 siung bawang putih\r\n1 ruas jahe\r\n1 ruas kunyit\r\n1 sdt ketumbar bubuk\r\nGaram & gula secukupnya', 'Lumuri ikan dengan air jeruk nipis dan garam, diamkan 15 menit.\r\nHaluskan semua bumbu, lalu tumis dengan sedikit minyak hingga harum.\r\nMasukkan kecap manis dan margarin leleh, aduk rata.\r\nOlesi ikan dengan bumbu tumis di kedua sisinya.\r\nBakar ikan di atas bara api atau teflon grill sambil sesekali dioles sisa bumbu hingga matang dan harum.\r\nSajikan dengan sambal dan lalapan.', '1749801428-IMG-20250613-WA0087.jpg', 1),
(58, 'Kentang Telur Balado', 'Kentang dan Telur tinggi protein', NULL, '3 butir telur rebus, kupas\r\n3 buah kentang, kupas & potong dadu\r\nMinyak untuk menggoreng\r\nBumbu Halus:\r\n7 buah cabai merah keriting\r\n5 buah cabai rawit merah\r\n5 siung bawang merah\r\n3 siung bawang putih\r\n1 buah tomat\r\nGaram, gula, dan penyedap secukupnya', 'Goreng kentang hingga matang & kecokelatan, tiriskan.\r\nGoreng telur sebentar biar permukaannya agak kering, sisihkan.\r\nHaluskan bumbu, lalu tumis sampai harum dan matang.\r\nTambahkan garam, gula, dan penyedap sesuai selera.\r\nMasukkan kentang dan telur ke dalam bumbu, aduk rata.\r\nMasak hingga bumbu meresap, angkat.', '1749801546-IMG-20250613-WA0088.jpg', 1),
(59, 'Tanghulu', 'Buah karamel khas dari china', NULL, 'Strobery\r\nAnggur\r\nGula pasir\r\nAir\r\nJeruk nipis', 'Siapkan buah di tusukan sate\r\n Masak gula dan air di panci kecil sampai mendidih dan mengental (sekitar 150°C bila pakai termometer).\r\nTambahkan air jeruk nipis, aduk sebentar.\r\nCelupkan buah ke dalam larutan gula panas hingga terlapisi rata.\r\nAngkat dan diamkan di atas kertas minyak hingga mengeras.', '1749801643-IMG-20250613-WA0086.jpg', 4),
(60, 'Pancake', 'Camilam lembut dengan cara pembuatan yang gampang', NULL, '200 gr tepung terigu\r\n250 ml susu cair\r\n1 butir telur\r\n2 sdm gula pasir\r\n1 sdt baking powder\r\n1 sdt vanili\r\nSejumput garam\r\nMargarin untuk oles', 'Campur tepung, baking powder, vanili, garam.\r\nKocok telur, gula, dan susu, lalu masukkan ke adonan tepung.\r\nAduk hingga licin, diamkan 10 menit.\r\nPanaskan teflon, oles margarin, tuang 1 sendok sayur adonan.\r\nMasak hingga berlubang dan bagian bawah kecoklatan, balik sebentar.\r\nSajikan dengan madu atau topping favorit.', '1749801759-IMG-20250613-WA0081.jpg', 4),
(61, 'Es Teler', 'Perpaduan buah buahan dan es yang dingin dan segar', NULL, 'Alpukat, keruk\r\nNangka, potong-potong\r\nKelapa muda serut\r\nMelon keruk (opsional)\r\n100 ml sirup cocopandan\r\n200 ml susu kental manis\r\nEs serut secukupnya', 'Siapkan gelas/mangkuk, masukkan alpukat, kelapa, nangka, dan melon.\r\nTambahkan es serut.\r\nSiram sirup cocopandan dan susu kental manis.\r\nSajikan dingin.', '1749801889-IMG-20250613-WA0084.jpg', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` enum('admin','user') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`, `role`) VALUES
(1, 'RaflyKu', '$2y$10$YeKh7zJj53TFDJ5hzX66seArcEfex8r1p2HhtA3RXqRjClx9Vw33u', '2025-06-12 04:17:01', 'user'),
(2, 'RaflyKurniawan', '$2y$10$VeFj80KoExq.AUb2g1sfcOYfIne/dz8AKHbbCf7jfTAOIbxMSV8Ya', '2025-06-12 04:34:57', 'user'),
(3, 'AryaAbdi', '$2y$10$u8lN2xTk6eJr..e17aMmz.4du0XGjekotQziT2Z0nnRP1RmTH.b26', '2025-06-12 06:06:49', 'user'),
(4, 'Halo', '$2y$10$0Fg1OCTIfpqyqOpi.gPxue.nG3gUsyDKllCDNN8UqYnV2kbxKhoBa', '2025-06-12 09:33:20', 'user'),
(5, 'Arya', '$2y$10$qrYaQl3KpWtqenKw12k1UOd1JzP0kxk3ZXYcVoGmW8iE3Vg2hc/Me', '2025-06-12 16:59:00', 'user'),
(6, 'AbyanMauesCoklat', '$2y$10$ve/Gvh5wWkA7GJ/QOHTCEOUUjm0d9QcEsmyvH4.IN.gyob9Rp/.Jq', '2025-06-12 18:01:19', 'user'),
(7, 'regyna', '$2y$10$nU2UdHBFKkqCgl.OPGHR3ueiYCGQ/4BMSiVAvH/LWs3w/tATykyPW', '2025-06-13 02:29:39', 'user');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_resep` (`id_resep`);

--
-- Indeks untuk tabel `komentar_web`
--
ALTER TABLE `komentar_web`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `resep`
--
ALTER TABLE `resep`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `komentar_web`
--
ALTER TABLE `komentar_web`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `resep`
--
ALTER TABLE `resep`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `komentar_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `komentar_ibfk_2` FOREIGN KEY (`id_resep`) REFERENCES `resep` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `komentar_web`
--
ALTER TABLE `komentar_web`
  ADD CONSTRAINT `komentar_web_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
