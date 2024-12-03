BEGIN
    edit_detail_produk(
        p_id_detail_produk => 'CA4SRQ001',
        p_stok             => 50,
        p_harga_reguler    => 149000,
        p_id_diskon        => NULL
    );
END;

BEGIN
    edit_produk(
        p_id_produk    => 'CJCQYK',
        p_nama_produk  => 'Cardigan Rajut',
        p_kategori     => 'cardigan and jacket',
        p_deskripsi    => 'Cardigan hangat dengan bahan tebal.'
    );
END;
