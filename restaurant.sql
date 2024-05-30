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