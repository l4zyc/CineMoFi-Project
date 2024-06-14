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
    ('PU004', 'SU004', 'ST005', '2019-10-01'),
    ('PU005', 'SU005', 'ST003', '2019-11-09'),
    ('PU006', 'SU006', 'ST001', '2019-12-19'),
    ('PU007', 'SU003', 'ST004', '2023-12-27'),
    ('PU008', 'SU003', 'ST007', '2023-09-28'),
    ('PU009', 'SU005', 'ST006', '2022-01-29'),
    ('PU010', 'SU007', 'ST005', '2019-10-01'),
    ('PU011', 'SU009', 'ST004', '2019-05-21'),
    ('PU012', 'SU001', 'ST001', '2019-04-18'),
    ('PU013', 'SU001', 'ST007', '2023-03-19'),
    ('PU014', 'SU002', 'ST009', '2021-06-29'),
    ('PU015', 'SU006', 'ST008', '2019-10-23')

CREATE TABLE PurchaseDetail(
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL, 
	FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	FoodQtyPurchase INT NOT NULL,
	DrinkQtyPurchase INT NOT NULL
	PRIMARY KEY(PurchaseID)
)

INSERT INTO PurchaseDetail VALUES
    ('PU001', 'FO001', 'DR006', 'MO001', 20, 2),
    ('PU002', 'FO002', 'DR006', 'MO002', 10, 3),
    ('PU003', 'FO001', 'DR001', 'MO003', 50, 4),
    ('PU004', 'FO009', 'DR010', 'MO004', 35, 5),
    ('PU005', 'FO005', 'DR006', 'MO006', 20, 6),
    ('PU006', 'FO006', 'DR006', 'MO001', 10, 7),
    ('PU007', 'FO001', 'DR008', 'MO007', 15, 8),
    ('PU008', 'FO010', 'DR002', 'MO010', 30, 2),
    ('PU009', 'FO010', 'DR005', 'MO007', 70, 3),
    ('PU010', 'FO005', 'DR005', 'MO008', 70, 10),
    ('PU011', 'FO005', 'DR005', 'MO005', 10, 5),
    ('PU012', 'FO003', 'DR004', 'MO001', 20, 7),
    ('PU013', 'FO010', 'DR004', 'MO002', 15, 8),
    ('PU014', 'FO002', 'DR001', 'MO006', 10, 9),
    ('PU015', 'FO005', 'DR001', 'MO005', 10, 4)


CREATE TABLE TransactionHeader(
	TransactionID CHAR(5) PRIMARY KEY CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate Date NOT NULL
)


INSERT INTO TransactionHeader VALUES 
    ('TR001', 'ST001', 'CU001', '2024-10-15'),
    ('TR002', 'ST002', 'CU002', '2022-09-12'),
    ('TR003', 'ST002', 'CU003', '2024-11-02'),
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


CREATE TABLE TransactionDetail (
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	DrinkID CHAR(5) FOREIGN KEY REFERENCES MsDrink(DrinkID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	MovieID CHAR(5) FOREIGN KEY REFERENCES MsMovie(MovieID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	FoodID CHAR(5) FOREIGN KEY REFERENCES MsFood(FoodID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TicketQtySales INT NOT NULL,
	DrinkQtySales INT NOT NULL,
	FoodQtySales INT NOT NULL
	PRIMARY KEY(TransactionID, DrinkID, MovieID, FoodID)
)

INSERT INTO TransactionDetail VALUES 
    ('TR001', 'DR001', 'MO001', 'FO001', 6, 1, 5),
    ('TR001', 'DR002', 'MO002', 'FO002', 5, 2, 4),
    ('TR001', 'DR003', 'MO003', 'FO003', 4, 3, 3),
    ('TR005', 'DR004', 'MO004', 'FO004', 3, 4, 2),
    ('TR005', 'DR005', 'MO005', 'FO005', 2, 5, 1),
    ('TR006', 'DR006', 'MO006', 'FO006', 1, 6, 6),
    ('TR007', 'DR007', 'MO007', 'FO007', 6, 1, 5),
    ('TR008', 'DR008', 'MO008', 'FO008', 5, 2, 4),
    ('TR009', 'DR009', 'MO009', 'FO009', 4, 3, 3),
    ('TR010', 'DR010', 'MO010', 'FO010', 3, 4, 2),
    ('TR011', 'DR001', 'MO001', 'FO001', 2, 5, 1),
    ('TR012', 'DR002', 'MO002', 'FO002', 1, 6, 6),
    ('TR003', 'DR003', 'MO003', 'FO003', 6, 1, 5),
    ('TR003', 'DR004', 'MO004', 'FO004', 5, 2, 4),
    ('TR003', 'DR005', 'MO005', 'FO005', 4, 3, 3),
    ('TR003', 'DR006', 'MO006', 'FO006', 3, 4, 2),
    ('TR002', 'DR007', 'MO007', 'FO007', 2, 5, 1),
    ('TR003', 'DR008', 'MO008', 'FO008', 1, 6, 6),
    ('TR003', 'DR009', 'MO009', 'FO009', 6, 1, 5),
    ('TR003', 'DR010', 'MO010', 'FO010', 5, 2, 4),
    ('TR006', 'DR001', 'MO001', 'FO001', 4, 3, 3),
    ('TR005', 'DR002', 'MO002', 'FO002', 3, 4, 2),
    ('TR006', 'DR003', 'MO003', 'FO003', 2, 5, 1),
    ('TR007', 'DR004', 'MO004', 'FO004', 1, 6, 6),
    ('TR009', 'DR005', 'MO005', 'FO005', 6, 1, 5),
    ('TR008', 'DR006', 'MO006', 'FO006', 5, 2, 4),
    ('TR012', 'DR007', 'MO007', 'FO007', 4, 3, 3),
    ('TR012', 'DR008', 'MO008', 'FO008', 3, 4, 2),
    ('TR012', 'DR009', 'MO009', 'FO009', 2, 5, 1),
    ('TR012', 'DR010', 'MO010', 'FO010', 1, 6, 6);
