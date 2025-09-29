-- DESENVOLVIMENTO DE UM BANCO DE DADOS PARA UM E-COMMERCE MARKETPLACE

CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- CRIAÇÃO DAS TABELAS

-- 1. VENDEDORES
CREATE TABLE Vendedores (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    cnpj CHAR(14) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_vendedores_cnpj UNIQUE (cnpj),
    CONSTRAINT uq_vendedores_email UNIQUE (email)
);

-- 2. FORNECEDORES
CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    contato_nome VARCHAR(100),
    email VARCHAR(255),
    telefone VARCHAR(20),
    CONSTRAINT uq_fornecedores_cnpj UNIQUE (cnpj)
);

-- 3. CLIENTES
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    tipo CHAR(2) NOT NULL,
    nome VARCHAR(255),
    cpf CHAR(11),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    cnpj CHAR(14),
    CONSTRAINT uq_clientes_email UNIQUE (email),
    CONSTRAINT uq_clientes_cpf UNIQUE (cpf),
    CONSTRAINT uq_clientes_cnpj UNIQUE (cnpj),
    CONSTRAINT chk_clientes_tipo CHECK (
        (tipo = 'PF' AND nome IS NOT NULL AND cpf IS NOT NULL AND cnpj IS NULL AND razao_social IS NULL) OR
        (tipo = 'PJ' AND cnpj IS NOT NULL AND razao_social IS NOT NULL AND cpf IS NULL AND nome IS NULL)
    )
);

-- 4. CATEGORIAS
CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    id_categoria_pai INT,
    CONSTRAINT uq_categorias_nome UNIQUE (nome),
    CONSTRAINT fk_categorias_pai FOREIGN KEY (id_categoria_pai) REFERENCES Categorias(id_categoria)
);
    
-- 5. PRODUTOS
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_vendedor INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sku VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0, -- Quantidade de "acesso rápido"
    url_imagem_principal VARCHAR(255),
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_produtos_sku UNIQUE (sku),
    CONSTRAINT fk_produtos_vendedores FOREIGN KEY (id_vendedor) REFERENCES Vendedores(id_vendedor)
);

-- 6. PRODUTOS E FORNECEDORES (Junção)
CREATE TABLE Produtos_Fornecedores (
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    custo_aquisicao DECIMAL(10, 2) NOT NULL,
    data_ultima_compra DATE,
    PRIMARY KEY (id_produto, id_fornecedor),
    CONSTRAINT fk_prod_forn_produtos FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    CONSTRAINT fk_prod_forn_fornecedores FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

-- 7. MOVIMENTAÇÕES DE ESTOQUE
CREATE TABLE Movimentacoes_Estoque (
    id_movimentacao INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo ENUM('ENTRADA', 'SAIDA', 'AJUSTE') NOT NULL,
    quantidade INT NOT NULL,
    id_pedido INT,
    id_fornecedor INT,
    observacao VARCHAR(255),
    CONSTRAINT fk_mov_estoque_produtos FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- 8. PRODUTOS E CATEGORIAS (Junção)
CREATE TABLE Produtos_Categorias (
    id_produto INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_produto, id_categoria),
    CONSTRAINT fk_prod_cat_produtos FOREIGN KEY (id_produto) REFERENCES Produtos (id_produto) ON DELETE CASCADE,
    CONSTRAINT fk_prod_cat_categorias FOREIGN KEY (id_categoria) REFERENCES Categorias (id_categoria) ON DELETE CASCADE
);

-- 9. AVALIAÇÕES DE PRODUTOS
CREATE TABLE Avaliacoes (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    pontuacao INT NOT NULL,
    comentario TEXT,
    data_avaliacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_avaliacoes_produtos FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) ON DELETE CASCADE,
    CONSTRAINT fk_avaliacoes_clientes FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    CONSTRAINT chk_avaliacoes_pontuacao CHECK (pontuacao >= 1 AND pontuacao <= 5)
);

-- 10. ENDEREÇOS
CREATE TABLE Enderecos (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    is_principal BOOLEAN DEFAULT false,
    CONSTRAINT fk_enderecos_clientes FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);

-- 11. MÉTODOS DE PAGAMENTO
CREATE TABLE Metodos_Pagamento (
    id_metodo_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    permite_salvar BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT uq_metodos_pagamento_nome UNIQUE (nome)
);

-- 12. FORMAS DE PAGAMENTO SALVAS PELO CLIENTE
CREATE TABLE Cliente_Formas_Pagamento (
    id_cliente_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_metodo_pagamento INT NOT NULL,
    apelido VARCHAR(50),
    detalhes_visuais VARCHAR(100) NOT NULL,
    token_provedor_pagamento VARCHAR(255) NOT NULL,
    is_principal BOOLEAN NOT NULL DEFAULT FALSE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cliente_fp_clientes FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE,
    CONSTRAINT fk_cliente_fp_metodos FOREIGN KEY (id_metodo_pagamento) REFERENCES Metodos_Pagamento(id_metodo_pagamento)
);

-- 13. PEDIDOS
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_endereco_entrega INT NOT NULL,
    id_metodo_pagamento INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Aguardando Pagamento', 'Pagamento Confirmado', 'Em Separação', 'Enviado', 'Entregue', 'Cancelado') NOT NULL DEFAULT 'Aguardando Pagamento',
    observacao TEXT,
    valor_produtos DECIMAL(10, 2) NOT NULL,
    valor_frete DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    codigo_rastreio VARCHAR(100),
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente),
    CONSTRAINT fk_pedidos_enderecos FOREIGN KEY (id_endereco_entrega) REFERENCES Enderecos(id_endereco),
    CONSTRAINT fk_pedidos_metodos_pagamento FOREIGN KEY (id_metodo_pagamento) REFERENCES Metodos_Pagamento (id_metodo_pagamento)
);

-- 14. ITENS DO PEDIDO (Junção)
CREATE TABLE Itens_Pedido (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_itens_pedido_pedidos FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    CONSTRAINT fk_itens_pedido_produtos FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- O QUE PODE SER ADICIONADO FUTURAMENTE?
-- TABELA RELACIONANDO O USO DE CUPONS, LISTA DE DESEJOS, LOGISTICA DE FRETE, DEVOLUÇÕES E TROCAS