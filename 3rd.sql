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

