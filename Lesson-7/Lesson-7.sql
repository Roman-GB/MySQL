
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select
a.user_id,
b.name
from
orders as a JOIN users as b 
on b.id = a.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

select 
a.name,
b.name
from 
products as a join catalogs as b 
on a.catalog_id = b.id;

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). Поля from, to и label 
-- содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

