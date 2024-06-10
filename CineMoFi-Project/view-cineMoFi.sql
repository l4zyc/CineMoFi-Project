GO
USE CineMoFi
GO

-- 1 --
-- Display Staffs (Obtained from StaffName in uppercase), PurchaseDate, and Total Food Purchase
-- (Obtained from counting all the Transaction) for every Purchase made by male staff and happenned in 2019.

SELECT UPPER(StaffName) AS 'Staff Name', PurchaseDate, SUM(pdf.FoodQtyPurchase) as 'Total Food Purchase' 
FROM MsStaff ms 
JOIN PurchaseHeader ph ON ms.StaffID = ph.StaffID
JOIN PurchaseDetailFood pdf ON ph.PurchaseID = pdf.PurchaseID
WHERE StaffGender = 'Male' AND YEAR(PurchaseDate) = 2019
GROUP BY StaffName, PurchaseDate

-- 2 --
-- Display PurchaseID, Supplier Name (Obtained from SupplierName in lowercase), 
-- and Total Drink Purchase (Obtained from total sum of DrinkQuantity) 
-- for every Total Drink Purchase that less than 5 and PurchaseID is even number.

SELECT PH.PurchaseID, LOWER(ms.SupplierName) AS 'Supplier Name', 
SUM(PurchaseDetailDrink.DrinkQtyPurchase) AS [Total Drink Purchase]
FROM PurchaseHeader  PH
JOIN MsSupplier ms ON PH.SupplierID = ms.SupplierID
JOIN PurchaseDetailDrink ON PurchaseDetailDrink.PurchaseID = PH.PurchaseID
WHERE PurchaseDetailDrink.DrinkQtyPurchase < 5
    AND CONVERT(INT, SUBSTRING(PH.PurchaseID, 3, LEN(PH.PurchaseID))) % 2 = 0
GROUP BY PH.PurchaseID, ms.SupplierName

-- 3 --
-- Display Transaction Date (Obtained from Converting the TransactionDate format to 'Mon dd. yyyy' example 'Oct 01. 2000'), 
-- Highest Food Price Sold (Obtained from getting the maximum food price), 
-- Lowest Drink Price Sold (Obtained from getting the minimum drink price) 
-- for every transaction that happened before June 2023.

SELECT 
    CONVERT(VARCHAR, TransactionDate, 107) AS Transaction_Date,
    MAX(Food.FoodPrice) AS Highest_Food_Price,
    MIN(Drink.DrinkPrice) AS Lowest_Drink_Price
FROM TransactionHeader
JOIN TransactionDetail ON  TransactionDetail.TransactionID = TransactionHeader.TransactionID
JOIN MsFood AS Food ON Food.FoodID = TransactionDetail.FoodID
JOIN MsDrink AS Drink ON Drink.DrinkID = TransactionDetail.DrinkID
WHERE MONTH(TransactionDate) < 6 AND YEAR(TransactionDate) < 2023
GROUP BY TransactionDate

-- 4 --
-- Display Staff's First Name (Obtained from getting the first staff name in lowercase format), 
-- FoodCategory, and Average Total Food Purchased (Obtained from the purchased food quantity 
-- average), and Total Food Purchased (Obtained from total sum of FoodQuantity) for every 
-- purchase that has average food quantity is more than 2 and the FoodCategory is 'Fried'.

SELECT LOWER(SUBSTRING(MsStaff.StaffName, 1, CHARINDEX(' ', MsStaff.StaffName) - 1)) AS 'Name',
FoodCategory,
AVG(PurchaseDetailFood.FoodQtyPurchase) AS 'Average Total Food Purchase',
SUM(PurchaseDetailFood.FoodQtyPurchase) AS [Total Food Purchase]
FROM MsStaff
JOIN PurchaseHeader ON PurchaseHeader.StaffID = MsStaff.StaffID
JOIN PurchaseDetailFood ON PurchaseDetailFood.PurchaseID = PurchaseHeader.PurchaseID
JOIN MsFood ON MsFood.FoodID = PurchaseDetailFood.FoodID
WHERE PurchaseDetailFood.FoodQtyPurchase > 2 AND MsFood.FoodCategory = 'Fried'
GROUP BY StaffName, FoodCategory

-- 5 --
-- Display TransactionID, Drink Transaction Forecast (Obtained from adding one year to the 
-- TransactionDate), and Drink Quantity (Obtained from adding ' Cup' at the end of DrinkQuantity) 
-- for every 'Soft Drink' or 'Herbal' drink category in a single transaction that has more than 1 
-- quantity sold.

SELECT DISTINCT th.TransactionID, DATEADD(YEAR, 1, TransactionDate) AS [Drink Transaction Forecast], CONCAT(DrinkQtySales, ' Cup') AS [Drink Quantity]
FROM TransactionDetail td
	JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
	JOIN (SELECT td.DrinkID, DrinkCategory AS Drink
		FROM TransactionDetail td
			JOIN TransactionHeader th ON td.TransactionID = th.TransactionID 
			JOIN MsDrink md ON td.DrinkID = md.DrinkID
			WHERE DrinkCategory IN ('Herbal', 'Soft Drink')) AS CategoryDrink ON td.DrinkID = CategoryDrink.DrinkID

-- 6 --	
-- Display StaffID, Transaction Date (Obtained from Converting the TransactionDate to 'dd Mon 
-- yyyy' format, ex: 31 Jan 2023), Movie Identification (Obtained from change the first 2 letter 
-- from MovieID to ‘Movie ‘), Movie Name (Obtained from adding 'Film ' in front of the 
-- MovieName), and MovieCategory for every Movie that has duration higher than the average 
-- duration and the MovieID is 'MO003'

