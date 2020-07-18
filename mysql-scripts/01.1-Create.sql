CREATE DATABASE IF NOT EXISTS partiu2020;
USE partiu2020;


CREATE table endereco(
    id int auto_increment NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	complemento VARCHAR(10),
    bairro VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    primary key(id)
) ENGINE=InnoDB;

CREATE table usuario(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL,
	cpf long,
    nome VARCHAR(50) NOT NULL,
    nascimento DATE,
    email VARCHAR(50) NOT NULL UNIQUE,
    telefone VARCHAR(11),
    genero char,
    senha VARCHAR(200) NOT NULL,
    endereco int
);

INSERT INTO usuario
(tipo,cpf ,nome,nascimento,email ,telefone,genero,senha,endereco)
values ('garcom','57731434885','Benjamin Bento Isaac Ramos',STR_TO_DATE('08/09/1997','%d/%m/%Y'),'benjamin.bento@gmail.com','27171119','M','123','4'),
('cliente','34145942850','Brenda Mariah Tânia Duarte',STR_TO_DATE('09/02/1986','%d/%m/%Y'),'brenda.mariah@gmail.com','25581929','F','123','5'),
('garcom','68651273827','Tomas Pietro Joaquim Teixeira',STR_TO_DATE('13/05/1984','%d/%m/%Y'),'tomas.pietro@gmail.com','38221874','M','123','6'),
('garcom','42943022837','Adriana Stefany Figueiredo',STR_TO_DATE('25/05/1987','%d/%m/%Y'),'adriana.stefany@gmail.com','29167155','F','123','7');

CREATE table restaurante(
	cnpj VARCHAR(14) NOT NULL,
	codigo_cardapio VARCHAR(5) NOT NULL,
    razao_social VARCHAR(100) NOT NULL,
    nom_fantasia VARCHAR(100) NOT NULL,
    id_endereco int NOT NULL,
    qtd_mesas int(2) NOT NULL,
    logotipo LONGBLOB,
    descricao VARCHAR(700),
    status char NOT NULL,
    primary key (cnpj),
    foreign key (id_endereco) references endereco(id)
);

CREATE table horario_restaurante(
	cnpj_restaurante VARCHAR(14) NOT NULL,
    dia_semana int(1) NOT NULL,
    hra_entrada TIME NOT NULL,
    hra_fim TIME NOT NULL,
    foreign key (cnpj_restaurante) references restaurante(cnpj)    
);

CREATE table funcionario_restaurante(
	id int NOT NULL auto_increment,
	id_funcionario int NOT NULL,
	cnpj_restaurante VARCHAR(14),
    status char NOT NULL default 'A',
	primary key(id),
	foreign key(id_funcionario) references usuario(id),
	foreign key(cnpj_restaurante) references restaurante(cnpj)
);



CREATE table especialidade(
	id int NOT NULL auto_increment,
	nome VARCHAR(50) NOT NULL, 
	primary key (id)
);

CREATE table especialidade_restaurante(
	id int NOT NULL auto_increment,
	cnpj_restaurante VARCHAR(14) NOT NULL,
    id_especialidade int NOT NULL,
    primary key(id),
    foreign key (cnpj_restaurante) references restaurante(cnpj),
    foreign key (id_especialidade) references especialidade(id)
);

CREATE table comanda(
	id int NOT NULL auto_increment,
    id_garcom int NOT NULL,
    codigo_comanda VARCHAR(10) NOT NULL,
    mesa int(2) NOT NULL,
    status char NOT NULL,
    dta_entrada datetime NOT NULL,
    dta_saida datetime,
    dta_atualizacao datetime NOT NULL,
    foreign key (id_garcom) references usuario(id),
    primary key (id)
);

CREATE table usuario_comanda(
	id int NOT NULL auto_increment,
    cod_usuario int NOT NULL,
    cod_comanda int NOT NULL,
    foreign key (cod_usuario) references usuario(id),
    foreign key (cod_comanda) references comanda(id),
    primary key (id)
);

CREATE table avaliacao(
	id int NOT NULL auto_increment,
    id_cliente int NOT NULL,
    id_comanda int NOT NULL,
    av_estabelecimento smallint NOT NULL,
    av_funcionario smallint NOT NULL,
    desc_estabelecimento VARCHAR(200),
    desc_funcionario VARCHAR(200),
    primary key(id),
    foreign key (id_comanda) references comanda (id),
    foreign key (id_cliente) references usuario(id)
);

CREATE table item(
	id int NOT NULL auto_increment,
    cnpj_restaurante VARCHAR(14) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    detalhe VARCHAR(200),
    nome VARCHAR(100) NOT NULL,
    tipo int NOT NULL, 
    valor double(10,2) NOT NULL,
    status char,
    primary key (id),
    foreign key (cnpj_restaurante) references restaurante (cnpj)
);

CREATE table especialidade_item(
	id int NOT NULL auto_increment,
	id_item int NOT NULL,
    id_especialidade int NOT NULL,
    primary key(id),
    foreign key (id_item) references item(id),
    foreign key (id_especialidade) references especialidade(id)
);

CREATE table pedido(
	id int NOT NULL auto_increment,
    id_comanda int NOT NULL,
    id_item int NOT NULL,
    data datetime NOT NULL,
    porc_desconto double(3,3),
    status char NOT NULL,
	observacao VARCHAR(200),
    foreign key (id_item) references item(id),
	foreign key (id_comanda) references comanda(id),
    primary key(id)
);

CREATE table usuario_pedido(
	id int NOT NULL auto_increment,
    id_usuario int NOT NULL,
    id_pedido int NOT NULL,
    id_comanda int NOT NULL,
    porc_paga double NOT NULL,
    status char not null,
    foreign key (id_comanda) references comanda(id),
    foreign key (id_usuario) references usuario(id),
    foreign key (id_pedido) references pedido(id) ON DELETE CASCADE,
    primary key (id)
);