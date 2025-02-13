create table books(
book_id number,
book_name varchar2(50) not null,
author_name varchar2(20) not null,
price number not null,
publisher varchar2(20) not null,
version number,
book_category varchar2(20) not null,
active number not null,
constraint book_id_pk primary key(book_id),
constraint bav_uq unique(book_name,author_name,version),
constraint price_cq check(price>=0),
constraint active_cq check(active in(0,1))
);
insert into books(book_id,book_name,author_name,price,publisher,version,book_category,active)values(21,'dhoni un told story','dhoni',5000,'DRS',2,'adventure',1);
insert into books(book_id,book_name,author_name,price,publisher,version,book_category,active)values(20,'MK adventures','mk',8000,'MRS',2,'adventure',1);

create table orders(
  order_id number,
  username varchar2(20),
  book_id1 number,
  order_date TIMESTAMP default SYSTIMESTAMP not null ,
  deliver_date date,
  total_amount number,
  qty number,
  order_status varchar2(20),
  constraint order_id_pk primary key(order_id),
  constraint usern_book_id_orddate_uq unique(username,book_id1,order_date),
  constraint book_id_fk foreign key(book_id1) references books(book_id),
  constraint  total_amount_ck check(total_amount>=0),
  constraint qty_ck check(qty>=1)
  );
  insert into orders(order_id,username,book_id1,deliver_date,total_amount,qty,order_status)values(2,'kanna',20,to_date('12-12-2020','dd-mm-yyyy'),5000,2,'pending');  
  insert into orders(order_id,username,book_id1,deliver_date,total_amount,qty,order_status)values(3,'',20,to_date('12-12-2020','dd-mm-yyyy'),500,3,'cancelled');     
