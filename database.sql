-- Grupo 4
/*
			   - Felipe Seda Raposo de Almeida
  202208386296 - Thaís Bustamante
*/


-- Excluir o banco de dados e recria-lo
DROP DATABASE IF EXISTS commerce;

-- Criar o Banco de Dados
CREATE DATABASE commerce;

-- Usar o Banco criado
USE commerce;

-- Criar tabela de clientes
CREATE TABLE clientes (
	cod_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(150) NOT NULL,
  	cidade VARCHAR(100) NOT NULL,
  	estado CHAR(2) NOT NULL,
  	genero CHAR(1) NOT NULL CONSTRAINT clientes_genero_check CHECK (genero = 'M' OR genero = 'F'),
  	dt_nascimento DATE NOT NULL,
  	estado_civil VARCHAR(45) NOT NULL CONSTRAINT clientes_estado_civil_check CHECK (
    	estado_civil = 'solteiro' OR
    	estado_civil = 'casado' OR
    	estado_civil = 'divorciado' OR
    	estado_civil = 'viuvo' OR
    	estado_civil = 'separado'
    )
);

-- Criar tabela de funcionarios
CREATE TABLE funcionarios (
	cod_funcionario INT PRIMARY KEY AUTO_INCREMENT,
  	nome VARCHAR(150) NOT NULL,
  	cidade VARCHAR(100) NOT NULL,
  	estado CHAR(2) NOT NULL,
  	genero CHAR(1) NOT NULL CONSTRAINT funcionarios_genero_check CHECK (genero = 'M' OR genero = 'F'),
  	dt_nascimento DATE NOT NULL,
  	estado_civil VARCHAR(50) NOT NULL CONSTRAINT funcionarios_estado_civil_check CHECK (
    	estado_civil = 'solteiro' OR
    	estado_civil = 'casado' OR
    	estado_civil = 'divorciado' OR
    	estado_civil = 'viuvo' OR
    	estado_civil = 'separado'
    ),
  	cargo VARCHAR(50) NOT NULL CONSTRAINT funcionarios_cargo_check CHECK (
    	cargo = 'vendedor' OR 
      	cargo = 'gerente' OR
      	cargo = 'ajudante'
    )
);

-- Criar tabela de fabricantes
CREATE TABLE fabricantes (
	cod_fabricante INT PRIMARY KEY AUTO_INCREMENT,
  	nome VARCHAR(150) NOT NULL,
  	site VARCHAR(150),
  	email VARCHAR(100) NOT NULL
);

-- Criar tabela de produtos
CREATE TABLE produtos (
	cod_produto INT PRIMARY KEY AUTO_INCREMENT,
  	nome VARCHAR(150) UNIQUE NOT NULL,
  	descricao TEXT,
  	preco NUMERIC(12,2) CHECK (
    	COALESCE(preco, 0) >= 0
    ),
	cod_fabricante INT,
    
  	FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante) ON DELETE SET NULL
);

-- Criar tabela de compras
CREATE TABLE compras (
	cod_compra INT PRIMARY KEY AUTO_INCREMENT,
  	hora TIME NOT NULL DEFAULT (CURRENT_TIME),
  	dt DATE NOT NULL DEFAULT (CURRENT_DATE),
    cod_cliente INT,
    cod_funcionario INT,
    cod_produto INT,
  
  	FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente),
    FOREIGN KEY (cod_funcionario) REFERENCES funcionarios(cod_funcionario),
    FOREIGN KEY (cod_produto) REFERENCES produtos(cod_produto)
);

-- Criar tabela de relacionamento entre compras e produtos
CREATE TABLE compras_produtos (
  	valor_desconto NUMERIC(12,2) DEFAULT 0 CHECK (valor_desconto >= 0),
  	qtd INT NOT NULL DEFAULT 1 CHECK (qtd > 0),
	cod_compra INT,
    cod_produto INT,
	CONSTRAINT pk_compras_produtos PRIMARY KEY (cod_compra, cod_produto),
	FOREIGN KEY (cod_compra) REFERENCES compras(cod_compra),
	FOREIGN KEY (cod_produto) REFERENCES produtos(cod_produto)
);


-- Inserir registros na tabela de clientes
INSERT INTO clientes 
	(nome, cidade, estado, genero, estado_civil, dt_nascimento)
