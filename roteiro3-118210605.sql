-- ROTEIRO 3
-- CRIACAO DAS TABELAS
CREATE TABLE farmacia (
id INT,
bairro VARCHAR(15),
cidade VARCHAR(20),
estado CHAR(2),
tipo VARCHAR(6),
CHECK (tipo = 'SEDE' OR tipo = 'FILIAL')
);

CREATE TABLE funcionario (
cpf CHAR(11),
nome VARCHAR(30),
id_farmacia INT REFERENCES farmacia (id),
tipo CHAR(1),
CHECK (tipo = 'G' OR tipo = 'C' OR tipo = 'E' OR tipo = 'F' OR tipo = 'V' OR tipo = 'A')
);

-- CADA FARMACIA PODE TER APENAS UM GERENTE
ALTER TABLE funcionario ADD CONSTRAINT gerente_unico EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'G');


