USE bike;

SELECT ROUND(AVG(quantity)) AS 'Stock Average'
FROM stock;

-- Question 2

SELECT * FROM cust_order_item;

SELECT * FROM stock;

SELECT distinct product.product_name 
FROM product 
JOIN stock
ON product.product_id = stock.product_id
WHERE stock.quantity = 0
ORDER BY product.product_name;

-- Question 3

SELECT category.category_name, sum(stock.quantity) As instock
FROM category
JOIN product ON category.category_id = product.category_id
JOIN stock On product.product_id = stock.product_id
JOIN store ON store.store_id = stock.store_id
WHERE store.store_name = 'Baldwin Bikes'
GROUP BY category.category_name
ORDER BY instock ASC;

-- question 4

USE employees;

SELECT count(emp_no) AS 'Number of employees'
FROM employees; 

-- questions 5

SELECT departments.dept_name, FORMAT(AVG(salaries.salary), 2) AS avg_salary
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON dept_emp.emp_no = salaries.emp_no
GROUP BY departments.dept_name
HAVING avg_salary < '60000';

-- Question 6

SELECT departments.dept_name, COUNT(dept_emp.emp_no) AS 'number of females'
FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE employees.gender = 'F'
GROUP BY departments.dept_name
ORDER BY departments.dept_name;

