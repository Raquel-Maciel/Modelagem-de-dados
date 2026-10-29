## Metadados

- **Raquel de Araujo Maciel Silva – RGM 49040120**
- **Isabel de Araujo Ferreira Maciel – RGM 49038940**
- **Luiz Alencar Silva Feitosa – RGM 49633996**
- **Gabriel de Araujo Ferreira Maciel – RGM 49038796**
- **Vinicius Rodrigues de Brito – RGM 49475428**

## 1. Caracterização da Organização

* **Nome da Empresa:** Garagem Salles Estúdio automotivo.
* **Porte e Operação:** Empresa de pequeno porte, contando com uma equipe de 3 funcionários e uma média de atendimento  de aproximadamente 10 Carros por dia.
* **Problema Identificado:** Atualmente, a empresa realiza o controle de operações de forma predominantemente manual, o que gera *problemas no registro de entrada e saída de veículos*, falta de agilidade no acompanhamento das ordens de serviço e dificuldade na auditoria de pagamentos e estoque de produtos utilizados.
* **Justificativa da Escolha:** A escolha do estabelecimento justifica-se pela real necessidade de transformação digital e automação dos processos de negócio. A implantação de um sistema informatizado é imprescindível para eliminar gargalos operacionais, garantir a segurança dos dados dos clientes e profissionalizar o controle de faturamento e atendimento.
* **Evidências e Fontes:** As informações e características operacionais foram levantadas por meio de análise do perfil oficial da empresa no Instagram (@salies.lavagens) e Entrevista


## 2. Processos de Negócio

- **Principais processos mapeados:** cadastro de clientes, id de veículos, id de estacionamento, serviços prestados, agendamentos, formas de pagamento.

- **Fluxogramas 

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais
*O que o sistema precisa FAZER cadastrar clientes – nome, CPF, telefone, endereço – cadastrar veículo – placa, modelo, marca, ano e proprietário – cadastrar serviços – lavagem, lavagem de motor, ducha, lavagem de moto, higienização, polimento, restauração de farol, cristalização de vidros, restauração de plásticos - cadastrar formas de pagamento – consultar histórico de veículo – gerar relatórios – serviços utilizados, faturamento, produtos utilizados *

### 3.2 Requisitos Não Funcionais
*Características de qualidade – segurança – somente usuários autorizados podem acessar – desempenho – o banco de dados deve ser utilizado de forma descomplicada e rápida – disponibilidade – funcionamento disponível no horário de expediente – backup – copias periódicas – privacidade – dados dos clientes e funcionários protegidos*

---

## 4. Regras de Negócio
* cada cliente pode possuir um ou mais veículos – cada veículo deve estar vinculado a um cliente – um veículo pode possuir vários registros de serviços – um veículo não pode ser liberado sem que o pagamento esteja registrado  ou autorizado*


- **Regras operacionais: o funcionário deve registar a entrada e a saída do veículo – o sistema deve registar dada e horário de entrada e saída – somente funcionários autorizados podem alterar uma ordem de serviço – o estoque deve ser atualizado sempre que um produto for utilizado – o responsável deve conferir os dados do veículo antes de finalizar o atendimento – o sistema deve permitir consultar os atendimentos anteriores*

- **Restrições organizacionais:** *somente funcionários terá acesso aos dados – os dados dos clientes devem ser mantidos em sigilo – o sistema deve seguir a politica interna de backup da empresa – determinadas alterações no cadastro só podem ser feitas pelo gerente de acesso .*

---

## 5. Dicionário de Dados (Conceptual e Lógico)

Para cada entidade identificada no sistema da Garagem Salles Estúdio Automotivo, detalham-se abaixo os atributos, tipos de dados, cardinalidades e regras associadas.

### 5.1 Entidade: Cliente
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_cliente | Inteiro (PK) | 1 para N | Identificador único do cliente (Chave Primária). |
| nome | Varchar(100) | Obrigatório | Nome completo do cliente. |
| cpf | Varchar(14) | Obrigatório (Único) | CPF do cliente para fins fiscais e cadastro (LGPD: dado protegido e sigiloso). |
| telefone | Varchar(20) | Opcional | Número de contato para avisos de conclusão e agendamentos. |
| endereco | Varchar(200) | Opcional | Endereço residencial ou comercial do cliente. |

### 5.2 Entidade: Veículo
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_veiculo | Inteiro (PK) | 1 para N | Identificador único do veículo. |
| placa | Varchar(10) | Obrigatório (Único) | Placa de identificação do automóvel (utilizada para OCR/entrada rápida). |
| modelo | Varchar(50) | Obrigatório | Modelo do veículo (ex: BMW S1000, Onix, etc.). |
| marca | Varchar(50) | Obrigatório | Fabricante do veículo. |
| cor | Varchar(30) | Opcional | Cor predominante do veículo. |
| ano | Inteiro | Opcional | Ano de fabricação. |
| id_cliente | Inteiro (FK) | N para 1 | Relaciona o veículo ao seu respectivo proprietário (Cliente). Cada cliente pode possuir um ou mais veículos. |

