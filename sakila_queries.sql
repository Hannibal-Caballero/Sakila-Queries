/* ============================================================================
   PROYECTO: LÓGICA Y CONSULTAS SQL (BBDD SAKILA)
   ============================================================================ */

-- 1. Crea el esquema de la BBDD.
/*El esquema relacional se creó a partir del script DDL provisto y se encuentra 
 documentado gráficamente en el archivo 'README.md' mediante el diagrama 'sakila_schema.png'.*/


-- 2. Muestra los nombres de todas las películas con una clasificación por edades de 'R'.

select title , rating 
from film
where rating = 'R' ;


-- 3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.

select a.first_name , a.last_name , a.actor_id 
from actor a 
where a.actor_id between 30 and 40 ;



-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select f.title , f.original_language_id ,f.language_id 
from film f 
where f.original_language_id = f.language_id ;
-- Nota: La consulta devuelve 0 registros debido a que en el dataset 'Sakila' la columna 'original_language_id' solo contiene valores nulos.


-- 5. Ordena las películas por duración de forma ascendente.

select f.title , f.length 
from film f 
order by f.length asc ;


-- 6. Encuentra el nombre y apellido de los actores que tengan 'Allen' en su apellido.

select a.first_name , a.last_name 
from actor a 
where a.last_name like '%ALLEN%' ;


-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla "film" y muestra la clasificación junto con el recuento.

select f.rating, count(f.film_id ) as "nº-films"
from film f 
group by f.rating ;


-- 8. Encuentra el título de todas las películas que son 'PG-13' o tienen una duración mayor a 3 horas en la tabla film.

select f.title , f.rating , f.length 
from film f 
where  f.rating = 'PG-13'  or  f.length > 180
order by f.rating, f.length desc ;


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select round(variance(f.replacement_cost ),2) as "variance_cost"
from film f  ;


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select MAX(f.length ) as "max_length", MIN(f.length ) as "min-length"
from film f  ;


-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select p.rental_id , r.rental_date , p.amount 
from rental r 
inner join payment p 
on p.rental_id =r.rental_id 
order by r.rental_date desc , p.rental_id desc 
offset 1 limit 1

; 


-- 12. Encuentra el título de las películas en la tabla "film" que no sean ni 'NC-17' ni 'G' en cuanto a su clasificación.

select f.title , f.rating 
from film f 
where f.rating not in ('G', 'NC-17');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

select f.rating , round( AVG(f.length ),1) as "averege"
from film f 
group by f.rating 
order by averege desc ;


-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select f.title , f.length 
from film f 
where f.length > 180
order by f.length ;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

select SUM(p.amount )as "gross_rental_income"
from payment p ;


-- 16. Muestra los 10 clientes con mayor valor de id.

select c.customer_id ,c.first_name , c.last_name 
from  customer c 
order by  c.customer_id desc 
limit 10 ;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título 'Egg Igby'.

select  f.film_id , f.title as "pelicula" ,a.first_name as "nombre", a.last_name as "apellido"
from film f 
inner join film_actor fa 
on f.film_id = fa.film_id 
inner join actor a 
on a.actor_id =fa.actor_id 
where f.title = 'EGG IGBY'

-- 18. Selecciona todos los nombres de las películas únicos.

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT f.title AS "titulo", COUNT(fa.actor_id) AS "total_actores"
FROM film f
INNER JOIN film_actor fa 
ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
HAVING COUNT(fa.actor_id) = 1;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla "film".

select  f.title as "titulo", c."name"  as "categoria", f.length as "duracion"
from category c 
inner join film_category fc 
on c.category_id = fc.category_id 
inner join film f 
on f.film_id = fc.film_id 
where c."name" = 'Comedy'
and f.length > 180;


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
 
select c."name" as "categoria" , round (AVG(f.length ),1) as "promedio_duracion"
from category c 
inner join film_category fc 
on c.category_id =fc.category_id 
inner join film f 
on f.film_id = fc.film_id 
group by c.category_id  , c."name" 
having AVG(f.length ) > 110
order by promedio_duracion desc ;



-- 21. ¿Cuál es la media de duración del alquiler de las películas?

select   AVG(( r.return_date - r.rental_date )) as "promedio_alquiler"
from rental r ;


