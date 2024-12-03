akun = [
  # primary key = id akun
  {
    "id akun": 1, # id akun
    "nama": "Fredy Kurniadi",
    "email": "fredy.kurniadi.tif423@polban.ac.id",
    "password": "my_password",
  }
]

provinsi = [
  # primary key = id provinsi
  {
    "id provinsi": "32",
    "nama provinsi": "Jawa Barat",
  }
]

kab_kota = [
  # primary key = id kota
  # foreign key = id provinsi
  {
    "id kota": "73",
    "nama kota": "Kota Bandung",
    "id provinsi": "32"
  }
]

kecamatan = [
  # primary key = id kecamatan
  # foreign key = id kota
  {
    "id kecamatan": "190",
    "nama kecamatan": "Cicendo",
    "id kota": "73"
  }
]

desa_kel = [
  # primary key = id desa_kel
  # foreign key = id kecamatan
  {
    "id desa_kel": "002",
    "nama desa_kel": "Pasirkaliki",
    "id kecamatan": "73"
  }
]

alamat = [
  # foreign key = id akun (1 akun bisa banyak alamat)
  # id akun nempel ke akun
  {
    "id akun": 1,
    "alamat lengkap": "Jl Pasir Kalili Gg Musaen No 92A/6A",
    "kode alamat": "3273190002" # kode bps 10 digit
    # provinsi: 32
    # kab/kota: 73
    # kecamatan: 190
    # desa/kel: 002
  },
  {
    "id akun": 1,
    "alamat lengkap": "alamat akun 1 yang kedua",
    "kode alamat": "0000000000" # 10 digit
  }
]

list_kategori = [
  # primary key: id kategori
  {
    "id kategori": 1,
    "kategori": "baju"
  },
  {
    "id kategori": 2,
    "kategori": "celana"
  }
]

list_produk = [
  # primary key: id produk
  # foreign key: id kategori
  {
    "id produk": 1,
    "nama barang": "kemeja merah",
    "deskripsi": "blablabla",
    "id kategori": 1
  }
]

size_produk = [
  # foreign key: id produk
  {
    "id produk": 1,
    "size": "S",
    "harga": 100_000,
    "stok": 5
  },
  {
    "id produk": 1,
    "size": "M",
    "harga": 100_000,
    "stok": 5
  }
]

keranjang = [
  # primary key: id keranjang
  {
    "id keranjang": 1,
    "id akun": 1,
    "id barang": 1,
    "size": "M",
    "jumlah barang": 1
  }
]

pembayaran_terdaftar = [
  # primary key: id pembayaran_terdaftar
  {
    "id pembayaran_terdaftar": 1,
    "jenis pembayaran": "Transfer Bank BCA"
  }
]

diskon = [
  # foreign key: id produk, size
  {
    "id produk": 1,
    "size": "M",
    "diskon": 30,
    "tanggal mulai": "06/11/2024",
    "tanggal akhir": "10/11/2024"
  }
]

riwayat_pembelian = [
  # primary key: id pembelian
  # foreign key: id akun, size, id pembayaran terdaftar
  {
    "id pembelian": 1,
    "id akun": 1,
    "tanggal pembelian": "20/12/2024",
    "size": "M",
    "jumlah": 1,
    "status pembayaran": "Belum bayar",
    "id pembayaran_terdaftar": -1 # (belum bayar)
  }
]