### 5.3 Entidade: Serviços
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_servico | Inteiro (PK) | 1 para N | Identificador único do serviço oferecido. |
| nome_servico | Varchar(100) | Obrigatório | Nome da atividade (ex: Lavagem simples, cristalização de vidros, restauração de plásticos). |
| descricao | Texto | Opcional | Detalhes do que o procedimento inclui. |
| valor | Decimal(10,2)| Obrigatório | Preço base cobrado pelo serviço. |

### 5.4 Entidade: Ordem de Serviço (OS)
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_os | Inteiro (PK) | 1 para N | Número de identificação da Ordem de Serviço. |
| data_entrada| Datetime | Obrigatório | Momento exato em que o funcionário registra a entrada do veículo. |
| data_saida | Datetime | Opcional | Momento de liberação do veículo (Regra: nenhum veículo é liberado sem o pagamento registrado). |
| id_veiculo | Inteiro (FK) | 1 para 1 | Veículo que está passando pelo atendimento. |
| id_funcionario| Inteiro (FK) | N para 1 | Funcionário responsável por registrar e acompanhar a ordem de serviço. |
| status_os | Varchar(30) | Obrigatório | Estado atual (Ex: 'Em Andamento', 'Concluído', 'Aguardando Pagamento'). |

### 5.5 Entidade: Funcionários
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_func | Inteiro (PK) | 1 para N | Identificador único do funcionário. |
| nome | Varchar(100) | Obrigatório | Nome completo do colaborador. |
| cargo | Varchar(50) | Obrigatório | Função exercida (ex: Gerente, Atendente, Lavador). |
| nivel_acesso| Varchar(20) | Obrigatório | Define permissões (Ex: Somente funcionários autorizados/gerentes podem alterar ordens de serviço). |

### 5.6 Entidade: Pagamento
| Atributo | Tipo de Dado | Cardinalidade | Descrição / Regra de Negócio |
| :--- | :--- | :--- | :--- |
| id_pagamento| Inteiro (PK) | 1 para 1 | Identificador da transação financeira. |
| id_os | Inteiro (FK) | 1 para 1 | Ordem de serviço vinculada ao pagamento. |
| valor_total | Decimal(10,2)| Obrigatório | Valor cobrado somando os serviços executados e produtos utilizados. |
| metodo | Varchar(30) | Obrigatório | Forma de pagamento utilizada (Pix, Crédito, Débito, Dinheiro). |

---

### Convenções, Fluxo de Dados e Governança (LGPD)

* *Convenções de Nomenclatura:* Utilização de letras minúsculas separadas por underscore (snake_case) para tabelas e colunas; chaves primárias padronizadas como id_[entidade] e chaves estrangeiras como id_[entidade_referenciada].
* *Expressão Formal, Tipos e Índices:* Utilização de padrões relacionais SQL (Integers para chaves, Varchar para textos, Decimal para valores financeiros e Datetime para controle de tempo). Índices criados nas chaves primárias e em campos de alta frequência de busca (como a placa do veículo e o cpf do cliente).
* *Fluxo de Dados e Acesso por Operação:* O fluxo operacional começa com o cadastro do cliente e do veículo. Em seguida, o funcionário autorizado registra a entrada na Ordem de Serviço, vincula os serviços e produtos utilizados, e o ciclo se encerra obrigatoriamente na tabela de pagamento para a liberação da saída.
* *Log de Acesso e LGPD:* O sistema mantém rastreabilidade das operações críticas por meio de níveis de acesso. Os dados sensíveis dos clientes (como CPF e telefone) atendem rigorosamente aos princípios da Lei Geral de Proteção de Dados (LGPD), garantindo sigilo corporativo e restrição contra vazamentos ou consultas indevidas.


## 6. Modelagem Conceitual 

- **Entidades reconhecidas / Atributos e classificações:** *cliente - que representa a pessoa que utiliza os serviços da estética; id do cliente, nome,CPF, telefone, e-mail, endereço.
Veiculo – o veiculo pertence ao cliente; id de veiculo, placa, marca, ano, modelo, ano, cor, id docliente
Funcionário – responsável pelo atendimento e execução dos serviços; id do funcionário, nome, CPF, cargo, telefone
Serviço – qual serviço oferecido pela empresa; id do serviço, nome do serviço, descrição, valor, tempo estimado
Prestação de serviço de estacionamento – id do cliente, id do veiculo, data e hora, valores relacionados
Pagamento – registra o pagamento realizado pelo cliente; id do pagamento, data, valor, forma de pagamento, status do pagamento*

