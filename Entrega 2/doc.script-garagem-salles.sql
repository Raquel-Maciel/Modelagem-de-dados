-- GARAGEM SALLES ESTUDIO AUTOMOTIVO
-- Script demonstrativo MySQL 8.0+. Dados ficticios.
-- Escala operacional informada: media de 10 veiculos por dia,
-- de segunda-feira a sabado (6 dias por semana).
-- Em 4 semanas: aproximadamente 240 atendimentos. A massa ampliada
-- abaixo representa 240 atendimentos ficticios ao longo de 24 dias uteis.
CREATE DATABASE IF NOT EXISTS garagem_salles CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE garagem_salles;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS movimentacao_estoque, caixa, pagamento, permanencia_estacionamento,
 item_venda, venda_produto, consumo_produto, item_compra, compra, fornecedor,
 item_ordem_servico, ordem_servico, item_agendamento, agendamento, produto,
 servico, veiculo, funcionario, cliente;
SET FOREIGN_KEY_CHECKS=1;

-- TABELAS E CONSTRAINTS
CREATE TABLE cliente (
 id_cliente INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(120) NOT NULL,
 cpf CHAR(11) NULL UNIQUE, telefone VARCHAR(20) NOT NULL,
 email VARCHAR(120), endereco VARCHAR(200)
);
CREATE TABLE funcionario (
 id_funcionario INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(120) NOT NULL,
 telefone VARCHAR(20), cargo VARCHAR(60) NOT NULL, ativo BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE veiculo (
 id_veiculo INT AUTO_INCREMENT PRIMARY KEY, id_cliente INT NOT NULL,
 placa VARCHAR(8) NOT NULL UNIQUE, marca VARCHAR(60) NOT NULL,
 modelo VARCHAR(60) NOT NULL, cor VARCHAR(30), ano SMALLINT,
 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
 CHECK (ano IS NULL OR ano BETWEEN 1900 AND 2100)
);
CREATE TABLE servico (
 id_servico INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(100) NOT NULL UNIQUE,
 descricao VARCHAR(255), preco_base DECIMAL(10,2) NOT NULL,
 ativo BOOLEAN NOT NULL DEFAULT TRUE, CHECK (preco_base>=0)
);
CREATE TABLE agendamento (
 id_agendamento INT AUTO_INCREMENT PRIMARY KEY, id_cliente INT NOT NULL,
 id_veiculo INT NOT NULL, data_hora DATETIME NOT NULL,
 situacao VARCHAR(20) NOT NULL, observacao VARCHAR(255),
 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
 FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
 CHECK (situacao IN ('AGENDADO','CONFIRMADO','CANCELADO','CONCLUIDO','NAO_COMPARECEU'))
);
CREATE TABLE item_agendamento (
 id_item_agendamento INT AUTO_INCREMENT PRIMARY KEY, id_agendamento INT NOT NULL,
 id_servico INT NOT NULL, quantidade DECIMAL(10,2) NOT NULL,
 preco_previsto DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento),
 FOREIGN KEY (id_servico) REFERENCES servico(id_servico),
 CHECK (quantidade>0), CHECK (preco_previsto>=0)
);
CREATE TABLE ordem_servico (
 id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY, id_veiculo INT NOT NULL,
 id_funcionario INT NOT NULL, id_agendamento INT NULL,
 data_hora_entrada DATETIME NOT NULL, data_hora_saida DATETIME NULL,
 situacao VARCHAR(25) NOT NULL, observacao VARCHAR(255),
 FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento),
 CHECK (situacao IN ('ABERTA','EM_EXECUCAO','AGUARDANDO_PAGAMENTO','CONCLUIDA','CANCELADA')),
 CHECK (data_hora_saida IS NULL OR data_hora_saida>=data_hora_entrada)
);
CREATE TABLE item_ordem_servico (
 id_item_os INT AUTO_INCREMENT PRIMARY KEY, id_ordem_servico INT NOT NULL,
 id_servico INT NOT NULL, quantidade DECIMAL(10,2) NOT NULL,
 preco_unitario DECIMAL(10,2) NOT NULL, observacao VARCHAR(255),
 FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico),
 FOREIGN KEY (id_servico) REFERENCES servico(id_servico),
 CHECK (quantidade>0), CHECK (preco_unitario>=0)
);
CREATE TABLE fornecedor (
 id_fornecedor INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(120) NOT NULL,
 documento VARCHAR(18) UNIQUE, telefone VARCHAR(20), email VARCHAR(120), endereco VARCHAR(200)
);
CREATE TABLE produto (
 id_produto INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(120) NOT NULL,
 marca VARCHAR(60) NOT NULL DEFAULT 'Vonixx', unidade VARCHAR(20) NOT NULL,
 custo_referencia DECIMAL(10,2) NOT NULL, estoque_minimo DECIMAL(10,2) NOT NULL DEFAULT 0,
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 CHECK (custo_referencia>=0), CHECK (estoque_minimo>=0)
);
CREATE TABLE compra (
 id_compra INT AUTO_INCREMENT PRIMARY KEY, id_fornecedor INT NOT NULL,
 id_funcionario INT NOT NULL, data_compra DATE NOT NULL,
 documento_ref VARCHAR(40), situacao VARCHAR(20) NOT NULL,
 FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (situacao IN ('REGISTRADA','RECEBIDA','CANCELADA'))
);
CREATE TABLE item_compra (
 id_item_compra INT AUTO_INCREMENT PRIMARY KEY, id_compra INT NOT NULL,
 id_produto INT NOT NULL, quantidade DECIMAL(10,2) NOT NULL,
 custo_unitario DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
 FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
 CHECK (quantidade>0), CHECK (custo_unitario>=0)
);
CREATE TABLE consumo_produto (
 id_consumo INT AUTO_INCREMENT PRIMARY KEY, id_ordem_servico INT NOT NULL,
 id_produto INT NOT NULL, id_funcionario INT NOT NULL,
 data_consumo DATETIME NOT NULL, quantidade DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico),
 FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (quantidade>0)
);
CREATE TABLE venda_produto (
 id_venda INT AUTO_INCREMENT PRIMARY KEY, id_cliente INT NULL,
 id_funcionario INT NOT NULL, data_venda DATETIME NOT NULL, situacao VARCHAR(20) NOT NULL,
 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (situacao IN ('ABERTA','PAGA','CANCELADA'))
);
CREATE TABLE item_venda (
 id_item_venda INT AUTO_INCREMENT PRIMARY KEY, id_venda INT NOT NULL,
 id_produto INT NOT NULL, quantidade DECIMAL(10,2) NOT NULL,
 preco_unitario DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (id_venda) REFERENCES venda_produto(id_venda),
 FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
 CHECK (quantidade>0), CHECK (preco_unitario>=0)
);
CREATE TABLE permanencia_estacionamento (
 id_permanencia INT AUTO_INCREMENT PRIMARY KEY, id_veiculo INT NOT NULL,
 id_funcionario INT NOT NULL, entrada DATETIME NOT NULL, saida DATETIME NULL,
 tarifa_aplicada DECIMAL(10,2) NOT NULL DEFAULT 0, valor_cobrado DECIMAL(10,2),
 FOREIGN KEY (id_veiculo) REFERENCES veiculo(id_veiculo),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (saida IS NULL OR saida>=entrada), CHECK (tarifa_aplicada>=0),
 CHECK (valor_cobrado IS NULL OR valor_cobrado>=0)
);
CREATE TABLE caixa (
 id_caixa INT AUTO_INCREMENT PRIMARY KEY, id_funcionario INT NOT NULL,
 data_abertura DATETIME NOT NULL, data_fechamento DATETIME NULL,
 valor_abertura DECIMAL(10,2) NOT NULL DEFAULT 0, valor_contado DECIMAL(10,2),
 situacao VARCHAR(15) NOT NULL,
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (situacao IN ('ABERTO','FECHADO')), CHECK (valor_abertura>=0),
 CHECK (valor_contado IS NULL OR valor_contado>=0)
);
CREATE TABLE pagamento (
 id_pagamento INT AUTO_INCREMENT PRIMARY KEY, id_ordem_servico INT NULL,
 id_venda INT NULL, id_funcionario INT NOT NULL, data_pagamento DATETIME NOT NULL,
 valor DECIMAL(10,2) NOT NULL, forma_pagamento VARCHAR(20) NOT NULL,
 situacao VARCHAR(20) NOT NULL,
 FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico(id_ordem_servico),
 FOREIGN KEY (id_venda) REFERENCES venda_produto(id_venda),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK ((id_ordem_servico IS NOT NULL AND id_venda IS NULL) OR
        (id_ordem_servico IS NULL AND id_venda IS NOT NULL)),
 CHECK (valor>0),
 CHECK (forma_pagamento IN ('DINHEIRO','PIX','DEBITO','CREDITO','TRANSFERENCIA')),
 CHECK (situacao IN ('CONFIRMADO','ESTORNADO','PENDENTE'))
);
CREATE TABLE movimentacao_estoque (
 id_movimentacao INT AUTO_INCREMENT PRIMARY KEY, id_produto INT NOT NULL,
 id_compra INT NULL, id_item_compra INT NULL, id_consumo INT NULL, id_item_venda INT NULL,
 id_funcionario INT NOT NULL, data_movimentacao DATETIME NOT NULL,
 tipo VARCHAR(10) NOT NULL, quantidade DECIMAL(10,2) NOT NULL, motivo VARCHAR(30) NOT NULL,
 FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
 FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
 FOREIGN KEY (id_item_compra) REFERENCES item_compra(id_item_compra),
 FOREIGN KEY (id_consumo) REFERENCES consumo_produto(id_consumo),
 FOREIGN KEY (id_item_venda) REFERENCES item_venda(id_item_venda),
 FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
 CHECK (tipo IN ('ENTRADA','SAIDA')), CHECK (quantidade>0),
 CHECK (motivo IN ('COMPRA','CONSUMO','VENDA','AJUSTE'))
);

