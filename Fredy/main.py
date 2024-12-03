# https://sig.bps.go.id/bridging-kode/index
# https://sig.bps.go.id/assets/images/bagan_pengkodean.png

akun = [
  # primary key = id akun
  {
    "id akun": 1, # id akun
    "nama": "Fredy Kurniadi",
    "email": "fredy.kurniadi.tif423@polban.ac.id",
    "password": "my_password",
  }
]

alamat = [
  # foreign key = id akun (1 akun bisa banyak alamat)
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
    "id": 1,
    "kategori": "baju"
  },
  {
    "id": 2,
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



'''
event:
1. register
2. login
3. add kategori ke list_kategori
4. add produk ke list_produk
5. update deskripsi produk pada produk dalam list_produk
6. update id kategori produk pada produk dalam list_produk
7. tambah size produk di size_produk
8. update harga per size suatu produk di size_produk
9. update stok per size suatu produk di size_produk

'''