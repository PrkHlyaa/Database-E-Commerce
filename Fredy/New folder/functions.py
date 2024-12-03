from data import *

def register(nama, email, password):
  '''
  jika email belum terdaftar, user dapat membuat akun baru
  '''
  global akun
  if email not in [user['email'] for user in akun]:
    akun.append([{
      "id akun": len(akun) + 1,
      "nama": nama,
      "email": email,
      "password": password
    }])
  
def login(nama, email, password):
  '''
  jika email sudah terdaftar dan passwordnya benar, return id akun
  '''
  global akun
  for user in akun:
    if [nama, email, password] == [user['nama'], user['email'], user['password']]:
      return user['id']

def update_data_user(id_user, nama='', password='', alamat_awal='', alamat_akhir='', kode_alamat_awal='', kode_alamat_akhir=''):
  '''
  jika sudah login (memiliki id_user), dapat update data diri
  '''
  if nama + password:
    global akun
    for user in akun:
      if id_user == user['id']:
        if nama: user['nama'] = nama
        if password: user['password'] = password
        break
  if alamat_awal + kode_alamat_awal:
    global alamat
    for lokasi in alamat:
      if id_user == lokasi['id akun']:
        if alamat_awal: lokasi['alamat lengkap'] = alamat_akhir
        if kode_alamat_awal: lokasi['kode alamat'] = kode_alamat_akhir
      break

def change_password(id_user, password_akhir):
  '''
  ubah password jika akun terdaftar
  '''
  update_data_user(id_user, password=password_akhir)

# bagian riwayat pembelian belum beres
def show_data_diri(id_user, tipe='keranjang'):
  '''
  show alamat, keranjang, riwayat pembelian user 
  tipe: alamat, keranjang, riwayat pembelian
  '''
  output = []
  if tipe == 'alamat':
    global alamat
    for i in alamat:
      if id_user == i['id akun']:
        data_provinsi = ''
        global provinsi
        for j in provinsi:
          if j['id provinsi'] == i['kode alamat'][:2]:
            data_provinsi = j['nama provinsi']
            break

        data_kota = ''
        global kab_kota
        for j in kab_kota:
          if j['id kota'] == i['kode alamat'][2:4]:
            data_kota = j['nama kota']

        data_kecamatan = ''
        global kecamatan
        for j in kecamatan:
          if j['id kecamatan'] == i['kode alamat'][4:7]:
            data_kecamatan = j['nama kecamatan']

        data_desa_kel = ''
        global desa_kel
        for j in desa_kel:
          if j['id desa_kel'] == i['kode alamat'][7:]:
            data_desa_kel = j['nama desa_kel']

        output.append({
          "alamat lengkap": i['alamat lengkap'],
          "provinsi": data_provinsi,
          "kota": data_kota,
          "kecamatan": data_kecamatan,
          "desa_kel": data_desa_kel
        })
    return output
  
  if tipe == 'keranjang':
    global keranjang
    for data in keranjang:
      if id_user == data['id akun']:
        # size, jumlah barang, harga, nama barang, deskripsi, kategori
        nama_barang = ''
        deskripsi = ''
        global list_produk
        for j in list_produk:
          if j['id produk'] == data['id barang']:
            nama_barang = j['nama barang']
            deskripsi = j['deskripsi']
            kategori = ''
            global list_kategori
            for k in list_kategori:
              if k['id kategori'] == j['id kategori']:
                kategori = k['kategori']
                break

        harga = ''
        global size_produk
        for j in size_produk:
          if j['size'] == data['size']:
            harga = j['harga']

        output.append({
          "nama barang": nama_barang,
          "deskripsi": deskripsi,
          "kategori": kategori,
          "size": data['size'],
          "harga": harga,
          "jumlah barang": data['jumlah barang']
        })
  
  if tipe == "riwayat pembelian":
    pass

  return output
  pass


def add_kategori(kategori): 
  '''
  menambah kategori jika belum terdaftar
  add kategori ke list_kategori
  '''
  global list_kategori
  if kategori not in [i['kategori'] for i in list_kategori]:
    list_kategori.append({
      "id kategori": len(list_kategori) + 1,
      "kategori": kategori
    })

def add_produk(nama_barang, deskripsi, kategori):
  '''
  add produk ke list_produk
  '''
  id_kategori = ''
  global list_kategori
  for i in list_kategori:
    if i['kategori'] == kategori:
      id_kategori = i['id kategori']
      break
  
  global list_produk
  list_produk.append({
    "id produk": len(list_produk) + 1,
    "nama barang": nama_barang,
    "deskripsi": deskripsi,
    "id kategori": id_kategori
  })
  
def update_deskripsi_produk(nama_barang, deskripsi): 
  '''
  update deskripsi produk pada produk dalam list_produk
  '''
  global list_produk
  for i in list_produk:
    if i['nama barang'] == nama_barang:
      i['deskripsi']= deskripsi
      break

def update_kategori_produk(nama_barang, kategori):
  '''
  update id kategori produk pada produk dalam list_produk
  '''
  global list_produk
  global list_kategori
  for i in list_produk:
    if i['nama barang'] == nama_barang:
      for j in list_kategori:
        if j['kategori'] == kategori:
          i['id kategori'] = j['id kategori']
          break
      break

def tambah_size(nama_barang, size, harga, stok=0):
  '''
  tambah size produk di size_produk
  '''
  global list_produk
  for i in list_produk:
    if i['nama barang'] == nama_barang:
      global size_produk
      if [i['id produk'], size] not in [[k['id produk'], k['size']] for k in size_produk]:
        size_produk.append({
          "id produk": i['id produk'],
          "size": size,
          "harga": harga,
          "stok": stok
        })
      break
  
def update_harga_stok_size(nama_barang, size, harga="", stok=""):
  '''
  tambah size produk di size_produk
  '''
  global list_produk
  for i in list_produk:
    if i['nama barang'] == nama_barang:
      global size_produk
      for j in size_produk:
        if [j['id barang'], j['size']] == [i['id barang'], size]:
          if harga: j['harga'] = harga
          if stok: j['stok'] = stok
          break
      break

# mungkin bikin fungsi get_id_barang(nama_barang)
def get_id_barang(nama_barang):
  global list_produk
  for i in list_produk:
    if i['nama barang'] == nama_barang:
      return i['id produk'] 

def add_data_keranjang(id_user, nama_barang, size, jumlah_barang): 
  '''
  klo dah ada, lakukan update. klo g aada baru append
  '''
  id_barang = get_id_barang(nama_barang)
  global keranjang

  # if [id_user, id_barang, size, jumlah_barang] not in []
  keranjang.append({
    "id keranjang": len(keranjang) + 1,
    "id akun": id_user,
    "id barang": id_barang,
    "size": size,
    "jumlah barang": jumlah_barang
  })  
  



