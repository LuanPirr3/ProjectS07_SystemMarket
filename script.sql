-- Criando tabela Cargo

CREATE TABLE IF NOT EXISTS integracao.TBCARGO (
	id				SMALLINT(3)		UNSIGNED 	AUTO_INCREMENT 		NOT NULL,
	cargo			varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE (cargo)
);

-- Criando tabela Nivel de acesso

CREATE TABLE IF NOT EXISTS integracao.TBNIVEL_ACESSO (
	id				SMALLINT(3)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	acesso			varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(acesso)
);

-- Criando Tabela Usuario

CREATE TABLE IF NOT EXISTS integracao.TBUSUARIO(								
	id 				int(6)	 										NOT NULL,   -- Usuario
	nome			varchar(30)										NOT NULL,	-- Nome
	senha			varchar(15)										NOT NULL,	-- Senha
	email			varchar(100)											,
	data_update		TIMESTAMP 												,
	data_nascimento	DATE 													,
	ativo			BOOLEAN											NOT NULL,
	id_cargo		SMALLINT(3)		UNSIGNED								,
	id_nivl_acesso	SMALLINT(3)		UNSIGNED								,
	id_res_adicao	int(11)													,
	id_ult_ativacao	int(11)													,
	
	PRIMARY KEY (id),
	UNIQUE(email),
	FOREIGN KEY(id_cargo) REFERENCES TBCARGO(id),
	FOREIGN KEY(id_nivl_acesso) REFERENCES TBNIVEL_ACESSO(id)
);

-- Criando Tabela Departamento

CREATE TABLE IF NOT EXISTS integracao.TBDEPARTAMENTO (
	id				SMALLINT(3)		UNSIGNED						NOT NULL,	-- Usuario
	departamento	varchar(50)										NOT NULL,
	ativo			boolean											NOT	NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(departamento)
);

-- Criando Tabela Grupo

CREATE TABLE IF NOT EXISTS integracao.TBGRUPO (
	id				SMALLINT(3)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	grupo			varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_departamento	SMALLINT		UNSIGNED						NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_departamento) REFERENCES TBDEPARTAMENTO(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE (grupo)
	);
	
-- Criando Tabela Familia
	
CREATE TABLE IF NOT EXISTS integracao.TBFAMILIA (
	id				SMALLINT(3)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	familia			varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_grupo 		SMALLINT		UNSIGNED						NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_grupo) REFERENCES TBGRUPO(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(familia)
);

-- Criando Tabela Usuario Departamento

CREATE TABLE IF NOT EXISTS integracao.TBUSU_DEPARTAMENTO (
	id_usuario		int(11)											NOT NULL,
	id_departamento	SMALLINT		UNSIGNED						NOT NULL,
	id_grupo		SMALLINT		UNSIGNED						NOT NULL,
	id_familia		SMALLINT		UNSIGNED						NOT NULL,
	
	PRIMARY KEY(id_usuario),
	FOREIGN KEY(id_usuario) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_departamento) REFERENCES TBDEPARTAMENTO(id),
	FOREIGN KEY(id_grupo) REFERENCES TBGRUPO(id),
	FOREIGN KEY(id_familia) REFERENCES TBFAMILIA(id)
	
);

-- Criando Tabela Produto Marca Empresa

CREATE TABLE IF NOT EXISTS integracao.TBPRO_MAR_EMPRESA (
	id				SMALLINT(3)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	empresa			varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(empresa)
);


-- Criando Tabela Produto Marca Distribuidor

CREATE TABLE IF NOT EXISTS integracao.TBPRO_MAR_DISTRIBUIDOR (
	id				SMALLINT(3)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	distribuidor	varchar(50)										NOT NULL,
	ativo			boolean											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(distribuidor)
);

-- Criando Tabela Marca 

CREATE TABLE IF NOT EXISTS integracao.TBPRO_MARCA (
	id				SMALLINT(4)		UNSIGNED	AUTO_INCREMENT		NOT NULL,
	nome			varchar(50)										NOT NULL,
	id_empresa		SMALLINT		UNSIGNED						NOT NULL,
	id_distribuidor	SMALLINT		UNSIGNED						NOT NULL,
	ativo			boolean											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	id_res_adicao	int(11)											NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_empresa) REFERENCES TBPRO_MAR_EMPRESA(id),
	FOREIGN KEY(id_distribuidor)	REFERENCES TBPRO_MAR_DISTRIBUIDOR(id),
	FOREIGN KEY(id_ult_ativacao) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_adicao) REFERENCES TBUSUARIO(id),
	UNIQUE(nome)
);

-- Criando Tabela Produto

CREATE TABLE IF NOT EXISTS integracao.TBPRODUTO (
	codigo			INT(11)											NOT NULL,
	nome			VARCHAR(40)										NOT NULL,
	descricao		VARCHAR(40)												, -- Complemento de cadmer
	id_marca		SMALLINT(4)		UNSIGNED						NOT NULL,
	unidade			VARCHAR(6)												, -- Complemento de cadmer
	loja_est		DOUBLE(12,3)									NOT NULL, -- Complemento de cadmer
	custo			DOUBLE(10,2)									NOT NULL, -- Complemento de cadmer
	venda			DOUBLE(20,5)									NOT NULL, -- Complemento de cadmer
	id_grupo		SMALLINT(3)		UNSIGNED						NOT NULL,
	id_familia		SMALLINT(3)		UNSIGNED						NOT NULL,
	dt_ult_entrada	DATE													, -- Complemento de cadmer
	dt_ult_preco	DATE													, -- Complemento de cadmer
	dt_ult_saida	DATE													, -- Complemento de cadmer
	id_res_cadastro	int(11)											NOT NULL,
	dt_cadastro		TIMESTAMP										NOT NULL,
	ativo			BOOLEAN											NOT NULL,
	id_ult_ativacao	int(11)											NOT NULL,
	PRIMARY KEY(codigo),
	UNIQUE(nome)
);

-- Criando Tabela Produtos Pedido

CREATE TABLE IF NOT EXISTS integracao.TBPRO_PEDIDO (
	id				INT				UNSIGNED	AUTO_INCREMENT		NOT NULL,
	id_codigo		INT(11)											NOT NULL,
	id_responsavel	int(11)											NOT NULL,
	data_pedido		TIMESTAMP												,
	quantidade		INT				UNSIGNED						NOT NULL,
	id_res_checagem	int(11)													,
	dt_checagem		TIMESTAMP												,
	url_recibo		VARCHAR(255)											,
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_codigo) REFERENCES TBPRODUTO(codigo),
	FOREIGN KEY(id_responsavel) REFERENCES TBUSUARIO(id),
	FOREIGN KEY(id_res_checagem) REFERENCES TBUSUARIO(id),
	UNIQUE(data_pedido)
);

-- Criando TBUSUSARIO_PRESENCIAL

CREATE TABLE IF NOT EXISTS TBUSUARIO_PRESENCIAL (
	id				Int,
    ip_local		varchar(45),
    tbusuario_id	Int(6),
    
    PRIMARY KEY(id),
    FOREIGN KEY(tbusuario_id) REFERENCES TBUSUARIO(id)
);

-- CRIANDO TBUSUARIO_REMOTO

CREATE TABLE IF NOT EXISTS TBUSUARIO_REMOTO (
	id				Int,
    ip_remoto		varchar(45),
    tbusuario_id	Int(6),
    
    PRIMARY KEY(id),
    FOREIGN KEY(tbusuario_id) REFERENCES TBUSUARIO(id)
);

