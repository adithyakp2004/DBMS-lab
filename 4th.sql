select * from candidate where candid in(select candid
from contest c,constituency s where c.constid=s.constid
group by candid having count(distinct state)>1);

select state from constituency group by state
having count(*)=(select max(count(*))
from constituency group by state);

create or replace procedure checkage(id number,age number) as
begin
if age>=18 then
insert into voters(vid,age)
values(id,age);
else
dbms_output.put_line('NOT ELIGIBLE');
end if;
end;
/
exec checkage(4,20);

create or replace procedure countvoters(id number) as
c number;
begin
select noofofvoters into c from constituency
where constid=id;
dbms_output.put_line(c);
end;
/
exec countvoters(1);
select noofvoters into c from constituency where constid=id;

create or replace trigger updatecount
after insert on voters
for each row
begin
update constituency
set noofvoters=noofvoters+1
where constid=:new.constid;
end;
/
