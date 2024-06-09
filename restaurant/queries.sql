-- Cliente que mais fez pedidos por ano?
WITH ClienteGastos AS (
    SELECT
        YEAR(mesa.data_hora_entrada) AS ano,
        cliente.nome_cliente AS cliente,
        SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) AS total_gasto,
        ROW_NUMBER() OVER (
			PARTITION BY YEAR(mesa.data_hora_entrada)
			ORDER BY SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) DESC
		) AS rn
    FROM tb_pedido pedido
    JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
    JOIN tb_cliente cliente ON mesa.id_cliente = cliente.id_cliente
    JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
    GROUP BY YEAR(mesa.data_hora_entrada), cliente.nome_cliente
) SELECT ano, cliente, total_gasto
FROM ClienteGastos
WHERE rn = 1
ORDER BY ano;
-- 2022, João Pedro	da Luz, 20216
-- 2023, Sr. Ryan das Neves, 29727
-- 2024, Ana Laura Casa Grande, 16625


-- Qual o cliente que mais gastou em todos os anos?
SELECT
	cliente.nome_cliente AS cliente,
	SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) AS total_gasto
FROM tb_pedido pedido
JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
JOIN tb_cliente cliente ON mesa.id_cliente = cliente.id_cliente
JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
GROUP BY cliente.nome_cliente
ORDER BY total_gasto DESC
LIMIT 1;
-- Sr. Ryan das Neves, 55094

-- Qual o período do ano em que o restaurante tem maior movimento?
SELECT
    YEAR(mesa.data_hora_entrada) AS ano,
    SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) AS total_recebido
FROM tb_pedido pedido
JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
GROUP BY YEAR(mesa.data_hora_entrada)
ORDER BY total_recebido DESC
LIMIT 1;
-- 2023, 1972898

-- Qual a empresa que tem mais funcionarios como clientes do restaurante?
SELECT empresa.nome_empresa AS empresa, COUNT(funcionario.codigo_funcionario) AS numero_de_funcionarios
FROM tb_beneficio funcionario
JOIN tb_cliente cliente ON cliente.id_cliente = funcionario.codigo_funcionario
JOIN tb_empresa empresa ON empresa.codigo_empresa = funcionario.codigo_empresa
GROUP BY empresa.nome_empresa
ORDER BY numero_de_funcionarios DESC
LIMIT 1;
-- Stream Tech, 19

-- Qual empresa que tem mais funcionarios que consomem sobremesas no restaurante por ano?
WITH gastos_por_ano AS (
	SELECT
		YEAR(mesa.data_hora_entrada) AS ano,
		cliente.id_cliente AS id_cliente,
		SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) AS total_gasto,
		ROW_NUMBER() OVER (
			PARTITION BY YEAR(mesa.data_hora_entrada)
			ORDER BY SUM(prato.preco_unitario_prato * CAST(pedido.quantidade_pedido AS DECIMAL)) DESC
		) AS rn
	FROM tb_pedido pedido
	JOIN tb_mesa mesa ON pedido.codigo_mesa = mesa.codigo_mesa
	JOIN tb_cliente cliente ON mesa.id_cliente = cliente.id_cliente
	JOIN tb_prato prato ON pedido.codigo_prato = prato.codigo_prato
	JOIN tb_tipo_prato tipo_prato ON prato.codigo_tipo_prato = tipo_prato.codigo_tipo_prato
	WHERE tipo_prato.nome_tipo_prato = 'Sobremesa'
	GROUP BY YEAR(mesa.data_hora_entrada), cliente.id_cliente
) 
SELECT ano, empresa.nome_empresa AS empresa
FROM gastos_por_ano cliente
JOIN tb_beneficio funcionario ON funcionario.codigo_funcionario = cliente.id_cliente
JOIN tb_empresa empresa ON empresa.codigo_empresa = funcionario.codigo_empresa
WHERE rn = 1
ORDER BY ano;
-- 2022, Stream Tech
-- 2023, Tech 4 All
-- 2024, Triangle Tech