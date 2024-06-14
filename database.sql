-- Grupo 4
/*
  Felipe Seda Raposo de Almeida
*/


-- Excluir o banco de dados e recria-lo
drop database if exists commerce;

create database commerce;

use commerce;

-- Criar tabela de clientes
create table clientes (
	cod_cliente int primary key auto_increment,
	nome varchar(150) not null,
  	cidade varchar(100) not null,
  	estado char(2) not null,
  	genero char(1) not null constraint clientes_genero_check check (genero = 'M' or genero = 'F'),
  	dt_nascimento date not null,
  	estado_civil varchar(150) not null constraint clientes_estado_civil_check check (
    	estado_civil = 'solteiro' or
    	estado_civil = 'casado' or
    	estado_civil = 'divorciado' or
    	estado_civil = 'viuvo' or
    	estado_civil = 'separado'
    )
);

-- Criar tabela de funcionarios
create table funcionarios (
	cod_funcionario int primary key auto_increment,
  	nome varchar(150) not null,
  	cidade varchar(100) not null,
  	estado char(2) not null,
  	genero char(1) not null constraint funcionarios_genero_check check (genero = 'M' or genero = 'F'),
  	dt_nascimento date not null,
  	estado_civil varchar(50) not null constraint funcionarios_estado_civil_check check (
    	estado_civil = 'solteiro' or
    	estado_civil = 'casado' or
    	estado_civil = 'divorciado' or
    	estado_civil = 'viuvo' or
    	estado_civil = 'separado'
    ),
  	cargo varchar(50) not null constraint funcionarios_cargo_check check (
    	cargo = 'vendedor' or 
      	cargo = 'gerente' or
      	cargo = 'ajudante'
    )
);

-- Criar tabela de fabricantes
create table fabricantes (
	cod_fabricante int primary key auto_increment,
  	nome varchar(150) not null,
  	site varchar(150),
  	email varchar(150) not null
);

-- Criar tabela de produtos
create table produtos (
	cod_produto int primary key auto_increment,
  	nome varchar(150) unique not null,
  	descricao text,
  	preco numeric(12,2) check (
    	coalesce(preco, 0) >= 0
    ),
  
  	cod_fabricante int not null references fabricantes(cod_fabricante)
);

-- Criar tabela de compras
create table compras (
	cod_compra int primary key auto_increment,
  	hora time not null default (current_time),
  	data date not null default (current_date),
  
  	cod_cliente int not null references clientes(cod_cliente),
  	cod_funcionario int not null references funcionarios(cod_funcionario)
);

-- Criar tabela de relacionamento entre compras e produtos
create table compras_produtos (
	cod_compra int not references compras(cod_compra),
	cod_produto int not references produtos(cod_produto),
  
  	valor_desconto numeric(12,2) default 0 check (
    	coalesce(valor_desconto, 0) >= 0
    ),
  	qtd int not null default 1 check (
    	qtd > 0
    ),
  
  	primary key (cod_compra, cod_produto)
);

-- Inserir registros na tabela de clientes
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


-- Inserir registros na tabela de funcionarios
insert into funcionarios 
	(nome, cidade, estado, genero, estado_civil, dt_nascimento, cargo)
values
	('Felipe Raposo', 'Rio de Janeiro', 'RJ', 'M', 'solteiro', '2001-10-16', 'gerente'),
	('Abelardo Silva', 'Niterói', 'RJ', 'M', 'solteiro', '2002-01-01', 'vendedor'),
	('Marco Santos', 'Rio de Janeiro', 'RJ', 'F', 'casado', '2000-11-11', 'vendedor'),
    ('João Costa', 'Rio de Janeiro', 'RJ', 'M', 'divorciado', '2003-11-01', 'ajudante'),
	('Isabela Trindade', 'Rio de Janeiro', 'RJ', 'F', 'casado', '1992-07-30', 'vendedor'),
	('Rebeca Santos', 'Duque de Caxias', 'RJ', 'F', 'separado', '1960-12-31', 'ajudante');
	

-- Inserir registros na tabela de fabricantes
insert into fabricantes 
	(nome, site, email)
values
	('Produtos China', null, 'contato@produtoschina.com'),
	('Produtos Paraguai', 'https://produtosparaguai.com', 'contato@produtosparaguai.com'),
	('Koka Mola Fabricante', 'https://kokamola.com', 'kokamola@kokamola.com'),
	('Marikver Inc.', 'https://marickver.com', 'contato@marikver.com');

-- Inserir registros na tabela de produtos
insert into produtos
	(nome, descricao, preco, cod_fabricante)
values
	('Cortador de unha', 'Pra cortar unha', 11.99, 1),
	('Guarda chuva furado', 'Não precisa explicar', 9.87, 1),
	('Cerveja sem álcool', 'Para quem não gosta de beber e dirigir', 5.89, 2),
	('Martelo sem cabeça', null, 17.55, 2),
	('Oxigênio engarrafado', 'Pra respirar melhor!', 99.99, 3),
	('Monóxido de carbono engarrafado', 'Pra respirar pior!', 99.99, 3),
	('Carne vegana', 'Feita com apenas 54 ingredientes!', 120.99, 4),
	('Ovo de tatu', 'Muito bom, vale experimentar!', 11.99, 4);


-- 2.a
select nome, site, email from fabricantes;

-- 2.b
select nome from clientes
where 
	cidade not like 'rio de janeiro' and
    cidade not like 'niterói'
    order by nome;
    
-- 2.c
select nome from funcionarios
where 
	timestampdiff(year, dt_nascimento, current_timestamp) <= 30
    AND genero = 'F';

-- 2.d
select coalesce(sum(qtd), 0) as qtd_total_produtos from compras_produtos;

-- 2.e
select pr.nome , cp.qtd * pr.preco - cp.valor_desconto as preco
from produtos as pr , compras_produtos as cp
where cp.cod_produto = pr.cod_produto
order by preco desc
limit 1;

-- 2.f
SELECT 
    cli.estado AS estado_cliente,
    SUM(cp.qtd * p.preco - cp.valor_desconto) AS total_vendas
FROM 
    compras c
JOIN 
    compras_produtos cp ON c.cod_compra = cp.cod_compra
JOIN 
    produtos p ON cp.cod_produto = p.cod_produto
JOIN 
    clientes cli ON c.cod_cliente = cli.cod_cliente
GROUP BY 
    cli.estado;

--2.g
SELECT DISTINCT 
    p.nome
FROM 
    compras c
JOIN 
    compras_produtos cp ON c.cod_compra = cp.cod_compra
JOIN 
    produtos p ON cp.cod_produto = p.cod_produto
JOIN 
    clientes cli ON c.cod_cliente = cli.cod_cliente
WHERE 
    cli.cidade = 'Niterói'
ORDER BY 
    p.nome;

-- 2.h
SELECT 
    estado_civil,
    COUNT(*) AS quantidade_clientes
FROM 
    clientes
GROUP BY 
    estado_civil
HAVING 
    COUNT(*) > 5;