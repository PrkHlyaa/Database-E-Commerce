create or replace PROCEDURE edit_detail_produk(
    p_id_detail_produk IN detailproduk.id_detail_produk%TYPE,
    p_stok             IN detailproduk.stok%TYPE,
    p_harga_reguler    IN detailproduk.harga_reguler%TYPE,
    p_id_diskon        IN detailproduk.id_diskon%TYPE DEFAULT NULL
) AS
    v_id_produk produk.id_produk%TYPE;
    v_ukuran detailproduk.ukuran%TYPE;
    v_diskon_count NUMBER;
BEGIN
    -- Ambil id_produk dan ukuran dari detail_produk untuk validasi
    SELECT id_produk, ukuran
    INTO v_id_produk, v_ukuran
    FROM detailproduk
    WHERE id_detail_produk = p_id_detail_produk;

    -- Validasi id_diskon (jika diberikan)
    IF p_id_diskon IS NOT NULL THEN
        SELECT COUNT(*)
        INTO v_diskon_count
        FROM diskon
        WHERE id_diskon = p_id_diskon;

        IF v_diskon_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'ID Diskon tidak valid.');
        END IF;
    END IF;

    -- Update data detail_produk
    UPDATE detailproduk
    SET stok = p_stok,
        harga_reguler = p_harga_reguler,
        id_diskon = p_id_diskon
    WHERE id_detail_produk = p_id_detail_produk;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'ID Detail Produk tidak ditemukan.');
    END IF;

    COMMIT;
END;