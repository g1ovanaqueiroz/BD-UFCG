-- Q1
SELECT COUNT(*) FROM employee WHERE sex = 'F';

-- Q2
SELECT AVG(salary) FROM employee WHERE address LIKE '%TX' AND sex = 'M';

-- Q3
SELECT superssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados FROM employee GROUP BY superssn ORDER BY COUNT(*);

-- Q4
SELECT s.fname AS nome_supervisor, COUNT(e.superssn) AS atd_supervisionados FROM employee AS e JOIN employee AS s ON s.ssn = e.superssn GROUP BY e.superssn, s.ssn ORDER BY COUNT(e.superssn);

-- Q5
SELECT s.fname AS nome_supervisor, COUNT(*) AS atd_supervisionados FROM employee AS e LEFT JOIN employee AS s ON s.ssn = e.superssn GROUP BY e.superssn, s.ssn ORDER BY COUNT(*);

-- Q6
SELECT MIN(empregados.emp) AS qtd FROM (SELECT COUNT(pno) AS emp FROM works_on GROUP BY pno) AS empregados;

-- Q7
SELECT pno AS proj, COUNT(essn) AS qtd FROM works_on GROUP BY pno HAVING COUNT(essn) = ( SELECT MIN(qtd) AS qtd_empregados FROM (SELECT COUNT(essn) AS qtd FROM works_on GROUP BY pno) as qtds);

-- Q8
SELECT w.pno AS num_proj, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn GROUP BY w.pno;

-- Q9
SELECT w.pno AS num_proj, p.pname AS proj_nome, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn JOIN project AS p ON p.pnumber = w.pno GROUP BY w.pno, p.pnumber;

-- Q10
SELECT e.fname, e.salary FROM employee AS e, (SELECT MAX(emp.salary) AS salary FROM  employee AS emp, works_on AS w WHERE w.essn = emp.ssn AND w.pno = 92) AS s WHERE e.salary > s.salary;

-- Q11
SELECT e.ssn, COUNT(w.essn) AS qtd_proj FROM employee as e LEFT JOIN works_on AS w on e.ssn = w.essn GROUP BY e.ssn ORDER BY COUNT(w.essn);

-- Q12
SELECT * FROM (SELECT w.pno    AS num_proj, COUNT(e.ssn) AS qtd_func FROM (employee  AS e FULL OUTER JOIN works_on AS w ON (w.essn = e.ssn))  GROUP BY w.pno) AS ew WHERE ew.qtd_func < 5;

-- Q13
SELECT DISTINCT s.fname AS fname FROM employee AS s, dependent AS d, works_on AS w, project AS p WHERE (p.plocation LIKE '%Sugarland%' AND p.pnumber = w.pno AND w.essn = s.ssn AND s.ssn = d.essn);

-- Q14
SELECT dname FROM department WHERE NOT EXISTS (SELECT dnum FROM project WHERE dnumber = dnum);

-- Q15
SELECT DISTINCT fname, lname FROM employee AS e, works_on WHERE essn = ssn AND ssn <> '123456789' AND NOT EXISTS ((SELECT pno FROM works_on WHERE essn = '123456789') EXCEPT(SELECT pno FROM works_on WHERE essn = e.ssn));