- **Relacionamentos pertinentes:** 
* Cliente → Veículo
Um cliente pode possuir um ou vários veículos, enquanto cada veículo pertence a um cliente.
Relacionamento:
Cliente 1 : N Veículos
Veículo → Ordem de Serviço
Um veículo pode possuir várias ordens de serviço ao longo do tempo.
Relacionamento:
Veículo 1 : N Ordens de Serviço
Funcionário → Ordem de Serviço
Um funcionário pode ser responsável por várias ordens de serviço.
Relacionamento:
Funcionário 1 : N Ordens de Serviço
Ordem de Serviço → Serviço
Uma ordem de serviço pode possuir um ou vários serviços, e um mesmo serviço pode aparecer em várias ordens.
Relacionamento:
Ordem de Serviço N : N Serviço
Nesse caso, normalmente é necessária uma entidade intermediária, como Item Ordem Serviço.
Ordem de Serviço → produto
Uma ordem de serviço pode utilizar vários produtos e um produto pode ser utilizada em várias ordens.
Relacionamento:
Ordem de Serviço N : N produto
Ordem de Serviço → Pagamento
Uma ordem de serviço possui registro de pagamento.
Relacionamento:
Ordem de Serviço 1 : 1 Pagamento.*


- **Restrições e políticas organizacionais aplicadas ao modelo.**
* O modelo deverá respeitar as regras de negócio e as políticas internas da empresa. Cada veículo deverá estar associado a um cliente cadastrado. Cada ordem de serviço deverá estar relacionada a um veículo e a um funcionário responsável. Os serviços e peças utilizados deverão ser registrados na ordem de serviço para possibilitar o cálculo do valor total do atendimento.
O estoque deverá ser atualizado sempre que um produto for utilizada. O sistema deverá controlar os níveis de acesso dos funcionários, permitindo que determinadas informações sejam alteradas somente por usuários autorizados. Os dados dos clientes deverão ser protegidos e tratados de acordo com as políticas de segurança da organização e com a legislação aplicável.
O sistema também deverá manter a integridade dos dados, impedindo registros inválidos ou inconsistentes, como uma ordem de serviço vinculada a um veículo inexistente.
---

## 7. Diagrama Entidade-Relacionamento (DER)

- Anexe o DER (em imagem).
 

---

## 8. Justificativa Técnica

*A modelagem conceitual foi elaborada considerando os principais processos envolvidos no funcionamento da empresa de estética automotiva e estacionamento, com foco no cadastro de clientes e veículos, agendamento de serviços, utilização do estacionamento e controle dos pagamentos. As entidades, atributos, relacionamentos e cardinalidades foram definidos de acordo com as necessidades identificadas no negócio, buscando representar as operações de forma organizada e evitar a duplicidade de informações. As entidades; Cliente foi definida porque é necessário identificar e armazenar os dados das pessoas que utilizam os serviços da empresa. Foram considerados atributos como nome, telefone, endereço e data de cadastro. A entidade Veículo foi separada de Cliente porque um cliente pode possuir mais de um veículo. Dessa forma, informações específicas do automóvel, como placa, marca, modelo, ano, cor e status, não precisam ser repetidas no cadastro do cliente. A entidade Serviço representa os diferentes serviços oferecidos pela empresa e possui atributos como identificação, nome, descrição e valor. Sua separação permite manter um cadastro dos serviços e seus respectivos preços. A entidade Agendamento foi criada para representar a programação dos atendimentos, permitindo registrar data, horário e status do atendimento. Essa entidade é necessária porque o agendamento possui informações próprias que não pertencem diretamente ao cliente ou ao serviço. A entidade Estacionamento representa o controle da permanência dos veículos no estabelecimento. Foram definidos atributos como data e hora de entrada, data e hora de saída e valor, possibilitando acompanhar cada utilização do estacionamento. A entidade Pagamento foi criada para registrar as transações financeiras relacionadas aos serviços e ao estacionamento, armazenando informações como data, valor, status e forma de pagamento.
Em relação aos atributos foram selecionados considerando as informações necessárias para identificar, controlar e consultar cada processo. Foram utilizados identificadores, como id_cliente, id_veicúlo, id serviço, id_agendamento, id_estacionamento e id_pagamento, para garantir que cada registro possa ser identificado individualmente. A placa foi incluída na entidade Veículo por ser uma informação fundamental para identificação do automóvel. Já os atributos de data, hora, status e valor foram utilizados para permitir o acompanhamento dos atendimentos, da permanência no estacionamento e das transações financeiras. A escolha desses atributos evita armazenar informações desnecessárias no modelo conceitual e mantém cada informação associada à entidade à qual realmente pertence. 
Os Relacionamentos foram definidos para representar as interações existentes entre as entidades. O relacionamento Cliente possui Veículo representa que um cliente pode cadastrar seus veículos no sistema. O relacionamento Cliente realiza Agendamento permite registrar os atendimentos solicitados por cada cliente. O relacionamento Agendamento inclui Serviço relaciona o atendimento agendado ao serviço que será realizado. O relacionamento Veículo utiliza Estacionamento permite controlar a entrada e a saída dos veículos e manter o histórico das utilizações do estacionamento. Os relacionamentos entre Agendamento/Pagamento e Estacionamento/Pagamento permitem registrar os valores pagos pelas operações realizadas. Cardinalidades
As cardinalidades foram estabelecidas de acordo com as regras identificadas para o funcionamento da empresa. A relação entre Cliente e Veículo permite que um cliente possua vários veículos, enquanto cada veículo está associado a um cliente. Isso evita duplicar os dados do cliente quando ele possui mais de um automóvel. A relação entre Cliente e Agendamento permite que um mesmo cliente realize vários agendamentos ao longo do tempo, mantendo o histórico dos atendimentos. A relação entre Veículo e Estacionamento permite que o mesmo veículo utilize o estacionamento diversas vezes, possibilitando o registro de diferentes entradas e saídas. As cardinalidades foram escolhidas para representar a quantidade mínima e máxima de ocorrências permitidas entre as entidades, contribuindo para a integridade e consistência do banco de dados.
Dessa forma, o modelo conceitual busca representar fielmente os processos da empresa automotiva, mantendo as informações organizadas, reduzindo redundâncias e estabelecendo relacionamentos que permitam garantir a integridade dos dados. As decisões de modelagem foram tomadas considerando as regras de negócio identificadas e a necessidade de possibilitar futuras consultas, alterações e expansão do sistema.
*

