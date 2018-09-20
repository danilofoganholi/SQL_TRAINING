--Criando tabela de departamento
CREATE TABLE TabelaDep
(
	COD_DEPTO INT IDENTITY,
	DEPTO VARCHAR(30) NOT NULL,

	--definindo chave primária
	CONSTRAINT PK_TabelaDep PRIMARY KEY (COD_DEPTO)
	);

--Criando tabela Tabela cargo
CREATE TABLE TabelaCar
(
	COD_CARGO INT IDENTITY,
	CARGO VARCHAR(50) NOT NULL,
	SALARIO_INIC NUMERIC (10,2) NOT NULL,

	--definindo chave primária
	CONSTRAINT PK_TabelaCar PRIMARY KEY (COD_CARGO)
	);

--Criando tabela Tabela empregados
CREATE TABLE Empregados
(
	CODFUN INT IDENTITY,
	NOME VARCHAR(50) NOT NULL,
	NUM_DEPEND tinyint NOT NULL, 
	DATA_NASCIMENTO DATE NOT NULL,  
	COD_DEPTO INT NOT NULL,
	COD_CARGO INT NOT NULL,
	DATA_ADMISSAO DATE NOT NULL,
	SALARIO NUMERIC(10,2) NOT NULL,
	SINDICALIZADO BIT NOT NULL,
	OBS VARCHAR(50),
	
	--definindo chave primária
	CONSTRAINT PK_EMPREGADOS PRIMARY KEY (CODFUN),

	--definindo chave estrangeira 
	CONSTRAINT FK_Empregados_TabelaDep  
			FOREIGN KEY (COD_DEPTO)
			REFERENCES TabelaDep (COD_DEPTO),

	--definindo chave estrangeira 
		CONSTRAINT FK_Empregados_TabelaCar
			FOREIGN KEY (COD_CARGO)
			REFERENCES TabelaCar (COD_CARGO) 
	);

--Criando tabela Tabela dependentes
CREATE TABLE Dependentes
(
	CODFUN INT NOT NULL,
	CODDEP INT IDENTITY,
	NOME VARCHAR(50) NOT NULL,
	DATA_NASCIMENTO DATE NOT NULL,
	
	--definindo chave primária
	CONSTRAINT PK_Dependentes PRIMARY KEY (CODDEP, CODFUN),

	--definindo chave estrangeira 
	CONSTRAINT FK_Dependentes_Empregados  
			FOREIGN KEY (CODFUN)
			REFERENCES Empregados (CODFUN)

);