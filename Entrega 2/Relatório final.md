# Entrega 2 — Modelo Lógico, Implementação SQL e Apresentação Final
## Projeto: Sistema de Gestão da Garagem Salles Estúdio Automotivo

## Integrantes

| Nome completo | RGM | Usuário GitHub |
|---|---|---|
| Raquel de Araujo Maciel Silva | RGM 49040120 | Raquel-Maciel |
| Isabel de Araujo Ferreira Maciel | RGM 49038940 | isabell426 |
| Luiz Alencar Silva Feitosa | RGM 49633996 | luizalencar08 |
| Vinicius Rodrigues de Brito | RGM 49475428 | Vini-vn |
| Gabriel de Araujo Ferreira Maciel | RGM 49038796 | gabrielmaciel1005 |

---

# 1. Relatório Técnico Final

## 1.1 Revisão do Modelo Conceitual

### Caracterização da Organização
* **Nome:** Garagem Salles Estúdio Automotivo.  
* **Natureza:** Empresa privada do segmento de serviços automotivos de pequeno porte.  
* **Contexto e Porte:** Estabelecimento com 3 funcionários, atendendo aproximadamente 10 veículos por dia (~300 atendimentos mensais). Atua com serviços de estética automotiva, lavagem e estacionamento, utilizando insumos da linha Vonixx e comercializando produtos acessórios com acréscimo de 30% sobre o custo de aquisição.  

### Problemas e Necessidades Identificados
* **P1 — Cadastro e histórico:** Necessidade de centralizar os dados de clientes e veículos e consultar o histórico de atendimentos.
* **P2 — Acompanhamento dos serviços:** Necessidade de acompanhar os serviços solicitados, seus itens, valores, responsáveis e situação.
* **P3 — Estacionamento:** Necessidade de registrar entrada, permanência e saída dos veículos, além dos valores cobrados quando aplicável.
* **P4 — Controle financeiro:** A empresa não realiza fechamento formal de caixa, dificultando a conferência consolidada dos recebimentos e do faturamento.
* **P5 — Estoque:** A empresa não possui controle formal de estoque; portanto, não acompanha de forma centralizada as entradas, o consumo interno, as vendas e os saldos disponíveis dos produtos.
* **P6 — Compras e reposição:** Necessidade de registrar compras de produtos e insumos, incluindo itens da linha Vonixx, para conhecer custos, quantidades e datas de aquisição.
* **P7 — Relatórios gerenciais:** Necessidade de reunir dados para analisar quantidade de atendimentos, serviços mais solicitados, vendas, faturamento, movimentação de produtos e desempenho operacional.

### Escopo do Sistema
O sistema proposto abrangerá os principais dados operacionais e administrativos da organização: clientes, veículos, funcionários, agendamentos, ordens de serviço, serviços, estacionamento, pagamentos, fornecedores, compras, produtos, consumo de produtos nos serviços, vendas de produtos e movimentações de estoque.

### Justificativa da Escolha
A organização foi escolhida por representar uma operação real de pequeno porte com processos de atendimento, serviços automotivos, estacionamento, compras e comercialização de produtos. O volume de cerca de dez veículos por dia permite estudar um cenário realista de cadastro, execução de serviços e movimentações financeiras e de materiais. Destaca-se também o vínculo familiar com a administração, garantindo acesso irrestrito para pesquisa de campo.

