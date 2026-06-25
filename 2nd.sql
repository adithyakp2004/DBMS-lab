update studentr set total=mark1+mark2+mark3;

update studentr set gpa=total/3;
select * from studentr;

select * from studentr where date_of_birth like '%02';

select * from studentr where branch='MCA';

select branch,max(gpa) from studentr group by branch;

select * from studentr where sname like 'S%';

select * from studentr where sname like '%AR';

delete from studentr where usn='1RN23MC047';
