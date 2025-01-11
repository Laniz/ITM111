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
    
    




