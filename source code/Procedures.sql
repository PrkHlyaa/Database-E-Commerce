- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
DAFTAR PROSEDUR
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
1. ADD_ALAMAT  
2. ADD_TO_WISHLIST  
3. DELETE_FROM_KERANJANG  
4. DELETE_FROM_WISHLIST  
5. EDIT_DETAIL_PRODUK  
6. EDIT_PRODUK  
7. HAPUS_PRODUK  
8. INSERT_TO_CHECKOUT  
9. INSERT_TO_KERANJANG  
10. LAPORAN_PENJUALAN  
11. PERBARUI_STOK  
12. REGISTER_USER   
13. TAMBAH_DETAIL_PRODUK  
14. TAMBAH_DISKON  
15. TAMBAH_PRODUK  
16. UPDATE_ALAMAT  
17. UPDATE_CHECKOUT_STATUS  
18. UPDATE_DATA_DIRI  

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 1: ADD_ALAMAT
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE add_alamat(
    p_id_customer IN VARCHAR2,
    p_detail_alamat IN VARCHAR2,
    p_kode_pos IN VARCHAR2,
    p_id_kecamatan IN VARCHAR2
) IS
    l_id_alamat VARCHAR2(32);        -- ID Alamat yang digenerate
    l_kecamatan_exists INTEGER;     -- Untuk memeriksa apakah kecamatan valid
    l_count_alamat INTEGER;         -- Nomor urut alamat customer
    l_customer_code VARCHAR2(3);    -- 3 digit pertama dari id_customer
    l_kecamatan_code VARCHAR2(3);   -- 3 digit terakhir dari id_kecamatan
BEGIN
    -- Cek apakah id_kecamatan ada
    SELECT COUNT(*)
    INTO l_kecamatan_exists
    FROM kecamatan
    WHERE id_kecamatan = p_id_kecamatan;

    IF l_kecamatan_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: Kecamatan ID does not exist');
    END IF;

    -- Ambil 3 digit pertama dari id_customer
    l_customer_code := SUBSTR(p_id_customer, -3, 3);

    -- Ambil 3 digit terakhir dari id_kecamatan
    l_kecamatan_code := SUBSTR(p_id_kecamatan, -3, 3);

    -- Hitung nomor urut alamat berdasarkan id_customer dan id_kecamatan
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id_alamat, -2))), 0) + 1
    INTO l_count_alamat
    FROM alamatcustomer
    WHERE id_customer = p_id_customer
      AND id_kecamatan = p_id_kecamatan;

    -- Generate ID Alamat
    l_id_alamat := 'ACUS' || l_customer_code || l_kecamatan_code || LPAD(l_count_alamat, 2, '0');

    -- Insert ke tabel alamatcustomer
    INSERT INTO alamatcustomer (
        id_alamat,
        detail_alamat,
        kode_pos,
        id_kecamatan,
        id_customer
    )
    VALUES (
        l_id_alamat,
        p_detail_alamat,
        p_kode_pos,
        p_id_kecamatan,
        p_id_customer
    );

    DBMS_OUTPUT.PUT_LINE('Alamat added successfully with ID: ' || l_id_alamat);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding alamat: ' || SQLERRM);
END;

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 2: ADD_TO_WISHLIST
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE add_alamat(
    p_id_customer IN VARCHAR2,
    p_detail_alamat IN VARCHAR2,
    p_kode_pos IN VARCHAR2,
    p_id_kecamatan IN VARCHAR2
) IS
    l_id_alamat VARCHAR2(32);        -- ID Alamat yang digenerate
    l_kecamatan_exists INTEGER;     -- Untuk memeriksa apakah kecamatan valid
    l_count_alamat INTEGER;         -- Nomor urut alamat customer
    l_customer_code VARCHAR2(3);    -- 3 digit pertama dari id_customer
    l_kecamatan_code VARCHAR2(3);   -- 3 digit terakhir dari id_kecamatan
