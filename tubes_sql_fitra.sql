DECLARE
    v_deskripsi_produk VARCHAR2(1024); 
BEGIN
    v_deskripsi_produk := 'Relax Shirt
Nikmati kenyamanan maksimal tanpa mengorbankan gaya dengan Relax Shirt. Dirancang khusus untuk pria modern yang menginginkan kesan santai namun tetap rapi, kemeja ini adalah pilihan ideal untuk aktivitas harian Anda.

Fitur utama:

Bahan Premium: Menggunakan campuran katun dan linen yang ringan, lembut, dan breathable untuk kenyamanan sepanjang hari.
Potongan Regular Fit: Memberikan ruang gerak yang bebas tanpa terlihat longgar.
Desain Santai: Dilengkapi detail kerah minimalis dan kancing kayu untuk tampilan natural dan santai.
Pilihan Warna Lembut: Tersedia dalam warna-warna netral dan pastel, cocok untuk suasana kasual hingga semi-formal.
Relax Shirt sangat cocok untuk acara santai, perjalanan liburan, atau sekadar menikmati waktu bersama teman dan keluarga. Dengan perpaduan antara fungsionalitas dan estetika, kemeja ini wajib ada di koleksi Anda. Pilihan sempurna untuk pria yang mencintai kenyamanan dan gaya.';

    insert_produk('Relax Shirt', 'baju pria', v_deskripsi_produk);
END;
/