### Evidências da Organização
* **Perfil oficial:** [Instagram da Garagem Salles](https://www.instagram.com/salles.lavagens)
* **Endereço completo:** Rua Campo da Vinha, 517, Jardim Santa Terezinha, São Paulo – SP, 03572-090.
* **Responsável pelo atendimento:** Leonardo Sales — Telefone: (11) 95291-3828.
* **Evidências visuais:** Fotografias da visita e da entrevista arquivadas na pasta `levantamento/evidencias/`.

### Relato da Entrevista e Observação Presencial
A entrevista foi realizada presencialmente no dia **15/09/2026** na sede da Garagem Salles, com a participação da integrante Raquel de Araújo e atendimento do responsável Leonardo Sales. 
* **Achados da observação presencial:** Notou-se que a organização física adota numeração por ordem de chegada para organizar os veículos no pátio. O estabelecimento opera no modelo "leva e traz" (clientes deixam o veículo para serviços e retornam) e atende também clientes que utilizam o local como estacionamento de longa permanência (moradores e comerciantes locais). 
* *O relato completo detalhado encontra-se no arquivo [levantamento/levantamento.md](levantamento/levantamento.md).*

---

### Processos de Negócio
1. **Cadastro e Gestão de Clientes e Veículos:** Registro de dados pessoais e vínculo com os automóveis atendidos.
2. **Agendamento e Atendimento:** Marcação prévia ou entrada por ordem de chegada, associando veículos aos serviços de lavagem, estética ou estadia.
3. **Ordens de Serviço e Execução:** Lançamento de itens executados pelos funcionários e controle de status.
4. **Controle de Estoque e Compras:** Registro de aquisições de produtos Vonixx junto a fornecedores e baixa por consumo interno ou revenda.
5. **Fechamento Financeiro e Caixa:** Emissão de meios de pagamento e comprovantes fiscais vinculados às ordens de serviço e estadias.

### Requisitos do Sistema

#### Requisitos Funcionais (RF)
* **RF01:** O sistema deve permitir cadastrar clientes informando nome completo, CPF, telefone, e-mail e endereço completo.
* **RF02:** O sistema deve permitir registrar veículos vinculados a um cliente, contendo placa, modelo, cor e marca.
* **RF03:** O sistema deve permitir registrar agendamentos associando cliente, veículo e os serviços desejados.
* **RF04:** O sistema deve permitir abrir e gerenciar ordens de serviço com atribuição de funcionários responsáveis.
* **RF05:** O sistema deve permitir registrar entradas e saídas no estacionamento (estadia) com cálculo automático de tarifas.
* **RF06:** O sistema deve permitir o controle de estoque de produtos (entradas por compra, saídas por consumo/venda e saldo atual).
* **RF07:** O sistema deve registrar pagamentos e emitir relatórios de faturamento consolidado por período.

#### Requisitos Não Funcionais (RNF)
* **RNF01:** O banco de dados deve garantir integridade referencial utilizando chaves primárias e estrangeiras em todas as relações.
* **RNF02:** O sistema deve assegurar a proteção de dados sensíveis em conformidade com a LGPD (Lei nº 13.709/2018).
* **RNF03:** O SGBD utilizado deve ser compatível com MySQL, garantindo alta performance de consultas e transações seguras.

---

### Regras de Negócio, Operacionais e Restrições

#### Regras de Negócio (RN)
* **RN01:** Todo cliente deverá possuir um identificador único no sistema.
* **RN02:** Todo veículo deverá estar vinculado a um cliente cadastrado, e sua placa não poderá estar duplicada.
* **RN03:** Todo agendamento deverá estar associado a um cliente, a um veículo e aos serviços solicitados.
* **RN04:** Os agendamentos deverão respeitar a disponibilidade de horários e a capacidade de atendimento.
* **RN05:** Cancelamentos e alterações de agendamentos deverão manter um histórico no sistema.
* **RN06:** Os serviços executados deverão corresponder aos serviços solicitados e autorizados pelo cliente.
* **RN07:** Cada atendimento deverá possuir informações que permitam identificar os serviços realizados e os responsáveis.
* **RN08:** Toda entrada e saída de veículos do estacionamento deverá ser registrada.
* **RN09:** O valor do estacionamento deverá seguir a tabela de tarifas estabelecida pela empresa.
* **RN10:** A quantidade de veículos estacionados não poderá ultrapassar a capacidade física do estacionamento.
* **RN11:** Todo pagamento deverá possuir registro de valor, data, forma de pagamento e situação.
* **RN12:** As operações que exigirem documentação fiscal deverão respeitar as obrigações legais aplicáveis.
* **RN13:** Toda entrada e saída de produtos deverá ser registrada no controle de estoque.
* **RN14:** Toda venda de produtos deverá registrar os itens, as quantidades e os valores correspondentes.
* **RN15:** Cada funcionário deverá possuir identificação individual no sistema.
* **RN16:** O acesso às informações deverá respeitar as permissões atribuídas a cada funcionário.
* **RN17:** Danos, reclamações e irregularidades deverão possuir registros para consulta e acompanhamento.
* **RN18:** Os dados pessoais de clientes e funcionários deverão ser protegidos conforme a LGPD.
* **RN19:** Os registros financeiros e operacionais deverão manter histórico para possibilitar consultas e auditorias.

#### Regras Operacionais (RO)
* **RO01:** Um agendamento somente poderá ser confirmado se houver horário disponível na agenda da empresa.
* **RO02:** Um agendamento somente poderá ser realizado quando o cliente e o veículo estiverem identificados no sistema.
* **RO03:** Um serviço somente poderá ser iniciado após a confirmação dos serviços solicitados pelo cliente.
* **RO04:** Um veículo somente poderá entrar no estacionamento se houver vaga disponível.
* **RO05:** A saída de um veículo deverá possuir registro do horário de entrada e do horário de saída.
* **RO06:** A liberação do veículo deverá ocorrer após a confirmação do pagamento, salvo autorização excepcional registrada.
* **RO07:** Um pagamento somente poderá ser considerado concluído após a confirmação da transação.
* **RO08:** A retirada de um produto do estoque somente poderá ocorrer se houver quantidade disponível, exceto em ajustes autorizados.
* **RO09:** Uma venda somente poderá ser finalizada após o registro dos produtos, quantidades e valores.
* **RO10:** Um cancelamento deverá ser registrado no histórico, não podendo simplesmente apagar o agendamento original.
* **RO11:** Uma alteração de cadastro somente poderá ser realizada por um usuário autorizado.
* **RO12:** Uma ocorrência envolvendo danos ou irregularidades deverá ser registrada para permitir sua análise e acompanhamento.

#### Restrições Legais e Organizacionais (REO)
* **REO01 (LGPD):** Lei nº 13.709/2018 — Garante a proteção dos dados pessoais dos clientes e funcionários.
* **REO02:** Capacidade física do estacionamento — Impede o registro de veículos acima da quantidade de vagas.
* **REO03:** Horário de funcionamento — Evita agendamentos fora do expediente.
* **REO04:** Política interna de preços e tarifas — Fixa o acréscimo de 30% em revendas e tabela fixa de lavagem.
* **REO05 a REO10:** Normas internas de segurança de acesso, retenção de logs financeiros e obrigações fiscais.

---

### Notação do DER Conceitual
O DER foi desenvolvido utilizando o software **brModelo Web**, seguindo rigorosamente a notação padrão.
* **DER conceitual revisado:** [Visualizar o PDF do DER — Estacionamento](https://github.com/Raquel-Maciel/entrega-2---modelagem-de-dados/blob/main/DER_Estacionamento.pdf)

| Apontamento da correção da E1 | O que mudou no trabalho | Por quê |
|---|---|---|
| Revisão do relacionamento entre cliente e veículo | O relacionamento `possui` teve suas cardinalidades revistas. | Ajustar a associação correta 1:N entre clientes e veículos. |
| Revisão do relacionamento entre agendamentos e serviços | As cardinalidades do relacionamento `inclui` foram revisadas. | Melhorar a modelagem N:N via tabela associativa entre agendamentos e serviços. |
| Revisão da representação de pagamentos e comprovantes | O relacionamento anterior foi substituído por `comprova` ligando cupom fiscal a pagamento. | Organizar corretamente a emissão de documentos fiscais. |
| Inclusão de novos elementos | Adicionadas as entidades `produto` e `cupom fiscal`, com especialização de produtos. | Abranger o escopo de revenda e controle financeiro exigido. |

---

## 1.2 Conversão do Modelo Conceitual para o Modelo Lógico
A conversão mapeou entidades em tabelas, atributos em colunas tipadas e relacionamentos em chaves estrangeiras (`FK`) ou tabelas associativas (`item_servico`, `item_compra`, `item_venda`) para lidar com cardinalidades N:N. A especialização de produtos foi traduzida preservando a integridade hierárquica e referencial.

## 1.3 Definição de Chaves Primárias e Estrangeiras
* **`cliente`** — **PK:** `id_cliente` | **FK:** Nenhuma.
* **`veiculo`** — **PK:** `id_veiculo` | **FK:** `id_cliente` (ref. `cliente`).
* **`funcionario`** — **PK:** `id_funcionario` | **FK:** Nenhuma.
* **`servico`** — **PK:** `id_servico` | **FK:** Nenhuma.
* **`agendamento`** — **PK:** `id_agendamento` | **FKs:** `id_cliente`, `id_veiculo`.
* **`ordem_servico`** — **PK:** `id_os` | **FKs:** `id_agendamento`, `id_funcionario`.
* **`item_servico`** (Assoc.) — **PK Comp.:** `id_os` + `id_servico` | **FKs:** `id_os`, `id_servico`.
* **`estadia`** — **PK:** `id_estadia` | **FK:** `id_veiculo`.
* **`fornecedor`** — **PK:** `id_fornecedor` | **FK:** Nenhuma.
* **`produto`** — **PK:** `id_produto` | **FK:** `id_fornecedor`.
* **`compra`** — **PK:** `id_compra` | **FK:** `id_fornecedor`.
* **`item_compra`** (Assoc.) — **PK Comp.:** `id_compra` + `id_produto` | **FKs:** `id_compra`, `id_produto`.
* **`movimentacao_estoque`** — **PK:** `id_movimentacao` | **FK:** `id_produto`.
* **`venda_produto`** — **PK:** `id_venda` | **FK:** `id_cliente`.
* **`item_venda`** (Assoc.) — **PK Comp.:** `id_venda` + `id_produto` | **FKs:** `id_venda`, `id_produto`.
* **`pagamento`** — **PK:** `id_pagamento` | **FKs:** `id_os` (opc.), `id_estadia` (opc.), `id_venda` (opc.).
* **`cupom_fiscal`** — **PK:** `id_cupom` | **FK:** `id_pagamento`.

## 1.4 Processo de Normalização (1FN, 2FN e 3FN)
* **1FN:** Eliminação de grupos repetitivos e atributos multivalorados, garantindo atomicidade em todas as colunas (ex.: separação de itens de serviço e produtos em tabelas associativas).
* **2FN:** Eliminação de dependências parciais, assegurando que todas as colunas não-chave dependam integralmente da chave primária.
* **3FN:** Eliminação de dependências transitivas, garantindo que nenhum atributo não-chave dependa de outro atributo não-chave.

## 1.5 Justificativas Técnicas das Decisões
* **Chaves Primárias:** Utilização de inteiros auto-incrementais (`AUTO_INCREMENT`) para garantir alta performance de indexação e unicidade imutável.
* **Chaves Estrangeiras:** Implementadas para assegurar a integridade referencial estrita entre o cadastro de clientes, veículos, ordens de serviço e pagamentos.
* **Restrições (`UNIQUE`, `NOT NULL`):** Aplicadas para cumprir regras de negócio vitais, como impedir placas duplicadas (`RN02`) e obrigar o preenchimento de dados cadastrais essenciais.
* **Escolha do SGBD:** Utilização de **MySQL** em conformidade com a infraestrutura laboratorial da instituição, garantindo robustez transacional ACID.

## 1.6 Proposta de Arquitetura Analítica para BI, IA e Tabela de Rastreabilidade

### Indicadores-Chave de Desempenho (KPIs) Propostos
1. **Faturamento Total Mensal:** Receita consolidada proveniente de ordens de serviço, estadias e comercialização de produtos.
2. **Ticket Médio por Ordem de Serviço:** Razão entre a receita total de serviços e a quantidade de ordens finalizadas no mês.
3. **Controle de Ruptura de Estoque:** Monitoramento em tempo real de produtos da linha Vonixx abaixo do estoque mínimo.

### Tabela de Rastreabilidade
| Problema ou KPI | Tabelas Envolvidas | Consulta no Script |
| :--- | :--- | :--- |
| **P1** — Centralizar dados e histórico | `cliente`, `veiculo`, `ordem_servico` | `G01` |
| **P2** — Acompanhar serviços e status | `ordem_servico`, `item_servico`, `servico` | `G02` |
| **P3** — Registrar fluxo de estacionamento | `estadia`, `veiculo` | `G03` |
| **P4** — Fechamento consolidado de caixa | `pagamento`, `ordem_servico`, `estadia`, `venda_produto` | `G04` |
| **P5** — Controle formal de estoque | `produto`, `movimentacao_estoque` | `G05` |
| **P6** — Registro de compras e custos | `compra`, `item_compra`, `produto`, `fornecedor` | `G06` |
| **P7** — Relatórios de desempenho operacional | `ordem_servico`, `item_servico`, `servico`, `pagamento` | `G07` |
| **KPI 1** — Faturamento Total Mensal | `pagamento` | `G08` |
| **KPI 2** — Ticket Médio por OS | `ordem_servico`, `pagamento` | `G09` |
| **KPI 3** — Produtos com Estoque Crítico | `produto` | `G10` |

---

# 2. Modelo Lógico Relacional
O diagrama lógico detalhado em formato PDF encontra-se hospedado no repositório do grupo:
* **[Acessar PDF do Modelo Lógico Relacional](https://github.com/Raquel-Maciel/Modelagem-de-dados/blob/main/Entrega%202/Modelo_L%C3%B3gico_Garagem_Salles.pdf)**

---

# 3. Script SQL Completo
O código fonte executável contendo a criação do banco, tabelas, constraints, massa de dados e consultas gerenciais (`G01` a `G10`) encontra-es salvo no repositório na pasta dedicada (`docs/script.sql`).

---

# 4. Massa de Dados
Projetada de forma coerente com a operação real de **10 veículos atendidos por dia (~300 por mês)**. A massa de dados simula um ciclo operacional completo contendo múltiplos clientes, veículos, ordens de serviço finalizadas com diversas formas de pagamento (Pix, Cartão, Dinheiro), além de produtos Vonixx com variações de estoque normal e crítico para testar com eficácia as consultas gerenciais e de auditoria.

---

# 5. Repositório GitHub
O repositório oficial do grupo reúne todos os artefatos exigidos (Relatório no README, Dicionário de Dados, diagramas, pasta de levantamento com fotos comprobatórias em JPG/PNG e script SQL executável), apresentando um histórico de commits equilibrado entre os integrantes.

---

# 6. Uso de Inteligência Artificial

| Item | Descrição do Uso |
| :--- | :--- |
| **Ferramenta e etapa** | OpenAI ChatGPT e Google Gemini — Utilizados nas etapas de normalização (3FN), estruturação de chaves estrangeiras, revisão do script SQL DDL/DML e modelagem da massa de dados. |
| **Motivação** | Otimizar a sintaxe de comandos DDL para MySQL, validar dependências funcionais e assegurar que as consultas com múltiplos `JOINs` correspondessem exatamente aos códigos de rastreabilidade (`Gxx`). |
| **Prompt(s) utilizados** | *"Atuando como DBA MySQL, estruture o script SQL completo para um sistema de estética automotiva contendo as tabelas cliente, veiculo, ordem_servico, item_servico, produto, movimentacao_estoque e pagamento, aplicando restrições de integridade."* |
| **Resposta recebida** | Estruturação relacional inicial com comandos `CREATE TABLE`, definições de chaves e exemplos preliminares de consultas cruzadas. |
| **Fontes consultadas e verificadas** | Comparação direta com o DER conceitual do brModelo e com as regras de negócio anotadas na entrevista de campo com o gestor Leonardo Sales. |
| **Trechos rejeitados ou corrigidos** | Adequação manual de tipos de dados específicos de outros SGBDs gerados pela IA para o padrão compatível com MySQL, além de ajustes nas chaves compostas das tabelas associativas. |
| **Justificativa da escolha final** | Garantia de conformidade total com as normas da disciplina, desempenho de indexação e execução sem erros em ambiente MySQL limpo. |
| **Reflexão crítica** | A IA acelerou a estruturação sintática, mas a validação humana foi indispensável para evitar falhas de cardinalidade e assegurar o alinhamento com a realidade da garagem. |

---

# 7. Apresentação Corporativa Final (Pitch)
Preparada nos moldes exigidos (slides limpos e minimalistas), estruturada em 7 etapas cronometradas (Contextualização, Solução, Modelo Lógico, Implementação SQL, Demonstração de Consultas, Potencial de BI/IA e Benefícios para a Gestão), com a participação integral da equipe para a defesa técnica perante a banca.
