1. update studentr set total=mark1+mark2+mark3;

2. update studentr set gpa=total/3;
   select * from studentr;

3. select * from studentr where date_of_birth like '%02';

4. select * from studentr where branch='MCA';

5. select branch,max(gpa) from studentr group by branch;

6. select * from studentr where sname like 'S%';

7. select * from studentr where sname like '%AR';

8. delete from studentr where usn='1RN23MC047';