SELECT ms.StaffID, CONVERT(VARCHAR, TransactionDate, 106) AS [Transaction Date], 
REPLACE(mm.MovieID, 'MO', 'Movie ') AS [Movie Identification],
CONCAT('Film', MovieName) AS [Movie Name], MovieCategory
FROM MsStaff ms
	JOIN TransactionHeader th ON ms.StaffID = th.StaffID
	JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
	JOIN MsMovie mm ON td.MovieID = mm.MovieID,
	(SELECT AVG(MovieDuration) AS Average
		FROM MsMovie) AS AverageMovieDuration
WHERE mm.MovieID = 'MO003' AND MovieDuration > Average

-- 7 --
-- Display Last Name (Obtained from getting the last name of the CustomerName) and Total Movie 
-- Sold (Obtained from the total multiplication of TicketQuantity and Movie Price) for every first 
-- quarter of a year which Total Movie Sold is above the Average of all Total Movie Sold.

SELECT SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName), LEN(CustomerName)) AS [Last Name], 
	CAST(SUM(TicketQtySales*MoviePrice) AS NUMERIC(10,2)) AS [Total Movie Sold]
FROM MsCustomer mc
	JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
	JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
	JOIN MsMovie mm ON td.MovieID = mm.MovieID
WHERE DATENAME(QUARTER, TransactionDate) = 1
GROUP BY CustomerName
HAVING SUM(TicketQtySales*MoviePrice) > (
	SELECT AVG(TotalMovieSold) FROM(
		SELECT th.TransactionID, SUM(TicketQtySales*MoviePrice) AS TotalMovieSold
		FROM MsMovie mm 
			JOIN TransactionDetail td ON mm.MovieID = td.MovieID
			JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
		GROUP BY th.TransactionID) AS [Average Ticket Movie Sold])

-- 8 --
-- Display Transaction (Obtained from changing the first two character from TransactionID to 
-- 'Transaction ' in Uppercase format), StaffName, Customer Name (Obtained from adding 
-- 'Ms/Mrs. ' in front of the CustomerName), and Transaction Date (Obtained from getting the year 
-- of TransactionDate) for every female customer and total transaction is higher than the average 
-- total transaction

SELECT UPPER(REPLACE(th.TransactionID, 'TR', 'Transaction ')) AS [Transaction],
StaffName, ('Mr/Mrs. ' + CustomerName) AS [Customer Name], YEAR(TransactionDate) AS [Transaction Date]
FROM MsCustomer mc
JOIN TransactionHeader th ON th.CustomerID = mc.CustomerID
JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
JOIN MsStaff ON MsStaff.StaffID = th.StaffID,
	(
		SELECT AVG(TotalTransaction) AS Average FROM (
			SELECT COUNT(th.TransactionID) AS TotalTransaction FROM
				TransactionHeader th
				JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
				GROUP BY th.TransactionID
		) AS Total
	) AS AverageTransaction
WHERE CustomerGender = 'Female' 
GROUP BY Average, th.TransactionID, CustomerName, TransactionDate, StaffName
HAVING COUNT(th.TransactionID) > Average


-- 9 --
-- Create a view named 'TotalPurchase' to display Staff (Obtained from changing first staff name 
-- with 'Staff ') MovieName, MovieRating, Average Ticket Bought (Obtained from average of 
-- TicketQuantity), and Total Ticket Bought (Obtained from total sum of the TicketQuantity). for 
-- every movie that has 5 star rating and the total sum of TicketQuantity is higher than the Average 
-- Ticket Bought

GO
CREATE VIEW TotalPurchase AS
SELECT REPLACE(StaffName, SUBSTRING(StaffName, 0, CHARINDEX(' ', StaffName)), 'Staff ') AS [Staff], 
MovieName, 
MovieRating, 
AVG(TicketQtySales) AS [Average Ticket Bought], 
SUM(TicketQtySales) AS [Total Ticket Bought]
FROM MsStaff ms
	JOIN TransactionHeader th ON ms.StaffID = th.StaffID
	JOIN TransactionDetail td ON th.TransactionID = td.TransactionID
	JOIN MsMovie mm ON td.MovieID = mm.MovieID
WHERE MovieRating = 5
GROUP BY StaffName, MovieName, MovieRating
HAVING SUM(TicketQtySales) > AVG(TicketQtySales)
GO
SELECT*FROM TotalPurchase


-- 10 --
-- Create a view named 'Food Sales' to display FoodName, Total Quantity Sold (Obtained from 
-- total sum of FoodQuantity sold), and Average Food Price (Obtained average of FoodPrice) for 
-- every food which category is 'Sandwich' and the Transaction is happenned in current Year.

GO
CREATE VIEW [Food Sales] AS
SELECT FoodName, SUM(FoodQtySales) AS [Total Quantity Sold], ROUND(AVG(FoodPrice),2) AS 'Average Food Price'
FROM MsFood mf
JOIN TransactionDetail td ON td.FoodID = mf.FoodID
JOIN TransactionHeader th ON td.TransactionID  =th.TransactionID
WHERE FoodCategory = 'Sandwich' AND YEAR(TransactionDate) = YEAR(GETDATE())
GROUP BY FoodName
GO

SELECT * FROM [Food Sales]