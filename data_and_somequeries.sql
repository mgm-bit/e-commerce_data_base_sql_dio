USE ecommerce;

-- 1. MÉTODOS DE PAGAMENTO
INSERT INTO Metodos_Pagamento (id_metodo_pagamento, nome, permite_salvar) VALUES 
(1, 'Cartão de Crédito', TRUE), 
(2, 'Boleto Bancário', FALSE), 
(3, 'Pix', FALSE),
(4, 'PayPal', TRUE);

-- 2. VENDEDORES
INSERT INTO Vendedores (id_vendedor, razao_social, nome_fantasia, cnpj, email, telefone, ativo) VALUES
(1, 'Eletrônicos & Cia LTDA', 'Eletrônicos & Cia', '11111111000111', 'contato@eletronicosecia.com', '11988887777', TRUE),
(2, 'Casa e Conforto Comércio de Utilidades', 'Casa & Conforto', '22222222000122', 'vendas@casaconforto.com.br', '21977776666', TRUE),
(3, 'Vida Saudável Suplementos', 'Corpo & Mente Suplementos', '66666666000166', 'contato@corpomentefit.com', '51966665555', TRUE);

-- 3. FORNECEDORES
INSERT INTO Fornecedores (id_fornecedor, razao_social, cnpj, contato_nome, email) VALUES
(1, 'Importa-Tudo Brasil Componentes Eletrônicos', '33333333000133', 'Carlos Lima', 'carlos.lima@importatudo.com'),
(2, 'Tecidos Nacionais S.A.', '44444444000144', 'Fernanda Souza', 'fernanda@tecidosnacionais.com.br'),
(3, 'NutriGlobal Ingredientes', '77777777000177', 'Marcos Rocha', 'marcos@nutriglobal.com');

-- 4. CATEGORIAS (hierarquia expandida)
INSERT INTO Categorias (id_categoria, nome, id_categoria_pai) VALUES
(1, 'Eletrônicos', NULL),
(2, 'Casa', NULL),
(3, 'Saúde & Bem-Estar', NULL),
(4, 'Smartphones', 1),
(5, 'Acessórios', 1),
(6, 'Computadores', 1),
(7, 'Cama e Banho', 2),
(8, 'Decoração', 2),
(9, 'Suplementos', 3);

-- 5. CLIENTES (mais variedade)
INSERT INTO Clientes (id_cliente, email, senha_hash, telefone, tipo, nome, cpf, razao_social, nome_fantasia, cnpj) VALUES
(1, 'ana.silva@email.com', 'hash_senha_ana', '11911112222', 'PF', 'Ana Silva', '11122233344', NULL, NULL, NULL),
(2, 'bruno.costa@email.com', 'hash_senha_bruno', '73933334444', 'PF', 'Bruno Costa', '22233344455', NULL, NULL, NULL),
(3, 'compras@solucoesti.com.br', 'hash_senha_empresa', '41355556666', 'PJ', NULL, NULL, 'Soluções em TI LTDA', 'Soluções TI', '55555555000155'),
(4, 'carla.mendes@email.com', 'hash_senha_carla', '31944445555', 'PF', 'Carla Mendes', '44455566677', NULL, NULL, NULL),
(5, 'contato@innovate.com.br', 'hash_senha_innovate', '21922223333', 'PJ', NULL, NULL, 'Innovate Marketing Digital', 'Innovate Marketing', '88888888000188'),
(6, 'ricardo.souza@email.com', 'hash_senha_ricardo', '48911112222', 'PF', 'Ricardo Souza', '99988877766', NULL, NULL, NULL);

-- 6. ENDEREÇOS (mais variedade)
INSERT INTO Enderecos (id_cliente, cep, logradouro, numero, bairro, cidade, estado, is_principal) VALUES
(1, '01001-000', 'Praça da Sé', '100', 'Sé', 'São Paulo', 'SP', TRUE),
(1, '20040-004', 'Avenida Rio Branco', '156', 'Centro', 'Rio de Janeiro', 'RJ', FALSE),
(2, '45653-005', 'Avenida Soares Lopes', '1500', 'Centro', 'Ilhéus', 'BA', TRUE),
(3, '80050-350', 'Avenida Sete de Setembro', '2775', 'Rebouças', 'Curitiba', 'PR', TRUE),
(4, '30112-010', 'Avenida do Contorno', '2000', 'Floresta', 'Belo Horizonte', 'MG', TRUE),
(5, '22290-160', 'Avenida Pasteur', '300', 'Urca', 'Rio de Janeiro', 'RJ', TRUE),
(6, '88015-200', 'Avenida Hercílio Luz', '500', 'Centro', 'Florianópolis', 'SC', TRUE);

