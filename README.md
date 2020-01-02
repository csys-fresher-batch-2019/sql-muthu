# buy and sale the car
* https://www.cars24.com

## features
 * user should able to upload the car details.
### Features 1: add car details and owner information
 ```sql
 create table car_detail
(
car_owner_id number,
car_id number not null,
car_brand varchar2(20) not null,
car_name varchar2(20)not null,
tr_type varchar2(20)not null,
fuel_type  varchar2(20) not null,
reg_state varchar2(20)not null,
reg_year number not null,
driven_km number not null,
price number not null,
update_date timestamp default current_timestamp,
status varchar2(20) default 'update',
constraint fuel_type_cq  check(fuel_type in('diesel','petrol','lpg'',cng')),
constraint reg_year_cq check(reg_year>=1947 and reg_year<=(EXTRACT(YEAR from sysdate))),
constraint driven_km_cq check(driven_km>=0 and driven_km<=9999999),
constraint car_id_pk primary key(car_id),
constraint status_ch check(status in('update','ordered','delevered')),
constraint car_own_car_name_brand_uq unique(car_owner_id,car_brand,car_name)
);
```
* add the car detail:
```sql
create sequence car_id_sq start with 1001 increment by 1;
insert into car_detail(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km,price)values(21,car_id_sq.nextval,'maruti','maruti ritz','manual','petrol','tamil nadu',2019,20000,110890);
insert into car_detail(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km,price)values(21,car_id_sq.nextval,'maruti','maruti alto','manual','diesel','kerala',2019,20100,789076);
insert into car_detail(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km,price)values(23,car_id_sq.nextval,'honda','honda city','manual','diesel','tamil nadu',2019,2000,894048);
insert into car_detail(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km,price)values(39,car_id_sq.nextval,'audi','audi-zada','manual','diesel','tamil nadu',2019,2000,684984);
insert into car_detail(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km,price)values(11,car_id_sq.nextval,'audi','audi','manual','diesel','tamil nadu',2019,2000,348782);
```
#### TABLE

| car_owner_id | car_id | car_brand | car_name | tr_type | fuel_type | reg_state  | reg_year | driven_km |   price   |update_date  |
|--------------|--------|-----------|----------|---------|-----------|------------|----------|-----------|-----------|-------------|
| 134          | 231    | maruti    | alto     | manual  | petrol    | tamil nadu | 2018     | 20,0000   | 1145000   |02-01-20 PM  |
| 135          | 984    | maruti    | ritz     | manual  | petrol    | kerala     | 2017     | 679030    | 1245000   |02-01-20 PM  |
| 136          | 983    | honda     | city     | manual  | petrol    | mumbai     | 2016     | 157890    | 649000    |02-01-20 PM  |

### Feature 2:car seller details:
```sql
create table 
car_seller(
seller_id  number,
seller_name varchar2(20) not null,
seller_contact_no number not null,
constraint owner_id_pk primary key(seller_id),
constraint seller_contact_no_ck check(length(to_char(seller_contact_no))=10)
);

insert into car_seller(seller_id,seller_name,seller_contact_no)values(23,'kannna',8973456768);
insert into car_seller(seller_id,seller_name,seller_contact_no)values(21,'selva raj',7894030293);
insert into car_seller(seller_id,seller_name,seller_contact_no)values(39,'pearl',8923940920);
insert into car_seller(seller_id,seller_name,seller_contact_no)values(11,'sugu',8674638292);
```
* select * from car_seller;

### table

| seller_id | seller_name  |seller_contact_no|
|---------- |--------------|-----------------|
| 23        | kanna        | 8973456768      |
| 21        | selva raj    | 7894030293      |
| 39        | pearl        | 8923940920      |
| 11        | sugu         | 8674638292      | 

## features: order the car

```sql
create table car_order(
order_id number,
buyer_name varchar2(20)not null,
buyer_contact_number number(10) not null,
car_id number not null,
seller_id number not null,
test_drive varchar(3) not null,
status varchar2(20) default 'ordered' not null,
ordered_date timestamp default current_timestamp,
delivered_date timestamp default current_timestamp+10,
constraint order_id_pk primary key(order_id),
constraint car_id_uq unique(car_id),
constraint seller_id_fk foreign key(seller_id) references car_seller(seller_id),
constraint car_id_fk foreign key(car_id) references car_detail(car_id),
constraint buyer_phone_number_ck check(length(to_char(buyer_contact_number))=10),
constraint car_seller_order_id_uq unique(car_id,seller_id),
constraint test_drive_cq check(test_drive in ('yes','no')),
constraint car_status_ck check(status in('ordered','cancelled','delivered','shipped'))
);

insert into car_order(order_id,buyer_name,buyer_contact_number,car_id,seller_id,test_drive,status)values(order_id_sq.nextval,'kanna',8970393728,1001,21,'yes','ordered');
insert into car_order(order_id,buyer_name,buyer_contact_number,car_id,seller_id,test_drive,status)values(order_id_sq.nextval,'pearl',8970393756,1002,21,'yes','ordered');
```
### table : 
| order_id | buyer_name | buyer_phone_number | car_id | seller_id | test_drive | ordered_date | delivered_date| 
|----------|------------|--------------------|--------|-----------|------------|--------------|---------------|
| 20       | kanna      | 8970393728         | 1001   | 21        |     yes    |   02-01-20   |    12-01-20   |
| 21       | pearl      | 8970393756         | 1002   | 21        |     yes    |   03-01-20   |    13-01-20   |
