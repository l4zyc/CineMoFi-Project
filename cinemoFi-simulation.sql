-- Menambahkan 2 Customer baru yang bernama Jack dan Mary
INSERT INTO MsCustomer VALUES 
	('CU011', 'Jack Handerson', '2005-05-08', 'Male'),
	('CU012', 'Mary Landerson', '1999-12-15', 'Female')

-- Membuat 2 Transaction Baru untuk 2 Customer baru
INSERT INTO TransactionHeader VALUES 
	('TR016','ST010', 'CU011', '2024-06-13'),
	('TR017', 'ST009', 'CU012', '2024-06-13')

-- Memberikan Detail dari Transaction tentang pemesanan/pembelian yang dilakukan yang terdapat makanan, tiket, dan minuman
-- beserta juga dengan jumlah pembelian
INSERT INTO TransactionDetail VALUES 
	('TR016', 'DR001', 'MO003', 'FO002', 2, 1, 3),
	('TR017', 'DR002', 'MO002', 'FO001', 2, 2, 2)

-- Mulai Transaksi Eksplisit
BEGIN TRANSACTION

-- Memperbarui data table MsCustomer dengan mengganti nama pelanggan karena salah input
UPDATE MsCustomer
SET CustomerName = 'Jack Rythm'
WHERE CustomerID = 'CU012'

-- Menghapus data TransactionDetail dengan Transaction ID T017
DELETE FROM TransactionDetail
WHERE TransactionID = 'TR017'

-- Commit perubahan transaction tersebut
COMMIT 
-- Membatalkan perubahan
ROLLBACK
