CREATE VIEW daftar_produk AS
SELECT
    p.id_produk,
    p.nama_produk,
    p.kategori,
    p.deskripsi,
    dp.ukuran,
    dp.harga_reguler,
    dp.stok,
    d.diskon,
    d.tanggal_mulai AS tanggal_mulai_diskon,
    d.tanggal_berakhir AS tanggal_berakhir_diskon,
    ch.waktu_checkout,
    ch.total,
    ch.status_pembayaran
FROM
    produk p
JOIN detailproduk dp ON p.id_produk = dp.id_produk
LEFT JOIN diskon d ON dp.id_diskon = d.id_diskon
JOIN keranjang k ON dp.id_detail_produk = k.id_detail_produk
JOIN checkout ch ON k.id_checkout = ch.id_checkout
ORDER BY ch.waktu_checkout DESC;
