DELIMITER //
CREATE PROCEDURE register_user(
    IN user_name VARCHAR(255), 
    IN user_email VARCHAR(255), 
    IN user_password VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM akun WHERE email = user_email) THEN
        INSERT INTO akun (nama, email, 'password') VALUES (user_name, user_email, user_password);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION login_user(user_email VARCHAR(255), user_password VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE user_id INT;
    SELECT id_akun INTO user_id 
    FROM akun 
    WHERE email = user_email AND password = user_password;
    RETURN user_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE tambah_size_produk(
    IN product_id INT, 
    IN 'size' VARCHAR(10), 
    IN price INT, 
    IN stock INT
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM size_produk WHERE id_produk = product_id AND 'size' = 'size') THEN
        INSERT INTO size_produk (id_produk, 'size', harga, stok) VALUES (product_id, 'size', price, stock);
    END IF;
END //
DELIMITER ;

CREATE VIEW user_addresses AS
SELECT 
    a.id_akun,
    a.alamat_lengkap,
    p.nama_provinsi,
    k.nama_kota,
    kec.nama_kecamatan,
    d.nama_desa_kel
FROM alamat a
JOIN provinsi p ON LEFT(a.kode_alamat, 2) = p.id_provinsi
JOIN kab_kota k ON SUBSTRING(a.kode_alamat, 3, 2) = k.id_kota
JOIN kecamatan kec ON SUBSTRING(a.kode_alamat, 5, 3) = kec.id_kecamatan
JOIN desa_kel d ON RIGHT(a.kode_alamat, 3) = d.id_desa_kel;

DELIMITER //
CREATE PROCEDURE update_user_data(
    IN user_id INT,
    IN new_name VARCHAR(255),
    IN new_password VARCHAR(255)
)
BEGIN
    IF new_name IS NOT NULL THEN
        UPDATE akun SET nama = new_name WHERE id_akun = user_id;
    END IF;

    IF new_password IS NOT NULL THEN
        UPDATE akun SET password = new_password WHERE id_akun = user_id;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_product(
    IN product_name VARCHAR(255),
    IN product_description TEXT,
    IN category_name VARCHAR(255)
)
BEGIN
    DECLARE category_id INT;
    
    SELECT id_kategori INTO category_id FROM list_kategori WHERE kategori = category_name;
    
    IF category_id IS NOT NULL THEN
        INSERT INTO list_produk (nama_barang, deskripsi, id_kategori) 
        VALUES (product_name, product_description, category_id);
        -- INSERT INTO list_kategori (kategori) VALUES (category_name);
        -- SET category_id = LAST_INSERT_ID();
    END IF;
    
    -- INSERT INTO list_produk (nama_barang, deskripsi, id_kategori) 
    -- VALUES (product_name, product_description, category_id);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_to_cart(
    IN user_id INT,
    IN product_id INT,
    IN product_size VARCHAR(10),
    IN quantity INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM size_produk WHERE id_produk = product_id AND 'size' = product_size) THEN
        INSERT INTO keranjang (id_akun, id_barang, 'size', jumlah_barang) 
        VALUES (user_id, product_id, product_size, quantity);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid product size';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE update_cart(
    IN user_id INT,
    IN product_id INT,
    IN product_size VARCHAR(10),
    IN new_quantity INT
)
BEGIN
    UPDATE keranjang 
    SET size = product_size, jumlah_barang = new_quantity
    WHERE id_akun = user_id AND id_barang = product_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE delete_from_cart(
    IN user_id INT,
    IN product_id INT,
    IN product_size VARCHAR(10)
)
BEGIN
    DELETE FROM keranjang 
    WHERE id_akun = user_id AND id_barang = product_id AND size = product_size;
END //
DELIMITER ;

DELIMITER //
        CREATE PROCEDURE add_payment_method(
            IN payment_method VARCHAR(255)
        )
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pembayaran_terdaftar WHERE jenis_pembayaran = payment_method) THEN
        INSERT INTO pembayaran_terdaftar (jenis_pembayaran) VALUES (payment_method);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_discount(
    IN product_id INT,
    IN 'size' VARCHAR(10),
    IN discount_percentage INT,
    IN 'start_date' DATE,
    IN end_date DATE
)
BEGIN
    INSERT INTO diskon (id_produk, 'size', diskon, tanggal_mulai, tanggal_akhir)
    VALUES (product_id, 'size', discount_percentage, 'start_date', end_date)
    ON DUPLICATE KEY UPDATE 
        diskon = discount_percentage,
        tanggal_mulai = 'start_date',
        tanggal_akhir = end_date;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE update_payment_status(
    IN purchase_id INT,
    IN payment_method VARCHAR(255)
)
BEGIN
    DECLARE payment_id INT;
    SELECT id_pembayaran_terdaftar INTO payment_id 
    FROM pembayaran_terdaftar WHERE jenis_pembayaran = payment_method;

    IF payment_id IS NOT NULL THEN
        UPDATE riwayat_pembelian 
        SET status_pembayaran = 'Sudah bayar', id_pembayaran_terdaftar = payment_id 
        WHERE id_pembelian = purchase_id;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid payment method';
    END IF;
END //
DELIMITER ;

CREATE VIEW cart_contents AS
SELECT 
    k.id_akun,
    k.id_barang,
    p.nama_barang,
    p.deskripsi,
    s.size,
    s.harga,
    k.jumlah_barang,
    c.kategori
FROM keranjang k
JOIN list_produk p ON k.id_barang = p.id_produk
JOIN size_produk s ON k.id_barang = s.id_produk AND k.size = s.size
JOIN list_kategori c ON p.id_kategori = c.id_kategori;

DELIMITER //
CREATE FUNCTION calculate_total_price(
    cart_id INT,
    purchase_date DATE
)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_price DECIMAL(10,2) DEFAULT 0;

    SELECT SUM(
        s.harga * k.jumlah_barang * (1 - IFNULL(d.diskon, 0) / 100)
    ) INTO total_price
    FROM keranjang k
    JOIN size_produk s ON k.id_barang = s.id_produk AND k.size = s.size
    LEFT JOIN diskon d ON k.id_barang = d.id_produk AND k.size = d.size 
        AND purchase_date BETWEEN d.tanggal_mulai AND d.tanggal_akhir
    WHERE k.id_keranjang = cart_id;

    RETURN total_price;
END //
DELIMITER ;

