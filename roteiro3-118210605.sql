-- ROTEIRO 3

-- ESTADOS DO BRASIL
CREATE TYPE estado AS ENUM ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO');

-- FARMACIAS PODEM SER SEDES (S) OU FILIARES (F)
CREATE TABLE farmacia (
id INTEGER PRIMARY KEY,
bairro VARCHAR(15) UNIQUE,
cidade VARCHAR(20),
current_estado estado,
tipo CHAR(1),
CHECK (tipo = 'S' OR tipo = 'F')
);

-- SO PODE HAVER UMA SEDE
ALTER TABLE farmacia ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE (tipo = 'S');

-- PARA QUE UM FUNCIONARIO NAO ESTEJA LOTADO EM NENHUMA FARMACIA BASTA QUE O ID DE FARMACIA SEJA NULL
CREATE TABLE funcionario (
cpf CHAR(11) PRIMARY KEY,
gerente BOOLEAN,
farmacia_id INTEGER REFERENCES farmacia (id),
nome VARCHAR(30),
tipo CHAR(1),
CHECK (tipo = 'C' OR tipo = 'E' OR tipo = 'F' OR tipo = 'V' OR tipo = 'A'),
);

--  GERENTES SO PODEM SER ADMINISTRADORES OU FARMACEUTICOS
ALTER TABLE funcionario ADD CONSTRAINT gerente_adm_farm EXCLUDE USING gist (gerente = TRUE) WHERE (tipo = 'C' OR tipo = 'E' OR tipo = 'V');

-- CADA FARMACIA PODE TER APENAS UM GERENTE
ALTER TABLE funcionario ADD CONSTRAINT gerente_unico EXCLUDE USING gist (farmacia_id WITH =) WHERE (gerente = TRUE);

-- CLIENTES DEVEM SER MAIORES DE IDADE
CREATE TABLE cliente (
nascimendo DATE,
cpf CHAR(11) PRIMARY KEY,
nome VARCHAR(50),
telefone VARCHAR(11),
CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, nascimendo)) > 17)
);

-- CADA CLIENTE PODE TER MAIS DE UM ENDERECO ALOCADO
CREATE TABLE endereco_cliente (
id INTEGER PRIMARY KEY,
endereco VARCHAR(100),
cpf_cliente CHAR(11) REFERENCES cliente (cpf),
tipo CHAR(1),
CHECK (tipo = 'R' OR tipo = 'T' OR tipo = 'O')
);

CREATE TABLE medicamento (
codigo INTEGER PRIMARY KEY,
receita_obrigatoria BOOLEAN,
nome VARCHAR(50),
preco NUMERIC
);

CREATE TABLE venda (
codigo INTEGER PRIMARY KEY,
vendedor CHAR(11) REFERENCES funcionario (cpf) NOT NULL,
cliente CHAR(11) REFERENCES cliente (cpf),
farmacia INTEGER REFERENCES farmacia (id) NOT NULL
);

-- QUAIS MEDICAMENTOS ESTAO ASSOCIADOS A CADA VENDA
CREATE TABLE venda_medicamento (
codigo_venda INTEGER REFERENCES venda (codigo) NOT NULL,
medicamento INTEGER REFERENCES medicamento (codigo) NOT NULL
);

-- UMA ENTREGA SO PODE SER FEITA A UM CLIENTE CADASTRADO E COM ENDERECO CADASTRADO
CREATE TABLE entrega (
id INTEGER PRIMARY KEY,
codigo_venda INTEGER REFERENCES venda (codigo) NOT NULL,
cpf_cliente CHAR(11) REFERENCES cliente (cpf) NOT NULL,
endereco INTEGER REFERENCES endereco_cliente (id) NOT NULL
);