-- MASSA DE DADOS FICTICIA
-- Os primeiros registros representam cenarios variados de cadastro e operacao.
-- A ampliacao com 240 atendimentos esta inserida logo apos os registros-base.
INSERT INTO cliente (nome,cpf,telefone,email,endereco) VALUES
('Mariana Costa','11111111111','(11) 90000-0001','mariana@example.com','Rua Alfa, 100'),
('Carlos Mendes','22222222222','(11) 90000-0002','carlos@example.com','Rua Beta, 200'),
('Fernanda Lima','33333333333','(11) 90000-0003',NULL,'Rua Gama, 300'),
('Joao Ribeiro',NULL,'(11) 90000-0004',NULL,NULL),
('Ana Souza','44444444444','(11) 90000-0005','ana@example.com','Rua Delta, 400'),
('Pedro Alves','55555555555','(11) 90000-0006','pedro@example.com','Rua Epsilon, 500'),
('Julia Martins','66666666666','(11) 90000-0007',NULL,'Rua Zeta, 600'),
('Rafael Santos','77777777777','(11) 90000-0008','rafael@example.com','Rua Eta, 700');

INSERT INTO funcionario (nome,telefone,cargo) VALUES
('Funcionario Demonstracao 1','(11) 91111-0001','Atendimento'),
('Funcionario Demonstracao 2','(11) 91111-0002','Servicos'),
('Funcionario Demonstracao 3','(11) 91111-0003','Gerencia');

INSERT INTO veiculo (id_cliente,placa,marca,modelo,cor,ano) VALUES
(1,'ABC1D23','Toyota','Corolla','Prata',2022),
(1,'DEF4G56','Honda','Fit','Branco',2018),
(2,'HIJ7K89','Chevrolet','Onix','Preto',2021),
(3,'LMN1O23','Volkswagen','Polo','Cinza',2020),
(5,'OPQ2R34','Fiat','Argo','Vermelho',2023),
(6,'STU5V67','Hyundai','HB20','Branco',2022),
(7,'WXY8Z90','Renault','Kwid','Prata',2021),
(8,'BCD1E23','Jeep','Renegade','Preto',2024);

INSERT INTO servico (nome,descricao,preco_base) VALUES
('Lavagem simples','Lavagem externa e limpeza basica',50.00),
('Lavagem completa','Limpeza interna e externa',90.00),
('Higienizacao interna','Higienizacao de partes internas',180.00),
('Polimento','Polimento da pintura automotiva',350.00),
('Cristalizacao de vidros','Tratamento de superficies de vidro',120.00),
('Restauracao de plasticos','Tratamento de plasticos externos',100.00);