BEGIN
    -- Cek apakah id_kecamatan ada
    SELECT COUNT(*)
    INTO l_kecamatan_exists
    FROM kecamatan
    WHERE id_kecamatan = p_id_kecamatan;

    IF l_kecamatan_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Error: Kecamatan ID does not exist');
    END IF;

    -- Ambil 3 digit pertama dari id_customer
    l_customer_code := SUBSTR(p_id_customer, -3, 3);

    -- Ambil 3 digit terakhir dari id_kecamatan
    l_kecamatan_code := SUBSTR(p_id_kecamatan, -3, 3);

    -- Hitung nomor urut alamat berdasarkan id_customer dan id_kecamatan
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id_alamat, -2))), 0) + 1
    INTO l_count_alamat
    FROM alamatcustomer
    WHERE id_customer = p_id_customer
      AND id_kecamatan = p_id_kecamatan;

    -- Generate ID Alamat
    l_id_alamat := 'ACUS' || l_customer_code || l_kecamatan_code || LPAD(l_count_alamat, 2, '0');

    -- Insert ke tabel alamatcustomer
    INSERT INTO alamatcustomer (
        id_alamat,
        detail_alamat,
        kode_pos,
        id_kecamatan,
        id_customer
    )
    VALUES (
        l_id_alamat,
        p_detail_alamat,
        p_kode_pos,
        p_id_kecamatan,
        p_id_customer
    );

    DBMS_OUTPUT.PUT_LINE('Alamat added successfully with ID: ' || l_id_alamat);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding alamat: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 3: DELETE_FROM_KERANJANG
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE delete_from_keranjang (
    p_id_keranjang IN VARCHAR2
)
AS
    v_id_checkout keranjang.id_checkout%TYPE;  -- Variabel untuk menyimpan nilai id_checkout
BEGIN
    -- Periksa apakah ID Keranjang ada di tabel
    SELECT id_checkout
    INTO v_id_checkout
    FROM keranjang
    WHERE id_keranjang = p_id_keranjang;

    -- Jika id_checkout tidak NULL, barang sudah di-checkout
    IF v_id_checkout IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Gagal menghapus: Barang sudah di-checkout dan tidak dapat dihapus.');
        RETURN;
    END IF;

    -- Hapus baris dari keranjang berdasarkan ID Keranjang
    DELETE FROM keranjang
    WHERE id_keranjang = p_id_keranjang;

    -- Berikan informasi bahwa baris berhasil dihapus
    DBMS_OUTPUT.PUT_LINE('Baris dengan ID Keranjang ' || p_id_keranjang || ' berhasil dihapus.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Gagal menghapus: ID Keranjang ' || p_id_keranjang || ' tidak ditemukan.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 4: DELETE_FROM_WISHLIST
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE delete_from_wishlist(
    p_id_customer IN VARCHAR2,
    p_id_detail_produk IN VARCHAR2
) IS
    l_wishlist_exists INTEGER;
BEGIN
    -- Check if the wishlist entry exists for the given customer and product
    SELECT COUNT(*)
    INTO l_wishlist_exists
    FROM wishlist
    WHERE id_customer = p_id_customer
    AND id_detail_produk = p_id_detail_produk;

    IF l_wishlist_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Error: Wishlist item does not exist for the given customer and product');
    END IF;

    -- Delete the entry from the wishlist
    DELETE FROM wishlist
    WHERE id_customer = p_id_customer
    AND id_detail_produk = p_id_detail_produk;

    DBMS_OUTPUT.PUT_LINE('Wishlist item deleted successfully for customer ID: ' || p_id_customer);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting from wishlist: ' || SQLERRM);
END;



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 5: EDIT_DETAIL_PRODUK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
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


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 6: EDIT_PRODUK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE edit_produk(
    p_id_produk    IN produk.id_produk%TYPE,
    p_nama_produk  IN produk.nama_produk%TYPE,
    p_kategori     IN produk.kategori%TYPE,
    p_deskripsi    IN produk.deskripsi%TYPE
) AS
    v_kategori_valid BOOLEAN := FALSE;
BEGIN
    -- Validasi kategori
    IF p_kategori IN ('tops', 'cardigan and jacket', 'dress', 'skirts', 'accessoris') THEN
        v_kategori_valid := TRUE;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Kategori tidak valid.');
    END IF;

    -- Update data produk
    IF v_kategori_valid THEN
        UPDATE produk
        SET nama_produk = p_nama_produk,
            kategori = p_kategori,
            deskripsi = p_deskripsi
        WHERE id_produk = p_id_produk;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'ID Produk tidak ditemukan.');
        END IF;
    END IF;

    COMMIT;
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 7: HAPUS_PRODUK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE HAPUS_PRODUK (
    p_id_produk IN VARCHAR2
) IS
    -- Variabel untuk mengecek apakah produk ada
    v_count_produk INTEGER;
