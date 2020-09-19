-- QUESTOES 1 E 2
CREATE TABLE AUTOMOVEL (
placa CHAR (7),
marca VARCHAR (20),
modelo VARCHAR (20),
numero_serial CHAR (17)
);

CREATE TABLE SEGURADO (
cpf CHAR (11),
nome VARCHAR (30),
nascimento DATE,
endereco VARCHAR (30),
telefone VARCHAR (11)
);

CREATE TABLE PERITO (
cpf CHAR (11),
nome VARCHAR (30),
nascimento DATE,
endereco VARCHAR (30),
telefone VARCHAR (11),
data_contratacao DATE,
salario NUMERIC
);

CREATE TABLE OFICINA (
cnpj CHAR (11),
endereco VARCHAR (30),
nome VARCHAR(20),
telefone VARCHAR (11)
);

CREATE TABLE SEGURO (
id SERIAL,
cpf_segurado CHAR (11),
placa_automovel CHAR (7),
data_contratacao DATE,
validade DATE,
valor NUMERIC
);

CREATE TABLE SINISTRO (
id SERIAL,
horario_da_ocorrencia TIMESTAMP,
descricao VARCHAR (100),
num_seguro SERIAL
);

CREATE TABLE PERICIA (
id SERIAL,
cpf_perito CHAR(11),
num_sinistro SERIAL,
descricao VARCHAR (100)
);

CREATE TABLE REPARO (
id SERIAL,
num_pericia SERIAL,
valor NUMERIC,
cnpj_oficina CHAR (11)
);

-- QUESTAO 3
ALTER TABLE AUTOMOVEL ADD PRIMARY KEY (numero_serial);
ALTER TABLE SEGURADO ADD PRIMARY KEY (cpf);
ALTER TABLE PERITO ADD PRIMARY KEY (cpf);
ALTER TABLE OFICINA ADD PRIMARY KEY (cnpj);
ALTER TABLE SEGURO ADD PRIMARY KEY (id);
ALTER TABLE SINISTRO ADD PRIMARY KEY (id);
ALTER TABLE PERICIA ADD PRIMARY KEY (id);
ALTER TABLE REPARO ADD PRIMARY KEY (id);

-- QUESTAO 4
ALTER TABLE SEGURO ADD CONSTRAINT chave_estrangeira FOREIGN KEY (cpf_segurado) REFERENCES SEGURADO (cpf);
ALTER TABLE SEGURO ADD CONSTRAINT chaveEstrangeira FOREIGN KEY (placa_automovel) REFERENCES AUTOMOVEL (placa);
ALTER TABLE SINISTRO ADD CONSTRAINT chave_estrangeira FOREIGN KEY (num_seguro) REFERENCES SEGURO (id);
ALTER TABLE PERICIA ADD CONSTRAINT chave_estrangeira FOREIGN KEY (cpf_perito) REFERENCES PERITO (cpf);
ALTER TABLE PERICIA ADD CONSTRAINT chaveEstrangeira FOREIGN KEY (num_sinistro) REFERENCES SINISTRO (id);
ALTER TABLE REPARO ADD CONSTRAINT chave_estrangeira FOREIGN KEY (num_pericia) REFERENCES PERICIA (id);
ALTER TABLE REPARO ADD CONSTRAINT chaveEstrangeira FOREIGN KEY (cnpj_oficina) REFERENCES OFICINA (cnpj);

--QUESTAO 5
-- Em automovel: nenhum dos atributos deveria poder ser nulo
-- Em segurado: CPF, nome e nascimento devem ser not null
-- Em perito: CPF, nome, data_nascimento e data_contratacao devem ser not null
-- Em oficina: nenhum dos atributos deveria poder ser nulo
-- Em seguro: nenhum dos atributos deveria poder ser nulo
-- Em sinistro: nenhum dos atributos deveria poder ser nulo
-- Em pericia: nenhum dos atributos deveria poder ser nulo
-- Em reparo: nenhum dos atributos deveria poder ser nulo

--QUESTAO 6: Done

-- QUESTAO 7
CREATE TABLE AUTOMOVEL (
placa CHAR (7) PRIMARY KEY,
marca VARCHAR (20) NOT NULL,
modelo VARCHAR (20) NOT NULL,
numero_serial CHAR (17) NOT NULL
);

CREATE TABLE SEGURADO (
cpf CHAR (11) PRIMARY KEY,
nome VARCHAR (30) NOT NULL,
nascimento DATE NOT NULL,
endereco VARCHAR (30),
telefone VARCHAR (11)
);

CREATE TABLE PERITO (
cpf CHAR (11) PRIMARY KEY,
nome VARCHAR (30) NOT NULL,
nascimento DATE NOT NULL,
endereco VARCHAR (30),
telefone VARCHAR (11),
data_contratacao DATE NOT NULL,
salario NUMERIC
);

CREATE TABLE OFICINA (
cnpj CHAR (11) PRIMARY KEY,
endereco VARCHAR (30) NOT NULL,
nome VARCHAR(20) NOT NULL,
telefone VARCHAR (11) NOT NULL
);

CREATE TABLE SEGURO (
id SERIAL PRIMARY KEY,
cpf_segurado CHAR (11) NOT NULL REFERENCES SEGURADO (cpf),
placa_automovel CHAR (7) NOT NULL REFERENCES AUTOMOVEL (placa),
data_contratacao DATE NOT NULL,
validade DATE NOT NULL,
valor NUMERIC NOT NULL
);

CREATE TABLE SINISTRO (
id SERIAL PRIMARY KEY,
horario_da_ocorrencia TIMESTAMP NOT NULL,
descricao VARCHAR (100) NOT NULL,
num_seguro SERIAL REFERENCES SEGURO (id) NOT NULL
);

CREATE TABLE PERICIA (
id SERIAL PRIMARY KEY,
cpf_perito CHAR(11) REFERENCES PERITO (cpf) NOT NULL,
num_sinistro SERIAL REFERENCES SINISTRO (id) NOT NULL,
descricao VARCHAR (100) NOT NULL
);

CREATE TABLE REPARO (
id SERIAL PRIMARY KEY,
num_pericia SERIAL REFERENCES PERICIA (id) NOT NULL,
valor NUMERIC NOT NULL,
cnpj_oficina CHAR (11) REFERENCES OFICINA (cnpj) NOT NULL
);

--  QUESTAO 8: Done

--QUESTOES 9, 10: Done