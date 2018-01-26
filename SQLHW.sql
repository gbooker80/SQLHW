USE SAKILA;
SHOW TABLES;

-- QUESTIONS

-- Question 1a:
SELECT first_name,last_name
FROM actor;

SELECT CONCAT(UCASE(first_name), " ", UCASE(last_name)) as 'Actor Name'
FROM actor;

-- Question 2a:
SELECT first_name, last_name, actor_id
FROM actor
WHERE first_name like "Joe";

-- Question 2b:
SELECT first_name, last_name, actor_id
FROM actor
WHERE last_name like "%GEN%";

-- Question 2c:
SELECT first_name, last_name, actor_id
FROM actor
WHERE last_name like "%LI%"
ORDER BY last_name, first_name;

-- Question 2d:
SELECT * FROM country
WHERE country in ('Afghanistan', 'Bangladesh', 'China');

-- Question 3a: 
ALTER TABLE actor 
ADD COLUMN middle_name VARCHAR(30) AFTER first_name;

-- Question 3b:
ALTER TABLE actor MODIFY middle_name BLOB;

-- Question 3c:
ALTER TABLE actor DROP middle_name;

-- Question 4a:
SELECT last_name, COUNT(last_name) AS 'Number of Actors' 
FROM actor
GROUP BY last_name;

-- Question 4b:
SELECT last_name, COUNT(last_name) AS 'Number of Actors' 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- Question 4c:
UPDATE actor
SET first_name = 'HARPO' 
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

-- Question 4d:
UPDATE actor
SET first_name = 
	CASE 
		WHEN first_name = "HARPO"
			THEN "GROUCHO"
		ELSE "MUCHO GROUCHO"
	END
WHERE actor_id = 172;

-- Question 5a:
SHOW COLUMNS from sakila.address;

SHOW CREATE TABLE sakila.address;

/* CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `location` geometry NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  SPATIAL KEY `idx_location` (`location`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8 */


-- Question 6a: 
SELECT first_name, last_name, address from staff s
INNER JOIN address a ON s.address_id = a.address_id;

-- Question 6b:
SELECT s.staff_id, first_name, last_name, SUM(amount) as 'Total Amount Rung Up'
FROM staff s
INNER JOIN payment p 
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

-- Question 6c:
Select f.title, COUNT(fa.actor_id) as 'Number of Actors'
FROM film f
LEFT JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id;

-- Question 6d:
SELECT f.title, COUNT(i.inventory_id) as 'Number in Inventory'
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id
HAVING title = "Hunchback Impossible";

-- Question 6e:
SELECT c.last_name, c.first_name, SUM(p.amount) as 'Total Paid'
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY p.customer_id
ORDER BY last_name, first_name;

-- Question 7a:
SELECT title FROM film
WHERE language_id IN
	(SELECT language_id FROM language
	WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

-- Question 7b:
SELECT first_name, last_name FROM actor
WHERE actor_id IN
	(SELECT actor_id FROM film_actor
	WHERE film_id IN
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- Question 7c:
SELECT c.first_name, c.last_name, c.email, co.country FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city ci
ON ci.city_id = a.city_id
LEFT JOIN country co
ON co.country_id = ci.country_id
WHERE country = "Canada";

-- Question 7d:
SELECT * from film
WHERE film_id IN
	(SELECT film_id FROM film_category
	WHERE category_id IN
		(SELECT category_id FROM category
		WHERE name = "Family"));
		
-- Question 7e:
SELECT f.title , COUNT(r.rental_id) AS 'Number of Rentals' FROM film f
RIGHT JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r 
ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- Question 7f:
SELECT s.store_id, sum(amount) as 'Revenue' FROM store s
RIGHT JOIN staff st
ON s.store_id = st.store_id
LEFT JOIN payment p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- Question 7g:
SELECT s.store_id, ci.city, co.country FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id;

-- Question 7h:
SELECT c.name, sum(p.amount) as 'Revenue per Category' FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN inventory i
ON fc.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN payment p
ON p.rental_id = r.rental_id
GROUP BY name;

-- Question 8a:
CREATE VIEW top_5_by_genre AS
SELECT c.name, sum(p.amount) as 'Revenue per Category' FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN inventory i
ON fc.film_id = i.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN payment p
ON p.rental_id = r.rental_id
GROUP BY name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- Question 8b:
SELECT * FROM top_5_by_genre;

-- Question 8c:
DROP VIEW top_5_by_genre;