VALUES
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
	('Lucas Bragança', 'Rio de Janeiro', 'RJ', 'M', 'casado', '2002-02-27'),
    ('Ana Souza', 'São Paulo', 'SP', 'F', 'solteiro', '1990-03-15'),
	('Carlos Oliveira', 'Rio de Janeiro', 'RJ', 'M', 'casado', '1985-07-22'),
	('Mariana Santos', 'Belo Horizonte', 'MG', 'F', 'solteiro', '1992-11-30'),
	('João Almeida', 'Curitiba', 'PR', 'M', 'casado', '1988-01-17'),
	('Fernanda Costa', 'Salvador', 'BA', 'F', 'divorciado', '1995-05-10'),
	('Pedro Silva', 'Porto Alegre', 'RS', 'M', 'solteiro', '1993-09-08'),
	('Laura Martins', 'Fortaleza', 'CE', 'F', 'casado', '1991-12-25');


-- Inserir registros na tabela de funcionarios
INSERT INTO funcionarios 
	(nome, cidade, estado, genero, estado_civil, dt_nascimento, cargo)
VALUES
	('Felipe Raposo', 'Rio de Janeiro', 'RJ', 'M', 'solteiro', '2001-10-16', 'gerente'),
	('Abelardo Silva', 'Niterói', 'RJ', 'M', 'solteiro', '2002-01-01', 'vendedor'),
	('Marco Santos', 'Rio de Janeiro', 'RJ', 'F', 'casado', '2000-11-11', 'vendedor'),
    ('João Costa', 'Rio de Janeiro', 'RJ', 'M', 'divorciado', '2003-11-01', 'ajudante'),
	('Isabela Trindade', 'Rio de Janeiro', 'RJ', 'F', 'casado', '1992-07-30', 'vendedor'),
	('Rebeca Santos', 'Duque de Caxias', 'RJ', 'F', 'separado', '1960-12-31', 'ajudante');


-- Fazendo algumas mudanças nos dados	
-- Mudando o nome
UPDATE funcionarios SET nome = 'Ariadne Silva' 
WHERE cod_funcionario = 2;

UPDATE funcionarios SET nome = 'Marcela Santos' 
WHERE cod_funcionario = 3;

-- Mudando o genero
UPDATE funcionarios SET genero = 'F' 
WHERE cod_funcionario = 2;


-- Inserir registros na tabela de fabricantes
INSERT INTO fabricantes 
	(nome, site, email)
VALUES
	('Produtos China', null, 'contato@produtoschina.com'),
	('Produtos Paraguai', 'https://produtosparaguai.com', 'contato@produtosparaguai.com'),
	('Koka Mola Fabricante', 'https://kokamola.com', 'kokamola@kokamola.com'),
	('Marikver Inc.', 'https://marickver.com', 'contato@marikver.com');

-- Inserir registros na tabela de produtos
INSERT INTO produtos
	(nome, descricao, preco, cod_fabricante)
VALUES
	('Cortador de unha', 'Pra cortar unha', 11.99, 1),
	('Guarda chuva furado', 'Não precisa explicar', 9.87, 1),
	('Cerveja sem álcool', 'Para quem não gosta de beber e dirigir', 5.89, 2),
	('Martelo sem cabeça', null, 17.55, 2),
	('Oxigênio engarrafado', 'Pra respirar melhor!', 99.99, 3),
	('Monóxido de carbono engarrafado', 'Pra respirar pior!', 99.99, 3),
	('Carne vegana', 'Feita com apenas 54 ingredientes!', 120.99, 4),
	('Ovo de tatu', 'Muito bom, vale experimentar!', 11.99, 4);

-- Inserir registros na tabela de compras
INSERT INTO compras
	(hora, dt, cod_cliente, cod_funcionario, cod_produto)
