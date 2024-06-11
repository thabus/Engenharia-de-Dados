drop database if exists commerce;

create database commerce;

use commerce;

create table clientes (
	cod_cliente int primary key auto_increment,
	nome varchar(150) not null,
  cidade varchar(100) not null,
  estado char(2) not null,
  genero char(1) not null check (genero = 'M' or genero = 'F'),
  dt_nascimento date not null,
  estado_civil varchar(150) not null check (
    estado_civil = 'solteiro' or
    estado_civil = 'casado' or
    estado_civil = 'divorciado' or
    estado_civil = 'viuvo' or
    estado_civil = 'separado'
  )
);

create table funcionarios (
	cod_funcionario int primary key auto_increment,
  nome varchar(150) not null,
  cidade varchar(100) not null,
  estado char(2) not null,
  genero char(1) not null check (genero = 'M' or genero = 'F'),
  dt_nascimento date not null,
  estado_civil varchar(50) not null check (
    estado_civil = 'solteiro' or
    estado_civil = 'casado' or
    estado_civil = 'divorciado' or
    estado_civil = 'viuvo' or
    estado_civil = 'separado'
  ),
  cargo varchar(50) not null check (
    cargo = 'vendedor' or 
      cargo = 'gerente' or
      cargo = 'ajudante'
  )
);

create table fabricantes (
	cod_fabricante int primary key auto_increment,
  nome varchar(150) not null,
  site varchar(150),
  email varchar(150) not null
);

create table produtos (
	cod_produto int primary key auto_increment,
  nome varchar(150) unique not null,
  descricao text,
  preco numeric(12,2) check (
    coalesce(preco, 0) >= 0
  ),

  cod_fabricante int not null references fabricantes(cod_fabricante)
);

create table compras (
	cod_compra int primary key auto_increment,
  hora time not null default (current_time),
  data date not null default (current_date),

  cod_cliente int not null references clientes(cod_cliente),
  cod_funcionario int not null references funcionarios(cod_funcionario)
);

create table compras_produtos (
	cod_compra int references compras(cod_compra),
	cod_produto int references produtos(cod_produto),
  
  valor_desconto numeric(12,2) default 0 check (
    coalesce(valor_desconto, 0) >= 0
  ),
  qtd int not null default 1 check (
    qtd > 0
  ),

  primary key (cod_compra, cod_produto)
);