-- 7. PRODUTOS (mais produtos e de todos vendedores)
INSERT INTO Produtos (id_produto, id_vendedor, nome, sku, descricao, preco, quantidade_estoque) VALUES
(1, 1, 'Smartphone X-Pro 128GB', 'SPXP128', 'Smartphone de última geração com câmera tripla.', 2999.90, 0),
(2, 1, 'Fone de Ouvido Sem Fio Z', 'FOSFZ', 'Fone com cancelamento de ruído e bateria de 24h.', 499.50, 0),
(3, 1, 'Carregador Rápido USB-C 30W', 'CRUSBC30', 'Carregador compatível com diversos dispositivos.', 150.00, 0),
(4, 1, 'Notebook Gamer Fire V2', 'NTFGV2', 'Notebook com placa de vídeo dedicada RTX 4080.', 9500.00, 0),
(5, 1, 'Mouse Sem Fio Ergonômico', 'MSFE01', 'Mouse com design vertical para maior conforto.', 220.00, 0),
(6, 2, 'Jogo de Toalhas Premium (5 peças)', 'JTPE5P', 'Toalhas 100% algodão egípcio.', 250.00, 0),
(7, 2, 'Capa de Almofada Decorativa', 'CALMD', 'Capa de almofada em linho, 45x45cm.', 89.90, 0),
(8, 2, 'Vaso Decorativo de Cerâmica', 'VADEC', 'Vaso para plantas de porte médio, cor terracota.', 120.00, 0),
(9, 3, 'Whey Protein Concentrado 900g', 'WPC900', 'Sabor chocolate, 25g de proteína por dose.', 180.00, 0),
(10, 3, 'Creatina Monohidratada 300g', 'CM300', 'Creatina pura para aumento de força e performance.', 95.00, 0);

-- 8. PRODUTOS E CATEGORIAS (junção)
INSERT INTO Produtos_Categorias (id_produto, id_categoria) VALUES
(1, 1), (1, 4), (2, 1), (2, 5), (3, 1), (3, 5), (4, 1), (4, 6), (5, 1), (5, 5),
(6, 2), (6, 7), (7, 2), (7, 8), (8, 2), (8, 8), (9, 3), (9, 9), (10, 3), (10, 9);

-- 9. PRODUTOS E FORNECEDORES (junção)
INSERT INTO Produtos_Fornecedores (id_produto, id_fornecedor, custo_aquisicao) VALUES
(1, 1, 1800.00), (2, 1, 250.00), (3, 1, 70.00), (4, 1, 6500.00), (5, 1, 110.00),
(6, 2, 120.00), (7, 2, 40.00), (8, 2, 65.00), (9, 3, 90.00), (10, 3, 45.00);

-- 10. PEDIDOS (mais pedidos, datas variadas, status diferentes)
-- Pedido 1: Ana Silva, Julho. Entregue.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete, codigo_rastreio) VALUES
(1, 1, 1, 1, '2025-07-15 10:30:00', 'Entregue', 3149.90, 25.50, 'BR111111111BR');
-- Pedido 2: Bruno Costa, Agosto. Enviado.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete, codigo_rastreio) VALUES
(2, 2, 3, 3, '2025-08-02 14:00:00', 'Enviado', 749.50, 35.80, 'BR222222222BR');
-- Pedido 3: Soluções TI, Agosto. Entregue.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete, codigo_rastreio) VALUES
(3, 3, 4, 2, '2025-08-10 09:00:00', 'Entregue', 1500.00, 55.00, 'BR333333333BR');
-- Pedido 4: Ana Silva, Agosto. Cancelado.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete) VALUES
(4, 1, 2, 1, '2025-08-11 11:45:00', 'Cancelado', 89.90, 15.00);
-- Pedido 5: Ricardo Souza, Setembro. Pagamento Confirmado.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete) VALUES
(5, 6, 6, 1, '2025-09-01 20:10:00', 'Pagamento Confirmado', 719.50, 22.00);
-- Pedido 6: Carla Mendes, Setembro. Enviado.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete, codigo_rastreio) VALUES
(6, 4, 5, 3, '2025-09-05 13:00:00', 'Enviado', 275.00, 18.50, 'BR666666666BR');
-- Pedido 7: Ana Silva, Setembro. Recompra. Entregue.
INSERT INTO Pedidos (id_pedido, id_cliente, id_endereco_entrega, id_metodo_pagamento, data_pedido, status, valor_produtos, valor_frete, codigo_rastreio) VALUES
(7, 1, 1, 1, '2025-09-10 18:00:00', 'Entregue', 120.00, 12.30, 'BR777777777BR');

