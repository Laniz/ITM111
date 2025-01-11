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

use v_art;

SELECT  fname, lname, title
FROM artist JOIN artwork
	ON artist.artist_id = artwork_id
    WHERE artist.artist_id <> 2
    ORDER BY artist.artist_id;
    
USE v_art;

SELECT COUNT(country), fname, lname
FROM artist
WHERE country = 'France';

USE bike;

SELECT list_price
FROM product;

SELECT AVG(list_price)
FROM product;

SELECT FORMAT(AVG(list_price), 2) AS price
FROM product
WHERE model_year = '2016';

SELECT FORMAT(AVG(list_price), 2) AS price
FROM product
GROUP BY model_year;

SELECT  model_year,FORMAT (AVG(list_price), 2) AS price
FROM product
WHERE list_price > 2800
GROUP BY model_year;
 
 
 SELECT  model_year,FORMAT (AVG(DISTINCT(list_price)), 2) AS price
FROM product
WHERE list_price > 2800
GROUP BY model_year with rollup;

 Use sakila;


-- question 1 
SELECT name 
,		CASE
			WHEN name in ('English', 'Italian', 'French', 'Germail')
			THEN 'latin1'
			WHEN name in ('Japanesse', 'Mandarin')
			THEN 'utf8'
			ELSE 'Unkown'
        END character_set
FROM language;

-- Question 2

SELECT SUM( CASE WHEN rating = 'G' THEN 1 ELSE 0 END) G
,		SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) PG
,		SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) 'PG-13'
,		SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) R
,		SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) 'NC-17'
FROM film;


-- question 3

SELECT substr(last_name, 1,1) AS starts_with
,	SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,	SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer
GROUP BY substr(last_name, 1,1)
ORDER BY 1;

-- QUESTION 4




WITH Letters AS (
    SELECT 'A' AS letter
    UNION ALL
    SELECT 'B' AS letter
    UNION ALL
    SELECT 'C' AS letter
    UNION ALL
    SELECT 'D' AS letter
    UNION ALL
    SELECT 'E' AS letter
    UNION ALL
    SELECT 'F' AS letter
    UNION ALL
    SELECT 'G' AS letter
    UNION ALL
    SELECT 'H' AS letter
    UNION ALL
    SELECT 'I' AS letter
    UNION ALL
    SELECT 'J' AS letter
    UNION ALL
    SELECT 'K' AS letter
    UNION ALL
    SELECT 'L' AS letter
    UNION ALL
    SELECT 'M' AS letter
    UNION ALL
    SELECT 'N' AS letter
    UNION ALL
    SELECT 'O' AS letter
    UNION ALL
    SELECT 'P' AS letter
    UNION ALL
    SELECT 'Q' AS letter
    UNION ALL
    SELECT 'R' AS letter
    UNION ALL
    SELECT 'S' AS letter
    UNION ALL
    SELECT 'T' AS letter
    UNION ALL
    SELECT 'U' AS letter
    UNION ALL
    SELECT 'V' AS letter
    UNION ALL
    SELECT 'W' AS letter
    UNION ALL
    SELECT 'X' AS letter
    UNION ALL
    SELECT 'Y' AS letter
    UNION ALL
    SELECT 'Z' AS letter
)
SELECT L.letter AS starts_with,
       SUM(CASE WHEN c.active = 1 THEN 1 ELSE 0 END) AS active_count,
       SUM(CASE WHEN c.active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM Letters L
LEFT JOIN customer c
ON substr(c.last_name, 1, 1) = L.letter
GROUP BY L.letter
ORDER BY L.letter;






-- Question 5  

SELECT substr(last_name, 1,1) AS starts_with
,	SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) AS active_count
,	SUM(CASE WHEN active = 0 THEN 1 ELSE 0 END) AS inactive_count
FROM customer
GROUP BY substr(last_name, 1,1)
HAVING SUM(CASE WHEN active = 1 THEN 1 ELSE 0 END) > 30 
ORDER BY 1;
        