1. select * from student
where sem=2 and branchid=
(select branchid from branch
where branchname='MCA');

2. select * from student
where usn not in
(select usn from borrow);

3. select s.usn,s.name,b.branchname,
bk.bookname,a.authorname,
br.borrowed_date
from student s,branch b,book bk,
author a,borrow br
where s.usn=br.usn
and br.bookid=bk.bookid
and bk.authorid=a.authorid
and s.branchid=b.branchid
and s.sem=2
and b.branchname='MCA';

4.select authorid,count(*) from book group by authorid;

5.select * from student where usn in( select usn
from borrow group by usn having count(*)>2);

6.select * from student
where usn in( select usn
from borrow natural join book
group by usn
having count(distinct authorid)>1);

7.select bookname
from book
order by bookname desc;

8.select * from student
where usn in( select usn
from borrow natural join book
group by usn
having count(distinct publisher)=1);