INSERT INTO agendamento (id_cliente,id_veiculo,data_hora,situacao,observacao) VALUES
(1,1,'2026-10-20 09:00:00','CONFIRMADO','Agendamento demonstrativo'),
(2,3,'2026-10-21 10:00:00','CANCELADO','Cancelamento ficticio'),
(3,4,'2026-10-22 08:00:00','CONCLUIDO','Atendimento concluido'),
(5,5,'2026-10-23 09:00:00','CONFIRMADO','Lavagem agendada'),
(6,6,'2026-10-24 10:00:00','NAO_COMPARECEU','Cliente nao compareceu'),
(7,7,'2026-10-25 11:00:00','AGENDADO','Agendamento demonstrativo'),
(8,8,'2026-10-26 14:00:00','CANCELADO','Cancelamento demonstrativo');

INSERT INTO item_agendamento (id_agendamento,id_servico,quantidade,preco_previsto) VALUES
(1,2,1,90.00),(1,5,1,120.00),(2,1,1,50.00),(3,1,1,50.00),
(4,2,1,90.00),(5,3,1,180.00),(6,4,1,350.00),(7,6,1,100.00);

INSERT INTO ordem_servico (id_veiculo,id_funcionario,id_agendamento,data_hora_entrada,data_hora_saida,situacao,observacao) VALUES
(1,2,1,'2026-10-20 09:10:00','2026-10-20 11:20:00','CONCLUIDA','Ordem ficticia'),
(3,1,NULL,'2026-10-22 08:30:00','2026-10-22 09:30:00','CONCLUIDA',NULL),
(4,2,NULL,'2026-10-23 13:00:00',NULL,'CANCELADA','Cancelamento demonstrativo'),
(5,2,4,'2026-10-23 09:10:00','2026-10-23 10:30:00','CONCLUIDA','Servico concluido'),
(6,2,NULL,'2026-10-24 10:10:00','2026-10-24 12:00:00','CONCLUIDA','Higienizacao interna'),
(7,2,NULL,'2026-10-25 11:15:00',NULL,'EM_EXECUCAO','Servico em andamento');

INSERT INTO item_ordem_servico (id_ordem_servico,id_servico,quantidade,preco_unitario,observacao) VALUES
(1,2,1,90.00,NULL),(1,5,1,120.00,NULL),(2,1,1,50.00,NULL),
(3,4,1,350.00,'Item de ordem cancelada para teste'),
(4,2,1,90.00,NULL),(5,3,1,180.00,NULL),(6,6,1,100.00,NULL);

INSERT INTO fornecedor (nome,documento,telefone,email,endereco) VALUES
('Distribuidora Demonstrativa Vonixx',NULL,'(11) 92222-0001','vendas@example.com','Endereco ficticio');

INSERT INTO produto (nome,marca,unidade,custo_referencia,estoque_minimo) VALUES
('Shampoo automotivo','Vonixx','LITRO',25.00,5.00),
('Cera liquida','Vonixx','UNIDADE',40.00,3.00),
('Revitalizador de plasticos','Vonixx','UNIDADE',35.00,2.00),
('Limpa vidros','Vonixx','LITRO',18.00,4.00),
('Desengraxante','Vonixx','LITRO',22.00,2.00);

INSERT INTO compra (id_fornecedor,id_funcionario,data_compra,documento_ref,situacao) VALUES
(1,3,'2026-10-01','COMPRA-DEMO-001','RECEBIDA'),
(1,3,'2026-10-15','COMPRA-DEMO-002','RECEBIDA');

INSERT INTO item_compra (id_compra,id_produto,quantidade,custo_unitario) VALUES
(1,1,20,25.00),(1,2,10,40.00),(1,3,8,35.00),(2,4,10,18.00),(2,5,1,22.00);

INSERT INTO consumo_produto (id_ordem_servico,id_produto,id_funcionario,data_consumo,quantidade) VALUES
(1,1,2,'2026-10-20 09:30:00',2.00),
(1,4,2,'2026-10-20 10:00:00',1.00),
(2,1,2,'2026-10-22 08:45:00',1.50);

INSERT INTO venda_produto (id_cliente,id_funcionario,data_venda,situacao) VALUES
(1,1,'2026-10-20 11:30:00','ABERTA'),(2,1,'2026-10-22 10:00:00','ABERTA');
-- Precos de venda ilustrativos: custo + 30%.
INSERT INTO item_venda (id_venda,id_produto,quantidade,preco_unitario) VALUES
(1,2,1,52.00),(2,3,1,45.50);
UPDATE venda_produto SET situacao='PAGA' WHERE id_venda IN (1,2);

INSERT INTO permanencia_estacionamento (id_veiculo,id_funcionario,entrada,saida,tarifa_aplicada,valor_cobrado) VALUES
(1,1,'2026-10-20 09:05:00','2026-10-20 11:35:00',10.00,10.00),
(3,1,'2026-10-22 08:25:00','2026-10-22 10:10:00',10.00,10.00);

INSERT INTO pagamento (id_ordem_servico,id_venda,id_funcionario,data_pagamento,valor,forma_pagamento,situacao) VALUES
(1,NULL,1,'2026-10-20 11:25:00',210.00,'PIX','CONFIRMADO'),
(2,NULL,1,'2026-10-22 09:35:00',50.00,'DINHEIRO','CONFIRMADO'),
(NULL,1,1,'2026-10-20 11:31:00',52.00,'CREDITO','CONFIRMADO'),
(NULL,2,1,'2026-10-22 10:02:00',45.50,'DEBITO','CONFIRMADO');

INSERT INTO caixa (id_funcionario,data_abertura,data_fechamento,valor_abertura,valor_contado,situacao) VALUES
(3,'2026-10-20 08:00:00','2026-10-20 18:00:00',100.00,100.00,'FECHADO'),
(3,'2026-10-22 08:00:00',NULL,100.00,NULL,'ABERTO');

-- Movimentacoes: compras = entrada; consumo e vendas = saida.
INSERT INTO movimentacao_estoque
(id_produto,id_compra,id_item_compra,id_funcionario,data_movimentacao,tipo,quantidade,motivo) VALUES
(1,1,1,3,'2026-10-01 10:00:00','ENTRADA',20,'COMPRA'),
(2,1,2,3,'2026-10-01 10:00:00','ENTRADA',10,'COMPRA'),
(3,1,3,3,'2026-10-01 10:00:00','ENTRADA',8,'COMPRA'),
(4,2,4,3,'2026-10-15 10:00:00','ENTRADA',10,'COMPRA'),
(5,2,5,3,'2026-10-15 10:00:00','ENTRADA',1,'COMPRA');

