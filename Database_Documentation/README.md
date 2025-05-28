# 🛒 E-commerce Database

Este repositório contém o modelo de banco de dados relacional para um sistema de e-commerce. A estrutura foi projetada para gerenciar diferentes tipos de usuários (comum e jurídico), formas de pagamento, além do controle de produtos, pedidos, categorias, estoque e itens comprados.

Modelo visual: [dbdiagram.io](https://dbdiagram.io/d/Copy-of-Projeto-Pet-Senai-6835fa3e6980ade2ebb56f3c)   
Modelo MER: [BRMW](https://app.brmodeloweb.com/#!/publicview/682cc88d93035ccef6cfa6fe)

---

## 📐 Estrutura Geral

A modelagem contempla:

- **Usuários comuns (pessoas físicas) e usuários jurídicos (empresas)**, com relacionamentos entre eles
- **Cliente** com dados de login específicos
- **Formas de pagamento**, incluindo Pix, Boleto e Cartão (comentado no modelo, mas ainda no planejamento)
- **Catálogo de produtos** com categorias, preços, estoque e descrição
- **Pedidos** com múltiplos itens, incluindo valor total, endereço de entrega e data do pedido
- **Estoque** com controle de quantidade e localização dos produtos
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

### 💳 `Forma_Pagamento`

| Coluna     | Tipo     | Restrições         |
|------------|----------|--------------------|
| id         | int      | PK, auto incremento|
| tipo       | varchar  | not null           |
| descricao  | varchar  | opcional           |

---

### 🧑‍💻 `Cliente`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id                 | int      | PK, auto incremento                   |
| id_usuario_comum   | int      | FK → `Usuario_Comum(id)`              |

---

### 📦 `Produtos`

| Coluna     | Tipo     | Restrições                    |
|------------|----------|-------------------------------|
| id         | int      | PK, auto incremento           |
| nome       | varchar  | not null                      |
| marca      | varchar  | not null                      |
| id_categoria | int    | FK → `Categorias(id)`         |
| id_usuario_juridico | int    | FK → `Usuario_Juridico(id)`         |
| preco      | float    | not null                      |
| descricao  | varchar  | opcional                      |

---

### 🛒 `Pedidos`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id                 | int      | PK, auto incremento                   |
| valor_total        | float    | not null                              |
| endereco_entrega   | varchar  | not null                              |
| data_pedido        | date     | not null                              |
| id_cliente         | int      | FK → `Cliente(id)`                    |
| id_forma_pagamento | int      | FK → `Forma_Pagamento(id)`            |

---

### 📝 `Item_Pedido`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id_pedido          | int      | PK, FK → `Pedidos(id)`                |
| id_produto         | int      | PK, FK → `Produtos(id)`               |
| quantidade         | int      | not null                              |
| valor_unitario     | float    | not null                              |
| valor_total        | float    | not null                              |

---

### 🏷️ `Categorias`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id                 | int      | PK, auto incremento                   |
| nome               | varchar  | not null                              |
| tipo_animal        | varchar  | not null                              |

---

### 🏭 `Estoque`

| Coluna             | Tipo     | Restrições                            |
|--------------------|----------|---------------------------------------|
| id                 | int      | PK, auto incremento                   |
| id_produto         | int      | FK → `Produtos(id)`                   |
| quantidade         | int      | not null                              |
| localizacao        | varchar  | opcional                              |

---

## 🔗 Relacionamentos

- `Usuario_Juridico.id_responsavel` → `Usuario_Comum.id`
- `Cliente.id_usuario_comum` → `Usuario_Comum.id`
- `Pedidos.id_cliente` → `Cliente.id`
- `Pedidos.id_forma_pagamento` → `Forma_Pagamento.id`
- `Item_Pedido.id_pedido` → `Pedidos.id`
- `Item_Pedido.id_produto` → `Produtos.id`
- `Produtos.id_categoria` → `Categorias.id`
- `Estoque.id_produto` → `Produtos.id`

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** MySQL
- **Modelagem:** dbdiagram.io, MySQL Workbench
- **Script SQL:** disponível na pasta `/scripts`

---