-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select concat(a.first_name , ' ', a.last_name ) as "nombre_completo"
from actor a 
order by nombre_completo ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select to_char(r.rental_date , 'Day') as "dia_semana" ,count (r.rental_id ) as "dias_alquiler"
from rental r 
group by dia_semana 
order by dias_alquiler desc ;

select r.rental_date  as "dia_semana" ,count (r.rental_id ) as "dias_alquiler"
from rental r 
group by dia_semana 
order by dias_alquiler desc ;

-- 24. Encuentra las películas con una duración superior al promedio.

select  f.title , f.length 
from  film f 
where f.length  > (select AVG(f2.length ) from film f2   )
order by f.length desc ;


-- 25. Averigua el número de alquileres registrados por mes.

select  to_char(rental_date, 'yyyy-month') as "mes" , count(rental_id ) as "alquileres"
from rental
group by to_char(rental_date , 'yyyy-month')
order by alquileres desc ;


-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select round(AVG(p.amount ),1) as "promedio",round(stddev(p.amount ),1) "desviacion" ,round(variance(p.amount ),1) as " varianza"
from payment p ;


-- 27. ¿Qué películas se alquilan por encima del precio medio?

select f.title , f.rental_rate 
from film f 
where f.rental_rate > (select AVG(f2.rental_rate  )from film f2 )
order by f.rental_rate desc ;

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select fa.actor_id , count(fa.film_id ) as "+_40_peliculas"
from film_actor fa
group by fa.actor_id 
having count(fa.film_id )>40;


-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select  f.film_id ,f.title , count(i.inventory_id ) as " cantidad_disponible"
from  film f 
left join inventory i 
on f.film_id = i.film_id
group by f.film_id , f.title 
order by f.film_id asc;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

select a.actor_id ,a.first_name , a.last_name , count( fa.film_id ) as "nºpeliculas"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name 
order by "nºpeliculas" ;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select f.film_id , f.title , count(fa.actor_id ) as "nº_actores"
from film f 
left join film_actor fa 
on f.film_id = fa.film_id 
group by f.film_id , f.title 
order by "nº_actores" desc ;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select a.actor_id , a.first_name , a.last_name ,count(fa.film_id ) as "nºpeliculas"
from actor a 
left join film_actor fa 
on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name 
order by "nºpeliculas" desc ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select 
	f.film_id as "id", 
	f.title as "titulo",
	i.inventory_id as "id_inventario",
	r.rental_id as "id_rental"
from film f 
left join inventory i 
on f.film_id = i.film_id 
left join rental r 
on i.inventory_id = r.inventory_id  
order by f.film_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select c.customer_id ,c.first_name , c.last_name , SUM(p.amount ) "the_best_5"
from customer c 
inner join payment p 
on p.customer_id =c.customer_id 
group by c.customer_id ,c.first_name , c.last_name 
order by "the_best_5" desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select a.actor_id , a.first_name , a.last_name 
from  actor a 
where a.first_name ilike '%Johnny%';

-- 36. Renombra la columna "first_name" como Nombre y "last_name" como Apellido.

select 
	a.actor_id ,
	a.first_name  as "nombre", 
	a.last_name as "apellido"
from  actor a 
where a.first_name ilike '%Johnny%';

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select 
	MIN(a.actor_id) as "min_id" , MAX(a.actor_id ) as "max_id"
from  actor a ;

-- 38. Cuenta cuántos actores hay en la tabla "actor".

select count(a.actor_id ) as "nº_actores"
from actor a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select a.first_name as "nombre", a.last_name as "apellido"
from actor a 
order by a.last_name ;

-- 40. Selecciona las primeras 5 películas de la tabla "film".

select f.title 
from film f 
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select a.first_name , count(a.actor_id )as "nº_actores"
from actor a 
group by a.first_name 
order by "nº_actores" desc ;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select r.rental_id , c.first_name , c.last_name 
from rental r 
left join customer c 
on r.customer_id = c.customer_id;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select c.first_name , c.last_name , r.rental_id 
from customer c 
left join rental r 
on c.customer_id = r.customer_id;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select *
from film f 
cross join category c ;
--No aporta valor, porque asignar todas las categorias a cada pelicula independiente de su categoria real crea datos que no son reales.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

