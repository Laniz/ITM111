-- Question 1

use v_art;

SELECT artfile
FROM artwork
WHERE period ='Impressionism';

-- Question 2 

SELECT artwork.artwork_id, artwork.artfile 
FROM artwork
JOIN artwork_keyword ON artwork.artwork_id = artwork_keyword.artwork_id
JOIN keyword ON artwork_keyword.keyword_id = keyword.keyword_id
WHERE keyword.keyword LIKE '%flower%';

-- QUESTION 3

SELECT * FROM artist;

SELECT fname, lname, title
FROM artist 
	JOIN artwork
    ON artist.artist_id = artwork.artist_id;
    
-- question 4

USE magazine;

SELECT * FROM subscriber;
SELECT * FROM magazine;
SELECT * FROM subscription;

SELECT magazine.magazineName, subscriber.subscriberLastName, subscriber.subscriberFirstName
FROM subscription
INNER JOIN magazine ON subscription.magazineKey = magazine.magazineKey
INNER JOIN subscriber ON subscription.subscriberKey = subscriber.subscriberKey
ORDER BY magazine.magazineName ASC;

-- Question 5
  
SELECT magazine.magazineName -- subscriber.subscriberLastName, subscriber.subscriberFirstName
FROM subscription
INNER JOIN magazine ON subscription.magazineKey = magazine.magazineKey
INNER JOIN subscriber ON subscription.subscriberKey = subscriber.subscriberKey
WHERE subscriber.subscriberFirstName = 'Samantha' and subscriber.subscriberLastName = 'Sanders'
ORDER BY magazine.magazineName ASC;

-- Question 6 

USE employees;

SELECT first_name, last_name
FROM employees
ORDER BY last_name
LIMIT 5;

-- Question 7

SELECT employees.first_name, employees.last_name, departments.dept_name, salaries.salary, salaries.from_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE employees.first_name = 'Berni' and employees.last_name = 'Genin'
ORDER BY salaries.from_date DESC
LIMIT 1;




USE sakila;

-- Query for actors whose last name starts with 'L'
SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'L%'

UNION

-- Query for customers whose last name starts with 'L'
-- Query for cities
SELECT city_id AS id, city AS name
FROM city
WHERE city LIKE 'S%o%a'
UNION
-- Query for countries
SELECT country_id AS id, country AS name
FROM country
WHERE country LIKE 'S%o%a'
ORDER BY name;







-- First part of the union: actors whose first name starts with 'M' and films with title starting with 'LOVE'
SELECT a.last_name, f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.first_name LIKE 'M%'
AND f.title LIKE 'LOVE%'

UNION 

-- Second part of the union: actors whose last name starts with 'W' and films with title starting with 'LIFE'
SELECT a.last_name, f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.last_name LIKE 'W%'
AND f.title LIKE 'LIFE%'
ORDER BY last_name;


-- Query for actors whose first name starts with 'M' and film title starts with 'LOVE'
SELECT a.first_name, a.last_name, f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.first_name LIKE 'M%'
AND f.title LIKE 'LOVE%'

UNION

-- Query for actors whose last name starts with 'W' and film title starts with 'LIFE'
SELECT a.first_name, a.last_name, f.title
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE a.last_name LIKE 'W%'
AND f.title LIKE 'LIFE%'
-- Order the results by actor's last_name in ascending order
ORDER BY last_name;

-- Query for cities
SELECT city_id AS id, city AS name
FROM city
WHERE city LIKE 'S%o%a'
UNION
-- Query for countries
SELECT country_id AS id, country AS name
FROM country
WHERE country LIKE 'S%o%a'
ORDER BY name DESC;

-- Query for cities
SELECT city_id AS id, city AS name
FROM city
WHERE city LIKE 'S%o%a'
UNION ALL
-- Query for countries
SELECT country_id AS id, country AS name
FROM country
WHERE country LIKE 'S%o%a';




USE bike;

use sakila;
SELECT c.customer_id,
       concat(c.first_name, ' ', c.last_name) AS name,
       count(p.payment_id) AS payments,
       SUM(p.amount)
FROM customer c 
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE c.customer_id IN (1, 4, 210)
GROUP BY c.customer_id, name
ORDER BY name;


SELECT
       concat(c.first_name, ' ', c.last_name) AS name,
       SUM(p.amount)
FROM payment p
RIGHT JOIN customer c ON c.customer_id = p.customer_id
WHERE p.customer_id IN (1, 4, 210)
GROUP BY p.customer_id, name
ORDER BY name;

SELECT ones.x + tens.x + 1 AS counter
FROM (
  SELECT 0 AS x UNION ALL
  SELECT 1 AS x UNION ALL
  SELECT 2 AS x UNION ALL
  SELECT 3 AS x UNION ALL 
  SELECT 4 AS x UNION ALL
  SELECT 5 AS x UNION ALL
  SELECT 6 AS x UNION ALL
  SELECT 7 AS x UNION ALL
  SELECT 8 AS x UNION ALL
  SELECT 9 AS x
) ones CROSS JOIN
(
  SELECT 0 AS x UNION ALL
  SELECT 10 AS x UNION ALL
  SELECT 20 AS x UNION ALL
  SELECT 30 AS x UNION ALL
  SELECT 40 AS x UNION ALL
  SELECT 50 AS x UNION ALL
  SELECT 60 AS x UNION ALL
  SELECT 70 AS x UNION ALL
  SELECT 80 AS x UNION ALL
  SELECT 90 AS x
) tens
ORDER BY counter;


SELECT f.film_id, f.title, i.inventory_id
FROM film f LEFT JOIN inventory i
ON f.film_id = i.film_id
WHERE f.title REGEXP '^RA(I|N).*S'
AND i.film_id IS NULL
ORDER BY f.film_id, f.title, i.inventory_id;


 SELECT  *
     FROM   (SELECT 'Yes'       AS reply
             ,      'Decided'   AS answer
             UNION ALL
            SELECT 'No'        AS reply
            ,      'Decided'   AS answer
             UNION ALL
             SELECT 'Maybe'     AS reply
             ,      'Undecided' AS answer) a
             LEFT JOIN
            (SELECT 'Yes' AS reply
             UNION ALL
             SELECT 'No'  AS reply) b
     ON      a.reply = b.reply
     WHERE   b.reply IS NOT NULL;


 SELECT  *
     FROM   (SELECT 'Yes'       AS reply
             ,      'Decided'   AS answer
             UNION ALL
             SELECT 'No'        AS reply
             ,      'Decided'   AS answer
             UNION ALL
             SELECT 'Maybe'     AS reply
             ,      'Undecided' AS answer) a
             LEFT JOIN
            (SELECT 'Yes'       AS reply
             UNION ALL
             SELECT 'No'        AS reply) b
     ON      a.reply = b.reply;
     
USE sakila;     
     
        SELECT DISTINCT
         f.film_id left_id
,        i.film_id right_id
,        f.title
FROM     film f NATURAL JOIN inventory i
ORDER BY 1;

 SELECT  *
     FROM   (SELECT 'Yes'   AS reply
             UNION ALL
             SELECT 'No'    AS reply
             UNION ALL
             SELECT 'Maybe' AS reply) r;





















 