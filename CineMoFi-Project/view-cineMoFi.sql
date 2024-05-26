GO
USE CineMoFi
GO

-- 1 --
SELECT UPPER(StaffName) AS 'Staff Name', PurchaseDate ,SUM(PurchaseDetailFood.FoodQtyPurchase) as 'Total Food Purchase' FROM MsStaff 
JOIN PurchaseHeader ON MsStaff.StaffID = PurchaseHeader.StaffID
JOIN PurchaseDetailFood ON PurchaseHeader.PurchaseID = PurchaseDetailFood.PurchaseID
WHERE StaffGender = 'Male' AND YEAR(PurchaseDate) = 2019
GROUP BY StaffName, PurchaseDate

-- 2 --
SELECT PurchaseHeader.PurchaseID, LOWER(MsSupplier.SupplierName) AS 'Supplier Name', SUM(PurchaseDetailDrink.DrinkQtyPurchase) AS DrinkQty
FROM PurchaseHeader 
JOIN MsSupplier ON PurchaseHeader.SupplierID = MsSupplier.SupplierID
JOIN PurchaseDetailDrink ON PurchaseDetailDrink.PurchaseID = PurchaseHeader.PurchaseID
WHERE PurchaseDetailDrink.DrinkQtyPurchase < 5
    AND CONVERT(INT, SUBSTRING(PurchaseHeader.PurchaseID, 3, LEN(PurchaseHeader.PurchaseID))) % 2 = 0
GROUP BY PurchaseHeader.PurchaseID, MsSupplier.SupplierName

-- 3 --
SELECT 
    CONVERT(VARCHAR, TransactionDate, 107) AS Transaction_Date,
    MAX(Food.FoodPrice) AS Highest_Food_Price,
    MIN(Drink.DrinkPrice) AS Lowest_Drink_Price
FROM TransactionHeader
JOIN TransactionDetailFood ON  TransactionDetailFood.TransactionID = TransactionHeader.TransactionID
JOIN TransactionDetailDrink ON TransactionDetailDrink.TransactionID = TransactionHeader.TransactionID
JOIN MsFood AS Food ON Food.FoodID = TransactionDetailFood.FoodID
JOIN MsDrink AS Drink ON Drink.DrinkID = TransactionDetailDrink.DrinkID
WHERE TransactionDate < '2019-06-01'
GROUP BY TransactionDate

-- 4 --
SELECT LOWER(SUBSTRING(MsStaff.StaffName, 1, CHARINDEX(' ', MsStaff.StaffName) - 1)) AS 'Name',
AVG(PurchaseDetailFood.FoodQtyPurchase) AS 'Average Total Food', SUM(PurchaseDetailFood.FoodQtyPurchase) AS Total
FROM MsStaff
JOIN PurchaseHeader ON PurchaseHeader.StaffID = MsStaff.StaffID
JOIN PurchaseDetailFood ON PurchaseDetailFood.PurchaseID = PurchaseHeader.PurchaseID
JOIN MsFood ON MsFood.FoodID = PurchaseDetailFood.FoodID
WHERE PurchaseDetailFood.FoodQtyPurchase > 2 AND MsFood.FoodCategory = 'Fried'
GROUP BY StaffName

-- 5 --
SELECT DISTINCT th.TransactionID, DATEADD(YEAR, 1, TransactionDate) AS [Drink Transaction Forecast], CONCAT(DrinkQtySales, ' Cup') AS [Drink Quantity], TransactionDate, DrinkCategory
FROM TransactionDetailDrink tdd 
	JOIN TransactionHeader th ON tdd.TransactionID = th.TransactionID
	JOIN MsDrink md ON tdd.DrinkID = md.DrinkID,
	(SELECT DrinkCategory AS Drink
		FROM TransactionDetailDrink tdd 
			JOIN TransactionHeader th ON tdd.TransactionID = th.TransactionID 
			JOIN MsDrink md ON tdd.DrinkID = md.DrinkID
		WHERE DrinkCategory IN ('Herbal', 'Soft Drink')) AS urmom
WHERE DrinkCategory IN ('Herbal', 'Soft Drink')

-- 6 --	
SELECT ms.StaffID, CONVERT(VARCHAR, TransactionDate, 107) AS [Transaction Date], REPLACE(mm.MovieID, 'MO', 'Movie ') AS [Movie Identification],
	CONCAT('Film', MovieName) AS Film, MovieCategory