INSERT INTO movimentacao_estoque
(id_produto,id_consumo,id_funcionario,data_movimentacao,tipo,quantidade,motivo) VALUES
(1,1,2,'2026-10-20 09:30:00','SAIDA',2,'CONSUMO'),
(4,2,2,'2026-10-20 10:00:00','SAIDA',1,'CONSUMO'),
(1,3,2,'2026-10-22 08:45:00','SAIDA',1.5,'CONSUMO');

INSERT INTO movimentacao_estoque
(id_produto,id_item_venda,id_funcionario,data_movimentacao,tipo,quantidade,motivo) VALUES
(2,1,1,'2026-10-20 11:30:00','SAIDA',1,'VENDA'),
(3,2,1,'2026-10-22 10:00:00','SAIDA',1,'VENDA');

-- =========================================================
-- MASSA AMPLIADA: 240 ATENDIMENTOS FICTICIOS
-- Premissa: 10 veiculos por dia, de segunda a sabado,
-- durante 24 dias de funcionamento (4 semanas de 6 dias).
-- Os registros sao distribuidos de 05/10/2026 a 31/10/2026,
-- com 10 atendimentos por dia de funcionamento.
-- Os IDs sao definidos explicitamente para manter os relacionamentos.
-- =========================================================

CREATE TEMPORARY TABLE tmp_massa_240 AS
WITH RECURSIVE sequencia AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM sequencia WHERE n < 240
)
SELECT
    n,
    7 + n AS id_agendamento,
    6 + n AS id_ordem_servico,
    MOD(n - 1, 8) + 1 AS id_veiculo,
    CASE MOD(n - 1, 8) + 1
        WHEN 1 THEN 1 WHEN 2 THEN 1 WHEN 3 THEN 2 WHEN 4 THEN 3
        WHEN 5 THEN 5 WHEN 6 THEN 6 WHEN 7 THEN 7 ELSE 8
    END AS id_cliente,
    MOD(n - 1, 6) + 1 AS id_servico,
    DATE_ADD('2026-10-05', INTERVAL (FLOOR((n - 1) / 10) + FLOOR(FLOOR((n - 1) / 10) / 6)) DAY) AS dia,
    SEC_TO_TIME(28800 + MOD(n - 1, 10) * 2700) AS horario
FROM sequencia;

-- 240 agendamentos: dez por dia de funcionamento.
INSERT INTO agendamento
(id_agendamento,id_cliente,id_veiculo,data_hora,situacao,observacao)
SELECT id_agendamento,id_cliente,id_veiculo,
       TIMESTAMP(dia,horario),'CONCLUIDO',
       'Atendimento ficticio da massa ampliada'
FROM tmp_massa_240;

INSERT INTO item_agendamento
(id_agendamento,id_servico,quantidade,preco_previsto)
SELECT id_agendamento,id_servico,1,
       CASE id_servico
           WHEN 1 THEN 50.00 WHEN 2 THEN 90.00 WHEN 3 THEN 180.00
           WHEN 4 THEN 350.00 WHEN 5 THEN 120.00 ELSE 100.00
       END
FROM tmp_massa_240;

-- 240 ordens de servico concluidas, vinculadas aos agendamentos.
INSERT INTO ordem_servico
(id_ordem_servico,id_veiculo,id_funcionario,id_agendamento,
 data_hora_entrada,data_hora_saida,situacao,observacao)
SELECT id_ordem_servico,id_veiculo,2,id_agendamento,
       TIMESTAMP(dia,horario),
       DATE_ADD(TIMESTAMP(dia,horario), INTERVAL 1 HOUR),
       'CONCLUIDA','Ordem ficticia da massa ampliada'
FROM tmp_massa_240;

INSERT INTO item_ordem_servico
(id_ordem_servico,id_servico,quantidade,preco_unitario,observacao)
SELECT id_ordem_servico,id_servico,1,
       CASE id_servico
           WHEN 1 THEN 50.00 WHEN 2 THEN 90.00 WHEN 3 THEN 180.00
           WHEN 4 THEN 350.00 WHEN 5 THEN 120.00 ELSE 100.00
       END,
       'Servico executado - dado ficticio'
FROM tmp_massa_240;

-- Pagamentos distribuidos entre PIX, dinheiro, debito e credito.
INSERT INTO pagamento
(id_ordem_servico,id_venda,id_funcionario,data_pagamento,valor,forma_pagamento,situacao)
SELECT id_ordem_servico,NULL,1,
       DATE_ADD(TIMESTAMP(dia,horario), INTERVAL 65 MINUTE),
       CASE id_servico
           WHEN 1 THEN 50.00 WHEN 2 THEN 90.00 WHEN 3 THEN 180.00
           WHEN 4 THEN 350.00 WHEN 5 THEN 120.00 ELSE 100.00
       END,
       CASE MOD(n,4)
           WHEN 0 THEN 'PIX' WHEN 1 THEN 'DINHEIRO'
           WHEN 2 THEN 'DEBITO' ELSE 'CREDITO'
       END,
       'CONFIRMADO'
FROM tmp_massa_240;

DROP TEMPORARY TABLE tmp_massa_240;

-- =========================================================
-- ADEQUACOES AS RN, RO E REO DO RELATORIO FINAL
-- Parametros demonstrativos: confirmar capacidade, horarios e tarifas reais.
-- =========================================================

CREATE TABLE IF NOT EXISTS configuracao_estacionamento (
 id_config INT PRIMARY KEY, capacidade_maxima INT NOT NULL,
 CHECK (capacidade_maxima>0)
);
INSERT INTO configuracao_estacionamento VALUES (1,20)
ON DUPLICATE KEY UPDATE capacidade_maxima=VALUES(capacidade_maxima);

