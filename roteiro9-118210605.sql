-- Questão 1
-- A. vw_dptmgr: contém apenas o número do departamento e o nome do gerente;
CREATE VIEW vw_dptmgr AS SELECT d.dnumber AS department, e.fname || ' ' || e.lname AS manager FROM department AS d, employee AS e WHERE e.ssn = d.mgrssn;

-- B. vw_empl_houston: contém o ssn e o primeiro nome dos empregados com endereço em Houston;

-- C. vw_deptstats: contém o número do departamento, o nome do departamento e o número de funcionários que trabalham no departamento;

-- D. vw_projstats: contém o id do projeto e a quantidade de funcionários que trabalham no projeto;