create table intask(
task_id number,
task_name varchar2(30) not null,
task_performer varchar2(20) not null,
deadline_date date  not null,
completed_date date not null,
task_status varchar2(20) default 'assigned',
  modify_date date default sysdate,
  priority number,
 constraint task_id_pk primary key(task_id),
constraint task_name_uq unique(task_name),
  constraint priority_uq unique(priority),
constraint task_status_cq check(task_status in ('completed','not completed'))
);

insert into intask(task_id,task_name,task_performer,deadline_date,completed_date,task_status)values(1,'open your lap','MK',to_date('12-12-2019','dd-mm-yyyy'),to_date('12.12.2019','dd-mm-yyyy'),'completed');
insert into intask(task_id,task_name,task_performer,deadline_date,completed_date,task_status,modify_date,priority)values(2,'open your laptop','mkv',to_date('12-10-2020','dd-mm-yyyy'),to_date('12-10-2020','dd-mm-yyyy'),'not completed',to_date('10.10.2020','dd-mm-yyyy'),2);

insert into intask(task_id,task_name,task_performer,deadline_date,completed_date,task_status,modify_date,priority)values(3,'open your hand','mkf',to_date('12-10-2020','dd-mm-yyyy'),to_date('12-10-2020','dd-mm-yyyy'),'completed',to_date('11.10.2020','dd-mm-yyyy'),1);
select * from intask;  
   select count(*)from intask group by completed_date;               

