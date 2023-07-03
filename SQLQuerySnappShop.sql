/*select * from Orders$*/

/*check the min and max date*/
SELECT MIN(CreatedAt) AS MIN FROM Orders$
SELECT MAX(CreatedAt) AS MAX FROM Orders$

/*Number of orders  per month in 2022 and 2023 respectively*/
SELECT    MONTH(CreatedAt) AS MonthNumber,COUNT(distinct OrderID) AS NumOrders2022 FROM  Orders$ 
    WHERE    YEAR(CreatedAt) = '2022' and Basket<>0
	GROUP BY  MONTH(CreatedAt)
	ORDER BY  MONTH(CreatedAt) 
SELECT    COUNT(distinct OrderID) AS NumOrders2023 FROM  Orders$ 
    WHERE    YEAR(CreatedAt) = '2023' and Basket<>0
	GROUP BY  MONTH(CreatedAt)

/*Number of customers per month in 2022 and 2023 respectively*/
SELECT    COUNT(distinct CustomerID) AS NumCustomers2022 FROM  Orders$ 
    WHERE     YEAR(CreatedAt) = '2022' 
    GROUP BY  MONTH(CreatedAt)
SELECT    COUNT(distinct CustomerID) AS NumCustomers2023 FROM  Orders$ 
    WHERE     YEAR(CreatedAt) = '2023' 
    GROUP BY  MONTH(CreatedAt)

/*Number of orders per category*/
SELECT Category, COUNT(*) AS NumberCategory FROM Orders$
    GROUP BY Category 
	ORDER BY NumberCategory DESC

/*Sum of basket per category*/
SELECT Category, SUM(Basket) AS SumBasket FROM Orders$
    GROUP BY Category
	ORDER BY SumBasket DESC

/*Sum of Totaldiscount per Category*/
SELECT Category, SUM(TotalDiscount) AS SumTotDiscount FROM Orders$
    GROUP BY Category
	ORDER BY SumTotDiscount DESC

/*Sum of ShopDiscount per Category*/
SELECT Category, SUM(ShopDiscount) AS SumShopDiscount FROM Orders$
    GROUP BY Category
	ORDER BY SumShopDiscount DESC

/*Sum of VoucherCost per Category*/
SELECT Category, SUM(VoucherCost) AS SumVouchCost FROM Orders$
    GROUP BY Category
	ORDER BY SumVouchCost DESC

/*Most selling category based on order*/
SELECT TOP 1 Category, count(OrderID) AS CountOrder FROM Orders$
    GROUP BY Category 
    ORDER BY CountOrder DESC;

/*To see if there is a customer with basket zero.*/
SELECT DISTINCT OrderID FROM Orders$ WHERE Basket= 0;

/*Average basket for customers who have made more than 2 parchases*/
SELECT  customerid, COUNT(*) AS order_count,AVG(Basket) AS AVGBasket
      FROM  Orders$   WHERE Basket>0
      GROUP BY  customerid
      HAVING  count(*) > 2
;
 WITH AVGBasketMore2 AS (
      SELECT  CustomerID, AVG(Basket) AS AVGBasket
      FROM    Orders$   WHERE Basket>0
      GROUP BY  customerid
      HAVING  count(*) > 2
)
SELECT Avg(AVGBasket) AS AVGBasketMore2 FROM AVGBasketMore2;

/*Customer's first order average basket*/
WITH firstorder AS (
  SELECT customerid, CreatedAt, basket,
    ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY createdat
                       ) AS n
  FROM Orders$
) 
SELECT customerid, CreatedAt, Basket FROM firstorder
WHERE n = 1 
ORDER BY CreatedAt;

WITH firstorder AS (
  SELECT customerid, CreatedAt, basket,
    ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY createdat
                       ) AS n
  FROM Orders$ WHERE Basket<>0
) 
SELECT Avg(basket) AS AVGFirstOrdBasket FROM firstorder
WHERE n = 1 
;

  
  



    



