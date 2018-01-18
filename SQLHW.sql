USE SAKILA;
SHOW TABLES;

-- QUESTIONS

-- Question 1a:
SELECT first_name,last_name
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
SELECT country_id, country
FROM country
WHERE country in ('Afghanistan','Bangladesh','China')
