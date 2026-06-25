
create table tourist_place (tpid number primary key, history
varchar(20), kilometers number(3),state varchar(20),tpname varchar(20));

create table tourist(tid number primary key, country varchar(20),
age number,tname varchar(20));

create table visits (tpid number(3) references
tourist_place(tpid), tid number references
tourist(tid),
vdate date,
primary key (tpid, tid));

create table email
(tid number references tourist(tid),
email varchar (20), primary key (tid, email));


select state from tourist_place group by state 
having count(*)=(select max(count(*)) from tourist_placegroup by state);

select * from tourist_place where tpid in(
select tpid from visits group by tpid having count(*)=(
select max(count(*)) from visits group by tpid));

select * from tourist where tid in(
select tid from visits natural join tourist_place
where state='karnataka' group by tid
having count(*)=(select count(*)
from tourist_place where state='karnataka'));

select * from tourist where tid in(
select tid from visits natural join tourist_place
group by tid having count(distinct state)=(
select count(distinct state) from tourist_place));

select * from tourist_place where tpid in(
select tpid from visits natural join tourist
group by tpid having count(distinct country)=(
select count(distinct country)from tourist));
