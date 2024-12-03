BEGIN
    TAMBAH_DISKON(
        p_id_produk => 'CJCQYK',
        p_nama_diskon => 'Diskon Musim Dingin',
        p_tanggal_mulai => TO_DATE('2024-12-04', 'YYYY-MM-DD'),
        p_tanggal_berakhir => TO_DATE('2024-12-31', 'YYYY-MM-DD'),
        p_diskon => 50,
        p_maksimal_diskon => 30000
    );
END;
