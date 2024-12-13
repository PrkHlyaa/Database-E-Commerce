-- PRODUK_TERBARU
CREATE OR REPLACE FORCE VIEW "SIGMA_USER"."PRODUK_TERBARU" ("ID_PRODUK", "NAMA_PRODUK", "KATEGORI", "DESKRIPSI", "UKURAN", "HARGA_REGULER", "STOK", "DISKON", "NAMA_DISKON", "STOK_TERBARU") AS 
  SELECT
    p.id_produk,
    p.nama_produk,
    p.kategori,
    p.deskripsi,
    dp.ukuran,
    dp.harga_reguler,
    dp.stok,
    d.diskon,
    d.nama_diskon,
    dp.stok AS stok_terbaru
FROM
    produk p
JOIN detailproduk dp ON p.id_produk = dp.id_produk
LEFT JOIN diskon d ON dp.id_diskon = d.id_diskon
WHERE
    dp.stok > 0  -- Produk dengan stok lebih besar dari 0
ORDER BY
    p.id_produk DESC;


-- RIWAYAT_PEMBELIAN_PENGGUNA
CREATE OR REPLACE FORCE VIEW "SIGMA_USER"."RIWAYAT_PEMBELIAN_USER" ("ID_CUSTOMER", "USERNAME", "EMAIL", "ID_KERANJANG", "NAMA_PRODUK", "UKURAN", "KUANTITAS", "SUBTOTAL", "ID_CHECKOUT", "TOTAL", "STATUS_PEMBAYARAN", "WAKTU_CHECKOUT", "WAKTU_LAST_UPDATE", "METODE_PEMBAYARAN") AS 
  SELECT
    c.id_customer,
    c.username,
    c.email,
    k.id_keranjang,
    p.nama_produk,
    dp.ukuran,
    k.kuantitas,
    k.subtotal,
    ch.id_checkout,
    ch.total,
    ch.status_pembayaran,
    ch.waktu_checkout,
    ch.waktu_last_update,
    mp.metode_pembayaran
FROM
    customer c
JOIN keranjang k ON c.id_customer = k.id_customer
JOIN detailproduk dp ON k.id_detail_produk = dp.id_detail_produk
JOIN produk p ON dp.id_produk = p.id_produk
JOIN checkout ch ON k.id_checkout = ch.id_checkout
JOIN metodepembayaran mp ON ch.id_metode = mp.id_metode
ORDER BY ch.waktu_checkout DESC;
