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
    global riwayat_pembelian
    global size_produk
    global list_produk
    global pembayaran_terdaftar
    
    for i in riwayat_pembelian:
      dictionary = {}
      if i["id akun"] == id_user:
        dictionary["tanggal pembelian"] = i["tanggal pembelian"]
        dictionary["size"] = i["size"]
        dictionary["jumlah"] = i["jumlah"]
        dictionary["status pembayaran"] = i["status pembayaran"]
        for j in list_produk:
          if i["id barang"] == j["id produk"]:
            dictionary["nama barang"] = j["nama barang"]
            dictionary["deskripsi"] = j["deskripsi"]
            for k in list_kategori:
              if j["id kategori"] == k["id kategori"]:
                dictionary["kategori"] = k["kategori"]
                break
            break
        for j in size_produk:
          if [i["id barang"], i["size"]] == [j["id produk"], j["size"]]:
            dictionary["harga"] = j["harga"]
            break 
        for j in pembayaran_terdaftar:
          if i["id pembayaran_terdaftar"] == j["id pembayaran_terdaftar"]:
            dictionary["jenis pembayaran"] = j["jenis pembayaran"]
            break
        output.append(dictionary)

  return output


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
  klo dah ada, lakukan update? klo g aada baru append
  '''
  id_barang = get_id_barang(nama_barang)
  global keranjang

  if [id_user, id_barang, size, jumlah_barang] not in [[i["id akun"], i["id barang"], i["size"], i["jumlah barang"]] for i in keranjang]:
    keranjang.append({
      "id keranjang": len(keranjang) + 1,
      "id akun": id_user,
      "id barang": id_barang,
      "size": size,
      "jumlah barang": jumlah_barang
    })  
  
def update_data_keranjang(id_user, nama_barang, size, jumlah_barang=None):
  '''
  klo di keranjang ada yg id_user, id_barang, size nya sama, 
  ubah size atau jumlah barangnya
  '''
  global keranjang
  id_barang = get_id_barang(nama_barang)
  for barang in keranjang:
    if [barang["id akun"], barang["id barang"]] == [id_user, id_barang]:
      barang["size"] = size
      if jumlah_barang is not None:
        barang["jumlah barang"] = jumlah_barang

def delete_data_keranjang(id_user, nama_barang, size):
  global keranjang
  id_barang = get_id_barang(nama_barang)
  temp = []
  for barang in keranjang:
    if [barang["id akun"], barang["id barang"], barang["size"]] == [id_user, id_barang, size]:
      continue
    temp.append(barang)
  keranjang = temp

def tambah_pembayaran_terdaftar(jenis_pembayaran):
  global pembayaran_terdaftar
  if jenis_pembayaran not in [pembayaran["jenis pembayaran"] for pembayaran in pembayaran_terdaftar]:
    pembayaran_terdaftar.append({"id pembayaran_terdaftar": len(pembayaran_terdaftar)+1, "jenis pembayaran": jenis_pembayaran}) 

def tambah_diskon(nama_barang, size, besar_diskon, tanggal_mulai, tanggal_akhir):
  global diskon
  id_produk = get_id_barang(nama_barang)
  if [id_produk, size, tanggal_mulai, tanggal_akhir] not in [[i["id produk"], i["size"], i["tanggal mulai"], i["tanggal akhir"]] for i in diskon]:
    diskon.append({
      "id produk": id_produk,
      "size": size,
      "diskon": besar_diskon,
      "tanggal mulai": tanggal_mulai,
      "tanggal akhir": tanggal_akhir
    })

def tampilkan_daftar_barang(kategori=""):
  global list_kategori
  global list_produk
  global size_produk
  global diskon

  # nama barang, deskripsi, kategori, size dan harga yang ada, stok, diskon
  ans = []
  for produk in list_produk:
    id_produk =  produk["id produk"]
    temp = {
      "nama barang": produk["kemeja merah"],
      "deskripsi": produk["deskripsi"],
    }

    id_kategori = produk["id kategori"]
    for i_kategori in list_kategori:
      if i_kategori["id kategori"] == id_kategori:
        temp["kategori"] == i_kategori["kategori"]
        break

    for size in size_produk:
      temp2 = temp
      if size["id produk"] == id_produk:
        temp2["size"] == size["size"]
        temp2["harga"] == size["harga"]
        temp2["stok"] == size["stok"]

        for i_diskon in diskon:
          if i_diskon["id produk"] == id_produk and temp2["size"] == i_diskon["size"]:
            temp3 = temp2
            temp3["diskon"] == i_diskon["diskon"]
            temp3["tanggal mulai"] = i_diskon["tanggal mulai"]
            temp3["tanggal akhir"] == i_diskon["tanggal akhir"]
            ans.append(temp3)

  if kategori == "":
    return ans
  return [i for i in ans if i["kategori"] == kategori]

def ubah_status_pembayaran(id_pembelian, jenis_pembayaran):
  global riwayat_pembelian
  global pembayaran_terdaftar
  for i in riwayat_pembelian:
    if i["id pembelian"] == id_pembelian:
      i["status pembayaran"] = "Sudah bayar"
      for j in pembayaran_terdaftar:
        if j["jenis pembayaran"] == jenis_pembayaran:
          i["id pembayaran_terdaftar"] = j["id pembayaran_terdaftar"]
          break
      break

def melakukan_pembayaran(id_user, id_keranjang, jenis_pembayaran, tanggal_pembelian, jumlah_pembayaran):
  global keranjang
  global pembayaran_terdaftar
  global diskon
  global riwayat_pembelian 
  global size_produk

  # bisa kalau jenis pembayaran terdaftar
  if jenis_pembayaran not in [i["jenis pembayaran"] for i in pembayaran_terdaftar]:
    return
  
  tanggal_pembelian = tanggal_pembelian.split("/")
  tanggal_pembelian = [int(x) for x in tanggal_pembelian]

  isi_keranjang = []
  for i in keranjang:
    berhasil_dibayar = False
    if i["id keranjang"] == id_keranjang:

      # bisa kalau stok nya ada 
      for j in size_produk:
        if j["id produk"] == i["id barang"]: 
          if i["jumlah barang"] <= j["stok"]:
            harga_barang = j["harga"]
          else: 
            return
          break

      # cek diskon
      dapat_diskon = 0
      for j in diskon:
        if [j["id produk"], j["size"]] == [i["id barang"], i["size"]]:
          tanggal_mulai_diskon = j["tanggal mulai"].split("/")
          tanggal_mulai_diskon = [int(x) for x in tanggal_mulai_diskon]
          tanggal_akhir_diskon = j["tanggal akhir"].split("/")
          tanggal_akhir_diskon = [int(x) for x in tanggal_akhir_diskon]
          if tanggal_mulai_diskon[0] <= tanggal_pembelian[0] <= tanggal_akhir_diskon[0]\
          and tanggal_mulai_diskon[1] <= tanggal_pembelian[1] <= tanggal_akhir_diskon[1]\
          and tanggal_mulai_diskon[2] <= tanggal_pembelian[2] <= tanggal_akhir_diskon[2]:
            dapat_diskon = j["diskon"]
            break
      
      # bisa kalau jumlah pembayaran sama dengan harga pembayaran
      harga = (100-dapat_diskon)/100* harga_barang * i["jumlah barang"]
      # stok produk berkurang
      if harga == jumlah_pembayaran:
        for j in size_produk:
          if j["id produk"] == i["id barang"] and i["jumlah barang"] <= j["stok"]:
            j["stok"] -= i["jumlah barang"]
            berhasil_dibayar = True

            # riwayat pembeli bertambah
            riwayat_pembelian.append({
              "id pembelian": len(riwayat_pembelian) + 1,
              "id akun": id_user,
              "tanggal pembelian": tanggal_pembelian,
              "id barang": i["id barang"],
              "size": i["size"],
              "jumlah": i["jumlah barang"],
              "status pembayaran": "Sudah bayar",
              "id pembayaran_terdaftar": jenis_pembayaran
            })
            break

      # isi keranjang berkurang
      if not berhasil_dibayar:
        isi_keranjang.append(i)

  keranjang = isi_keranjang  

def dapat_harga(id_keranjang, tanggal_pembelian):
  global keranjang
  global diskon
  global size_produk
  
  tanggal_pembelian = tanggal_pembelian.split("/")
  tanggal_pembelian = [int(x) for x in tanggal_pembelian]

  for i in keranjang:
    if i["id keranjang"] == id_keranjang:

      # bisa kalau stok nya ada 
      for j in size_produk:
        if j["id produk"] == i["id barang"]: 
          if i["jumlah barang"] <= j["stok"]:
            harga_barang = j["harga"]
          else: 
            return
          break

      # cek diskon
      dapat_diskon = 0
      for j in diskon:
        if [j["id produk"], j["size"]] == [i["id barang"], i["size"]]:
          tanggal_mulai_diskon = j["tanggal mulai"].split("/")
          tanggal_mulai_diskon = [int(x) for x in tanggal_mulai_diskon]
          tanggal_akhir_diskon = j["tanggal akhir"].split("/")
          tanggal_akhir_diskon = [int(x) for x in tanggal_akhir_diskon]
          if tanggal_mulai_diskon[0] <= tanggal_pembelian[0] <= tanggal_akhir_diskon[0]\
          and tanggal_mulai_diskon[1] <= tanggal_pembelian[1] <= tanggal_akhir_diskon[1]\
          and tanggal_mulai_diskon[2] <= tanggal_pembelian[2] <= tanggal_akhir_diskon[2]:
            dapat_diskon = j["diskon"]
            break
      
      return (100-dapat_diskon)/100* harga_barang * i["jumlah barang"]



            
            