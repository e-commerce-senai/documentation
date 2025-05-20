# 🛒 E-commerce Database

Este repositório contém o modelo de banco de dados relacional para um sistema de e-commerce. A estrutura foi projetada para gerenciar diferentes tipos de usuários (comum e jurídico), diversas formas de pagamento (Pix, boleto, cartão), bem como o controle de produtos, pedidos e seus respectivos itens.

Modelo(Link): https://dbdiagram.io/d/Projeto-Pet-Senai-6824d5045b2fc4582f9f8c42

---

## 📐 Estrutura Geral

A modelagem contempla:

- Tipos distintos de usuários (físico e jurídico)
- Detalhamento individual de formas de pagamento
- Produtos com estoque e descrição
- Pedidos realizados com múltiplos itens

---

## 📊 Tabelas e Colunas

### 🧑‍💼 `Tipo_Usuario`
Define o tipo de cadastro do usuário.

| Coluna     | Tipo         | Descrição                            |
|------------|--------------|--------------------------------------|
| id         | int (PK)     | Chave primária (auto incremento)     |
| tipo       | varchar(255) | Tipo de usuário (ex: comum, jurídico)|
| descricao  | varchar(255) | Descrição adicional (opcional)       |

---

### 👤 `Usuario_Comum`
Dados de usuários pessoas físicas.

| Coluna          | Tipo         | Descrição                           |
|-----------------|--------------|-------------------------------------|
| id              | int (PK)     | Chave primária                      |
| nome            | varchar(255) | Nome do usuário                     |
| sobrenome       | varchar(255) | Sobrenome                           |
| cpf             | varchar(255) | CPF (único)                         |
| data_nascimento | date         | Data de nascimento                  |
| email           | varchar(255) | E-mail (único)                      |
| senha           | varchar(255) | Senha de acesso                     |
| endereco        | varchar(255) | Endereço (opcional)                 |
| id_tipo         | int (FK)     | Referência a `Tipo_Usuario`         |

---

### 🏢 `Usuario_Juridico`
Dados de empresas (pessoas jurídicas).

| Coluna        | Tipo         | Descrição                           |
|---------------|--------------|-------------------------------------|
| id            | int (PK)     | Chave primária                      |
| nome_fantasia | varchar(255) | Nome fantasia                       |
| razao_social  | varchar(255) | Razão social                        |
| cnpj          | varchar(255) | CNPJ (único)                        |
| endereco      | varchar(255) | Endereço                            |
| email         | varchar(255) | E-mail (único)                      |
| telefone      | varchar(255) | Telefone de contato                 |
| id_tipo       | int (FK)     | Referência a `Tipo_Usuario`         |

---

### 💳 `Forma_Pagamento`
Métodos disponíveis para pagamento.

| Coluna     | Tipo         | Descrição                      |
|------------|--------------|-------------------------------|
| id         | int (PK)     | Chave primária                |
| tipo       | varchar(255) | Nome do tipo (Pix, Boleto etc.)|
| descricao  | varchar(255) | Descrição adicional (opcional)|

---

### 💸 Tabelas Específicas de Pagamento

#### `Pix`
| Coluna             | Tipo         | Descrição                             |
|--------------------|--------------|---------------------------------------|
| id                 | int (PK)     | Chave primária                        |
| chave_pix          | varchar(255) | Chave Pix                             |
| data_pagamento     | datetime     | Data do pagamento (opcional)          |
| id_forma_pagamento | int (FK)     | Referência a `Forma_Pagamento`        |

#### `Boleto`
| Coluna             | Tipo         | Descrição                             |
|--------------------|--------------|---------------------------------------|
| id                 | int (PK)     | Chave primária                        |
| codigo_boleto      | varchar(255) | Código identificador do boleto        |
| vencimento         | date         | Data de vencimento                    |
| pago               | date         | Data de pagamento (opcional)          |
| id_forma_pagamento | int (FK)     | Referência a `Forma_Pagamento`        |

#### `Cartao`
| Coluna             | Tipo         | Descrição                             |
|--------------------|--------------|---------------------------------------|
| id                 | int (PK)     | Chave primária                        |
| numero_cartao      | varchar(255) | Número do cartão                      |
| nome_titular       | varchar(255) | Nome do titular                       |
| validade           | date         | Validade                              |
| bandeira           | varchar(255) | Bandeira do cartão                    |
| tipo_cartao        | boolean      | Tipo: 0 (Débito), 1 (Crédito)         |
| id_forma_pagamento | int (FK)     | Referência a `Forma_Pagamento`        |

---

### 📦 `Produtos`
Catálogo de produtos disponíveis para venda.

| Coluna     | Tipo         | Descrição                       |
|------------|--------------|---------------------------------|
| id         | int (PK)     | Chave primária                  |
| nome       | varchar(255) | Nome do produto                 |
| marca      | varchar(255) | Marca                           |
| modelo     | varchar(255) | Modelo                          |
| quantidade | int          | Quantidade em estoque           |
| preco      | float        | Preço unitário                  |
| descricao  | varchar(255) | Descrição (opcional)            |

---

### 📑 `Pedidos`
Pedidos feitos por usuários comuns.

| Coluna             | Tipo         | Descrição                           |
|--------------------|--------------|-------------------------------------|
| id                 | int (PK)     | Chave primária                      |
| valor_total        | float        | Valor total do pedido               |
| endereco_entrega   | varchar(255) | Endereço de entrega                 |
| id_usuario         | int (FK)     | Referência a `Usuario_Comum`        |
| id_forma_pagamento | int (FK)     | Referência a `Forma_Pagamento`      |

---

### 🔗 `Pedido_Produto`
Relaciona pedidos aos produtos incluídos neles.

| Coluna         | Tipo   | Descrição                                   |
|----------------|--------|---------------------------------------------|
| id_pedido      | int    | FK para `Pedidos` (parte da PK composta)     |
| id_produto     | int    | FK para `Produtos` (parte da PK composta)    |
| quantidade     | int    | Quantidade adquirida                         |
| valor_unitario | float  | Valor unitário no momento da venda           |
| valor_total    | float  | Subtotal referente ao item                   |

---

## 🔗 Relacionamentos

- `Usuario_Comum` & `Usuario_Juridico` → `Tipo_Usuario`
- `Pedidos` → `Usuario_Comum`, `Forma_Pagamento`
- `Pix`, `Boleto`, `Cartao` → `Forma_Pagamento`
- `Pedido_Produto` → `Pedidos`, `Produtos`

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** MySQL
- **Modelagem:** dbdiagram.io, MySQL Workbench
- **Script SQL:** disponível na pasta `/scripts`
