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

-- Q7 ERRADA CONCERTAR
--SELECT empregados.pno AS num_projeto, MIN(empregados.emp) AS qtd_func FROM (SELECT pno, COUNT(pno) AS emp FROM works_on GROUP BY pno) AS empregados GROUP BY empregados.pno;

-- Q8
SELECT w.pno AS num_proj, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn GROUP BY w.pno;

-- Q9
SELECT w.pno AS num_proj, p.pname AS proj_nome, AVG(e.salary) AS media_sal FROM employee AS e JOIN works_on AS w ON e.ssn = w.essn JOIN project AS p ON p.pnumber = w.pno GROUP BY w.pno, p.pnumber;

-- Q10