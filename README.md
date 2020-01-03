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

###--update the car status in car_details table:
```sql
update car_detail  set status='ordered' where car_id=(select car_id from car_order where car_order.car_id=car_detail.car_id); 
```
#### table:
| car_owner_id | car_id | car_branad | car_name    | tr_type | fuel_type | reg_state  | reg_year | driven_km | price  | updated_date                   | status  |
|--------------|--------|------------|-------------|---------|-----------|------------|----------|-----------|--------|--------------------------------|---------|
| 11           | 1005   | audi       | audi        | manual  | diesel    | tamil nadu | 2019     | 2000      | 348782 | 02-01-20 03:31:13.997000000 PM | update  |
| 21           | 1001   | maruti     | maruti ritz | manual  | petrol    | tamil nadu | 2019     | 20000     | 110890 | 02-01-20 03:31:13.970000000 PM | ordered |
| 21           | 1002   | maruti     | maruti alto | manual  | diesel    | kerala     | 2019     | 20100     | 789076 | 02-01-20 03:31:13.977000000 PM | ordered |
| 23           | 1003   | honda      | honda city  | manual  | diesel    | tamil nadu | 2019     | 2000      | 894048 | 02-01-20 03:31:13.982000000 PM | update  |
| 39           | 1004   | audi       | audi-zada   | manual  | diesel    | tamil nadu | 2019     | 2000      | 684984 | 02-01-20 03:31:13.990000000 PM | update  |

select query for  gather the car information depend on the car brand;
```sql
select * from car_detail where car_brand='maruti';
```
#### table
| car_id | car_owner_id | car_branad | car_name    | tr_type | fuel_type | reg_state  | reg_year | driven_km | price  | updated_date                   | status  |
|--------|--------------|------------|-------------|---------|-----------|------------|----------|-----------|--------|--------------------------------|---------|
| 1001   | 21           | maruti     | maruti ritz | manual  | petrol    | tamil nadu | 2019     | 20000     | 110890 | 02-01-20 03:31:13.970000000 PM | ordered |
| 1002   | 21           | maruti     | maruti alto | manual  | diesel    | kerala     | 2019     | 20100     | 789076 | 02-01-20 03:31:13.977000000 PM | ordered |

select query for  gather the owner information depends on car id:
```sql
select* from car_detail t,car_seller r where t.car_owner_id=r.seller_id;
```
### table
| car_owner_id | car_id | car_branad | car_name    | tr_type | fuel_type | reg_state  | reg_year | driven_km | price  | updated_date                   | status  | seller_name | seller_contact_no |
|--------------|--------|------------|-------------|---------|-----------|------------|----------|-----------|--------|--------------------------------|---------|-------------|-------------------|
| 21           | 1001   | maruti     | maruti ritz | manual  | petrol    | tamil nadu | 2019     | 20000     | 110890 | 02-01-20 03:31:13.970000000 PM | ordered | selva raj   | 7894030293        |
| 21           | 1002   | maruti     | maruti alto | manual  | diesel    | kerala     | 2019     | 20100     | 789076 | 02-01-20 03:31:13.977000000 PM | ordered | selva raj   | 7894030293        |
| 23           | 1003   | honda      | honda city  | manual  | diesel    | tamil nadu | 2019     | 2000      | 894048 | 02-01-20 03:31:13.982000000 PM | update  | kannna      | 8973456768        |
| 39           | 1004   | audi       | audi-zada   | manual  | diesel    | tamil nadu | 2019     | 2000      | 684984 | 02-01-20 03:31:13.990000000 PM | update  | pearl       | 8923940920        |
| 11           | 1005   | audi       | audi        | manual  | diesel    | tamil nadu | 2019     | 2000      | 348782 | 02-01-20 03:31:13.997000000 PM | update  | sugu        | 8674638292        |

select query for display the car_owner details depend on  registration state:
```sql
select * from car_seller  where seller_id =(select car_owner_id from car_detail where reg_state='kerala');
```
select query for display the car detail depends on car registration state
```sql
select * from  car_detail t left outer join car_seller d on t.car_owner_id=d.seller_id where reg_state='tamil nadu'; 
```
select query for  display all the ordered  cars details with seller details;
```sql
select * from car_detail where status='ordered';
```
select query for  display the car details  using some cases(car_brand,car_model,car,kellometer,reg_state)
```sql
select * from  car_detail t left outer join car_seller d on t.car_owner_id=d.seller_id where t.reg_state='tamil nadu' and t.driven_km>=2000 and driven_km <=20000 and t.car_brand='audi' and t.status='update';
```
to view all available cars:
```sql
select car_brand, car_name,count(car_brand)as available_car_count from car_detail where status='update' group by car_brand,car_name;
```
select query for  display the car details  using some cases(tr_type,fuel_type)
```sql
select * from car_detail c  right outer join car_seller d on c.car_owner_id=d.seller_id where c.tr_type='manual'and c.fuel_type='petrol';
```
to view all ordered cars;(using join and group by)
```sql
select c.car_brand, c.car_name,s.seller_id ,s.seller_name from car_detail c,car_seller s where c.status='ordered' and c.car_owner_id=s.seller_id group by c.car_brand,c.car_name,s.seller_id,s.seller_name;
```
view the car_status:
```sql
select car_available(1001)as car_status from dual;
```
###function:
```sql
create or replace FUNCTION CAR_AVAILABLE(fn_car_id number)
RETURN VARCHAR2 AS 
statuss varchar2(20);
BEGIN
select status into statuss from car_detail where car_id=fn_car_id ; 
  RETURN statuss;
END CAR_AVAILABLE;
```


