-- Selecionar a quantidade total de gols de cada partida
SELECT gols_time1 + gols_time2 AS Gols FROM time_partida;

-- Selecionar todos os jogadores do time 1
SELECT * FROM jogador WHERE time_id = 1;

-- Selecionar todos os jogadores do time 2
SELECT * FROM jogador WHERE time_id = 2;