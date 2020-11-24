-- Questão 1
-- A. vw_dptmgr: contém apenas o número do departamento e o nome do gerente;
CREATE VIEW vw_dptmgr AS SELECT d.dnumber AS department, e.fname || ' ' || e.lname AS manager FROM department AS d, employee AS e WHERE e.ssn = d.mgrssn;

-- B. vw_empl_houston: contém o ssn e o primeiro nome dos empregados com endereço em Houston;
CREATE VIEW vw_empl_houston AS SELECT e.ssn, e.fname FROM employee AS e WHERE e.address LIKE '%Houston%';

-- C. vw_deptstats: contém o número do departamento, o nome do departamento e o número de funcionários que trabalham no departamento;
CREATE VIEW vw_deptstats AS SELECT d.dnumber, d.dname, COUNT (e.dno) AS qtd_funcionarios FROM department AS d, employee AS e  WHERE d.dnumber = e.dno GROUP BY d.dnumber;

-- D. vw_projstats: contém o id do projeto e a quantidade de funcionários que trabalham no projeto;
CREATE VIEW vw_projstats AS SELECT p.pnumber AS project_id, COUNT (w.pno) AS qtd_func FROM project AS p, works_on AS w WHERE p.pnumber = w.pno GROUP BY p.pnumber;

--Questao 2
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;
SELECT * FROM vw_deptstats WHERE qtd_funcionarios > 9;
SELECT * FROM vw_projstats WHERE qtd_func > 5;

-- Questao 3
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;