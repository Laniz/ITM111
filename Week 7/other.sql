use v_art;

SELECT title 
	FROM artwork
    WHERE period IN('Morden', 'Baroque');
    
select title, peiod
	from artwork
    Where period like '%impr%';
    
SELECT title, period
	FROM artwork
    WHERE period REGEXP '%a%';
    
SELECT title, period
	FROM artwork
    WHERE period REGEXP '^Post';
    
SELECT title, period
	FROM artwork
    WHERE period REGEXP 'ism$';
    
SELECT title, period
	FROM artwork
    WHERE period REGEXP 'the|in|on';
    
SELECT fname AS First, mname as Middle, lname AS last
	FROM artist
    WHERE mname IS NOT NULL
    order by mname;
    
USE bike;

SELECT * FROM product;

SELECT product_name, model_year, round(list_price) AS 'rounded price'
	FROM product;
    
SELECT product_name, model_year, round(list_price) + 100
	FROM product
    order by model_year;
