create table book(
book_id number not null,
book_name varchar2(20) not null,
price number not null,
constraint book_id_uq unique(book_id),
constraint price_ch check(price>=0)
);
insert into book values(1,'jaava',400);
insert into book values(2,'python',400);
insert into book values(3,'c',400);
create table book_stock
(
  stock_id number,
  book_id number not null,
  quantity number not null, 
  constraint  stock_id_pk primary key(stock_id)
  );
  insert into  book_stock(stock_id,book_id,quantity) values(10,2,2);
  insert into  book_stock(stock_id,book_id,quantity) values(11,3,1);
  create table order_items
  (
    item_id number not null,
    order_id number not null,
    book_id number not null,
    qty number not null,
    status1 varchar2(20),
    constraint item_id_pk primary key(item_id)
    );
    insert into order_items(item_id,order_id,book_id,qty,status1)values(2,3,1,3,'cancelled');
    insert into order_items(item_id,order_id,book_id,qty,status1)values(3,2,3,1,'pending');
    
    create table orders
    (
      order_id number ,
      username varchar2(20),
      total_amount number ,
      ordered_date date,
      delevered_date date,
      status varchar2(20),
     constraint order_id_pk primary key(order_id)
    );
    insert into orders(
    