CREATE TABLE IF NOT EXISTS horario_funcionamento (
 id_horario INT AUTO_INCREMENT PRIMARY KEY, dia_semana TINYINT NOT NULL UNIQUE,
 hora_abertura TIME NOT NULL, hora_fechamento TIME NOT NULL,
 ativo BOOLEAN NOT NULL DEFAULT TRUE,
 CHECK (dia_semana BETWEEN 1 AND 7), CHECK (hora_fechamento>hora_abertura)
);
INSERT INTO horario_funcionamento (dia_semana,hora_abertura,hora_fechamento,ativo) VALUES
(1,'08:00:00','18:00:00',TRUE),(2,'08:00:00','18:00:00',TRUE),
(3,'08:00:00','18:00:00',TRUE),(4,'08:00:00','18:00:00',TRUE),
(5,'08:00:00','18:00:00',TRUE),(6,'08:00:00','18:00:00',TRUE),
(7,'08:00:00','18:00:00',FALSE)
ON DUPLICATE KEY UPDATE hora_abertura=VALUES(hora_abertura),
 hora_fechamento=VALUES(hora_fechamento),ativo=VALUES(ativo);

CREATE TABLE IF NOT EXISTS tarifa_estacionamento (
 id_tarifa INT AUTO_INCREMENT PRIMARY KEY, descricao VARCHAR(100) NOT NULL,
 valor DECIMAL(10,2) NOT NULL, vigente_desde DATE NOT NULL,
 vigente_ate DATE NULL, ativo BOOLEAN NOT NULL DEFAULT TRUE,
 CHECK(valor>=0), CHECK(vigente_ate IS NULL OR vigente_ate>=vigente_desde)
);
INSERT INTO tarifa_estacionamento(descricao,valor,vigente_desde,ativo)
SELECT 'Tarifa padrao demonstrativa',10.00,'2026-01-01',TRUE
WHERE NOT EXISTS (SELECT 1 FROM tarifa_estacionamento WHERE descricao='Tarifa padrao demonstrativa');

CREATE TABLE IF NOT EXISTS perfil_acesso (
 id_perfil INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE,
 descricao VARCHAR(200)
);
INSERT IGNORE INTO perfil_acesso(nome,descricao) VALUES
('ADMINISTRADOR','Acesso administrativo'),('GERENTE','Acesso gerencial'),
('ATENDIMENTO','Cadastro e atendimento'),('OPERACIONAL','Servicos e estoque');

CREATE TABLE IF NOT EXISTS permissao_acesso (
 id_permissao INT AUTO_INCREMENT PRIMARY KEY, codigo VARCHAR(80) NOT NULL UNIQUE,
 descricao VARCHAR(200) NOT NULL
);
INSERT IGNORE INTO permissao_acesso(codigo,descricao) VALUES
('CLIENTE_CONSULTAR','Consultar clientes'),('CLIENTE_ALTERAR','Cadastrar e alterar clientes'),
('FINANCEIRO_CONSULTAR','Consultar financeiro'),('FINANCEIRO_OPERAR','Registrar pagamentos e caixa'),
('ESTOQUE_OPERAR','Registrar estoque'),('AGENDAMENTO_OPERAR','Operar agendamentos'),
('USUARIO_ADMINISTRAR','Administrar usuarios'),('OCORRENCIA_OPERAR','Operar ocorrencias');

CREATE TABLE IF NOT EXISTS perfil_permissao (
 id_perfil INT NOT NULL, id_permissao INT NOT NULL,
 PRIMARY KEY(id_perfil,id_permissao),
 FOREIGN KEY(id_perfil) REFERENCES perfil_acesso(id_perfil),
 FOREIGN KEY(id_permissao) REFERENCES permissao_acesso(id_permissao)
);
CREATE TABLE IF NOT EXISTS usuario_sistema (
 id_usuario INT AUTO_INCREMENT PRIMARY KEY, id_funcionario INT NOT NULL UNIQUE,
 id_perfil INT NOT NULL, login VARCHAR(80) NOT NULL UNIQUE,
 senha_hash VARCHAR(255) NOT NULL, ativo BOOLEAN NOT NULL DEFAULT TRUE,
 criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, ultimo_acesso DATETIME NULL,
 FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario),
 FOREIGN KEY(id_perfil) REFERENCES perfil_acesso(id_perfil)
);

-- Matriz inicial de permissoes por perfil (ajustavel pela administracao).
INSERT IGNORE INTO perfil_permissao(id_perfil,id_permissao)
SELECT pa.id_perfil, pe.id_permissao
FROM perfil_acesso pa CROSS JOIN permissao_acesso pe
WHERE pa.nome='ADMINISTRADOR';
INSERT IGNORE INTO perfil_permissao(id_perfil,id_permissao)
SELECT pa.id_perfil, pe.id_permissao
FROM perfil_acesso pa JOIN permissao_acesso pe
WHERE pa.nome='GERENTE' AND pe.codigo<>'USUARIO_ADMINISTRAR';
INSERT IGNORE INTO perfil_permissao(id_perfil,id_permissao)
SELECT pa.id_perfil, pe.id_permissao
FROM perfil_acesso pa JOIN permissao_acesso pe
WHERE pa.nome='ATENDIMENTO'
  AND pe.codigo IN ('CLIENTE_CONSULTAR','CLIENTE_ALTERAR','AGENDAMENTO_OPERAR','OCORRENCIA_OPERAR');
INSERT IGNORE INTO perfil_permissao(id_perfil,id_permissao)
SELECT pa.id_perfil, pe.id_permissao
FROM perfil_acesso pa JOIN permissao_acesso pe
WHERE pa.nome='OPERACIONAL'
  AND pe.codigo IN ('CLIENTE_CONSULTAR','ESTOQUE_OPERAR','OCORRENCIA_OPERAR');

