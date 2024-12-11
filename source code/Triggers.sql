-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--DAFTAR TRIGGER
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- 1. TRG_UPDATE_STOCK_ON_CANCEL  
-- 2. TRG_UPDATE_STOCK_ON_CHECKOUT  
-- 3. TRG_UPDATE_SUBTOTAL_DISCOUNT 

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- TRG_UPDATE_STOCK_ON_CANCEL  
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace TRIGGER trg_update_stock_on_cancel
AFTER UPDATE OF status_pembayaran ON checkout
FOR EACH ROW
WHEN (NEW.status_pembayaran = 'CANCELED')
DECLARE
    CURSOR cur_keranjang IS
        SELECT k.id_detail_produk, k.kuantitas
        FROM keranjang k
        WHERE k.id_checkout = :NEW.id_checkout;
BEGIN
    -- Iterasi setiap item dalam keranjang terkait checkout yang dibatalkan
    FOR r IN cur_keranjang LOOP
        UPDATE detailproduk
        SET stok = stok + r.kuantitas
        WHERE id_detail_produk = r.id_detail_produk;

        -- Validasi jika update stok gagal
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Gagal mengembalikan stok untuk ID Produk: ' || r.id_detail_produk);
        END IF;
    END LOOP;
END;

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- TRG_UPDATE_STOCK_ON_CHECKOUT  
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace TRIGGER trg_update_stock_on_checkout
AFTER INSERT ON checkout
FOR EACH ROW
DECLARE
    CURSOR c_keranjang IS
        SELECT k.id_detail_produk, k.kuantitas
        FROM keranjang k
        WHERE k.id_customer = :NEW.id_customer;

    v_detail_produk keranjang.id_detail_produk%TYPE;
    v_kuantitas keranjang.kuantitas%TYPE;
BEGIN
    -- Periksa jika status_pembayaran adalah PENDING
    IF :NEW.status_pembayaran = 'PENDING' THEN
        -- Iterasi setiap item dalam keranjang untuk customer ini
        FOR r IN c_keranjang LOOP
            v_detail_produk := r.id_detail_produk;
            v_kuantitas := r.kuantitas;

            -- Update stok pada tabel detailproduk
            UPDATE detailproduk
            SET stok = stok - v_kuantitas
            WHERE id_detail_produk = v_detail_produk;

            -- Validasi apakah stok mencukupi (stok tidak boleh negatif)
            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'Stok produk tidak mencukupi untuk ID: ' || v_detail_produk);
            END IF;
        END LOOP;
    END IF;
END;

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- TRG_UPDATE_SUBTOTAL_DISCOUNT 
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
create or replace TRIGGER trg_update_subtotal_discount
AFTER UPDATE OF id_diskon ON detailproduk
FOR EACH ROW
DECLARE
    v_diskon_percentage NUMBER;
    v_subtotal NUMBER;
    v_kuantitas NUMBER;
BEGIN
    -- Cek jika diskon baru ditambahkan
    IF :NEW.id_diskon IS NOT NULL AND :OLD.id_diskon IS NULL THEN
        -- Ambil nilai diskon dari tabel diskon
        SELECT diskon INTO v_diskon_percentage
        FROM diskon
        WHERE id_diskon = :NEW.id_diskon;

        -- Update subtotal di keranjang (hanya untuk keranjang dengan id_checkout IS NULL)
        FOR record IN (
            SELECT id_keranjang, kuantitas
            FROM keranjang
            WHERE id_detail_produk = :NEW.id_detail_produk AND id_checkout IS NULL
        ) LOOP
            v_subtotal := :NEW.harga_reguler * (1 - v_diskon_percentage / 100) * record.kuantitas;

            UPDATE keranjang
            SET subtotal = v_subtotal
            WHERE id_keranjang = record.id_keranjang;
        END LOOP;

    -- Cek jika diskon dihapus (id_diskon menjadi NULL)
    ELSIF :NEW.id_diskon IS NULL AND :OLD.id_diskon IS NOT NULL THEN
        -- Update subtotal dengan harga reguler
        FOR record IN (
            SELECT id_keranjang, kuantitas
            FROM keranjang
            WHERE id_detail_produk = :NEW.id_detail_produk AND id_checkout IS NULL
        ) LOOP
            v_subtotal := :NEW.harga_reguler * record.kuantitas;

            UPDATE keranjang
            SET subtotal = v_subtotal
            WHERE id_keranjang = record.id_keranjang;
        END LOOP;
    END IF;
END;

