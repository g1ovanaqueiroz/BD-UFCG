-- Questão 1
-- A. vw_dptmgr: contém apenas o número do departamento e o nome do gerente;
CREATE VIEW vw_dptmgr AS SELECT d.dnumber AS department, e.fname || ' ' || e.lname AS manager FROM department AS d, employee AS e WHERE e.ssn = d.mgrssn;

-- B. vw_empl_houston: contém o ssn e o primeiro nome dos empregados com endereço em Houston;
CREATE VIEW vw_empl_houston AS SELECT e.ssn, e.fname FROM employee AS e WHERE e.address LIKE '%Houston%';

-- C. vw_deptstats: contém o número do departamento, o nome do departamento e o número de funcionários que trabalham no departamento;
CREATE VIEW vw_deptstats AS SELECT d.dnumber, d.dname, COUNT (e.dno) AS qtd_funcionarios FROM department AS d, employee AS e  WHERE d.dnumber = e.dno GROUP BY d.dnumber;

-- D. vw_projstats: contém o id do projeto e a quantidade de funcionários que trabalham no projeto;
CREATE VIEW vw_projstats AS SELECT p.pnumber AS project_id, COUNT (w.pno) AS qtd_func FROM project AS p, works_on AS w WHERE p.pnumber = w.pno GROUP BY p.pnumber;

--Questão 2
SELECT * FROM vw_dptmgr;
SELECT * FROM vw_empl_houston;
SELECT * FROM vw_deptstats;
SELECT * FROM vw_projstats;
SELECT * FROM vw_deptstats WHERE qtd_funcionarios > 9;
SELECT * FROM vw_projstats WHERE qtd_func > 5;

-- Questão 3
DROP VIEW vw_dptmgr;
DROP VIEW vw_empl_houston;
DROP VIEW vw_deptstats;
DROP VIEW vw_projstats;

-- Questão 4
CREATE FUNCTION check_age(essn CHAR(9))
RETURNS text AS $$

DECLARE bdate date;

BEGIN
  SELECT e.bdate INTO bdate FROM employee AS e WHERE e.ssn = essn;
  IF bdate IS NULL THEN
    RETURN 'UNKNOWN';
  ELSIF bdate > CURRENT_DATE THEN
    RETURN 'INVALID';
  ELSIF EXTRACT(YEAR FROM AGE(CURRENT_DATE, bdate)) > 49 THEN
    RETURN 'SENIOR';
  ELSE RETURN 'YOUNG';
  END IF;
END;
$$  LANGUAGE plpgsql;

-- Questão 5
-- A. Caso já tenha criado, remova a trigger:
DROP TRIGGER check_mgr ON department;

-- B. Insira um departamento com dnumber = 2, tendo como gerente o empregado com ssn = '999999999'.
INSERT INTO department VALUES ('Test', 2, '999999999', now());

-- C. Insira um novo employee com ssn = '999999999' e que atenda aos requisitos 2 e 3 para ser gerente. Insira também um subordinado.
-- employee '999999999'
INSERT INTO employee VALUES ('Joao','A','Silva','999999999','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,null,2);

-- employee '999999998', subordinado ao anterior
INSERT INTO employee VALUES ('Jose','A','Santos','999999998','10-OCT-1950','123 Peachtree, Atlanta, GA','M',85000,'999999999',2);

-- D. Crie a trigger;
CREATE FUNCTION check_mgr() RETURNS TRIGGER AS $check_mgr$
  BEGIN

    -- Se não for um funcionário atualmente alocado no departamento
    IF NOT EXISTS (SELECT e.ssn FROM employee AS e WHERE e.ssn = NEW.mgrssn AND e.dno = NEW.dnumber) THEN
      RAISE EXCEPTION 'manager must be a department''s employee';
    END IF;

    -- Se não possuir subordinados
    IF NOT EXISTS (SELECT e.ssn FROM employee AS e WHERE e.superssn = NEW.mgrssn) THEN
      RAISE EXCEPTION 'manager must have supevisees';
    END IF;

    -- Se não for 'SENIOR'
    IF check_age(NEW.mgrssn) != 'SENIOR' THEN
      RAISE EXCEPTION 'manager must be a SENIOR employee';
    END IF;
  
  RETURN NEW;
  END;
  $check_mgr$ LANGUAGE plpgsql;

CREATE TRIGGER check_mgr BEFORE INSERT OR UPDATE ON department
  FOR EACH ROW EXECUTE PROCEDURE check_mgr();

-- E. Agora execute os comandos abaixo e verifique se obteve os mesmos resultados.

-- o update funciona normalmente
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

-- não permite executar update
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = null WHERE dnumber=2;

-- não permite executar update porque esse employee não existe
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = '999' WHERE dnumber=2;

-- não permite executar update pois o employee não é do departamento
-- ERROR:  manager must be a department's employee
UPDATE department SET mgrssn = '111111100' WHERE dnumber=2;

-- altera a data de nascimento do employee para que ele deixe de ser Sênior
-- UPDATE 1
UPDATE employee SET bdate = '10-OCT-2000' WHERE ssn = '999999999';

-- não permite executar update
-- ERROR:  manager must be a SENIOR employee
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

-- altera a data de nascimento do employee para que ele volte a ser Sênior
-- UPDATE 1
UPDATE employee SET bdate = '10-OCT-1950' WHERE ssn = '999999999';

-- o update funciona normalmente
-- UPDATE 1
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

--remove os subordinados
-- DELETE 1
DELETE FROM employee WHERE superssn = '999999999';

-- não permite executar update pois o empregado não tem subordinados
-- ERROR:  manager must have supevisees
UPDATE department SET mgrssn = '999999999' WHERE dnumber=2;

--remove o employee '999999999'
-- DELETE 1
DELETE FROM employee WHERE ssn = '999999999';

--Remove o departamento 2
-- DELETE 1
DELETE FROM department where dnumber=2;