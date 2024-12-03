-- Insert data into akun
INSERT INTO akun (id_akun, nama, email, 'password') VALUES
(1, 'Fredy Kurniadi', 'fredy.kurniadi.tif423@polban.ac.id', 'my_password');

-- Insert data into provinsi
INSERT INTO provinsi (id_provinsi, nama_provinsi) VALUES
('32', 'Jawa Barat');

-- Insert data into kab_kota
INSERT INTO kab_kota (id_kota, nama_kota, id_provinsi) VALUES
('73', 'Kota Bandung', '32');

-- Insert data into kecamatan
INSERT INTO kecamatan (id_kecamatan, nama_kecamatan, id_kota) VALUES
('190', 'Cicendo', '73');

-- Insert data into desa_kel
INSERT INTO desa_kel (id_desa_kel, nama_desa_kel, id_kecamatan) VALUES
('002', 'Pasirkaliki', '190');

-- Insert data into alamat
INSERT INTO alamat (id_akun, alamat_lengkap, kode_alamat) VALUES
(1, 'Jl Pasir Kalili Gg Musaen No 92A/6A', '3273190002'),
(1, 'alamat akun 1 yang kedua', '0000000000');

-- Insert data into list_kategori
INSERT INTO list_kategori (id_kategori, kategori) VALUES
(1, 'baju'),
(2, 'celana');

-- Insert data into list_produk
INSERT INTO list_produk (id_produk, nama_barang, deskripsi, id_kategori) VALUES
(1, 'kemeja merah', 'blablabla', 1);

-- Insert data into size_produk
INSERT INTO size_produk (id_produk, 'size', harga, stok) VALUES
(1, 'S', 100000, 5),
(1, 'M', 100000, 5);

-- Insert data into keranjang
INSERT INTO keranjang (id_keranjang, id_akun, id_barang, 'size', jumlah_barang) VALUES
(1, 1, 1, 'M', 1);

-- Insert data into pembayaran_terdaftar
INSERT INTO pembayaran_terdaftar (id_pembayaran_terdaftar, jenis_pembayaran) VALUES
(1, 'Transfer Bank BCA');

-- Insert data into diskon
INSERT INTO diskon (id_produk, 'size', diskon, tanggal_mulai, tanggal_akhir) VALUES
(1, 'M', 30, '2024-11-06', '2024-11-10');

-- Insert data into riwayat_pembelian
INSERT INTO riwayat_pembelian (id_pembelian, id_akun, tanggal_pembelian, id_barang, 'size', jumlah, status_pembayaran, id_pembayaran_terdaftar) VALUES
(1, 1, '2024-12-20', 1, 'M', 1, 'Belum bayar', -1);
