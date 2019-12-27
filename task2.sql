create table books
{
book_id number,
book_name varchar2(50) not null,
author_name varchar2(20) not null,
price number not null,
publisher vsrchar2(20) not null
version number,
category varchar2(20) not null,
active number not null
);
constraint book_id_pk primary key(book_id);
constraint bav_uq unique(book_name,author_name,version);
constraint price_cq check(price>=0);