CREATE TABLE IF NOT EXISTS ocorrencia (
 id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY, id_cliente INT NULL, id_veiculo INT NULL,
 id_funcionario_responsavel INT NOT NULL, tipo VARCHAR(30) NOT NULL,
 descricao TEXT NOT NULL, data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 situacao VARCHAR(20) NOT NULL DEFAULT 'ABERTA', providencia TEXT NULL,
 data_conclusao DATETIME NULL,
 FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
 FOREIGN KEY(id_veiculo) REFERENCES veiculo(id_veiculo),
 FOREIGN KEY(id_funcionario_responsavel) REFERENCES funcionario(id_funcionario),
 CHECK(tipo IN ('DANO','RECLAMACAO','IRREGULARIDADE','OUTRO')),
 CHECK(situacao IN ('ABERTA','EM_ANALISE','RESOLVIDA','CANCELADA'))
);
CREATE TABLE IF NOT EXISTS autorizacao_liberacao (
 id_autorizacao INT AUTO_INCREMENT PRIMARY KEY, id_permanencia INT NOT NULL,
 id_funcionario_autorizador INT NOT NULL, data_autorizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 justificativa VARCHAR(255) NOT NULL,
 FOREIGN KEY(id_permanencia) REFERENCES permanencia_estacionamento(id_permanencia),
 FOREIGN KEY(id_funcionario_autorizador) REFERENCES funcionario(id_funcionario)
);
CREATE TABLE IF NOT EXISTS documento_fiscal (
 id_documento INT AUTO_INCREMENT PRIMARY KEY, id_pagamento INT NOT NULL,
 tipo_documento VARCHAR(30) NOT NULL, numero_documento VARCHAR(60) NULL,
 chave_acesso VARCHAR(100) NULL, situacao VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
 data_emissao DATETIME NULL, FOREIGN KEY(id_pagamento) REFERENCES pagamento(id_pagamento),
 CHECK(situacao IN ('PENDENTE','EMITIDO','CANCELADO'))
);
CREATE TABLE IF NOT EXISTS historico_agendamento (
 id_historico INT AUTO_INCREMENT PRIMARY KEY, id_agendamento INT NOT NULL,
 situacao_anterior VARCHAR(20) NULL, situacao_nova VARCHAR(20) NOT NULL,
 data_alteracao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, observacao VARCHAR(255) NULL,
 FOREIGN KEY(id_agendamento) REFERENCES agendamento(id_agendamento)
);
CREATE TABLE IF NOT EXISTS auditoria_sistema (
 id_auditoria BIGINT AUTO_INCREMENT PRIMARY KEY, tabela_afetada VARCHAR(64) NOT NULL,
 operacao VARCHAR(10) NOT NULL, identificador_registro VARCHAR(100) NULL,
 data_evento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 usuario_banco VARCHAR(150) NOT NULL DEFAULT 'NAO_IDENTIFICADO', detalhes VARCHAR(500) NULL
);

DELIMITER $$
CREATE TRIGGER trg_agendamento_validar_insert BEFORE INSERT ON agendamento FOR EACH ROW
BEGIN
 DECLARE v_cliente INT; DECLARE v_abertura TIME; DECLARE v_fechamento TIME;
 DECLARE v_ativo BOOLEAN; DECLARE v_total INT;
 SELECT id_cliente INTO v_cliente FROM veiculo WHERE id_veiculo=NEW.id_veiculo;
 IF v_cliente IS NULL OR v_cliente<>NEW.id_cliente THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='O veiculo nao pertence ao cliente informado.';
 END IF;
 SELECT hora_abertura,hora_fechamento,ativo INTO v_abertura,v_fechamento,v_ativo
 FROM horario_funcionamento WHERE dia_semana=DAYOFWEEK(NEW.data_hora);
 IF v_ativo IS NULL OR v_ativo=FALSE OR TIME(NEW.data_hora)<v_abertura OR TIME(NEW.data_hora)>=v_fechamento THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Agendamento fora do horario de funcionamento.';
 END IF;
 SELECT COUNT(*) INTO v_total FROM agendamento
 WHERE DATE(data_hora)=DATE(NEW.data_hora) AND situacao IN ('AGENDADO','CONFIRMADO');
 IF v_total>=10 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Limite diario de 10 agendamentos atingido.'; END IF;
 IF EXISTS(SELECT 1 FROM agendamento WHERE id_veiculo=NEW.id_veiculo
  AND situacao IN ('AGENDADO','CONFIRMADO')
  AND ABS(TIMESTAMPDIFF(MINUTE,data_hora,NEW.data_hora))<60) THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ja existe agendamento proximo para este veiculo.';
 END IF;
END$$
CREATE TRIGGER trg_agendamento_validar_update BEFORE UPDATE ON agendamento FOR EACH ROW
BEGIN
 DECLARE v_cliente INT; DECLARE v_abertura TIME; DECLARE v_fechamento TIME; DECLARE v_ativo BOOLEAN;
 SELECT id_cliente INTO v_cliente FROM veiculo WHERE id_veiculo=NEW.id_veiculo;
 IF v_cliente IS NULL OR v_cliente<>NEW.id_cliente THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='O veiculo nao pertence ao cliente informado.';
 END IF;
 IF OLD.situacao='CANCELADO' AND NEW.situacao<>'CANCELADO' THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Agendamento cancelado nao pode ser reativado; crie outro.';
 END IF;
 IF NEW.data_hora<>OLD.data_hora OR NEW.id_veiculo<>OLD.id_veiculo OR NEW.id_cliente<>OLD.id_cliente THEN
  SELECT hora_abertura,hora_fechamento,ativo INTO v_abertura,v_fechamento,v_ativo
  FROM horario_funcionamento WHERE dia_semana=DAYOFWEEK(NEW.data_hora);
  IF v_ativo IS NULL OR v_ativo=FALSE OR TIME(NEW.data_hora)<v_abertura OR TIME(NEW.data_hora)>=v_fechamento THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Agendamento fora do horario de funcionamento.';
  END IF;
 END IF;
END$$
CREATE TRIGGER trg_agendamento_bloquear_delete BEFORE DELETE ON agendamento FOR EACH ROW
BEGIN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Nao exclua agendamentos; registre o cancelamento.'; END$$
CREATE TRIGGER trg_agendamento_historico AFTER UPDATE ON agendamento FOR EACH ROW
BEGIN
 IF OLD.situacao<>NEW.situacao THEN
  INSERT INTO historico_agendamento(id_agendamento,situacao_anterior,situacao_nova,observacao)
  VALUES(NEW.id_agendamento,OLD.situacao,NEW.situacao,NEW.observacao);
 END IF;
 INSERT INTO auditoria_sistema(tabela_afetada,operacao,identificador_registro,detalhes)
 VALUES('agendamento','UPDATE',NEW.id_agendamento,CONCAT('Situacao: ',OLD.situacao,' -> ',NEW.situacao));
END$$
CREATE TRIGGER trg_item_os_validar_servico BEFORE INSERT ON item_ordem_servico FOR EACH ROW
BEGIN
 DECLARE v_agendamento INT;
 SELECT id_agendamento INTO v_agendamento FROM ordem_servico WHERE id_ordem_servico=NEW.id_ordem_servico;
 IF v_agendamento IS NOT NULL AND NOT EXISTS(SELECT 1 FROM item_agendamento
  WHERE id_agendamento=v_agendamento AND id_servico=NEW.id_servico) THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Servico executado nao consta no agendamento.';
 END IF;
