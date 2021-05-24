  
   
-- Выполнение ДЗ (добавление внешних ключей)
 

ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friendship_status_id_fk 
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id)
   on delete cascade;
  
      

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
   on delete cascade;
   
   
   ALTER TABLE media 
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
   on delete cascade;
   
 ALTER TABLE posts 
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media_types(id)
   on delete cascade;
  
ALTER TABLE likes 
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
   on delete cascade;
   
   
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?   
   
 SELECT
  user_id,
  count( * ) as total,
  ( SELECT gender FROM profiles WHERE user_id = likes.user_id ) AS gender
    FROM likes
    group by gender
    order by total desc
    limit 1;          

-- 4. Подсчитать количество лайков которые получили 10 самых молодых пользователей.   

   
  select sum(likes_total) from 
  (select 
  (select count( * ) from likes
  where target_id = profiles.user_id and target_type = 'users') as likes_total
  from profiles 
  order by birthday
  desc limit 10) as user_likes;
  
    
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).   
 
-- За критерий активности принято количество поставленных лайков.  
  
  
  SELECT
  user_id,
   ( SELECT first_name FROM users WHERE id = likes.user_id ) as first_name, 
   ( SELECT last_name FROM users WHERE id = likes.user_id ) as last_name,
   target_id,
   count( * ) as total
   FROM likes
   group by user_id
   order by total
   limit 10;
  