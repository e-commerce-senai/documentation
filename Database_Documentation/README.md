# 🛒 E-commerce Database

Este repositório contém o modelo de banco de dados para um sistema de e-commerce, estruturado para gerenciar usuários, produtos, pedidos e formas de pagamento.

## 📐 Estrutura do Banco de Dados

A base de dados foi modelada para contemplar diferentes tipos de usuários (comum e jurídico), formas de pagamento variadas (Pix, boleto e cartão), além do controle completo de pedidos e produtos.

---

### 🧑‍💼 Tabela `Tipo_Usuario`

Armazena os tipos de usuários (por exemplo, consumidor comum ou pessoa jurídica).

| Coluna     | Tipo     | Descrição                       |
|------------|----------|---------------------------------|
| id         | int      | Chave primária, auto incremento |
| tipo       | varchar  | Tipo de usuário                 |
| descricao  | varchar  | Descrição do tipo (opcional)    |

---

### 👤 Tabela `Usuario_Comum`

Contém os dados de usuários pessoas físicas.

| Coluna          | Tipo     | Descrição                       |
|------------------|----------|---------------------------------|
| id               | int      | Chave primária, auto incremento |
| nome             | varchar  | Nome do usuário                 |
| sobrenome        | varchar  | Sobrenome do usuário            |
| cpf              | varchar  | CPF (único)                     |
| data_nascimento  | date     | Data de nascimento              |
| email            | varchar  | E-mail (único)                  |
| senha            | varchar  | Senha do usuário                |
| endereco         | varchar  | Endereço (opcional)             |
| id_tipo          | int      | Relacionamento com `Tipo_Usuario` |

---

### 🏢 Tabela `Usuario_Juridico`

Contém os dados de usuários pessoas jurídicas.

| Coluna        | Tipo     | Descrição                       |
|----------------|----------|---------------------------------|
| id             | int      | Chave primária, auto incremento |
| nome_fantasia  | varchar  | Nome fantasia                   |
| razao_social   | varchar  | Razão social                    |
| cnpj           | varchar  | CNPJ (único)                    |
| endereco       | varchar  | Endereço                        |
| email          | varchar  | E-mail (único)                  |
| telefone       | varchar  | Telefone                        |
| id_tipo        | int      | Relacionamento com `Tipo_Usuario` |

---

### 💳 Tabela `Forma_Pagamento`

Define os métodos disponíveis para pagamento.

| Coluna     | Tipo     | Descrição                       |
|------------|----------|---------------------------------|
| id         | int      | Chave primária, auto incremento |
| tipo       | varchar  | Tipo (Pix, Boleto, Cartão)      |
| descricao  | varchar  | Descrição do método (opcional)  |

---

### 💸 Tabelas de Detalhamento de Pagamento

#### `Pix`

| Coluna            | Tipo     | Descrição                                |
|-------------------|----------|------------------------------------------|
| id                | int      | Chave primária, auto incremento          |
| chave_pix         | varchar  | Chave Pix utilizada                      |
| data_pagamento    | datetime | Data do pagamento (opcional)            |
| id_forma_pagamento| int      | FK para `Forma_Pagamento`               |

#### `Boleto`

| Coluna            | Tipo     | Descrição                                |
|-------------------|----------|------------------------------------------|
| id                | int      | Chave primária, auto incremento          |
| codigo_boleto     | varchar  | Código do boleto                         |
| vencimento        | date     | Data de vencimento                       |
| pago              | date     | Data de pagamento (opcional)            |
| id_forma_pagamento| int      | FK para `Forma_Pagamento`               |

#### `Cartao`

| Coluna            | Tipo     | Descrição                                |
|-------------------|----------|------------------------------------------|
| id                | int      | Chave primária, auto incremento          |
| numero_cartao     | varchar  | Número do cartão                         |
| nome_titular      | varchar  | Nome do titular                          |
| validade          | date     | Data de validade                         |
| bandeira          | varchar  | Bandeira do cartão                       |
| tipo_cartao       | bool     | Tipo: Débito (0) ou Crédito (1)         |
| id_forma_pagamento| int      | FK para `Forma_Pagamento`               |

---

### 📦 Tabela `Produtos`

Armazena os produtos disponíveis na plataforma.

| Coluna     | Tipo     | Descrição                       |
|------------|----------|---------------------------------|
| id         | int      | Chave primária, auto incremento |
| nome       | varchar  | Nome do produto                 |
| marca      | varchar  | Marca                           |
| modelo     | varchar  | Modelo                          |
| quantidade | int      | Estoque disponível              |
| preco      | float    | Preço unitário                  |
| descricao  | varchar  | Descrição (opcional)            |

---

### 📑 Tabela `Pedidos`

Controla os pedidos realizados pelos usuários.

| Coluna            | Tipo     | Descrição                        |
|-------------------|----------|----------------------------------|
| id                | int      | Chave primária, auto incremento |
| valor_total       | float    | Valor total do pedido           |
| endereco_entrega  | varchar  | Endereço de entrega             |
| id_usuario        | int      | FK para `Usuario_Comum`         |
| id_forma_pagamento| int      | FK para `Forma_Pagamento`       |

---

### 📦📑 Tabela `Pedido_Produto`

Tabela intermediária que representa os itens de um pedido.

| Coluna         | Tipo   | Descrição                          |
|----------------|--------|------------------------------------|
| id_pedido      | int    | FK para `Pedidos` (PK composta)    |
| id_produto     | int    | FK para `Produtos` (PK composta)   |
| quantidade     | int    | Quantidade de produtos             |
| valor_unitario | float  | Valor unitário no momento da venda |
| valor_total    | float  | Total do item (quantidade × valor) |

---

## 🔗 Relacionamentos

- `Usuario_Comum` e `Usuario_Juridico` referenciam `Tipo_Usuario`.
- `Pedidos` referenciam `Usuario_Comum` e `Forma_Pagamento`.
- `Pix`, `Boleto` e `Cartao` referenciam `Forma_Pagamento`.
- `Pedido_Produto` referencia `Pedidos` e `Produtos`.

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** PostgreSQL ou MySQL
- **Ferramenta de modelagem:** dbdiagram.io & MySQL Workbench
- **Script de criação:** disponível em breve na pasta `/scripts`