END$$
CREATE TRIGGER trg_estacionamento_capacidade BEFORE INSERT ON permanencia_estacionamento FOR EACH ROW
BEGIN
 DECLARE v_capacidade INT; DECLARE v_ocupadas INT;
 SELECT capacidade_maxima INTO v_capacidade FROM configuracao_estacionamento WHERE id_config=1;
 SELECT COUNT(*) INTO v_ocupadas FROM permanencia_estacionamento WHERE saida IS NULL;
 IF v_ocupadas>=v_capacidade THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Estacionamento sem vagas.'; END IF;
END$$
CREATE TRIGGER trg_estacionamento_liberacao BEFORE UPDATE ON permanencia_estacionamento FOR EACH ROW
BEGIN
 DECLARE v_pagamento INT DEFAULT 0; DECLARE v_autorizacao INT DEFAULT 0;
 IF OLD.saida IS NULL AND NEW.saida IS NOT NULL THEN
  SELECT COUNT(*) INTO v_pagamento FROM ordem_servico os JOIN pagamento pg
   ON pg.id_ordem_servico=os.id_ordem_servico
   WHERE os.id_veiculo=NEW.id_veiculo AND pg.situacao='CONFIRMADO';
  SELECT COUNT(*) INTO v_autorizacao FROM autorizacao_liberacao WHERE id_permanencia=OLD.id_permanencia;
  IF v_pagamento=0 AND v_autorizacao=0 THEN
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Exige pagamento confirmado ou autorizacao registrada.';
  END IF;
 END IF;
END$$
CREATE TRIGGER trg_estoque_validar_saida BEFORE INSERT ON movimentacao_estoque FOR EACH ROW
BEGIN
 DECLARE v_saldo DECIMAL(10,2);
 IF NEW.tipo='SAIDA' THEN
  SELECT COALESCE(SUM(CASE WHEN tipo='ENTRADA' THEN quantidade ELSE -quantidade END),0)
  INTO v_saldo FROM movimentacao_estoque WHERE id_produto=NEW.id_produto;
  IF NEW.quantidade>v_saldo THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Estoque insuficiente.'; END IF;
 END IF;
END$$
CREATE TRIGGER trg_venda_validar_finalizacao BEFORE UPDATE ON venda_produto FOR EACH ROW
BEGIN
 IF NEW.situacao='PAGA' AND OLD.situacao<>'PAGA' AND NOT EXISTS
  (SELECT 1 FROM item_venda WHERE id_venda=NEW.id_venda) THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Venda nao pode ser finalizada sem itens.';
 END IF;
END$$
CREATE TRIGGER trg_item_venda_preco BEFORE INSERT ON item_venda FOR EACH ROW
BEGIN
 DECLARE v_custo DECIMAL(10,2);
 SELECT custo_referencia INTO v_custo FROM produto WHERE id_produto=NEW.id_produto;
 SET NEW.preco_unitario=ROUND(v_custo*1.30,2);
END$$
CREATE TRIGGER trg_item_venda_preco_update BEFORE UPDATE ON item_venda FOR EACH ROW
BEGIN
 DECLARE v_custo DECIMAL(10,2);
 SELECT custo_referencia INTO v_custo FROM produto WHERE id_produto=NEW.id_produto;
 SET NEW.preco_unitario=ROUND(v_custo*1.30,2);
END$$
CREATE TRIGGER trg_auditoria_pagamento AFTER INSERT ON pagamento FOR EACH ROW
BEGIN
 INSERT INTO auditoria_sistema(tabela_afetada,operacao,identificador_registro,detalhes)
 VALUES('pagamento','INSERT',NEW.id_pagamento,CONCAT('Valor=',NEW.valor,'; situacao=',NEW.situacao));
END$$
CREATE TRIGGER trg_auditoria_estoque AFTER INSERT ON movimentacao_estoque FOR EACH ROW
BEGIN
 INSERT INTO auditoria_sistema(tabela_afetada,operacao,identificador_registro,detalhes)
 VALUES('movimentacao_estoque','INSERT',NEW.id_movimentacao,
 CONCAT('Produto=',NEW.id_produto,'; tipo=',NEW.tipo,'; quantidade=',NEW.quantidade));
END$$
DELIMITER ;

CREATE INDEX idx_agendamento_data_situacao ON agendamento(data_hora,situacao);
CREATE INDEX idx_permanencia_aberta ON permanencia_estacionamento(saida,id_veiculo);
CREATE INDEX idx_movimentacao_produto_data ON movimentacao_estoque(id_produto,data_movimentacao);
CREATE INDEX idx_pagamento_ordem_situacao ON pagamento(id_ordem_servico,situacao);

-- LGPD e controle de acesso exigem tambem configuracao na aplicacao/servidor:
-- usar hash forte de senha, conexao criptografada, menor privilegio, backups protegidos,
-- validacao de perfil_permissao em cada operacao e politica de retencao/descarte.
-- A emissao fiscal depende de integracao com o sistema fiscal competente.

-- SELECT COM JOIN
SELECT os.id_ordem_servico,c.nome AS cliente,v.placa,s.nome AS servico,
       ios.quantidade,ios.preco_unitario
FROM ordem_servico os
JOIN veiculo v ON os.id_veiculo=v.id_veiculo
JOIN cliente c ON v.id_cliente=c.id_cliente
JOIN item_ordem_servico ios ON os.id_ordem_servico=ios.id_ordem_servico
JOIN servico s ON ios.id_servico=s.id_servico
ORDER BY os.id_ordem_servico;

-- UPDATE
UPDATE cliente SET telefone='(11) 90000-0099' WHERE id_cliente=4;

-- RN05 / RO10: cancelamentos nao sao apagados. O registro cancelado permanece no historico.

-- CONSULTAS GERENCIAIS
-- G01 — Quantos atendimentos foram registrados por dia?
-- Atende: P1 e KPI de veiculos atendidos por dia.
SELECT DATE(data_hora_entrada) AS dia,COUNT(*) AS total_ordens
FROM ordem_servico WHERE situacao<>'CANCELADA'
GROUP BY DATE(data_hora_entrada) ORDER BY dia;

-- G02 — Quais servicos foram mais executados e qual o faturamento correspondente?
-- Atende: P2 e KPI de servicos mais executados.
SELECT s.nome,SUM(ios.quantidade) AS quantidade_executada,
       SUM(ios.quantidade*ios.preco_unitario) AS faturamento
