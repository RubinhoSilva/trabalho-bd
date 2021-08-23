CREATE TABLE tb_pessoa(
	ID int primary key,
    Nome varchar(255),
    Idade int,
    Altura float,
    Peso float,
    Titulos int default 0,
    Salario float default 0
);

CREATE TABLE tb_pessoa_tecnico(
	CCT int,
    Pessoa_id int,
    primary key(CCT, Pessoa_id),
    FOREIGN KEY (Pessoa_id) REFERENCES tb_pessoa(ID)
);

CREATE TABLE tb_time(
	ID int primary key,
    Nome varchar(255),
    Historia text null,
    Bandeira varchar(255),
    Hino varchar(255),
    Logo varchar(255),
    Pessoa_tecnico_id int unique,
    FOREIGN KEY (Pessoa_tecnico_id) REFERENCES tb_pessoa_tecnico(CCT)
);

CREATE TABLE tb_pessoa_jogador(
	CCJ int,
    Posicao varchar(255),
    Gols int default 0,
    Pessoa_id int,
    primary key(CCJ, Pessoa_id),
	Time_id int,
    FOREIGN KEY (Pessoa_id) REFERENCES tb_pessoa(ID),
    FOREIGN KEY (Time_id) REFERENCES tb_time(ID)
);

CREATE TABLE tb_pessoa_arbitro(
	CCA int,
    Penalidades int default 0,
    E_fifa bool default false,
    E_video bool default false,
    Pessoa_id int,
    primary key(CCA, Pessoa_id),
    FOREIGN KEY (Pessoa_id) REFERENCES tb_pessoa(ID)
);

CREATE TABLE tb_time_uniforme(
	Numero int,
    Descricao text,
    Cor_principal varchar(20),
    Cor_secundaria varchar(20) null,
    Time_id int,
    primary key(Numero, Time_id),
    FOREIGN KEY (Time_id) REFERENCES tb_time(ID)
);

CREATE TABLE tb_campeonato(
	ID int primary key,
    Nome varchar(255),
    Data_incio date,
    Premiacao float,
    Descricao text null
);

CREATE TABLE tb_estadio(
	ID int primary key,
    Nome varchar(255),
    Apelido varchar(255) null,
    Capacidade int,
    Endereco varchar(255),
    Time_id int unique,
    FOREIGN KEY (Time_id) REFERENCES tb_time(ID)
);

CREATE TABLE tb_partida(
	ID int primary key,
    Valor float,
    Setor varchar(100),
    Cadeira int,
    Status int,
	Estadio_id int,
	Campeonato_id int,
    FOREIGN KEY (Estadio_id) REFERENCES tb_estadio(ID),
    FOREIGN KEY (Campeonato_id) REFERENCES tb_campeonato(ID)
);

CREATE TABLE tb_partida_lance(
	Tempo timestamp,
    Tipo int,
    Descricao text,
    Partida_id int,
	Pessoa_jogador_id int unique,
    primary key(Tempo, Partida_id),
    FOREIGN KEY (Partida_id) REFERENCES tb_partida(ID),
    FOREIGN KEY (Pessoa_jogador_id) REFERENCES tb_pessoa_jogador(CCJ)
);

CREATE TABLE tb_ingresso(
	ID int primary key,
    Data date,
    Horario time,
    Sumula text null,
    Observacoes text null,
    Partida_id int,
    FOREIGN KEY (Partida_id) REFERENCES tb_partida(ID)
);

CREATE TABLE tb_partida_entre_time(
    Partida_id int,
    Time_id int,
    primary key(Partida_id, Time_id),
    FOREIGN KEY (Partida_id) REFERENCES tb_partida(ID),
    FOREIGN KEY (Time_id) REFERENCES tb_time(ID)
);

CREATE TABLE tb_partida_apitada_arbitro(
    Partida_id int,
    Pessoa_arbitro_id int,
    primary key(Partida_id, Pessoa_arbitro_id),
    FOREIGN KEY (Partida_id) REFERENCES tb_partida(ID),
    FOREIGN KEY (Pessoa_arbitro_id) REFERENCES tb_pessoa_arbitro(CCA)
)