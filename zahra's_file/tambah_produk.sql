BEGIN
    tambah_produk(
        p_nama_produk => 'Cardigan Hangat',
        p_kategori => 'cardigan and jacket',
        p_deskripsi => 'Cardigan hangat dengan bahan tebal.'
    );
END;



BEGIN
    tambah_detail_produk(
        p_id_produk => 'CJCQYK',
        p_ukuran => 'M',
        p_stok => 30,
        p_harga_reguler => 299000
    );
END;