---

## 9. Uso de Inteligência Artificial


| Item | O que registrar |
|------|------------------|
| **ChatGPT** | A ferramenta ChatGPT foi utilizada como apoio no desenvolvimento do Modelo Conceitual de Banco de Dados da Garagem Salles. A inteligência artificial auxiliou na compreensão da plataforma ou Modelo, na identificação de entidades e atributos e na elaboração dos relacionamentos e cardinalidades. As orientações foram utilizadas como referência para a construção do DER, considerando as informações levantadas na pesquisa de campo realizada pelo grupo. |
| **Motivação** | Auxiliar na compreensão dos conceitos de modelagem de banco de dados e orientar a construção do Diagrama Entidade-Relacionamento, considerando as informações obtidas na pesquisa de campo. |
| **Prompt(s) utilizados** | 1. Com base no fluxograma da empresa e nas informações obtidas na pesquisa de campo, auxilie na identificação das entidades e atributos necessários para a elaboração do Diagrama Entidade-Relacionamento (DER).”
2. “Explique detalhadamente como utilizar a ferramenta ou Modelo para desenvolver o modelo conceitual de banco de dados.”
3. “Apresente orientações passo a passo para a criação das entidades, atributos identificadores, relacionamentos e cardinalidades.”
4. “Gere representações visuais do modelo para facilitar a compreensão e a organização das entidades e seus respectivos atributos.”
5. “Auxilie na definição dos relacionamentos e das cardinalidades, considerando as regras de negócio e os processos operacionais da empresa.”
6. “Analise o Diagrama Entidade-Relacionamento desenvolvido e identifique possíveis inconsistências, sugerindo correções para melhorar a estrutura do modelo.”|
| **Resposta recebida** | O ChatGPT forneceu orientações sobre a utilização da ferramenta Modelo e auxiliou na construção do Diagrama Entidade-Relacionamento (DER) da empresa Garagem Salles. A partir das informações coletadas na pesquisa de campo, foram sugeridas entidades como Cliente, Veículo, Serviço, Agendamento, Estacionamento e Pagamento, com seus respectivos atributos e identificadores.
A ferramenta também apresentou explicações sobre relacionamentos e cardinalidades, além de gerar representações visuais para facilitar a compreensão e a organização do modelo. Durante o desenvolvimento, foram analisadas imagens do diagrama elaborado pelo grupo, permitindo identificar inconsistências e sugerir ajustes na estrutura dos relacionamentos.
O auxílio da IA contribuiu para a compreensão dos conceitos de modelagem de banco de dados e para a aplicação prática dos conhecimentos adquiridos em sala de aula.. |
| **Justificativa da escolha final** | Por que o grupo manteve, adaptou ou rejeitou o que a IA sugeriu. |
| **Reflexão crítica** | Limites, vieses ou erros identificados no uso da IA nessa etapa (ex.: informação desatualizada, alucinação, generalização incorreta sobre o tipo de organização). |


---


**Entrega final:** README.md completo + DER + Dicionário de Dados em HTML (com exceção dos cursos GTI) anexado no repositório GitHub do grupo.

