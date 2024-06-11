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

insert into clientes 
	(nome, cidade, estado, genero, estado_civil, dt_nascimento)
values
	('Felipe Seda', 'Rio de Janeiro', 'RJ', 'M', 'solteiro', '2001-10-16'),
	('Mateus Silva', 'Niterói', 'RJ', 'M', 'solteiro', '2000-01-01'),
	('João Costa', 'Belford Roxo', 'RJ', 'M', 'divorciado', '2003-11-01'),
	('André Costa', 'Belford Roxo', 'RJ', 'M', 'solteiro', '2000-01-01'),
	('Laura Esperanto', 'Duque de Caxias', 'RJ', 'F', 'casado', '1993-07-30'),
	('Roberta Amendoim', 'Duque de Caxias', 'RJ', 'F', 'solteiro', '1999-12-31'),
	('Romulo Francisco', 'Itaboraí', 'RJ', 'M', 'solteiro', '1993-03-15'),
	('José Americano', 'Rio de Janeiro', 'RJ', 'M', 'solteiro', '2003-03-01'),
	('Gabriela Americano', 'Patos de Minas', 'MG', 'F', 'casado', '2000-11-11'),
	('Maria Clara', 'Patos de Minas', 'MG', 'F', 'casado', '1940-07-04'),
	('Nina Peixoto', 'Manaus', 'AM', 'F', 'viuvo', '1987-07-01'),
	('Nicolas Mendonça', 'Niterói', 'RJ', 'M', 'solteiro', '2000-01-01'),
	('Tiago Couto', 'Niterói', 'RJ', 'M', 'solteiro', '2001-11-05'),
	('Patrícia Aires', 'Porto Alegre', 'RS', 'F', 'casado', '1982-04-07'),
	('Emanuel Aires', 'Porto Alegre', 'RS', 'M', 'casado', '1982-05-07'),
	('Marina Bragança', 'Rio de Janeiro', 'RJ', 'F', 'casado', '2002-09-08'),
	('Lucas Bragança', 'Rio de Janeiro', 'RJ', 'M', 'casado', '2002-02-27');