with action_actors as (
	select f.film_id , f.title , c."name" 
	from film f 
	inner join film_category fc 
	on f.film_id = fc.film_id 
	inner join category c 
	on c.category_id = fc.category_id 
	where c."name" ilike 'action')
select distinct 
	a.actor_id , a.first_name , a.last_name 
	from action_actors
	inner join film_actor fa 
	on action_actors.film_id = fa.film_id
	inner join actor a 
	on fa.actor_id = a.actor_id
	order by a.actor_id 
	;

-- 46. Encuentra todos los actores que no han participado en películas.

select a.actor_id , a.first_name , a.last_name 
from actor a 
left join film_actor fa 
on a.actor_id =fa.actor_id 
left join film f 
on f.film_id = fa.film_id 
where f.film_id is null ;
-- Todos los actores registrados han participado en al menos una pelicula.

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select a.actor_id , a.first_name , a.last_name , count(fa.film_id ) as "nº_peliculas"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id ,a.first_name , a.last_name 
order by "nº_peliculas" desc  ;

-- 48. Crea una vista llamada "actor_num_peliculas" que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as 
select a.first_name as "nombre" , a.last_name  as "apellido", count(fa.film_id ) as "num_peliculas"
from actor a 
inner join film_actor fa 
on a.actor_id = fa.actor_id
group by nombre ,apellido ;

select *
from actor_num_peliculas;

-- 49. Calcula el número total de alquileres realizados por cada cliente.

 select c.customer_id , first_name , last_name , count(r.rental_id ) as "nº_alquileres"
 from customer c 
 left join rental r 
 on c.customer_id = r.customer_id 
 group by c.customer_id , first_name , last_name 
 order by "nº_alquileres" desc;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

select c."name" as "categoria" , SUM(f.length ) as "tiempo_total"
from category c 
inner join film_category fc 
on c.category_id = fc.category_id 
inner join film f 
on f.film_id = fc.film_id 
where c."name" ilike 'action'
group by c."name" 
;


-- 51. Crea una tabla temporal llamada "cliente_rentas_temporal" para almacenar el total de alquileres por cliente.

DROP TABLE IF EXISTS cliente_rentas_temporal;

create temporary table cliente_rentas_temporal as 
 select c.customer_id , first_name , last_name , count(r.rental_id ) as "nº_alquileres"
 from customer c 
 left join rental r 
 on c.customer_id = r.customer_id 
 group by c.customer_id , first_name , last_name 
 order by "nº_alquileres" desc;

select *
from cliente_rentas_temporal;

-- 52. Crea una tabla temporal llamada "peliculas_alquiladas" que almacene las películas que han sido alquiladas al menos 10 veces.

drop table if exist peliculas_alquiladas;

create temporary table peliculas_alquiladas as
	select f.film_id , f.title , count(f.film_id ) "mas_10_peliculas"
	from film f 
	inner join inventory i 
	on f.film_id = i.film_id
	inner join rental r 
	on i.inventory_id = r.inventory_id
	group by f.film_id , f.title 
	having count(f.film_id ) > 9
	order by "mas_10_peliculas" ;

select *
from peliculas_alquiladas;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre 'Tammy Sanders' y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

select concat(c.first_name ,' ', c.last_name ) as "nombre_completo",f.film_id ,f.title , r.return_date as "fecha_devolucion"
from customer c 
inner join rental r 
on c.customer_id = r.customer_id 
inner join inventory i 
on r.inventory_id = i.inventory_id
inner join film f 
on i.film_id = f.film_id
where concat(c.first_name ,' ', c.last_name ) ilike 'Tammy Sanders'
and r.return_date  is null
order by f.title ;


-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría 'Sci-Fi'. Ordena los resultados alfabéticamente por apellido.

with scifi_films as (
    select fc.film_id
    from category c
    inner join film_category fc on c.category_id = fc.category_id
    where c.name ILIKE 'sci-fi'
)
select distinct a.actor_id , a.first_name as "nombre", a.last_name as "apellido"
from scifi_films sf
inner join film_actor fa on  sf.film_id = fa.film_id
inner join actor a on fa.actor_id = a.actor_id
order by a.last_name ;


-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película 'Spartacus Cheaper' se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

