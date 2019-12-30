# CARS 24
* https://www.cars24.com

## features
 * user should able to upload the car details.
### Features 1: car details
 ~~~sql
 create table car_details
(
car_owner_id number not null,
car_id number not null,
car_brand varchar2(20) not null,
car_name varchar2(30)not null,
tr_type varchar2(20)not null,
fuel_type  varchar2(10) not null,
reg_state varchar2(20)not null,
reg_year number not null,
driven_km number not null,
constraint fuel_type_cq  check(fuel_type in('diesel','petrol','lpg'',cng')),
constraint reg_year_cq check(reg_year>=1947 and reg_date<2020),
constraint car_id_pk primary key(car_id),
constraint car_own_car_name_brand_uq unique(car_owner_id,car_brand,car_name)
);
create table
car_owners(
owner_id  number ,
owner_name varchar2(30) not null,
owner_mobile_no number(10),
constraint owner_id_pk primary key(owner_id),
constraint mobile_number_cq check(owner_mobile_no like ('[0-9]*10'))
);
create sequence car_id_sq start with 1001 increment by 1;
....
### Query:
insert into car_details(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km)values(21,car_id_sq.nextval,'maruti','maruti ritz','manual','petrol','tamil nadu',2019,20000);
insert into car_details(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km)values(22,car_id_sq.nextval,'maruti','maruti alto','manual','diesel','kerala',2019,20100);
insert into car_details(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km)values(23,car_id_sq.nextval,'honda','honda city','manual','diesel','tamil nadu',2019,2000);
select * from car_details;
insert into car_owners(owner_id,owner_name1,owner_mobile_no)values(21,'kanna',8973456768);
select * from car_owners;

  
