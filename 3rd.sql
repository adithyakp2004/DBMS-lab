create table team (tid int primary key, tname varchar(20), coach
varchar(20), captain_pid int, city varchar(20));

create table player (pid int primary key, pname varchar(20),
age int, tid int references team(tid));

create table stadium (sid int primary key, sname varchar(20),
picode number(8), city varchar(20), area varchar(20));

create table match (mid int primary key, mdate date,
time varchar(6),
sid int references stadium(sid),
team1_id int references team(tid),
team2_id int references team(tid),
winning_team_id int references team(tid),
man_of_match int references player(pid));

create table player_phone
(pid int references
player(pid), phone int,
primary
key(pid,phone));


select pname,tname,age from player p,team t
where p.tid=t.tid and age=(select min(age) from player);

select *from stadium where sid in(
select sid from match group by sid
having count(*)=(select max(count(*))
from match group by sid));

select * from player where pid not in
(select captain_pid from team)
and pid in(select man_of_match
from match group by man_of_match
having count(*)>=2);

select * from team where tid in(
select winning_team_id from match
group by winning_team_id
having count(*)=(select max(count(*))
from match group by winning_team_id));

select tname from team where tid in(
select winning_team_id from match
group by winning_team_id,sid
having count(*) in(select count(*)
from match group by winning_team_id));

