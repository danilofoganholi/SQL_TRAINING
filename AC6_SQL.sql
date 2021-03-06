--CRIAR TABELA DE UNIDADES
CREATE TABLE UNIDADES(
		COD_UNIDADE INT  IDENTITY, 
		NOME_UNIDADE VARCHAR(20),

		--CRIAR CHAVE PRIMARIA DA TABELA UNIDADES
		CONSTRAINT PK__UNIDADES PRIMARY KEY (COD_UNIDADE) 
);


--INSERIR NA TABLEA UNIDADES
INSERT INTO UNIDADES 
(NOME_UNIDADE)
VALUES 
('PEÇAS'), ('METROS'), ('QUILOGRAMAS'), ('DÚZIAS'), ('PACOTE'),('CAIXA');


--CRIAR TABELA CATEGORIAS
CREATE TABLE CATEGORIAS (
		COD_CATEGORIA INT  IDENTITY ,
		NOME_CATEGORIA VARCHAR (20),

		--CRIAR CHAVE PRIMARIA DA TABELA CATEGORIAS 
		CONSTRAINT PK__CATEGORIAS PRIMARY KEY (COD_CATEGORIA) 
);


--INSERIR NA TABELA CATEGORIAS
INSERT INTO CATEGORIAS
(NOME_CATEGORIA)
VALUES
('MOUSE'), ('PEN-DRIVE'), ('MONITOR DE VIDEO'), ('TECLADO'),
 ('CPU'),('CABO DE REDE');


 --CRIAR TABLEA PRODUTOS
CREATE TABLE PRODUTOS (
		COD_PRODUTO INT  IDENTITY ,
		NOME_PRODUTO VARCHAR (40),
		COD_UNIDADE_MEDIDA INT,
		COD_DE_CATEGORIA INT,
		QUANT_ESTOQUE INT,
		QUANT_MIN INT,
		PRECO_CUSTO FLOAT (5),
		PRECO_VENDA FLOAT (5),
		CAR_TEC VARCHAR (300),

		--CRIAR CHAVE ESTRANGEIRA DA TABELA PRODUTOS
		CONSTRAINT FK__PRODUTOS_UNIDADES
					FOREIGN KEY (COD_UNIDADE_MEDIDA)
					REFERENCES UNIDADES (COD_UNIDADE),

		--CRIAR CHAVE ESTRANGEIRA DA TABELA PRODUTOS
		CONSTRAINT FK__PRODUTOS_CATEGORIAS
					FOREIGN KEY (COD_DE_CATEGORIA)
					REFERENCES CATEGORIAS (COD_CATEGORIA),
		
		--CRIAR CHAVE PRIMARIA DA TABELA CATEGORIAS
		CONSTRAINT PK__PRODUTO PRIMARY KEY (COD_PRODUTO)
);


--INSERIR NA TABELA PRODUTOS
INSERT INTO PRODUTOS 
(NOME_PRODUTO,COD_UNIDADE_MEDIDA,COD_DE_CATEGORIA,
QUANT_ESTOQUE,QUANT_MIN,PRECO_CUSTO,PRECO_VENDA)
VALUES
('Caneta Azul' ,1, 1, 150, 40, 0.5, 0.75),
('Caneta Verde', 1, 1, 50, 40, 0.5, 0.75),
('Caneta Vermelha', 1, 1, 80, 35, 0.5, 0.75),
('Lápis', 1, 1, 400, 80, 0.5, 0.8),
('Régua', 1, 1, 40, 10, 1, 1.50);


--AUMENTAR DO PRECO DE CUSTO NOS PRODUTOS DO TIPO 2 EM 15%
UPDATE TB_PRODUTO 
SET PRECO_CUSTO *= 1.15
WHERE COD_TIPO=2


--ATUALIZAR PREÇO DE VENDA DOS PRODUTOS DO TIPO 2 PARA 30% ACIMA DO PREÇO DE CUSTO
UPDATE TB_PRODUTO 
SET PRECO_VENDA = PRECO_CUSTO*1.3
WHERE COD_TIPO=2


--ATUALIZAR TODOS OS IPI PARA 5 NOS PRODUTOS COM COD_TIPO = 3
UPDATE TB_PRODUTO 
SET IPI = 5
WHERE COD_TIPO=3