FROM MsStaff ms
	JOIN TransactionHeader th ON ms.StaffID = th.StaffID
	JOIN TransactionDetailMovie tdm ON th.TransactionID = tdm.TransactionID
	JOIN MsMovie mm ON tdm.MovieID = mm.MovieID,
	(SELECT AVG(MovieDuration) AS Average
		FROM MsMovie) AS AverageMovieDuration
WHERE mm.MovieID = 'MO003'
GROUP BY MovieDuration, Average, ms.StaffID, TransactionDate, mm.MovieID, MovieCategory, MovieName
HAVING MovieDuration > AverageMovieDuration.Average

-- 7 --
SELECT SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName)+1, 10) AS [Last Name], 
	CAST(SUM(TicketQtySales*MoviePrice) AS NUMERIC(10,2)) AS [Total Movie Sold]
FROM MsCustomer mc
	JOIN TransactionHeader th ON mc.CustomerID = th.CustomerID
	JOIN TransactionDetailMovie tdm ON th.TransactionID = tdm.TransactionID
	JOIN MsMovie mm ON tdm.MovieID = mm.MovieID
WHERE DATENAME(QUARTER, TransactionDate) = 1
GROUP BY CustomerName
HAVING SUM(TicketQtySales*MoviePrice) > (
	SELECT AVG(TotalMovieSold) FROM(
		SELECT th.TransactionID, SUM(TicketQtySales*MoviePrice) AS TotalMovieSold
		FROM MsMovie mm 
			JOIN TransactionDetailMovie tdm ON mm.MovieID = tdm.MovieID
			JOIN TransactionHeader th ON tdm.TransactionID = th.TransactionID
		GROUP BY th.TransactionID) AS [Average Ticket Movie Sold])

-- 8 --
SELECT UPPER(REPLACE(TransactionID, 'TR', 'Transaction')) AS [Transaction],
StaffName, ('Mr/Mrs.' + CustomerName) AS [Customer Name], YEAR(TransactionDate) AS [Transaction Date]
FROM TransactionHeader
JOIN MsCustomer ON MsCustomer.CustomerID = TransactionHeader.CustomerID
JOIN MsStaff ON MsStaff.StaffID = TransactionHeader.StaffID,

	(SELECT Average = AVG(CountTransaction.[Count]) FROM TransactionHeader,
		(SELECT [Count] = COUNT(TransactionID) FROM TransactionHeader) AS CountTransaction) AS AverageTransaction,
	
	(SELECT Summary = SUM(CountTransaction.[Count]) FROM TransactionHeader,
		(SELECT [Count] = COUNT(TransactionID) FROM TransactionHeader) AS CountTransaction) AS SummaryTransaction

WHERE CustomerGender = 'Female' AND SummaryTransaction.Summary > AverageTransaction.Average
GROUP BY TransactionID, CustomerName, StaffName, TransactionDate

-- 9 --
GO
CREATE VIEW TotalPurchase AS
SELECT REPLACE(StaffName, SUBSTRING(StaffName, 0, CHARINDEX(' ', StaffName)), 'Staff ') AS [Staff], MovieName, MovieRating, AVG(TicketQtySales) AS [Average Ticket Bought], SUM(TicketQtySales) AS [Total Ticket Bought]
FROM MsStaff ms
	JOIN TransactionHeader th ON ms.StaffID = th.StaffID
	JOIN TransactionDetailMovie tdm ON th.TransactionID = tdm.TransactionID
	JOIN MsMovie mm ON tdm.MovieID = mm.MovieID
WHERE MovieRating = 5
GROUP BY StaffName, MovieName, MovieRating
HAVING SUM(TicketQtySales) > AVG(TicketQtySales)
GO
SELECT*FROM TotalPurchase

-- 10 --
GO
CREATE VIEW [Food Sales] AS
SELECT FoodName, SUM(FoodQtySales) AS [Total Quantity Sold], AVG(FoodPrice) AS 'Average Food Price'
FROM MsFood mf
JOIN TransactionDetailFood tdf ON tdf.FoodID = mf.FoodID
JOIN TransactionHeader th ON tdf.TransactionID  =th.TransactionID
WHERE FoodCategory = 'Sandwich' AND YEAR(TransactionDate) = YEAR(GETDATE())
GROUP BY FoodName