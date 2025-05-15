CREATE TABLE `Tipo_Usuario` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) NOT NULL,
  `descricao` varchar(255)
);

CREATE TABLE `Usuario_Comum` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `sobrenome` varchar(255) NOT NULL,
  `cpf` varchar(255) UNIQUE NOT NULL,
  `data_nascimento` date NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `senha` varchar(255) NOT NULL,
  `endereco` varchar(255),
  `id_tipo` int NOT NULL
);

CREATE TABLE `Usuario_Juridico` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome_fantasia` varchar(255) NOT NULL,
  `razao_social` varchar(255) NOT NULL,
  `cnpj` varchar(255) UNIQUE NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `telefone` varchar(255) NOT NULL,
  `id_tipo` int NOT NULL
);

CREATE TABLE `Forma_Pagamento` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) NOT NULL,
  `descricao` varchar(255)
);

CREATE TABLE `Pix` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `chave_pix` varchar(255) NOT NULL,
  `data_pagamento` datetime,
  `id_forma_pagamento` int NOT NULL
);

CREATE TABLE `Boleto` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `codigo_boleto` varchar(255) NOT NULL,
  `vencimento` date NOT NULL,
  `pago` date,
  `id_forma_pagamento` int NOT NULL
);

CREATE TABLE `Cartao` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `numero_cartao` varchar(255) NOT NULL,
  `nome_titular` varchar(255) NOT NULL,
  `validade` date NOT NULL,
  `bandeira` varchar(255) NOT NULL,
  `tipo_cartao` bool NOT NULL,
  `id_forma_pagamento` int NOT NULL
);

CREATE TABLE `Pedidos` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `valor_total` float NOT NULL,
  `endereco_entrega` varchar(255) NOT NULL,
  `id_usuario` int NOT NULL,
  `id_forma_pagamento` int NOT NULL
);

CREATE TABLE `Produtos` (
  `id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `marca` varchar(255) NOT NULL,
  `modelo` varchar(255) NOT NULL,
  `quantidade` int NOT NULL,
  `preco` float NOT NULL,
  `descricao` varchar(255)
);

CREATE TABLE `Pedido_Produto` (
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unitario` float NOT NULL,
  `valor_total` float NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_produto`)
);

ALTER TABLE `Usuario_Comum` ADD FOREIGN KEY (`id_tipo`) REFERENCES `Tipo_Usuario` (`id`);

ALTER TABLE `Usuario_Juridico` ADD FOREIGN KEY (`id_tipo`) REFERENCES `Tipo_Usuario` (`id`);

ALTER TABLE `Pix` ADD FOREIGN KEY (`id_forma_pagamento`) REFERENCES `Forma_Pagamento` (`id`);

ALTER TABLE `Boleto` ADD FOREIGN KEY (`id_forma_pagamento`) REFERENCES `Forma_Pagamento` (`id`);

ALTER TABLE `Cartao` ADD FOREIGN KEY (`id_forma_pagamento`) REFERENCES `Forma_Pagamento` (`id`);

ALTER TABLE `Pedidos` ADD FOREIGN KEY (`id_usuario`) REFERENCES `Usuario_Comum` (`id`);

ALTER TABLE `Pedido_Produto` ADD FOREIGN KEY (`id_pedido`) REFERENCES `Pedidos` (`id`);

ALTER TABLE `Pedidos` ADD FOREIGN KEY (`id_forma_pagamento`) REFERENCES `Forma_Pagamento` (`id`);


ALTER TABLE `Pedido_Produto` ADD FOREIGN KEY (`id_produto`) REFERENCES `Produtos` (`id`);