--REDUZIR A QTD_MINIMA EM 10% EM TODOS OS PRODUTOS
UPDATE TB_PRODUTO 
SET QTD_MINIMA *= 0.9 


--ALTERAR (ENDEREÇO, BAIRRO, CIDADE, ESTADO, CEP) PARA OS CLIENTES DE CODIGO 11
UPDATE TB_CLIENTE 
SET ENDERECO = 'AV CELSO GARCIA, 1234',
	BAIRRO= 'TATUAPE',
	CIDADE='SAO PAULO',
	ESTADO='SP',
	CEP= '03407080'
WHERE CODCLI = 11


-- COPIAR (ENDEREÇO, BAIRRO, CIDADE, ESTADO, CEP) DO CLINETE 13 PARA OS 
---CAMPOS (END_COB, BAI_COB, CID_COB, EST_COB e CEP_COB) DO MESMO CLIENTE
UPDATE TB_CLIENTE
SET END_COB=ENDERECO, 
	BAI_COB=BAIRRO,
	CID_COB=CIDADE,
	EST_COB=ESTADO,
	CEP_COB=CEP
WHERE CODCLI = 13


--ATUALIZAR ICMS PARA 12 NOS ESTADOS : 
--(RJ, RO, AC, RR, MG, PR, SC, RS, MS, MT) NA TABELA TB_CLIENTE
UPDATE TB_CLIENTE
SET ICMS = 12
WHERE ESTADO IN ('RJ', 'RO', 'AC', 'RR', 'MG', 'PR', 'SC', 'RS', 'MS', 'MT')


--ALTERAR CAMPO ICMS PARA 18 NOS CLIENTES DE SP
UPDATE TB_CLIENTE
SET ICMS = 18
WHERE ESTADO = 'SP'


--ALTERAR CAMPO ICMS PARA 7 PARA OS ESTADOS QUE NÃO SEJAM:
--RJ, RO, AC, RR, MG, PR, SC, RS, MS, MT, SP
UPDATE TB_CLIENTE
SET ICMS = 7
WHERE ESTADO NOT IN  ('SP','RJ', 'RO', 'AC', 'RR', 
'MG', 'PR', 'SC', 'RS', 'MS', 'MT')


--ALTERAR NA TABELA TB_ITENSPEDIDOS O CAMPO DESCONTO PARA 7, 
--RESPEITANDO AS SEGUINTES REGRAS:
--ID_PRODUTO = 8 
--DATA_ENTREGA EM JANEIRO DE 2007
--QUANTIDADE > 1000
UPDATE TB_ITENSPEDIDO
SET DESCONTO = 7
WHERE ID_PRODUTO=8 AND 
(DATA_ENTREGA BETWEEN '2007.01.01' AND '2007.01.31')
 AND QUANTIDADE > 1000


--ZERAR O CAMPO DESCONTO EM TODOS OS ITENS COM:
--QUANTIDADE ABAIXO DE 1000
--COM DATA DE ENTREGA MAIOR QUE 01/06/2007
--DESCONTO > 0
UPDATE TB_ITENSPEDIDO
SET DESCONTO=0
WHERE DESCONTO > 0 AND 
(DATA_ENTREGA > '2007.06.01')
 AND QUANTIDADE < 1000


 --FAER COPIA TABELA TB_VENDEDOR
 SELECT * INTO VENDEDORES_TMP FROM TB_VENDEDOR 


 --EXCLUIR OS REGISTROS COM CODVEN > 5 NA TABELA VENDEDORES_TMP
 DELETE VENDEDORES_TMP WHERE CODVEN > 5


 --FAER COPIA TABELA TB_PEDIDO
 SELECT * INTO COPIA_PEDIDOS FROM TB_PEDIDO 


 --EXCLUIR OS REGISTROS COM CODVEN = 5 NA TABELA COPIA_PEDIDOS
 DELETE COPIA_PEDIDOS WHERE CODVEN = 5


 --EXCLUIR OS REGISTROS COM A DATA DE EMISSAO 
 --NO PRIMEIRO SEMESTRE DE 2007 NA TABELA COPIA_PEDIDOS
 DELETE COPIA_PEDIDOS WHERE (DATA_EMISSAO BETWEEN '2007-01-01' AND '2007-06-30')


 --EXCLUIR OS REGISTROS DA TABELA COPIA_PEDIDOS
 DELETE COPIA_PEDIDOS
