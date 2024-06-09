-- Tabela : tb_empresa
-- Descrição : planilha encaminhada pela empresa SeuBeneficio.com contendo informações autorizadas pelas empresas para compartilhamento.
-- Colunas:
-- codigo_empresa	:   codigo da empresa do sistema interno da SeuBeneficio.com.
--     tipo do dado int		
-- nome_empresa	:   nome da empresa cliente cadastrado no sistema interno da SeuBeneficio.com.
--     tipo do dado    varchar(500)			
-- uf_sede_empresa	:   unidade federativa da sede da empresa cliente da SeuBeneficio.com.
--     tipo do dado    varchar(2)
DROP TABLE IF EXISTS tb_empresa;			
CREATE TABLE tb_empresa (
	codigo_empresa INT PRIMARY KEY,
	nome_empresa VARCHAR(500),
	uf_sede_empresa VARCHAR(2)
);

-- Tabela : tb_tipo_beneficio
-- codigo_beneficio	: codigo do tipo do beneficio 1- Vale Refeição e 2- Vale Alimentação, os clientes beneficiários só podem ter um ou outro.
--     tipo do dado    int
-- tipo_beneficio	: codigo do tipo do beneficio 1- Vale Refeição e 2- Vale Alimentação, os clientes beneficiários só podem ter um ou outro.
--     tipo do dado    varchar(45)	
DROP TABLE IF EXISTS tb_tipo_beneficio;
CREATE TABLE tb_tipo_beneficio (
	codigo_beneficio INT PRIMARY KEY,
	tipo_beneficio VARCHAR(45)
);
INSERT INTO tb_tipo_beneficio (codigo_beneficio, tipo_beneficio)
VALUES (1, "Vale Refeição"), (2, "Vale Alimentação");

-- Tabela : tb_beneficio
-- Descrição : planilha encaminhada pela empresa SeuBeneficio.com contendo informações autorizadas pelas empresas para compartilhamento.
-- Colunas:
-- codigo_funcionario : codigo interno da plataforma da SeuBeneficio.com para cada beneficiario
--     tipo do dado	int		
-- email_funcionario : e-mail do cliente beneficiario
--     tipo do dado	varchar(200)			
-- codigo_beneficio : codigo do tipo do beneficio 1- Vale Refeição e 2- Vale Alimentação, os clientes beneficiários só podem ter um ou outro.
--     tipo do dado    int			
-- codigo_empresa	: codigo da empresa do sistema interno da SeuBeneficio.com.
--     tipo do dado    int			
-- tipo_beneficio	: codigo do tipo do beneficio 1- Vale Refeição e 2- Vale Alimentação, os clientes beneficiários só podem ter um ou outro.
--     tipo do dado    varchar(45)			
-- valor_beneficio	: valor total disponibilizado mensalmente.
--     tipo do dado    varchar(45)
DROP TABLE IF EXISTS tb_beneficio;
CREATE TABLE tb_beneficio (
	codigo_funcionario INT PRIMARY KEY,
	email_funcionario VARCHAR(200),
	tipo_beneficio VARCHAR(45),
	valor_beneficio VARCHAR(45),
	codigo_beneficio INT,
	codigo_empresa INT,

	FOREIGN KEY (codigo_beneficio) REFERENCES tb_tipo_beneficio(codigo_beneficio),
	FOREIGN KEY (codigo_empresa) REFERENCES tb_empresa(codigo_empresa)
);