BEGIN
    -- Mengecek apakah produk dengan id tertentu ada
    SELECT COUNT(*) INTO v_count_produk
    FROM produk
    WHERE id_produk = p_id_produk;

    -- Jika produk tidak ditemukan, tampilkan pesan error
    IF v_count_produk = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Produk dengan ID ' || p_id_produk || ' tidak ditemukan.');
    ELSE
        -- Hapus detail produk terkait
        DELETE FROM detailproduk
        WHERE id_produk = p_id_produk;

        -- Hapus produk dari tabel produk
        DELETE FROM produk
        WHERE id_produk = p_id_produk;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Produk dengan ID ' || p_id_produk || ' beserta detailnya berhasil dihapus.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Menangani kesalahan umum
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END HAPUS_PRODUK;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 8: INSERT_TO_CHECKOUT
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE insert_to_checkout (
    p_id_customer IN VARCHAR2,
    p_id_metode IN VARCHAR2
)
AS
    v_total NUMBER(10, 2);           -- Variabel untuk menghitung total
    v_id_checkout VARCHAR2(72);       -- Variabel untuk menyimpan ID Checkout
    v_status_pembayaran VARCHAR2(20) := 'PENDING';  -- Status pembayaran
    v_waktu_checkout TIMESTAMP;       -- Waktu Checkout (24 jam setelah sekarang)
    v_waktu_last_update TIMESTAMP := SYSTIMESTAMP;  -- Waktu Last Update (waktu saat ini dengan presisi)
    v_counter NUMBER;                -- Variabel untuk menghitung jumlah checkout pada jam yang sama
BEGIN
    -- Hitung total berdasarkan subtotal di tabel keranjang untuk id_customer yang diberikan
    SELECT SUM(subtotal)
    INTO v_total
    FROM keranjang
    WHERE id_customer = p_id_customer
    AND id_checkout IS NULL;  -- Hanya ambil barang yang belum di-checkout

    -- Periksa apakah ada barang di keranjang untuk customer tersebut
    IF v_total = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Gagal melakukan checkout: Tidak ada barang di keranjang.');
        RETURN;
    END IF;

    -- Hitung jumlah checkout yang sudah dilakukan oleh customer pada jam yang sama
    SELECT COUNT(*) + 1
    INTO v_counter
    FROM checkout
    WHERE id_checkout LIKE p_id_customer || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MI') || '%';

    -- Generate ID Checkout berdasarkan ID Customer, tahun, jam, dan counter
    v_id_checkout := p_id_customer || TO_CHAR(SYSTIMESTAMP, 'YYYYMMDDHH24MI') || TO_CHAR(v_counter, 'FM000');

    -- Tentukan waktu checkout (24 jam setelah sekarang)
    v_waktu_checkout := SYSTIMESTAMP + INTERVAL '1' DAY;  -- Menambahkan 1 hari ke waktu saat ini

    -- Insert data ke tabel checkout
    INSERT INTO checkout (
        id_checkout, total, status_pembayaran, waktu_checkout, waktu_last_update, id_metode, id_customer
    )
    VALUES (
        v_id_checkout, v_total, v_status_pembayaran, v_waktu_checkout, v_waktu_last_update, p_id_metode, p_id_customer
    );

    -- Update keranjang untuk menetapkan ID Checkout
    UPDATE keranjang
    SET id_checkout = v_id_checkout
    WHERE id_customer = p_id_customer
    AND id_checkout IS NULL;

    -- Berikan informasi bahwa data berhasil diinsert
    DBMS_OUTPUT.PUT_LINE('Checkout berhasil dilakukan dengan ID: ' || v_id_checkout);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 9: INSERT_TO_KERANJANG
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE insert_to_keranjang (
    p_id_customer      IN VARCHAR2,
    p_id_detail_produk IN VARCHAR2,
    p_kuantitas       IN NUMBER
)
AS
    v_id_keranjang VARCHAR(32);
    v_harga_reguler NUMBER; 
    v_stok          NUMBER;  
    v_subtotal      NUMBER;  
    v_id_diskon     VARCHAR2(50); 
    v_persentase_diskon FLOAT;
    v_urut NUMBER;
