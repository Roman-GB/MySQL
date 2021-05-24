    
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?   
   
-- Исходный 

 SELECT
  user_id,
  count( * ) as total,
  ( SELECT gender FROM profiles WHERE user_id = likes.user_id ) AS gender
    FROM likes
    group by gender
    order by total desc
    limit 1;          
  
   -- С использованием JOIN
   
   SELECT
  -- likes.user_id,
  count( * ) as total,
  profiles.gender
  FROM likes join profiles
  on  likes.user_id = profiles.user_id
  group by gender
    order by total desc
    limit 1;          
  
-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.   

  -- Исходный 
   
  select sum(likes_total) from 
  (select 
  (select count( * ) from likes
  where target_id = profiles.user_id and target_type = 'users') as likes_total
  from profiles 
  order by birthday
  desc limit 10) as user_likes;
 
   -- С использованием JOIN
 
 select sum(likes_total) as liked_young_users from  
  (select count( * ) as likes_total
  from likes right join profiles 
  on likes.target_id = profiles.user_id and target_type = 'users' 
  group by profiles.user_id 
  order by profiles.birthday
  desc limit 10)  as user_likes;
 

 

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).   
 
-- За критерий активности принято количество поставленных лайков.  
  
 -- Исходный 
   
  SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  LIMIT 10;
  
 -- С использованием JOIN
 	 
	 select 
	 users.id,
	 CONCAT(first_name, ' ', last_name) AS users,
	 count(distinct likes.id)+
	 count(distinct messages.id)+
	 count(distinct media.id) as active
	 from 
	 users left join likes
	  on likes.user_id = users.id
	  left join messages 
	  on messages.from_user_id = users.id
	  left join media 
	  on media.user_id = users.id
	  group by users.id 
	  order by active
	  limit 10;