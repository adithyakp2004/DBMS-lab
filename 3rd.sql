create table team (tid int primary key, tname varchar(20), coach
varchar(20), captain_pid int, city varchar(20));
INSERT INTO team VALUES (123, 'rcb', 'sunil', 1, 'bangalore');
INSERT INTO team VALUES (124, 'csk', 'laxman', 3, 'chennai');
INSERT INTO team VALUES (125, 'royals', 'singh', 4, 'rajasthan');
INSERT INTO team VALUES (126, 'daredevils', 'sehwag', 2, 'delhi');
INSERT INTO team VALUES (127, 'kkr', 'ravi', 5, 'goa');

create table player (pid int primary key, pname varchar(20),
age int, tid int references team(tid));
INSERT INTO player VALUES (1, 'sachin', 33, 123);
INSERT INTO player VALUES (2, 'dravid', 32, 124);
INSERT INTO player VALUES (3, 'dhoni', 30, 124);
INSERT INTO player VALUES (4, 'raina', 30, 125);
INSERT INTO player VALUES (5, 'kohli', 23, 126);

ALTER TABLE team
ADD CONSTRAINT fk_captain
FOREIGN KEY (captain_pid)
REFERENCES player(pid);

create table stadium (sid int primary key, sname varchar(20),
picode number(8), city varchar(20), area varchar(20));
INSERT INTO stadium VALUES (111, 'chinnaswamy', 56001, 'bangalore', 'mg road');
INSERT INTO stadium VALUES (222, 'kotla', 460009, 'delhi', 'highway');
INSERT INTO stadium VALUES (333, 'international', 38883, 'chennai', 'trnagar');
INSERT INTO stadium VALUES (444, 'ksca', 560098, 'bangalore', 'peenya');
INSERT INTO stadium VALUES (555, 'csca', 567772, 'cochin', 'beach road');

create table matches (mid int primary key, mdate date,time varchar(6),sid int references stadium(sid),
team1_id int references team(tid),team2_id int references team(tid),
winning_team_id int references team(tid),man_of_match int references player(pid));
INSERT INTO matches VALUES (101, '10-JAN-17', '10am', 111, 123, 124, 123, 1);
INSERT INTO matches VALUES (102, '11-JAN-17', '9am', 222, 124, 126, 126, 5);
INSERT INTO matches VALUES (103, '12-JAN-17', '11am', 111, 125, 126, 126, 5);
INSERT INTO matches VALUES (104, '10-JAN-17', '12am', 111, 125, 123, 123, 1);
INSERT INTO matches VALUES (105, '11-JAN-17', '9am', 222, 124, 126, 126, 5);

create table player_phone(pid int references player(pid), phone NUMBER(10),
primary key(pid,phone));
INSERT INTO player_phone VALUES (1, 998882928);
INSERT INTO player_phone VALUES (2, 877563733);
INSERT INTO player_phone VALUES (2, 988928822);
INSERT INTO player_phone VALUES (2, 877366383);

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

SELECT tname FROM team WHERE tid IN (
    SELECT winning_team_id FROM match
    GROUP BY winning_team_id
    HAVING COUNT(DISTINCT sid)=1);
