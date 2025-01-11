USE magazine;

-- QUESTION 1 

SELECT magazineName, ROUND(magazinePrice - (magazinePrice * 3/100),2) AS '3% off'
	FROM magazine;
 
-- QUESTION 2  
 
SELECT 
    subscriberKey, 
    -- ROUND(DATEDIFF(subscriptionStartDate, STR_TO_DATE('2020-12-20', '%Y-%m-%d')) / 365) * -1 AS 'Years since subscription' 
    -- ROUND(DATEDIFF(STR_TO_DATE('2020-12-20', '%Y-%m-%d')) / 365,subscriptionStartDate) * -1 AS 'Years since subscription' 
    ROUND(DATEDIFF('2020-12-20', subscriptionStartDate)/ 365) AS 'Years since subscription' 
    FROM subscription;

-- QUESTION 3

 SELECT subscriptionStartDate, subscriptionLength, 
 DATE_FORMAT(DATE_ADD(subscriptionStartDate, INTERVAL subscriptionLength MONTH), '%M %d, %Y') AS 'Sub end'
	FROM subscription;
    
-- QUESTION 4

USE bike;

-- SELECT LOCATE(' - ', product_name) AS hyphen_position, product_name 
-- FROM product;

SELECT LEFT(product_name, LOCATE(' - ', product_name) -1 ) AS 'product without year'
FROM product
ORDER BY product_id
LIMIT 14;

-- Question 5

SELECT product_name, 
       CONCAT('$', FORMAT(list_price / 3, 2)) AS 'One of 3 payments'
FROM product
WHERE model_year = 2019;



-- joins

 

 