BEGIN
    SELECT stok, harga_reguler, id_diskon
    INTO v_stok, v_harga_reguler, v_id_diskon
    FROM detailproduk
    WHERE id_detail_produk = p_id_detail_produk;

    IF p_kuantitas > v_stok THEN
        DBMS_OUTPUT.PUT_LINE('Gagal menambahkan ke keranjang: Kuantitas melebihi stok yang tersedia.');
        RETURN;
    END IF;

    IF v_id_diskon IS NOT NULL THEN
        SELECT diskon
        INTO v_persentase_diskon
        FROM DISKON
        WHERE id_diskon = v_id_diskon;

        v_subtotal := p_kuantitas * (v_harga_reguler * (1 - v_persentase_diskon));
    ELSE 
        v_subtotal := p_kuantitas * v_harga_reguler;
    END IF;
    
    SELECT NVL(MAX(SUBSTR(id_keranjang, -3)), 0) + 1
    INTO v_urut
    FROM keranjang
    WHERE SUBSTR(id_keranjang, 4, 8) = TO_CHAR(SYSDATE, 'YYYYMMDD');
    
    v_id_keranjang := 'KRJ' || TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(v_urut, 3, '0');

    INSERT INTO keranjang (id_keranjang, kuantitas, id_detail_produk, id_customer, subtotal, id_checkout)
    VALUES (v_id_keranjang, p_kuantitas, p_id_detail_produk, p_id_customer, v_subtotal, NULL);

    DBMS_OUTPUT.PUT_LINE('Data berhasil ditambahkan ke keranjang dengan ID: ' || v_id_keranjang);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Gagal menambahkan ke keranjang: ID detail produk tidak ditemukan.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 10: LAPORAN_PENJUALAN
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE laporan_penjualan IS
  CURSOR penjualan_cursor IS
    SELECT 
        p.nama_produk,
        p.kategori,
        SUM(k.kuantitas) AS total_terjual,
        SUM(k.subtotal) AS total_pendapatan
    FROM 
        keranjang k
    JOIN 
        detailproduk dp ON k.id_detail_produk = dp.id_detail_produk
    JOIN 
        produk p ON dp.id_produk = p.id_produk
    WHERE 
        k.id_checkout IS NOT NULL  -- Hanya penjualan yang telah dilakukan checkout
    GROUP BY 
        p.nama_produk, p.kategori
    ORDER BY 
        total_pendapatan DESC;

  record_penjualan penjualan_cursor%ROWTYPE;
BEGIN
  -- Header laporan
  DBMS_OUTPUT.PUT_LINE('Laporan Penjualan:');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Nama Produk | Kategori | Total Terjual | Total Pendapatan');
  DBMS_OUTPUT.PUT_LINE('---------------------------------------------');

  -- Iterasi melalui data penjualan
  FOR record_penjualan IN penjualan_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(record_penjualan.nama_produk || ' | ' ||
                         record_penjualan.kategori || ' | ' ||
                         record_penjualan.total_terjual || ' | ' ||
                         record_penjualan.total_pendapatan);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
END;



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 11: PERBARUI_STOK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE PERBARUI_STOK(
    p_id_detail_produk IN VARCHAR2,
    p_stok_ditambahkan IN NUMBER
) AS
    v_stok_awal NUMBER;
