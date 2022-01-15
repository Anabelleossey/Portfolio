--Exploring sales Data in Sql 


---Methods used: Aggregate functions, Creating Views, CTE´s, Join.

--Using CTE´s to find the total profit by State

WITH Orderld AS(
SELECT ol.State, 
       SUM(od.Profit) AS total_profit
FROM PROJECTPORTFOLIO..Order_list    ol
JOIN PROJECTPORTFOLIO..Order_details od
ON ol.[Order ID]=od.[Order ID]
GROUP BY State
)
SELECT *
FROM Orderld



--- Monthly profit, Revenue and Quantity sold in 2018

WITH Monthlyprofit AS(
SELECT MONTH(ol.[Order Date]) AS Month,
       YEAR(ol.[Order Date]) AS Year,
       od.Profit,
       od.Amount,
	   od.Quantity
FROM PROJECTPORTFOLIO..Order_list    ol
JOIN PROJECTPORTFOLIO..Order_details od
ON ol.[Order ID]= od.[Order ID]
)
SELECT *
FROM Monthlyprofit
WHERE Year=2018
ORDER BY 1 ASC



--- Sales revenue Vs Sales target

SELECT MONTH(ol.[Order Date]) AS month,
       YEAR(ol.[Order Date]) AS Year,
       SUM(od.Amount*od.Quantity) AS Salesrevenue,
	   SUM(Target) AS Salestarget
FROM PROJECTPORTFOLIO..Order_details od
INNER JOIN PROJECTPORTFOLIO..Order_list ol
ON od.[Order ID]=ol.[Order ID]
INNER JOIN PROJECTPORTFOLIO..Sales_target st
ON ol.[Order Date]=st.[Month of Order Date]
GROUP BY MONTH(ol.[Order Date]), YEAR(ol.[Order Date])



---Counting  distinct Customers

SELECT COUNT(DISTINCT CustomerName) AS CustomerName
FROM PROJECTPORTFOLIO..Order_list



---Top 10 percent profitable Customers

SELECT TOP(10) PERCENT ol.CustomerName,
                SUM(od.Profit) AS Profit
FROM PROJECTPORTFOLIO..Order_list ol
INNER JOIN PROJECTPORTFOLIO..Order_details od
ON ol.[Order ID]=od.[Order ID]
GROUP BY CustomerName
ORDER BY Profit DESC



-- Create view for later visualizations 

--Quantity sold per Category 

CREATE VIEW Quantitysoldpercategory AS
SELECT Category,
      SUM(Quantity) AS total_quantity
FROM PROJECTPORTFOLIO..Order_details
GROUP BY Category



--Quantity sold per Subcategory 

CREATE VIEW Quantitysoldpersubcategory AS
SELECT [Sub-Category],
       SUM(Quantity) AS total_quantity
FROM PROJECTPORTFOLIO..Order_details
GROUP BY [Sub-Category]


