CREATE DATABASE CineMoFi

GO
USE CineMoFi
GO

CREATE TABLE MsStaff(
	StaffID CHAR(5) PRIMARY KEY CHECK(StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(100) NOT NULL,
	StaffDOB Date CHECK (DATEDIFF(YEAR, StaffDOB, GETDATE()) >= 17) NOT NULL,
	StaffAddress VARCHAR(225) NOT NULL,
	StaffGender VARCHAR(100) NOT NULL CHECK(StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
)

INSERT INTO MsStaff VALUES
    ('ST001', 'John Doe', '1990-05-15', '123 Main Street, City', 'Male'),
    ('ST002', 'Jane Smith', '1995-08-20', '456 Elm Street, Town', 'Female'),
    ('ST003', 'Michael Johnson', '1988-12-10', '789 Oak Avenue, Village', 'Male'),
    ('ST004', 'Emily Brown', '1993-04-25', '101 Pine Road, Suburb', 'Female'),
    ('ST005', 'David Lee', '1997-11-30', '246 Maple Lane, Countryside', 'Male'),
    ('ST006', 'Sarah Wilson', '1992-07-05', '369 Cedar Court, Hamlet', 'Female'),
    ('ST007', 'Christopher Taylor', '1985-09-12', '555 Birch Drive, Rural', 'Male'),
    ('ST008', 'Emma Martinez', '1987-03-18', '777 Willow Way, Outskirts', 'Female'),
    ('ST009', 'Daniel Garcia', '1991-10-22', '888 Walnut Street, Periphery', 'Male'),
    ('ST010', 'Olivia Hernandez', '1996-01-08', '999 Sycamore Boulevard, Fringes', 'Female');

CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(100) NOT NULL,
	CustomerDOB Date NOT NULL,
	CustomerGender VARCHAR(100) NOT NULL CHECK(CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'),
)

INSERT INTO MsCustomer VALUES 
    ('CU001', 'Alice Johnson', '1987-06-15', 'Female'),
    ('CU002', 'Bob Smith', '1992-09-20', 'Male'),
    ('CU003', 'Charlie Brown', '1985-03-10', 'Male'),
    ('CU004', 'Diana Lee', '1990-07-25', 'Female'),
    ('CU005', 'Eva Garcia', '1996-11-30', 'Female'),
    ('CU006', 'Frank Martinez', '1994-04-05', 'Male'),
    ('CU007', 'Grace Wilson', '1989-01-12', 'Female'),
    ('CU008', 'Harry Taylor', '1983-08-18', 'Male'),
    ('CU009', 'Ivy Hernandez', '1998-10-22', 'Female'),
    ('CU010', 'Jack Davis', '1993-05-08', 'Male');

CREATE TABLE MsSupplier(
	SupplierID CHAR(5) PRIMARY KEY CHECK(SupplierID LIKE 'SU[0-9][0-9][0-9]'),
	SupplierAddress VARCHAR(225) NOT NULL,
	SupplierName VARCHAR(100) NOT NULL,
)

INSERT INTO MsSupplier VALUES 
    ('SU001', '123 Main Street', 'Johnson Hardware'),
    ('SU002', '456 Elm Street', 'Smith Electronics'),
    ('SU003', '789 Oak Street', 'Wilson Textiles'),
    ('SU004', '321 Maple Street', 'Brown Foods'),
    ('SU005', '654 Pine Street', 'Miller Pharmaceuticals'),
    ('SU006', '987 Cedar Street', 'Anderson Furniture'),
    ('SU007', '741 Birch Street', 'Davis Cosmetics'),
    ('SU008', '852 Walnut Street', 'Taylor Automotive'),
    ('SU009', '369 Cherry Street', 'Martinez Home Goods'),
    ('SU010', '147 Spruce Street', 'Clark Supplies')

CREATE TABLE MsFood(
	FoodID CHAR(5) PRIMARY KEY CHECK(FoodID LIKE 'FO[0-9][0-9][0-9]'),
	FoodPrice FLOAT(10) NOT NULL,
	FoodName VARCHAR(100) NOT NULL,
	FoodCategory VARCHAR(100) NOT NULL CHECK(FoodCategory IN ('Pasta','Salad','Sandwich','Snack','Fried')) 
)

INSERT INTO MsFood VALUES 
    ('FO001', 9.99, 'Spaghetti Carbonara', 'Pasta'),
    ('FO002', 6.49, 'Caesar Salad', 'Salad'),
    ('FO003', 8.99, 'Turkey Club Sandwich', 'Sandwich'),
    ('FO004', 3.99, 'Potato Chips', 'Snack'),
    ('FO005', 5.99, 'Chicken Wings', 'Fried'),
    ('FO006', 10.99, 'Fettuccine Alfredo', 'Pasta'),
    ('FO007', 7.99, 'Greek Salad', 'Salad'),
    ('FO008', 8.49, 'BLT Sandwich', 'Sandwich'),
    ('FO009', 2.99, 'Popcorn', 'Snack'),
    ('FO010', 6.99, 'Onion Rings', 'Fried');

CREATE TABLE MsDrink(
	DrinkID CHAR(5) PRIMARY KEY CHECK(DrinkID LIKE 'DR[0-9][0-9][0-9]'),
	DrinkPrice FLOAT(10) NOT NULL,
	DrinkName VARCHAR(100) NOT NULL,
	DrinkCategory VARCHAR(100) NOT NULL CHECK(DrinkCategory IN ('Soft Drink', 'Tea', 'Coffee', 'Milk', 'Herbal'))
)

INSERT INTO MsDrink VALUES 
    ('DR001', 1.99, 'Cola', 'Soft Drink'),
    ('DR002', 2.49, 'Green Tea', 'Tea'),
    ('DR003', 3.99, 'Latte', 'Coffee'),
    ('DR004', 2.99, 'Chocolate Milk', 'Milk'),
    ('DR005', 2.99, 'Chamomile Tea', 'Herbal'),
    ('DR006', 1.49, 'Orange Juice', 'Soft Drink'),
    ('DR007', 2.99, 'Black Tea', 'Tea'),
    ('DR008', 3.49, 'Cappuccino', 'Coffee'),
    ('DR009', 2.99, 'Strawberry Milk', 'Milk'),
    ('DR010', 1.99, 'Peppermint Tea', 'Herbal');

CREATE TABLE MsMovie(
	MovieID CHAR(5) PRIMARY KEY CHECK(MovieID LIKE 'MO[0-9][0-9][0-9]'),
	MovieCategory VARCHAR(100) NOT NULL CHECK(MovieCategory IN ('U', 'PG', 'PG-13', 'R', 'NC-17')),
	MovieName VARCHAR(100) NOT NULL,
	MovieRating INT NOT NULL CHECK(MovieRating >= 1 AND MovieRating <= 5),
	MovieDuration INT NOT NULL,
	MoviePrice FLOAT(10) NOT NULL
)

INSERT INTO MsMovie VALUES 
    ('MO001', 'PG-13', 'Inception', 5, 148, 10.99),
    ('MO002', 'PG', 'Toy Story', 4, 81, 8.99),
    ('MO003', 'R', 'The Godfather', 5, 175, 12.99),
    ('MO004', 'U', 'Finding Nemo', 4, 100, 9.99),
    ('MO005', 'NC-17', 'Pulp Fiction', 5, 154, 11.99),
    ('MO006', 'PG', 'The Lion King', 5, 88, 9.99),
    ('MO007', 'R', 'Fight Club', 4, 139, 11.99),
    ('MO008', 'PG', 'Harry Potter and the Sorcerers Stone', 4, 152, 10.99),
    ('MO009', 'PG', 'The Incredibles', 5, 115, 9.99),
    ('MO010', 'PG-13', 'The Matrix', 5, 136, 10.99)

CREATE TABLE PurchaseHeader(
	PurchaseID CHAR(5) PRIMARY KEY CHECK(PurchaseID LIKE 'PU[0-9][0-9][0-9]'),
	SupplierID CHAR(5) FOREIGN KEY REFERENCES MsSupplier(SupplierID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseDate Date NOT NULL,
)

INSERT INTO PurchaseHeader VALUES 
	('PU001', 'SU001', 'ST001', '2023-10-15'),
    ('PU002', 'SU002', 'ST002', '2019-09-12'),
    ('PU003', 'SU003', 'ST002', '2019-11-02'),
    ('PU004', 'SU004', 'ST002', '2019-10-01'),
    ('PU005', 'SU005', 'ST003', '2019-11-09'),
    ('PU006', 'SU006', 'ST001', '2019-12-19'),
    ('PU007', 'SU003', 'ST004', '2023-12-27'),
    ('PU008', 'SU003', 'ST007', '2023-09-28'),
    ('PU009', 'SU005', 'ST006', '2022-01-29'),
    ('PU010', 'SU007', 'ST005', '2019-02-12'),
    ('PU011', 'SU009', 'ST004', '2019-05-21'),
    ('PU012', 'SU001', 'ST001', '2019-04-18'),
    ('PU013', 'SU001', 'ST008', '2023-03-19'),
    ('PU014', 'SU002', 'ST009', '2021-06-29'),
    ('PU015', 'SU006', 'ST008', '2019-10-23')

CREATE TABLE PurchaseDetailFood(
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL, 
	FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	FoodQtyPurchase INT NOT NULL,
	PRIMARY KEY(PurchaseID)
)

INSERT INTO PurchaseDetailFood VALUES
    ('PU001', 'FO001', 13),
    ('PU002', 'FO002', 12),
    ('PU003', 'FO001', 10),
    ('PU004', 'FO009', 10),
    ('PU005', 'FO005', 09),
    ('PU006', 'FO006', 08),
    ('PU007', 'FO001', 29),
    ('PU008', 'FO010', 23),
    ('PU009', 'FO010', 22),
    ('PU010', 'FO005', 03),
    ('PU011', 'FO005', 34),
    ('PU012', 'FO003', 29),
    ('PU013', 'FO004', 22),
    ('PU014', 'FO002', 17),
    ('PU015', 'FO005', 06)

CREATE TABLE PurchaseDetailMovie(
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PRIMARY KEY(PurchaseID)
)

INSERT INTO PurchaseDetailMovie VALUES 
    ('PU001', 'MO001'),
    ('PU002', 'MO010'),
    ('PU003', 'MO006'),
    ('PU004', 'MO009'),
    ('PU005', 'MO001'),
    ('PU006', 'MO008'),
    ('PU007', 'MO007'),
    ('PU008', 'MO004'),
    ('PU009', 'MO001'),
    ('PU010', 'MO001'),
    ('PU011', 'MO002'),
    ('PU012', 'MO005'),
    ('PU013', 'MO003'),
    ('PU014', 'MO001'),
    ('PU015', 'MO002');

CREATE TABLE PurchaseDetailDrink(
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkQtyPurchase INT NOT NULL,
	PRIMARY KEY(PurchaseID)
)

INSERT INTO PurchaseDetailDrink VALUES 
    ('PU001', 'DR001', 13),
    ('PU002', 'DR009', 11),
    ('PU003', 'DR001', 10),
    ('PU004', 'DR010', 07),
    ('PU005', 'DR001', 02),
    ('PU006', 'DR010', 02),
    ('PU007', 'DR008', 21),
    ('PU008', 'DR002', 21),
    ('PU009', 'DR001', 28),
    ('PU010', 'DR005', 07),
    ('PU011', 'DR008', 35),
    ('PU012', 'DR004', 28),
    ('PU013', 'DR004', 26),
    ('PU014', 'DR002', 11),
    ('PU015', 'DR001', 02)

CREATE TABLE TransactionHeader(
	TransactionID CHAR(5) PRIMARY KEY CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate Date NOT NULL
)

INSERT INTO TransactionHeader VALUES 
    ('TR001', 'ST001', 'CU001', '2024-10-15'),
    ('TR002', 'ST002', 'CU002', '2022-09-12'),
    ('TR003', 'ST002', 'CU003', '2023-11-02'),
    ('TR004', 'ST002', 'CU004', '2023-10-01'),
    ('TR005', 'ST003', 'CU005', '2024-11-09'),
    ('TR006', 'ST001', 'CU006', '2024-12-19'),
    ('TR007', 'ST004', 'CU007', '2023-12-27'),
    ('TR008', 'ST007', 'CU008', '2023-09-28'),
    ('TR009', 'ST006', 'CU009', '2022-01-29'),
    ('TR010', 'ST005', 'CU010', '2019-02-12'),
    ('TR011', 'ST004', 'CU001', '2023-05-21'),
    ('TR012', 'ST001', 'CU002', '2023-04-18'),
    ('TR013', 'ST008', 'CU003', '2023-03-19'),
    ('TR014', 'ST009', 'CU004', '2021-06-29'),
    ('TR015', 'ST008', 'CU005', '2024-10-23');

CREATE TABLE TransactionDetailFood(
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	FoodQtySales INT NOT NULL,
	PRIMARY KEY(TransactionID, FoodID)
)

INSERT INTO TransactionDetailFood VALUES
	('TR001', 'FO001', 9),
	('TR001', 'FO005', 2),
	('TR002', 'FO006', 4),
	('TR002', 'FO010', 3),
	('TR003', 'FO005', 7),
	('TR003', 'FO007', 2),
	('TR004', 'FO004', 7),
	('TR004', 'FO001', 6),
	('TR005', 'FO004', 1),
	('TR005', 'FO003', 8),
	('TR006', 'FO005', 4),
	('TR006', 'FO002', 9),
	('TR007', 'FO005', 6),
	('TR007', 'FO004', 6),
	('TR008', 'FO007', 7),
	('TR008', 'FO005', 2),
	('TR009', 'FO002', 7),
	('TR009', 'FO005', 8),
	('TR010', 'FO010', 9),
	('TR010', 'FO004', 5),
	('TR011', 'FO002', 4),
	('TR011', 'FO004', 8),
	('TR012', 'FO006', 5),
	('TR012', 'FO009', 4),
	('TR013', 'FO004', 3)


CREATE TABLE TransactionDetailMovie(
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TicketQtySales INT NOT NULL
	PRIMARY KEY(TransactionID, MovieID)
)

INSERT INTO TransactionDetailMovie VALUES
	('TR001', 'MO001', 1),
	('TR002', 'MO002', 2),
	('TR003', 'MO003', 4),
	('TR004', 'MO004', 3),
	('TR005', 'MO005', 2),
	('TR006', 'MO006', 5),
	('TR007', 'MO007', 6),
	('TR008', 'MO008', 3),
	('TR009', 'MO009', 4),
	('TR010', 'MO010', 5),
	('TR011', 'MO001', 3),
	('TR012', 'MO002', 2),
	('TR013', 'MO003', 2),
	('TR014', 'MO004', 5),
	('TR015', 'MO005', 7),
	('TR001', 'MO002', 1),
	('TR002', 'MO003', 2),
	('TR003', 'MO004', 4),
	('TR004', 'MO005', 3),
	('TR005', 'MO006', 2),
	('TR006', 'MO007', 5),
	('TR007', 'MO008', 6),
	('TR008', 'MO010', 3),
	('TR009', 'MO001', 4),
	('TR010', 'MO001', 5)

CREATE TABLE TransactionDetailDrink(
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkQtySales INT NOT NULL
	PRIMARY KEY(TransactionID, DrinkID)
)

INSERT INTO TransactionDetailDrink VALUES
	('TR001', 'DR001', 1),
	('TR002', 'DR002', 2),
	('TR003', 'DR003', 4),
	('TR004', 'DR004', 2),
	('TR005', 'DR005', 1),
	('TR006', 'DR006', 3),
	('TR007', 'DR007', 5),
	('TR008', 'DR008', 2),
	('TR009', 'DR009', 2),
	('TR010', 'DR010', 5),
	('TR001', 'DR002', 1),
	('TR002', 'DR003', 2),
	('TR003', 'DR004', 4),
	('TR004', 'DR005', 2),
	('TR005', 'DR006', 1),
	('TR006', 'DR007', 3),
	('TR007', 'DR008', 5),
	('TR008', 'DR009', 2),
	('TR009', 'DR010', 2),
	('TR010', 'DR001', 5),
	('TR001', 'DR008', 1),
	('TR002', 'DR009', 2),
	('TR003', 'DR007', 4),
	('TR004', 'DR010', 2),
	('TR005', 'DR004', 1)