-- 11. ITENS DO PEDIDO (junção)
INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 2999.90), (1, 3, 1, 150.00), -- Pedido 1
(2, 2, 1, 499.50), (2, 6, 1, 250.00),  -- Pedido 2
(3, 3, 10, 150.00),                     -- Pedido 3
(5, 2, 1, 499.50), (5, 5, 1, 220.00),  -- Pedido 5
(6, 9, 1, 180.00), (6, 10, 1, 95.00),  -- Pedido 6
(7, 8, 1, 120.00);                      -- Pedido 7

-- 12. AVALIAÇÕES (mais variedade)
INSERT INTO Avaliacoes (id_produto, id_cliente, pontuacao, comentario) VALUES
(1, 1, 5, 'Celular excelente, câmera incrível e bateria dura o dia todo! Recomendo.'),
(2, 2, 4, 'O fone é ótimo, cancelamento de ruído funciona bem, mas poderia ser mais confortável.'),
(3, 3, 5, 'Compramos 10 unidades para a empresa e todos funcionam perfeitamente.'),
(5, 6, 3, 'Mouse bom, mas a bateria não dura tanto quanto o prometido.'),
(8, 1, 5, 'Vaso lindo, ficou perfeito na minha sala. Exatamente como na foto.');

-- 13. MOVIMENTAÇÕES DE ESTOQUE
-- Entradas iniciais dos fornecedores
INSERT INTO Movimentacoes_Estoque (id_produto, tipo, quantidade, id_fornecedor, observacao) VALUES
(1, 'ENTRADA', 100, 1, 'Recebimento NF #1001'), (2, 'ENTRADA', 200, 1, 'Recebimento NF #1002'),
(3, 'ENTRADA', 300, 1, 'Recebimento NF #1003'), (4, 'ENTRADA', 20, 1, 'Recebimento NF #1004'),
(5, 'ENTRADA', 150, 1, 'Recebimento NF #1005'), (6, 'ENTRADA', 50, 2, 'Recebimento NF #2001'),
(7, 'ENTRADA', 150, 2, 'Recebimento NF #2002'), (8, 'ENTRADA', 80, 2, 'Recebimento NF #2003'),
(9, 'ENTRADA', 250, 3, 'Recebimento NF #3001'), (10, 'ENTRADA', 500, 3, 'Recebimento NF #3002');
-- Saídas baseadas nos pedidos (NÃO INCLUI O PEDIDO CANCELADO #4)
INSERT INTO Movimentacoes_Estoque (id_produto, tipo, quantidade, id_pedido, observacao) VALUES
(1, 'SAIDA', 1, 1, 'Venda Pedido #1'), (3, 'SAIDA', 1, 1, 'Venda Pedido #1'),
(2, 'SAIDA', 1, 2, 'Venda Pedido #2'), (6, 'SAIDA', 1, 2, 'Venda Pedido #2'),
(3, 'SAIDA', 10, 3, 'Venda Pedido #3'),
(2, 'SAIDA', 1, 5, 'Venda Pedido #5'), (5, 'SAIDA', 1, 5, 'Venda Pedido #5'),
(9, 'SAIDA', 1, 6, 'Venda Pedido #6'), (10, 'SAIDA', 1, 6, 'Venda Pedido #6'),
(8, 'SAIDA', 1, 7, 'Venda Pedido #7');

-- 14. SINCRONIZANDO O ESTOQUE RESUMO
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 1) WHERE id_produto = 1;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 2) WHERE id_produto = 2;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 3) WHERE id_produto = 3;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 4) WHERE id_produto = 4;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 5) WHERE id_produto = 5;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 6) WHERE id_produto = 6;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 7) WHERE id_produto = 7;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 8) WHERE id_produto = 8;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 9) WHERE id_produto = 9;
UPDATE Produtos SET quantidade_estoque = (SELECT SUM(CASE WHEN tipo = 'ENTRADA' THEN quantidade ELSE -quantidade END) FROM Movimentacoes_Estoque WHERE id_produto = 10) WHERE id_produto = 10;