VALUES
	('08:15:23', '2024-01-01', 27, 3, 5),
	('09:45:10', '2024-01-02', 30, 2, 8),
	('10:30:45', '2024-01-03', 35, 4, 6),
	('11:15:30', '2024-01-04', 28, 5, 1),
	('12:00:00', '2024-01-05', 47, 1, 7),
	('13:45:22', '2024-01-06', 39, 6, 4),
	('14:30:10', '2024-01-07', 29, 3, 2),
	('15:20:35', '2024-01-08', 41, 2, 5),
	('16:10:15', '2024-01-09', 33, 4, 8),
	('17:05:40', '2024-01-10', 48, 1, 3),
	('18:25:55', '2024-01-11', 31, 5, 7),
	('19:15:05', '2024-01-12', 38, 3, 6),
	('20:10:50', '2024-01-13', 25, 2, 4),
	('20:25:30', '2024-01-14', 42, 6, 1),
	('20:35:33', '2024-01-15', 44, 4, 2),
	('20:45:10', '2024-01-16', 26, 5, 3),
	('20:55:20', '2024-01-17', 36, 1, 7),
	('01:30:55', '2024-01-18', 37, 2, 8),
	('02:15:30', '2024-01-19', 40, 4, 5),
	('03:10:45', '2024-01-20', 45, 3, 6),
	('04:55:50', '2024-01-21', 32, 6, 2),
	('05:40:15', '2024-01-22', 46, 1, 4),
	('06:25:30', '2024-01-23', 43, 5, 3),
	('07:10:10', '2024-01-24', 34, 2, 8),
	('08:55:25', '2024-01-25', 25, 4, 1);


-- Inserir registros na tabela compras_produtos
INSERT INTO compras_produtos
	(cod_compra, cod_produto, valor_desconto, qtd)
VALUES
	(1, 5, 0.00, 3),
	(2, 8, 0.00, 7),
	(3, 6, 0.00, 1),
	(4, 1, 0.00, 10),
	(5, 7, 0.00, 4),
	(6, 4, 0.00, 13),
	(7, 2, 0.00, 6),
	(8, 5, 0.00, 2),
	(9, 8, 0.00, 11),
	(10, 3, 0.00, 5),
	(11, 7, 0.00, 8),
	(12, 6, 0.00, 12),
	(13, 4, 1.23, 9),
	(14, 1, 2.34, 13),
	(15, 2, 3.45, 2),
	(16, 3, 4.56, 4),
	(17, 7, 5.67, 1),
	(18, 8, 6.78, 10),
	(19, 5, 7.00, 5),
	(20, 6, 0.00, 11),
	(21, 2, 0.00, 7),
	(22, 4, 0.00, 6),
	(23, 3, 0.00, 3),
	(24, 8, 0.00, 9),
	(25, 1, 0.00, 8);
    
    
-- 2.a
SELECT nome, site, email FROM fabricantes;

-- 2.b
SELECT nome
FROM clientes
WHERE cidade NOT LIKE 'rio de janeiro' 
AND cidade NOT LIKE 'niterói'
ORDER BY nome;
    
-- 2.c
SELECT nome 
FROM funcionarios
WHERE TIMESTAMPDIFF(YEAR, dt_nascimento, CURRENT_TIMESTAMP) <= 30
AND genero = 'F';

-- 2.d
SELECT COALESCE(SUM(qtd), 0) AS qtd_total_produtos 
FROM compras_produtos;

-- 2.e
SELECT pr.nome , cp.qtd * pr.preco - cp.valor_desconto AS preco
FROM produtos AS pr , compras_produtos AS cp
WHERE cp.cod_produto = pr.cod_produto
ORDER BY preco DESC
LIMIT 1;

-- 2.f
SELECT cli.estado AS estado_cliente, SUM(cp.qtd * p.preco - cp.valor_desconto) AS total_vendas
FROM compras AS c INNER JOIN compras_produtos AS cp 
 ON c.cod_compra = cp.cod_compra
INNER JOIN produtos AS p 
 ON cp.cod_produto = p.cod_produto
INNER JOIN clientes AS cli 
 ON c.cod_cliente = cli.cod_cliente
GROUP BY cli.estado;

-- 2.g
SELECT DISTINCT pr.nome
FROM compras AS co INNER JOIN compras_produtos AS cp 
 ON co.cod_compra = cp.cod_compra
INNER JOIN produtos AS pr 
 ON cp.cod_produto = pr.cod_produto
INNER JOIN clientes AS cl 
 ON co.cod_cliente = cl.cod_cliente
WHERE cl.cidade = 'Niterói'
ORDER BY pr.nome;

-- 2.h
SELECT estado_civil, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado_civil
HAVING COUNT(*) > 5;
