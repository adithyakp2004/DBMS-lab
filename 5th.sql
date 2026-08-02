
create table tourist_place (tpid number primary key, history
varchar(20), kilometers number(3),state varchar(20),tpname varchar(20));
INSERT INTO tourist_place VALUES (11, 'beauty', 160, 'karnataka', 'ooty');
INSERT INTO tourist_place VALUES (12, 'monuments', 270, 'kerala', 'beluru');
INSERT INTO tourist_place VALUES (13, 'beach', 360, 'tamilnadu', 'marina');

create table tourist(tid number primary key, country varchar(20),
age number,tname varchar(20));
INSERT INTO tourist VALUES (22, 'india', 34, 'prakash');
INSERT INTO tourist VALUES (23, 'orissa', 28, 'bhanu');
INSERT INTO tourist VALUES (24, 'india', 30, 'nagesh');

create table visits (tpid number(3) references
tourist_place(tpid), tid number references tourist(tid),
vdate date,primary key (tpid, tid));
INSERT INTO visits VALUES (12, 23, '13-NOV-14');
INSERT INTO visits VALUES (11, 24, '24-JUN-13');
INSERT INTO visits VALUES (13, 22, '25-SEP-11');
INSERT INTO visits VALUES (11, 23, '23-FEB-10');
INSERT INTO visits VALUES (13, 23, '12-JAN-10');
INSERT INTO visits VALUES (14, 24, '10-JAN-17');

create table email
(tid number references tourist(tid),
email varchar (25), primary key (tid, email));
INSERT INTO email VALUES (23, 'bhanu12@gmail.com');
INSERT INTO email VALUES (22, 'prakash242@gmail.com');
INSERT INTO email VALUES (24, 'nageshh@gmail.com');

select state from tourist_place group by state 
having count(*)=(select max(count(*)) from tourist_place group by state);

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
