-- Table for accounts
CREATE TABLE akun (
    id_akun INT PRIMARY KEY,
    nama VARCHAR(255),
    email VARCHAR(255),
    'password' VARCHAR(255)
);

-- Table for provinces
CREATE TABLE provinsi (
    id_provinsi VARCHAR(10) PRIMARY KEY,
    nama_provinsi VARCHAR(255)
);

-- Table for cities/regencies
CREATE TABLE kab_kota (
    id_kota VARCHAR(10) PRIMARY KEY,
    nama_kota VARCHAR(255),
    id_provinsi VARCHAR(10),
    FOREIGN KEY (id_provinsi) REFERENCES provinsi(id_provinsi)
);

-- Table for subdistricts
CREATE TABLE kecamatan (
    id_kecamatan VARCHAR(10) PRIMARY KEY,
    nama_kecamatan VARCHAR(255),
    id_kota VARCHAR(10),
    FOREIGN KEY (id_kota) REFERENCES kab_kota(id_kota)
);

-- Table for villages
CREATE TABLE desa_kel (
    id_desa_kel VARCHAR(10) PRIMARY KEY,
    nama_desa_kel VARCHAR(255),
    id_kecamatan VARCHAR(10),
    FOREIGN KEY (id_kecamatan) REFERENCES kecamatan(id_kecamatan)
);

-- Table for addresses
CREATE TABLE alamat (
    id_akun INT,
    alamat_lengkap TEXT,
    kode_alamat VARCHAR(10),
    FOREIGN KEY (id_akun) REFERENCES akun(id_akun)
);

-- Table for product categories
CREATE TABLE list_kategori (
    id_kategori INT PRIMARY KEY,
    kategori VARCHAR(255)
);

-- Table for products
CREATE TABLE list_produk (
    id_produk INT PRIMARY KEY,
    nama_barang VARCHAR(255),
    deskripsi TEXT,
    id_kategori INT,
    FOREIGN KEY (id_kategori) REFERENCES list_kategori(id_kategori)
);

-- Table for product sizes
CREATE TABLE size_produk (
    id_produk INT,
    'size' VARCHAR(10),
    harga INT,
    stok INT,
    PRIMARY KEY (id_produk, 'size'),
    FOREIGN KEY (id_produk) REFERENCES list_produk(id_produk)
);

-- Table for cart items
CREATE TABLE keranjang (
    id_keranjang INT PRIMARY KEY,
    id_akun INT,
    id_barang INT,
    'size' VARCHAR(10),
    jumlah_barang INT,
    FOREIGN KEY (id_akun) REFERENCES akun(id_akun),
    FOREIGN KEY (id_barang) REFERENCES list_produk(id_produk),
    FOREIGN KEY (id_barang, 'size') REFERENCES size_produk(id_produk, 'size')
);

-- Table for registered payment methods
CREATE TABLE pembayaran_terdaftar (
    id_pembayaran_terdaftar INT PRIMARY KEY,
    jenis_pembayaran VARCHAR(255)
);

-- Table for discounts
CREATE TABLE diskon (
    id_produk INT,
    'size' VARCHAR(10),
    diskon INT,
    tanggal_mulai DATE,
    tanggal_akhir DATE,
    PRIMARY KEY (id_produk, 'size'),
    FOREIGN KEY (id_produk, 'size') REFERENCES size_produk(id_produk, 'size')
);

-- Table for purchase history
CREATE TABLE riwayat_pembelian (
    id_pembelian INT PRIMARY KEY,
    id_akun INT,
    tanggal_pembelian DATE,
    id_barang INT,
    'size' VARCHAR(10),
    jumlah INT,
    status_pembayaran VARCHAR(50),
    id_pembayaran_terdaftar INT,
    FOREIGN KEY (id_akun) REFERENCES akun(id_akun),
    FOREIGN KEY (id_barang) REFERENCES list_produk(id_produk),
    FOREIGN KEY (id_barang, 'size') REFERENCES size_produk(id_produk, 'size'),
    FOREIGN KEY (id_pembayaran_terdaftar) REFERENCES pembayaran_terdaftar(id_pembayaran_terdaftar)
);


