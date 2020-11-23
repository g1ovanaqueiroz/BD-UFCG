-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-11-08 18:30:54.372

-- tables
-- Table: jogador
CREATE TABLE jogador (
    primeiro_nome varchar(15)  NOT NULL,
    ultimo_nome varchar(50),
    cpf char(11)  NOT NULL,
    time_id int  NOT NULL,
    CONSTRAINT jogador_pk PRIMARY KEY (cpf)
);

-- Table: participa
CREATE TABLE participa (
    jogador_cpf char(11)  NOT NULL,
    partida_id int  NOT NULL,
    posicao varchar(20)  NOT NULL,
    id int  NOT NULL,
    CONSTRAINT participa_pk PRIMARY KEY (id)
);

-- Table: partida
CREATE TABLE partida (
    id int  NOT NULL,
    local_partida varchar(50)  NOT NULL,
    CONSTRAINT partida_pk PRIMARY KEY (id)
);

-- Table: time_
CREATE TABLE time_ (
    nome varchar(30)  NOT NULL,
    id int  NOT NULL,
    CONSTRAINT time__pk PRIMARY KEY (id)
);

-- Table: time_partida
CREATE TABLE time_partida (
    partida_id INTEGER  NOT NULL,
    time1_id INTEGER  NOT NULL,
    time2_id INTEGER  NOT NULL,
    gols_time1 INTEGER  NOT NULL,
    gols_time2 INTEGER  NOT NULL,
    CONSTRAINT time_partida_pk PRIMARY KEY (partida_id)
);

-- foreign keys
-- Reference: Jogador_Time (table: jogador)
ALTER TABLE jogador ADD CONSTRAINT Jogador_Time
    FOREIGN KEY (time_id)
    REFERENCES time_ (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Participa_Jogador (table: participa)
ALTER TABLE participa ADD CONSTRAINT Participa_Jogador
    FOREIGN KEY (jogador_cpf)
    REFERENCES jogador (cpf)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Participa_Partida (table: participa)
ALTER TABLE participa ADD CONSTRAINT Participa_Partida
    FOREIGN KEY (partida_id)
    REFERENCES partida (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_partida_Partida (table: time_partida)
ALTER TABLE time_partida ADD CONSTRAINT time_partida_Partida
    FOREIGN KEY (partida_id)
    REFERENCES partida (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_partida_Time (table: time_partida)
ALTER TABLE time_partida ADD CONSTRAINT time_partida_Time
    FOREIGN KEY (time1_id) REFERENCES time_ (id)
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: time_partida_Time (table: time_partida)
ALTER TABLE time_partida ADD CONSTRAINT time_partida_Time2
    FOREIGN KEY (time2_id) REFERENCES time_ (id)
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.
