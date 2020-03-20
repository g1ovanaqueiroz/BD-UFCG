--QUESTAO 1

-- CRIACAO DE TABELAS
CREATE TABLE tarefas (
id BIGINT,
descricao VARCHAR (100),
cpf CHAR (11),
setor INTEGER,
classificacao CHAR(1)
);

-- COMANDOS EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483646, 'limpar o chão do corredor central', '98765432111', 0, 'F');
INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas VALUES (null, null, null, null, null);

-- COMANDOS NAO EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483644, 'limpar o chão do corredor superior', '987654323211', 0, 'F');
INSERT INTO tarefas VALUES (2147483643, 'limpar o chão do corredor superior', '98765432321', 0, 'FF');

-- QUESTAO 2

-- COMANDOS EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do téreo', '32323232955', 4, 'A');

-- QUESTAO 3

-- MUDANÇAS NECESSARIAS
ALTER TABLE tarefas ALTER COLUMN setor TYPE SMALLINT;

-- COMANDOS NAO EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');

-- COMANDOS EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');

-- QUESTAO 4

-- MUDANÇAS NECESSARIAS
DELETE FROM tarefas WHERE id IS NULL;
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN setor SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN classificacao SET NOT NULL;
ALTER TABLE tarefas RENAME COLUMN cpf TO func_resp_cpf;
ALTER TABLE tarefas RENAME COLUMN setor TO prioridade;
ALTER TABLE tarefas RENAME COLUMN classificacao TO status;

-- QUESTAO 5

-- MUDANÇAS NECESSARIAS
ALTER TABLE tarefas ADD UNIQUE (id);

-- COMANDOS EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');

-- COMANDOS NAO EXECUTADOS COM SUCESSO
INSERT INTO tarefas VALUES(2147483653, 'aparar grama da area frontal', '32323232911', 3, 'A');

-- QUESTAO 6

-- A
-- O ATRIBUTO JA HAVIA SIDO CONSTRUIDO COM ESSA RESTRICAO

-- B
-- ATUALIZACOES NECESSARIAS
UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

-- CHECK
ALTER TABLE tarefas ADD CONSTRAINT tipo_status CHECK (status = 'P' OR status = 'E' OR status = 'C');

-- QUESTAO 7
UPDATE tarefas SET prioridade = 5 WHERE prioridade > 5;
ALTER TABLE tarefas ADD CONSTRAINT tipo_prioridade CHECK (prioridade = 0 OR prioridade = 1 OR prioridade = 2 OR prioridade = 3 OR prioridade = 4 OR prioridade = 5);

-- QUESTAO 9

CREATE TABLE funcionario (
cpf CHAR(11) PRIMARY KEY,
data_nasc DATE NOT NULL,
nome VARCHAR(50) NOT NULL,
funcao VARCHAR(11) NOT NULL,
CHECK (funcao = 'LIMPEZA' OR funcao = 'SUP_LIMPEZA'),
nivel CHAR(1) NOT NULL,
CHECK (nivel = 'J' OR nivel = 'P' OR nivel = 'S'),
superior_cpf CHAR(11) REFERENCES funcionario (cpf),
CHECK ((superior_cpf IS NOT NULL AND funcao = 'LIMPEZA') OR funcao = 'SUP_LIMPEZA')
);

--COMANDOS QUE FUNCIONAM
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

-- COMANDOS QUE NAO FUNCIONAM
INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);