BEGIN
    -- Validasi input stok ditambahkan
    IF p_stok_ditambahkan <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'Stok yang ditambahkan harus lebih dari 0.'
        );
    END IF;

    -- Ambil stok awal untuk validasi id_detail_produk
    SELECT stok
    INTO v_stok_awal
    FROM detailproduk
    WHERE id_detail_produk = p_id_detail_produk;

    -- Perbarui stok
    UPDATE detailproduk
    SET stok = stok + p_stok_ditambahkan
    WHERE id_detail_produk = p_id_detail_produk;

    DBMS_OUTPUT.PUT_LINE('Stok berhasil diperbarui. Stok awal: ' || v_stok_awal || ', stok ditambahkan: ' || p_stok_ditambahkan || ', stok akhir: ' || (v_stok_awal + p_stok_ditambahkan));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'ID Detail Produk tidak ditemukan.'
        );
END;



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 12: REGISTER_USER
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE register_user(
    p_nama IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2
)
AS
    l_count NUMBER;        -- Untuk mengecek email sudah terdaftar atau belum
    l_year VARCHAR2(4);    -- Menyimpan format tahun (YYYY)
    l_sequence NUMBER;     -- Menyimpan nomor urut berdasarkan tahun
    l_id_customer VARCHAR2(32 CHAR); -- ID Customer yang akan digenerate
BEGIN
    -- Cek apakah email sudah terdaftar
    SELECT COUNT(*)
    INTO l_count
    FROM customer
    WHERE email = p_email;

    IF l_count = 0 THEN
        -- Ambil tahun saat ini
        l_year := TO_CHAR(SYSDATE, 'YYYY');

        -- Hitung nomor urut berdasarkan tahun
        SELECT NVL(MAX(TO_NUMBER(SUBSTR(id_customer, -2))), 0) + 1
        INTO l_sequence
        FROM customer
        WHERE SUBSTR(id_customer, 4, 4) = l_year;

        -- Generate ID Customer
        l_id_customer := 'CUS' || l_year || LPAD(l_sequence, 3, '0');

        -- Insert data ke tabel customer
        INSERT INTO customer (id_customer, username, email, password)
        VALUES (l_id_customer, p_nama, p_email, p_password);

        DBMS_OUTPUT.PUT_LINE('User berhasil didaftarkan dengan ID Customer: ' || l_id_customer);
    ELSE
        -- Raise error jika email sudah terdaftar
        RAISE_APPLICATION_ERROR(-20001, 'Email already registered.');
    END IF;
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 13: TAMBAH_DETAIL_PRODUK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE register_user(
    p_nama IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2
)
AS
    l_count NUMBER;        -- Untuk mengecek email sudah terdaftar atau belum
    l_year VARCHAR2(4);    -- Menyimpan format tahun (YYYY)
    l_sequence NUMBER;     -- Menyimpan nomor urut berdasarkan tahun
    l_id_customer VARCHAR2(32 CHAR); -- ID Customer yang akan digenerate
BEGIN
    -- Cek apakah email sudah terdaftar
    SELECT COUNT(*)
    INTO l_count
    FROM customer
    WHERE email = p_email;

    IF l_count = 0 THEN
        -- Ambil tahun saat ini
        l_year := TO_CHAR(SYSDATE, 'YYYY');

        -- Hitung nomor urut berdasarkan tahun
        SELECT NVL(MAX(TO_NUMBER(SUBSTR(id_customer, -2))), 0) + 1
        INTO l_sequence
        FROM customer
        WHERE SUBSTR(id_customer, 4, 4) = l_year;

        -- Generate ID Customer
        l_id_customer := 'CUS' || l_year || LPAD(l_sequence, 3, '0');

        -- Insert data ke tabel customer
        INSERT INTO customer (id_customer, username, email, password)
        VALUES (l_id_customer, p_nama, p_email, p_password);

        DBMS_OUTPUT.PUT_LINE('User berhasil didaftarkan dengan ID Customer: ' || l_id_customer);
    ELSE
        -- Raise error jika email sudah terdaftar
        RAISE_APPLICATION_ERROR(-20001, 'Email already registered.');
    END IF;
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 14: TAMBAH_DISKON
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE TAMBAH_DISKON( 
    p_id_produk IN VARCHAR2,
    p_nama_diskon IN VARCHAR2,
    p_tanggal_mulai IN DATE,
    p_tanggal_berakhir IN DATE,
    p_diskon IN FLOAT,
    p_maksimal_diskon IN NUMBER
) IS
    v_id_diskon VARCHAR2(32 CHAR);
