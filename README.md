#CARS 24
* https://www.cars24.com
## features
 * user should able to upload the car details.
 Features 1: list all the details
 ~~sql
 create table car_details
(
car_owner_id number not null,
car_id number not null,
car_brand varchar2(20) not null,
car_name varchar2(20)not null,
tr_type varchar2(20)not null,
fuel_type  varchar2(20) not null,
reg_state varchar2(20)not null,
reg_year number not null,
driven_km number not null,
constraint fuel_type_cq  check(fuel_type in('diesel','petrol','lpg'',cng')),
constraint car_owner_id_uq unique(car_owner_id),
constraint car_id_uq unique(car_id)
);

### Query:
insert into car_details(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km)values(21,car_id_sq.nextval,'maruti','maruti ritz','manual','petrol','tamil nadu',2019,20000);
insert into car_details(car_owner_id,car_id,car_brand,car_name,tr_type,fuel_type,reg_state,reg_year,driven_km)values(22,car_id_sq.nextval,'maruti','maruti alto','manual','diesel','kerala',2019,20100);
select * from car_details;


  
