USE SAKILA;
SHOW TABLES;

-- Questions

-- Question 1a
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