# 🛒 E-commerce Database

Este repositório contém o modelo de banco de dados relacional para um sistema de e-commerce. A estrutura foi projetada para gerenciar diferentes tipos de usuários (comum e jurídico), formas de pagamento (Pix, Boleto, Cartão), além do controle de produtos, pedidos e itens comprados.

Modelo visual: [dbdiagram.io](https://dbdiagram.io/d/Projeto-Pet-Senai-6824d5045b2fc4582f9f8c42)

---

## 📐 Estrutura Geral

A modelagem contempla:

- Usuários comuns (pessoas físicas) e usuários jurídicos (empresas)
- Detalhamento das formas de pagamento (Pix, Boleto, Cartão)
- Catálogo de produtos com estoque e descrição
- Pedidos com múltiplos itens e vínculo com o usuário e forma de pagamento
- Relacionamentos explícitos entre tabelas para manter integridade

---

## 📊 Tabelas e Colunas

### 👤 `Usuario_Comum`

| Coluna          | Tipo         | Restrições                         |
|-----------------|--------------|------------------------------------|
| id              | int          | PK, auto incremento, not null      |
| nome            | varchar      | not null                           |
| sobrenome       | varchar      | not null                           |
| cpf             | varchar      | not null, único                    |
| data_nascimento | date         | not null                           |
| email           | varchar      | not null, único                    |
| senha           | varchar      | not null                           |
| endereco        | varchar      | opcional                           |

---

### 🏢 `Usuario_Juridico`

| Coluna         | Tipo     | Restrições                       |
|----------------|----------|----------------------------------|
| id             | int      | PK, auto incremento, not null    |
| id_responsavel | int      | FK → `Usuario_Comum(id)`         |
| nome_fantasia  | varchar  | not null                         |
| razao_social   | varchar  | not null                         |
| cnpj           | varchar  | not null, único                  |
| endereco       | varchar  | not null                         |
| email          | varchar  | not null, único                  |
| telefone       | varchar  | not null                         |

---

## 💳 `Forma_Pagamento`

| Coluna     | Tipo     | Restrições         |
|------------|----------|--------------------|
| id         | int      | PK, auto incremento|
| tipo       | varchar  | not null           |
| descricao  | varchar  | opcional           |

---

### 💸 Tabelas Específicas de Pagamento

#### `Pix`

| Coluna             | Tipo       | Restrições                     |
|--------------------|------------|--------------------------------|
| id                 | int        | PK, auto incremento            |
| chave_pix          | varchar    | not null                       |
| data_pagamento     | datetime   | opcional                       |
| id_forma_pagamento | int        | FK → `Forma_Pagamento(id)`     |

#### `Boleto`

| Coluna             | Tipo     | Restrições                     |
|--------------------|----------|--------------------------------|
| id                 | int      | PK, auto incremento            |
| codigo_boleto      | varchar  | not null                       |
| vencimento         | date     | not null                       |
| pago               | date     | opcional                       |
| id_forma_pagamento | int      | FK → `Forma_Pagamento(id)`     |

#### `Cartao`

| Coluna             | Tipo     | Restrições                     |
|--------------------|----------|--------------------------------|
| id                 | int      | PK, auto incremento            |
| numero_cartao      | varchar  | not null                       |
| nome_titular       | varchar  | not null                       |
| validade           | date     | not null                       |
| bandeira           | varchar  | not null                       |
| tipo_cartao        | boolean  | not null (0 = Débito, 1 = Crédito) |
| id_forma_pagamento | int      | FK → `Forma_Pagamento(id)`     |

---

### 📦 `Produtos`

| Coluna     | Tipo     | Restrições                    |
|------------|----------|-------------------------------|
| id         | int      | PK, auto incremento           |
| nome       | varchar  | not null                      |
| marca      | varchar  | not null                      |
| modelo     | varchar  | not null                      |
| quantidade | int      | not null (controle de estoque)|
| preco      | float    | not null                      |
| descricao  | varchar  | opcional                      |

---

### 📑 `Pedidos`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id                 | int      | PK, auto incremento                   |
| valor_total        | float    | not null                              |
| endereco_entrega   | varchar  | not null                              |
| id_usuario         | int      | FK → `Usuario_Comum(id)`              |
| id_forma_pagamento | int      | FK → `Forma_Pagamento(id)`            |

---

### 🔗 `Pedido_Produto`

| Coluna         | Tipo   | Restrições                                  |
|----------------|--------|---------------------------------------------|
| id_pedido      | int    | PK, FK → `Pedidos(id)`                      |
| id_produto     | int    | PK, FK → `Produtos(id)`                     |
| quantidade     | int    | not null                                    |
| valor_unitario | float  | not null (valor no momento da compra)       |
| valor_total    | float  | not null (subtotal do item)                 |

---

## 🔗 Relacionamentos

- `Usuario_Juridico.id_responsavel` → `Usuario_Comum.id`
- `Pedidos.id_usuario` → `Usuario_Comum.id`
- `Pedidos.id_forma_pagamento` → `Forma_Pagamento.id`
- `Pix`, `Boleto`, `Cartao` → `Forma_Pagamento.id`
- `Pedido_Produto.id_pedido` → `Pedidos.id`
- `Pedido_Produto.id_produto` → `Produtos.id`

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** MySQL
- **Modelagem:** dbdiagram.io, MySQL Workbench
- **Script SQL:** disponível na pasta `/scripts`