BEGIN
    -- Memeriksa apakah tanggal mulai lebih besar dari hari ini
    IF p_tanggal_mulai <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Tanggal mulai harus lebih besar dari hari ini');
    END IF;

    -- Memeriksa apakah tanggal berakhir lebih besar dari tanggal mulai
    IF p_tanggal_berakhir <= p_tanggal_mulai THEN
        RAISE_APPLICATION_ERROR(-20002, 'Tanggal berakhir harus lebih besar dari tanggal mulai');
    END IF;

    -- Membuat ID diskon secara otomatis (misalnya: DSK001)
    BEGIN
        SELECT 'DSK' || LPAD(TO_CHAR(NVL(MAX(TO_NUMBER(SUBSTR(id_diskon, 4))), 0) + 1), 3, '0')
        INTO v_id_diskon
        FROM diskon
        WHERE REGEXP_LIKE(id_diskon, '^DSK[0-9]+$');  -- Pastikan hanya ID dengan format yang benar
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_id_diskon := 'DSK001';  -- Jika tidak ada data, mulai dengan DSK001
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Terjadi kesalahan saat membuat ID diskon');
    END;

    -- Menambahkan data diskon ke tabel diskon
    INSERT INTO diskon(id_diskon, nama_diskon, tanggal_mulai, tanggal_berakhir, diskon, maksimal_diskon)
    VALUES (v_id_diskon, p_nama_diskon, p_tanggal_mulai, p_tanggal_berakhir, p_diskon, p_maksimal_diskon);

    -- Memperbarui diskon di tabel detailproduk untuk semua produk dengan id_produk yang sesuai
    UPDATE detailproduk
    SET id_diskon = v_id_diskon
    WHERE id_produk = p_id_produk;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Diskon berhasil ditambahkan dengan ID: ' || v_id_diskon);
END TAMBAH_DISKON;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 15: TAMBAH_PRODUK
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE tambah_produk (
    p_nama_produk   IN VARCHAR2,
    p_kategori      IN VARCHAR2,
    p_deskripsi     IN CLOB
) IS
    v_id_produk      VARCHAR2(32);
    v_kode_kategori  VARCHAR2(3);  -- Mengubah panjang menjadi 3 untuk kode kategori
    v_produk_ada     INTEGER := 0;
    v_increment      INTEGER;
BEGIN
    -- Validasi kategori
    IF LOWER(p_kategori) NOT IN ('tops', 'cardigan and jacket', 'dress', 'skirts', 'accessories', 'bottoms', 'outerwear', 'footwear', 'activewear', 'lingerie', 'swimwear') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Kategori tidak valid.');
    END IF;

    -- Validasi nama produk unik
    SELECT COUNT(*)
    INTO v_produk_ada
    FROM produk
    WHERE LOWER(nama_produk) = LOWER(p_nama_produk);

    IF v_produk_ada > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Produk dengan nama yang sama sudah ada.');
    END IF;

    -- Tentukan kode kategori (3 huruf)
    CASE LOWER(p_kategori)
        WHEN 'tops' THEN v_kode_kategori := 'TOP';
        WHEN 'cardigan and jacket' THEN v_kode_kategori := 'CJ';
        WHEN 'dress' THEN v_kode_kategori := 'DRS';
        WHEN 'skirts' THEN v_kode_kategori := 'SKT';
        WHEN 'accessories' THEN v_kode_kategori := 'ACC';
        WHEN 'bottoms' THEN v_kode_kategori := 'BOT';
        WHEN 'outerwear' THEN v_kode_kategori := 'OWT';
        WHEN 'footwear' THEN v_kode_kategori := 'FW';
        WHEN 'activewear' THEN v_kode_kategori := 'AW';
        WHEN 'lingerie' THEN v_kode_kategori := 'LNG';
        WHEN 'swimwear' THEN v_kode_kategori := 'SWM';
    END CASE;

    -- Ambil angka increment (contoh: mencari angka terbesar dan menambahkannya dengan 1)
    SELECT NVL(MAX(TO_NUMBER(SUBSTR(id_produk, -2))), 0) + 1
    INTO v_increment
    FROM produk
    WHERE SUBSTR(id_produk, 1, 6) = 'PROD' || v_kode_kategori;

    -- Generate id_produk dengan format PROD + kode kategori + angka increment
    v_id_produk := 'PROD' || v_kode_kategori || TO_CHAR(v_increment, 'FM00');  -- Pastikan angka increment 2 digit

    -- Insert ke tabel produk
    INSERT INTO produk (id_produk, nama_produk, kategori, deskripsi)
    VALUES (v_id_produk, p_nama_produk, p_kategori, p_deskripsi);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20003, 'Terjadi kesalahan saat menambahkan produk: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 16: UPDATE_ALAMAT
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE update_alamat(
    p_id_alamat IN VARCHAR2,
    p_detail_alamat IN VARCHAR2,
    p_kode_pos IN VARCHAR2,
    p_id_kecamatan IN VARCHAR2
) IS
    l_alamat_exists INTEGER;
    l_kecamatan_exists INTEGER;
