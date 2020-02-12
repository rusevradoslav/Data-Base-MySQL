use colonial_blog_db;
create database colonial_blog_db;
#1.	Table Design
create table users
(

    id       int primary key auto_increment,
    username varchar(30) unique not null,
    password varchar(30)        not null,
    email    varchar(50)        not null

);
create table categories
(
    id       int primary key auto_increment,
    category varchar(30) not null
);
create table articles
(
    id          int primary key auto_increment,
    title       varchar(50) not null,
    content     text        not null,
    category_id int,
    constraint fk_article_category
        foreign key (category_id) references categories (id)
);

create table users_articles
(
    user_id    int,
    article_id int,
    constraint fk_users_articles_articles
        foreign key (article_id) references articles (id),
    constraint fk_users_articles_users
        foreign key (user_id) references users (id)
);

create table comments
(
    id         int primary key auto_increment,
    comment    varchar(255) not null,
    article_id int          not null,
    user_id    int          not null,
    constraint fk_comments_articles
        foreign key (article_id) references articles (id),
    constraint fk_comments_users
        foreign key (user_id) references users (id)
);

create table likes
(
    id         int primary key auto_increment,
    article_id int,
    comment_id int,
    user_id    int not null,
    constraint fk_likes_articles
        foreign key (article_id) references articles (id),
    constraint fk_likes_comments
        foreign key (comment_id) references comments (id),
    constraint kf_likes_users
        foreign key (user_id) references users (id)

);

#2.	Data Insertion
insert into likes (article_id, comment_id, user_id)
SELECT (select length(u.username) where u.id % 2 = 0),
       (select length(u.email) where u.id % 2 = 1),
       u.id as user_id
from users as u
where id between 16 and 20;

#3.	Data Update
update comments
set comment := (case
                    WHEN `id` % 2 = 0 THEN 'Very good article.'
                    WHEN `id` % 3 = 0 THEN 'This is interesting.'
                    WHEN `id` % 5 = 0 THEN 'I definitely will read the article again.'
                    WHEN `id` % 7 = 0 THEN 'The universe is such an amazing thing.'
                    ELSE comment
    END)
where id between 1 and 15;


#4.	Data Deletion
DELETE
from articles as a
where a.category_id is null;

#5.	Extract 3 biggest articles
select filtered.title, filtered.summary
from (
         SELECT a.id, a.title, concat(substr(content, 1, 20), '...') as summary
         from articles a
         order by length(a.content) desc
         limit 3) as filtered
order by id;

#6.	Golden Articles
select user_id,
       (select title
        from articles as a
        where a.id = user_id)
from users_articles as au
where au.user_id = au.article_id
order by article_id;

#7.	Extract categories

select c.category,
       count(a.category_id) as articles,
       (select count(l.article_id)
        from likes as l
                 join articles a2 on l.article_id = a2.id
                 join categories c2 on a2.category_id = c2.id
        where c2.id = c.id
       )                    as likes
from categories as c
         join articles a on c.id = a.category_id
group by c.category
order by likes desc, articles desc;

#8.	Extract the most commented Social article
select a.title,
       (select count(com.article_id)
        from comments as com
        where com.article_id = a.id
       ) as comments
from articles as a
         join categories c on a.category_id = c.id
where c.id = 5
order by comments desc
limit 1;

#9.	Extract the less liked comments
select concat(substr(comment, 1, 20), '...') as summary
from comments as c
where c.id not in (select comment_id
                   from likes as l
                   where l.comment_id is not null)
order by id desc
;
#10.Get user’s articles count
DELIMITER $$

CREATE FUNCTION udf_users_articles_count(given_username VARCHAR(30))
    RETURNS int
    DETERMINISTIC
BEGIN
    declare article_count int;
    set article_count = (
        select count(ua.user_id)
        from users_articles as ua
                 join users u on ua.user_id = u.id
        where u.username = given_username
        group by u.id
    );
    return article_count;
end;

DELIMITER ;

select udf_users_articles_count('UnderSinduxrein');

#11.	Like article
DELIMITER //

CREATE PROCEDURE udp_like_article(given_username VARCHAR(30), given_title VARCHAR(30))
BEGIN
    DECLARE negative CONDITION FOR SQLSTATE '45000';
    case
        when (select username
              from users
              where username = given_username) is null
            then signal negative set MESSAGE_TEXT = 'Non-existent user.';
        when (select title
              from articles
              where title = given_title) is null
            then signal negative set MESSAGE_TEXT = 'Non-existent article.';
        else
            insert into likes(article_id, comment_id, user_id)
            select (select a.id from articles as a where a.title = given_title),
                   null                                                            as comment_id,
                   (select u.id from users as u where u.username = given_username) as user_id;
        end case;

END
//

DELIMITER ;

CALL udp_like_article('BlaAntigadsa', 'Donnybrook, Victoria');
CALL udp_like_article('BlaAntigadsa', 'Na Pesho statiqta');