FROM item_ordem_servico ios JOIN servico s ON ios.id_servico=s.id_servico
JOIN ordem_servico os ON ios.id_ordem_servico=os.id_ordem_servico
WHERE os.situacao='CONCLUIDA'
GROUP BY s.id_servico,s.nome ORDER BY quantidade_executada DESC;

-- G03 — Qual foi a permanencia dos veiculos no estacionamento?
-- Atende: P3 e KPI de tempo de permanencia.
SELECT p.id_permanencia,v.placa,p.entrada,p.saida,
       TIMESTAMPDIFF(MINUTE,p.entrada,p.saida) AS minutos_permanencia,p.valor_cobrado
FROM permanencia_estacionamento p JOIN veiculo v ON p.id_veiculo=v.id_veiculo
ORDER BY p.entrada;

-- G04 — Qual o total recebido por forma de pagamento no periodo?
-- Atende: P4 e KPI de faturamento por forma de pagamento.
SELECT forma_pagamento,SUM(valor) AS total_recebido,COUNT(*) AS quantidade_pagamentos
FROM pagamento WHERE situacao='CONFIRMADO'
AND data_pagamento>='2026-10-01' AND data_pagamento<'2026-11-01'
GROUP BY forma_pagamento ORDER BY total_recebido DESC;

-- G05 — Quais produtos estao abaixo do estoque minimo?
-- Atende: P5 e KPI de produtos abaixo do estoque minimo.
SELECT p.id_produto,p.nome,p.marca,p.estoque_minimo,
COALESCE(SUM(CASE WHEN m.tipo='ENTRADA' THEN m.quantidade
                  WHEN m.tipo='SAIDA' THEN -m.quantidade END),0) AS saldo_atual
FROM produto p LEFT JOIN movimentacao_estoque m ON p.id_produto=m.id_produto
GROUP BY p.id_produto,p.nome,p.marca,p.estoque_minimo
HAVING saldo_atual<p.estoque_minimo ORDER BY saldo_atual;

-- G06 — Quanto foi comprado por fornecedor no periodo?
-- Atende: P6 e KPI de compras por fornecedor.
SELECT f.nome AS fornecedor,SUM(ic.quantidade*ic.custo_unitario) AS total_compras
FROM compra c JOIN fornecedor f ON c.id_fornecedor=f.id_fornecedor
JOIN item_compra ic ON c.id_compra=ic.id_compra
WHERE c.situacao='RECEBIDA' GROUP BY f.id_fornecedor,f.nome
ORDER BY total_compras DESC;

-- G07 — Quais produtos foram vendidos e qual o faturamento por produto?
-- Atende: P7 e KPI de vendas por produto.
SELECT p.nome,SUM(iv.quantidade) AS unidades_vendidas,
       SUM(iv.quantidade*iv.preco_unitario) AS faturamento
FROM item_venda iv JOIN produto p ON iv.id_produto=p.id_produto
JOIN venda_produto v ON iv.id_venda=v.id_venda
WHERE v.situacao='PAGA' GROUP BY p.id_produto,p.nome ORDER BY faturamento DESC;

-- G08 — Qual a diferenca entre valor contado e valor de abertura no caixa fechado?
-- Atende: P4 e KPI de diferenca de caixa.
SELECT id_caixa,data_abertura,data_fechamento,valor_abertura,valor_contado,
       (valor_contado-valor_abertura) AS diferenca_contagem
FROM caixa WHERE situacao='FECHADO';

-- G09 — Quais clientes ainda nao realizaram compras de produtos?
-- Atende: acompanhamento da carteira de clientes.
SELECT c.id_cliente,c.nome,c.telefone FROM cliente c
LEFT JOIN venda_produto v ON c.id_cliente=v.id_cliente
WHERE v.id_venda IS NULL ORDER BY c.nome;

-- CONSULTAS DE AUDITORIA
-- A01 — Existem veiculos sem cliente associado? Verifica: RN01.
SELECT v.* FROM veiculo v LEFT JOIN cliente c ON v.id_cliente=c.id_cliente
WHERE c.id_cliente IS NULL;

-- A02 — Existem agendamentos sem cliente ou veiculo valido? Verifica: RN02.
SELECT a.* FROM agendamento a
LEFT JOIN cliente c ON a.id_cliente=c.id_cliente
LEFT JOIN veiculo v ON a.id_veiculo=v.id_veiculo
WHERE c.id_cliente IS NULL OR v.id_veiculo IS NULL;

-- A03 — Existem ordens com data de saida anterior a entrada? Verifica: RN07.
SELECT * FROM ordem_servico WHERE data_hora_saida<data_hora_entrada;

-- A04 — Existem pagamentos sem exatamente uma origem? Verifica: RN08.
SELECT * FROM pagamento
WHERE (id_ordem_servico IS NULL AND id_venda IS NULL)
OR (id_ordem_servico IS NOT NULL AND id_venda IS NOT NULL);

-- A05 — Existem itens de ordem com quantidade ou preco invalidos? Verifica: RN04 e RN05.
SELECT * FROM item_ordem_servico WHERE quantidade<=0 OR preco_unitario<0;

-- A06 — Existem produtos com saldo negativo? Verifica: RN12.
SELECT p.id_produto,p.nome,
SUM(CASE WHEN m.tipo='ENTRADA' THEN m.quantidade
         WHEN m.tipo='SAIDA' THEN -m.quantidade END) AS saldo
FROM produto p JOIN movimentacao_estoque m ON p.id_produto=m.id_produto
GROUP BY p.id_produto,p.nome HAVING saldo<0;

-- A07 — Existem movimentacoes com motivo incompativel com o tipo?
-- Verifica: RN09, RN10 e RN11.
SELECT * FROM movimentacao_estoque
WHERE (motivo='COMPRA' AND tipo<>'ENTRADA')
OR (motivo IN ('CONSUMO','VENDA') AND tipo<>'SAIDA');

-- A08 — Existem ordens de servico sem itens registrados? Verifica: RN06.
SELECT os.* FROM ordem_servico os
LEFT JOIN item_ordem_servico ios ON os.id_ordem_servico=ios.id_ordem_servico
WHERE os.situacao<>'CANCELADA' AND ios.id_item_os IS NULL;

-- FIM DO SCRIPT