COMMIT;

SELECT 'Nova carga de dados abrangente inserida com sucesso!' AS status;

-- REALIZANDO ALGUMAS QUERIES

-- 1. ATUALMENTE QUANTOS CLIENTES SÃO TIPO PJ E QUANTOS SÃO PF?
SELECT tipo, COUNT(tipo)
FROM Clientes
GROUP BY (tipo);

-- 2. QUANTOS PEDIDOS FORAM FEITOS POR CADA CLIENTE?
SELECT
	c.id_cliente,
    COALESCE(c.nome, c.razao_social) AS nome_cliente, -- para lidar com clientes pj e pf: retorna o primeiro valor não nulo da lista informada
    COUNT(p.id_pedido) AS total_pedidos
FROM Clientes AS c
LEFT JOIN Pedidos AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, nome_cliente
ORDER BY total_pedidos;

-- 3. QUAL O VALOR TOTAL DOS PEDIDOS DE CADA CLIENTE?
SELECT
	c.id_cliente,
    COALESCE(c.nome, c.razao_social) AS nome_cliente,
    SUM(valor_produtos) AS valor_total
FROM Clientes AS c
LEFT JOIN PEDIDOS AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, nome_cliente
ORDER BY valor_total;

-- 4. UNA AS DUAS QUERIES ACIMA EM UMA SÓ
SELECT
	c.id_cliente,
    COALESCE(c.nome, c.razao_social) AS nome_cliente,
    COUNT(*) AS total_pedidos,
    SUM(valor_produtos) AS valor_total
FROM Clientes AS c
LEFT JOIN PEDIDOS AS p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, nome_cliente
ORDER BY valor_total;

-- 5. QUAL O TOTAL VENDIDO POR CADA VENDEDOR
SELECT
	v.nome_fantasia AS Vendedor,
    SUM(ip.quantidade * ip.preco_unitario) AS total_vendido
FROM Itens_pedido AS ip
JOIN Produtos AS p ON ip.id_produto = p.id_produto
JOIN Vendedores AS v ON p.id_vendedor = v.id_vendedor -- se parasse aqui teriamos quanto foi vendido, sem considerar algum pedido cancelado
JOIN Pedidos AS ped ON ip.id_pedido = ped.id_pedido
WHERE ped.status <> 'Cancelado'
GROUP BY v.nome_fantasia;

-- 6. QUAL O FATURAMENTO TOTAL DE PEDIDOS CONFIRMADOS?
SELECT SUM(valor_produtos + valor_frete) AS faturamento
FROM Pedidos
WHERE status <> 'Cancelado';

-- 7. QUAL O FATURAMENTO POR MÊS?
SELECT
	YEAR(data_pedido) AS ano,
    MONTH(data_pedido) AS mes,
    SUM(valor_produtos + valor_frete) AS faturamento_mensal
FROM Pedidos
WHERE status <> 'Cancelado'
GROUP BY ano, mes
ORDER BY ano, mes;

-- 8. QUAL VENDEDOR TEM PRODUTOS COM MELHOR AVALIAÇÃO MÉDIA?
SELECT
	v.nome_fantasia AS Vendedor,
    AVG(a.pontuacao) AS media_avaliacoes
FROM Vendedores AS v
JOIN Produtos AS p ON v.id_vendedor = p.id_vendedor
JOIN Avaliacoes AS a ON p.id_produto = a.id_produto
GROUP BY v.nome_fantasia
ORDER BY media_avaliacoes DESC;

-- 9. QUAIS PRODUTOS NUNCA FORAM VENDIDOS?
SELECT
	p.id_produto,
    p.nome,
    p.preco
FROM Produtos p
LEFT JOIN Itens_pedido AS ip ON p.id_produto = ip.id_produto
WHERE ip.id_pedido IS NULL; -- o notebook gamer pode ser mto caro e a capa talvez seja cafona, será?

-- 10. Quais produtos estão com estoque baixo ? Menos de 50 produtos?
SELECT
	nome,
    quantidade_estoque
FROM Produtos
WHERE quantidade_estoque < 50
ORDER BY quantidade_estoque ASC;


