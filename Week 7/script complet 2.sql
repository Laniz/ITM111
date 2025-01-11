use v_art;

-- Q1 

INSERT	INTO artist (artist_id, fname, mname, lname, dob, dod, country, local)
	VALUES('9','Johannes', NULL,'Vermeer', '1632','1674','Netherlands','N');
  
-- Q2  
  
SELECT fname, mname, lname, dob, dod, country, local
	FROM artist
	ORDER BY lname;

-- Q3 

UPDATE artist
SET dod = '1675'
where artist_id = '9';

-- Q4 

DELETE FROM artist
where artist_id = '9';

SELECT * FROM artist;

-- Bike shop quries

use bike;

-- Q5

SELECT first_name, last_name, phone, city
	FROM customer
    WHERE city = 'Houston';
    
-- Q6 
    
SELECT product_name, list_price, list_price - 500 AS discounted_price
	FROM product
    WHERE list_price > '5000'
    ORDER BY list_price DESC;
  
-- Q7
  
SELECT first_name, last_name, email
	FROM staff
    WHERE store_id != '1';
    
-- Q8     
    
SELECT product_name, model_year, list_price
	FROM product
    WHERE product_name LIKE '%spider%';
 
-- Q9 
    
SELECT product_name, list_price
	FROM product 
    WHERE list_price BETWEEN 500 AND 550
    ORDER BY list_price;
  
 -- Q10  
  
SELECT first_name, last_name, phone, street, city, state, zip_code
	FROM customer
    WHERE phone IS NOT NULL 
		AND (city LIKE '%ach%' OR city LIKE '%och%' OR last_name = 'WIlliam')
    LIMIT 5;
    
    
use sakila;

SELECT sub.city_id, sub.city
FROM (
    SELECT city_id, city
    FROM city
    WHERE country_id IN (SELECT country_id FROM country WHERE country IN ('Canada', 'Mexico'))
) AS sub;

SELECT city_id, city
FROM (
    SELECT city_id, city
    FROM city
    WHERE country_id IN (SELECT country_id FROM country WHERE country IN ('Canada', 'Mexico'))
);


SELECT city_id, city
FROM (
    SELECT city_id, city
    FROM city
    WHERE country_id IN (SELECT country_id FROM country WHERE country IN ('Canada', 'Mexico'))
);

SELECT actor_id
     ,      film_id
     FROM   film_actor
     WHERE  (actor_id, film_id) IN
      (SELECT a.actor_id
       ,      f.film_id
       FROM   actor a INNER JOIN film_actor fa
       ON     a.actor_id = fa.actor_id INNER JOIN film f
       ON     fa.film_id = f.film_id
       WHERE  a.last_name = 'MONROE'
       AND    f.rating = 'PG');
       
       SELECT city_id
    ,      city
     FROM   city
     WHERE  country_id IN
     (SELECT country_id
      FROM   country
       WHERE  country IN ('Canada','Mexico'));


       