BEGIN
    -- Check if id_alamat exists
    SELECT COUNT(*)
    INTO l_alamat_exists
    FROM alamatcustomer
    WHERE id_alamat = p_id_alamat;

    IF l_alamat_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Error: Alamat ID does not exist');
    END IF;

    -- Check if id_kecamatan exists
    SELECT COUNT(*)
    INTO l_kecamatan_exists
    FROM kecamatan
    WHERE id_kecamatan = p_id_kecamatan;

    IF l_kecamatan_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error: Kecamatan ID does not exist');
    END IF;

    -- Update the alamatcustomer record
    UPDATE alamatcustomer
    SET detail_alamat = p_detail_alamat,
        kode_pos = p_kode_pos,
        id_kecamatan = p_id_kecamatan
    WHERE id_alamat = p_id_alamat;

    DBMS_OUTPUT.PUT_LINE('Alamat updated successfully for ID: ' || p_id_alamat);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating alamat: ' || SQLERRM);
END;



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 17: UPDATE_CHECKOUT_STATUS
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE update_checkout_status (
    p_id_checkout IN VARCHAR2, 
    p_status_pembayaran IN VARCHAR2 
)
AS
    v_valid_status BOOLEAN := FALSE; 
BEGIN
    IF UPPER(p_status_pembayaran) IN ('SUCCESS', 'CANCELED') THEN
        v_valid_status := TRUE;
    END IF;

    IF NOT v_valid_status THEN
        DBMS_OUTPUT.PUT_LINE('Status pembayaran tidak valid. Hanya dapat menggunakan SUCCESS atau CANCELLED.');
        RETURN;
    END IF;

    UPDATE checkout
    SET status_pembayaran = UPPER(p_status_pembayaran),
        waktu_last_update = SYSTIMESTAMP
    WHERE id_checkout = p_id_checkout;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Gagal mengupdate: ID Checkout tidak ditemukan.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Status pembayaran berhasil diupdate untuk ID Checkout: ' || p_id_checkout);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Terjadi kesalahan: ' || SQLERRM);
END;


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
PROSEDUR 18: UPDATE_DATA_DIRI
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace PROCEDURE update_data_diri(
    p_id_customer IN VARCHAR2,
    p_email IN VARCHAR2,
    p_password IN VARCHAR2,
    p_username IN VARCHAR2
) IS
    l_customer_exists INTEGER;
BEGIN
    -- Check if id_customer exists
    SELECT COUNT(*)
    INTO l_customer_exists
    FROM customer
    WHERE id_customer = p_id_customer;

    IF l_customer_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error: Customer ID does not exist');
    END IF;

    -- Update the customer record
    UPDATE customer
    SET email = p_email,
        password = p_password,
        username = p_username
    WHERE id_customer = p_id_customer;

    DBMS_OUTPUT.PUT_LINE('Customer data updated successfully for ID: ' || p_id_customer);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating customer data: ' || SQLERRM);
END;