with primer_alq_spartacus as (
	select MIN(r.rental_date ) as "primer_alq"
	from film f 
	inner join inventory i on f.film_id = i.film_id 
	inner join rental r on i.inventory_id = r.inventory_id
	where f.title ilike 'Spartacus Cheaper'),
 id_act_name  as (
	select 
		fa.film_id, 
		a.actor_id as "id_actor" , 
		a.first_name as "nombre" , 
		a.last_name as "apellido"
	from actor a 
	inner join film_actor fa on a.actor_id = fa.actor_id),
id_inventory_film as (
	select 
		i.inventory_id ,
		f.film_id ,
		f.title 
	from inventory i 
	inner join film f on f.film_id = i.film_id )
select id_actor , nombre , apellido
from  id_act_name 
inner join id_inventory_film d on d.film_id = id_act_name.film_id 
inner join rental r on d.inventory_id = r.inventory_id
where r.rental_date > (select * from primer_alq_spartacus )
group by id_actor ,nombre , apellido 
order by apellido ;
-- Lo hice largo pero queria probar si podia unir varios CTEs

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría 'Music'.
 
select  a.actor_id , a.first_name , a.last_name 
from actor a 
where a.actor_id not in (
	select fa.actor_id 
	from film_actor fa 
	inner join film_category fc on  fa.film_id = fc.film_id 
	inner join category c on fc.category_id = c.category_id
	where c."name" ilike 'Music') 
order by a.actor_id asc ;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

with dias_alq_inventory as (
	select  r.inventory_id , (r.return_date - r.rental_date ) as "dias_alq"
	from rental r )
select f.film_id , f.title , dias_alq 
from dias_alq_inventory 
inner join inventory i on dias_alq_inventory.inventory_id = i.inventory_id
inner join film f on f.film_id = i.film_id 
where dias_alq > '8 days';

-- 58. Encuentra el título de todas las películas que son de la misma categoría que 'Animation'.

select f.film_id , f.title 
from film f 
inner join film_category fc on f.film_id = fc.film_id 
inner join category c  on fc.category_id = c.category_id
where c."name" ilike 'animation'


-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título 'Dancing Fever'. Ordena los resultados alfabéticamente por título de película.

select f.film_id , f.title ,f.length 
from film f 
where f.length = (
		select length 
		from film 
		where title ilike 'Dancing Fever')
order by f.title asc;



-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select r.customer_id , r.inventory_id , count(r.rental_id )
from rental r 

group by customer_id ;

select  c.customer_id , c.first_name , c.last_name , count(i.film_id )
from inventory i 
inner join rental r on i.inventory_id = r.inventory_id
inner join customer c on r.customer_id = c.customer_id
group by c.customer_id , c.first_name , c.last_name 
having count (distinct i.film_id ) > 6
order by c.last_name ;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

with canatidad_pelis_id as (
	select i.film_id as "id_pelicula" , count (r.rental_id) as "num_peliculas"
	from rental r 
	inner join inventory i on r.inventory_id = i.inventory_id
	group by film_id )
select c."name" , SUM(num_peliculas ) as "total_categforia"
from canatidad_pelis_id  
inner join film_category fc on fc.film_id = id_pelicula 
inner join category c on fc.category_id = c.category_id
group by c."name" 
order by "total_categforia" desc ;


-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

with catego_cod as (
	select fc.film_id ,c.category_id as "id_ categoria", c."name" as "categoria"
	from category c 
	inner join film_category fc 
	on c.category_id = fc.category_id )
select "id_ categoria" , categoria , count(f.film_id ) as "num_peliculas"
from catego_cod 
inner join film f 
on  catego_cod.film_id = f.film_id 
where f.release_year = 2006
group by "id_ categoria" ,categoria
order by "id_ categoria" ;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select s.staff_id , concat(s.first_name, ' ', s.last_name ), s.store_id as "tienda"
from staff s 
cross join store s2 ;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

select 
	c.customer_id  as "id_cliente",	c.first_name as "nombre", c.last_name as "apellido" , count(r.rental_id ) as "total_peliculas_alquiladas"
from customer c 
left join  rental r 
on c.customer_id = r.customer_id 
group by c.customer_id , c.first_name , c.last_name
order by "total_peliculas_alquiladas" desc ;
