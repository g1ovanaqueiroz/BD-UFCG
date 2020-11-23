-- Times
INSERT INTO time_ (nome, id) VALUES ('Flamengo', 1);
INSERT INTO time_ (nome, id) VALUES ('São Paulo', 2);
INSERT INTO time_ (nome, id) VALUES ('Corinthias', 3);
INSERT INTO time_ (nome, id) VALUES ('Santos', 4);
INSERT INTO time_ (nome, id) VALUES ('Fluminense', 5);

-- Jogadores
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Gabriel', 'Barbosa', '00000000000', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Bruno', 'Henrique', '00000000001', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Giorgian', 'De Arrascaeta', '00000000002', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Pedro', '', '00000000003', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Mauricio', 'Isla', '00000000004', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Diego', 'Alves', '00000000005', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Gerson', 'Santos', '00000000006', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Éverton', 'Ribeiro', '00000000007', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Filipe', 'Luís', '00000000008', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Victor', 'Coelho', '00000000009', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Diego', 'Ribas da Cunha', '00000000010', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Neneca', '', '00000000011', 1);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Fred', '', '00000000012', 5);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Nenê', '', '00000000013', 5);
INSERT INTO jogador (primeiro_nome, ultimo_nome, cpf, time_id) VALUES ('Muriel', 'Becker', '00000000014', 5);

INSERT INTO partida (id, local_partida) VALUES (1, 'Maracana');

INSERT INTO participa (jogador_cpf, partida_id, posicao, id) VALUES ('00000000000', 1, 'atacante', 1);
INSERT INTO participa (jogador_cpf, partida_id, posicao, id) VALUES ('00000000005', 1, 'goleiro', 2);
INSERT INTO participa (jogador_cpf, partida_id, posicao, id) VALUES ('00000000014', 1, 'goleiro', 3);
INSERT INTO participa (jogador_cpf, partida_id, posicao, id) VALUES ('00000000013', 1, 'Meia', 4);

INSERT INTO time_partida (partida_id, time1_id, time2_id, gols_time1, gols_time2) VALUES (1, 1, 5, 7, 1);