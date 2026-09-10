-- TABELA USUARIOS --
CREATE TABLE IF NOT EXISTS usuarios (
    id INTERGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    usuario TEXT NOT NULL UNIQUE,
    senha hash TEXT NOT NULL,
    cargo TEXT NOT NULL CHECK (cargo IN ('administrador', 'vendedor')),
    ativo INTERGER NOT NULL DEFAULT 1,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABELA PRODUTOS --
CREATE TABLE IF NOT EXISTS produtos (
    id INTERGER PRIMARY KEY AUTOINCREMENT,
    codigo_barras TEXT NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    preco_custo REAL NOT NULL DEFAULT 0.0,
    preco_venda REAL NOT NULL DEFAULT 0.0,
    estoque INTERGER NOT NULL DEFAULT 0,
    ativo INTERGER NOT NULL DEFAULT 1,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABELA DE VENDAS --
CREATE TABLE IF NOT EXISTS vendas (
    id INTERGER PRIMARY KEY AUTOINCREMENT,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INTERGER NOT NULL,
    total REAL NOT NULL DEFAULT 0.0, -- Total da venda
    forma_pagamento TEXT NOT NULL DEFAULT 'dinheiro',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) --Chave Estrangeira   
);

-- TABELA ITENS VENDAS --
CREATE TABLE IF NOT EXISTS itens_venda (
    id INTERGER PRIMARY KEY AUTOINCREMENT,
    venda_id INTERGER NOT NULL,
    produto_id INTERGER NOT NULL,
    quantidade INTERGER NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

