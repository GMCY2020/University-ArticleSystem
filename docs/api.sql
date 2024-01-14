use db_artsys;

-- 注册
insert into tb_user(user_name, user_password, create_time, update_time) value (?, ?, now(), now());

-- 登录
select * from tb_user where user_name = ?;

-- 获取所有文章
select
    tb_article.art_id, art_title, user_name, tb_article.art_detail, tb_article.create_time, tb_article.update_time
from
    tb_article
        join tb_userart on tb_article.art_id = tb_userart.art_id
        join tb_user on tb_userart.user_id = tb_user.user_id
where art_title regexp ? and user_name regexp ? limit ?, 10;

-- 文章 获取 根据 作者id
select
    *
from
    tb_article
where art_id in (select art_id from tb_userart where user_id = ?)
;


-- 文章 获取 收藏 根据 用户id
select
    tb_article.art_id, art_title, user_name, tb_article.art_detail, tb_article.create_time, tb_article.update_time
from
    tb_article
        join tb_userart on tb_article.art_id = tb_userart.art_id
        join tb_user on tb_userart.user_id = tb_user.user_id
where tb_article.art_id in (select tb_userstar.art_id from tb_userstar where tb_userstar.user_id = ?)
;

-- 添加文章
insert into tb_article(art_title, art_detail, create_time, update_time) value (?, ?, now(), now());
insert into tb_userart(user_id, art_id) value (?, ?);

-- 修改文章
update tb_article set art_title = ?, art_detail = ?, update_time = now() where art_id = ?;


-- 收藏文章
insert into tb_userstar value (?, ?);

-- 取消收藏文章
delete from tb_userstar where user_id = ? and art_id = ?;

-- 根据文章名称搜索作者
select art_id from tb_article where art_title = ?;

-- 删除文章
delete from tb_article where art_id = ?;
delete from tb_userart where user_id = ? and art_id = ?;

-- 更新文章
update tb_article set art_title = ?, art_detail = ? where art_id = ?;

-- 获取文章
select * from tb_article where art_id = ?;