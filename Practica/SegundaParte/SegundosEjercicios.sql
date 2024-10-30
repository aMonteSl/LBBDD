






-- Ejecicios consultas para DVDRental.
-- Listar todas las peliculas en las que el actor con el apellido 'Keitel' ha actuado
SELECT film.title, film_actor.actor_id, actor.last_name
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.last_name = 'Keitel';