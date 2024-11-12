# https://sig.bps.go.id/bridging-kode/index

akun = [
  # primary key = name
  # foreign key = alamat detail
  {
    "id": 1, # id akun
    "nama": "Fredy Kurniadi",
    "email": "fredy.kurniadi.tif423@polban.ac.id",
    "password": "12345678",
  }
]

# provinsi

kota = [
  # primary key = nama kota
  {
    "id": "04",
    "nama kota": "Bandung",
    "provinsi": "Jawa Barat"
  }
]

kecamatan = [
  # primary key = nama kecamatan
  # foreign key = kota
  {
    "id": "12",
    "nama kecamatan": "Cicendo",
    "kota": "Bandung"
  }
]

# kelurahan

alamat_detail = [
  # primary key = alamat detail
  # foreign key = kecamatan
  {
    "user_id": 1,
    "alamat detail": "Jl Pasir Kaliki Gg Musaen No 92A/6A",
    "kecamatan": "Cicendo"
  }
]

wishlist = [
  # primary key = id
  # foreign key = nama akun, nama barang
  {
    "id": 0,
    "id akun": 1,
    "id barang": 1,
    # "warna": "merah",
    "size": "M",
    "jumlah barang": 1
  }
]

kategori = [
  {
    "id": 1,
    "kategori": "baju"
  },
  {
    "id": 2,
    "kategori": "celana"
  }
]

detail_produk = [
  # primary key = nama barang
  {
    "id": 1,
    "nama barang": "kemeja",
    "deskripsi": "blablabla",
    "id kategori": 1,
  },
  {
    "id": 2,
    "nama barang": "jeans",
    "deskripsi": "blablabla",
    "id kategori": 2,
  }
]

# barang_yg_dipesan = [
#   # primary key = id pesan
#   # foreign key = nama akun, nama barang
#   {
#     "id pesan": "12345678",
#     "id akun": 1,
#     "id pesanan": 1
#   }
# ]

metode_pembayaran = [
  # primary key = id
  # foreign key = nama akun
  {
    "id": 1, # sambung ke riwayat pembelian id pembelian
    # "nama akun": "Fredy Kurniadi", # ubah jadi id akun?
    "jenis pembayaran": "Transfer Bank",
    "nomor pembayaran": "12345678" # rekening
  }
]

riwayat_pembelian = [
  # primary key = id pembelian
  # foreign key = barang yang dibeli
  {
    "id pembeli": 1,
    "id pembelian": 1,
    "tanggal pembelian": "20-12-2024",
    "barang yang dibeli": "kemeja",
    "size": "M",
    "jumlah": 1,
    "status pembelian": "Selesai"
  }
]

size_produk = [
  {
    "id": 1,
    "size": "L",
    "warna": "merah",
    "harga": 100000,
    "stok": 5
  },
  {
    "id": 1,
    "size": "M",
    "warna": "merah",
    "harga": 100000,
    "stok": 5
  }
]

warna_produk = [
  {
    "id": 1,
    "warna": "merah"
  }
]

diskon = [
  {
    "id produk": 1,
    "warna": "merah",
    "diskon": 30,
    "tanggal mulai": "06/11/2024",
    "tanggal akhir": "10/11/2024"
  }
]

daftar_pembayaran = [
  {
    "jenis pembayaran": "Transfer Bank",
  }
]

def show_list_barang(kategori=""):
  '''
  memperlihatkat detail produk beserta size nya dan stok masing-masing size

  filter: 
  - by kategori
  '''
  global detail_produk
  global size_produk
  print("show_list_barang")
  for produk in detail_produk:
    if kategori != "" and kategori != produk['kategori']: continue
    print(f"nama barang: {produk['nama barang']}")
    print(f"deskripsi: {produk['deskripsi']}")
    print(f"kategori barang: {produk['kategori barang']}")
    for size in size_produk:
      if produk['id'] != size['id']: continue
      print(f"\tsize: {size['size']}")
      print(f"\tharga: {size['harga']}")
      print(f"\tstok: {size['stok']}")
    print()
  print("-------------------------------------")

def nambah_barang(nama_barang, kategori, deskripsi=""):
  '''
  jika barang tidak terdaftar, bisa tambah barang
  '''
  global detail_produk
  print("nambah_barang")
  if nama_barang not in [produk['nama barang'] for produk in detail_produk]: 
    detail_produk.append({
      "id": max([produk['id'] for produk in detail_produk]) + 1,
      "nama barang": nama_barang,
      "deskripsi": deskripsi,
      "kategori barang": kategori
    })
    print("berhasil tambah barang")
  else: print("gagal tambah barang")
  print("-------------------------------------")

def update_barang(nama_barang, deskripsi="", nama_barang_baru=""):
  '''
  ubah deskripsi barang
  '''
  print("update_barang")
  global detail_produk
  for produk in detail_produk:
    if produk['nama barang'] == nama_barang:
      if deskripsi != "":
        produk['deskripsi'] = deskripsi
      if nama_barang_baru != "":
        produk['nama barang'] = nama_barang_baru
      break
  print("-------------------------------------")

def nambah_ukuran(nama_barang, size, harga):
  '''
  jika size yang ingin ditambahkan pada suatu barang belum terdaftar, bisa ditambah
  '''
  print("nambah_ukuran")
  global detail_produk
  global size_produk
  for produk in detail_produk:
    if produk['nama barang'] == nama_barang:
      if size not in [size_p['size'] if size_p['id'] == produk['id'] else None for size_p in size_produk]: 
        size_produk.append({
          "id": produk['id'],
          "size": size,
          "harga": harga,
          "stok": 0
        })
      break
  print("-------------------------------------")

# update stok
'''
jika size n warna terdaftar, bisa update stok
'''
def update_stok():
  pass

# update harga
'''
update harga dari barang dengan id dan size tertentu
'''

# pembayaran
'''
jika stok ada dan metode pembayaran telah terdaftar
'''

# update status pembayaran
'''
ketika pesanan dibuat, stok berkurang. jika hingga akhir waktu pembayaran masi belum dibayar, stok kembali ke semula
'''

# -----------------------------------------------------------------

# membuat akun
'''
bisa jika email belum terdaftar
'''

# update data diri

# nambah ke wishlist
'''
jika barang dan size belum terdaftar pada wishlist, bisa tambah wishlist
'''

# update wishlist
'''
hapus atau ubah jumlah produk yang diinginkan
'''

# komentar dan rating

# event diskon

show_list_barang(kategori="")
nambah_barang("nama_barang", "celana", deskripsi="")
show_list_barang(kategori="")
nambah_barang("nama_barang", "celana", deskripsi="")
show_list_barang(kategori="")
nambah_ukuran("nama_barang", "M", 0)
show_list_barang(kategori="")

