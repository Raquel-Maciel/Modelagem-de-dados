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

- **Regras operacionais:** *As regras operacionais estabelecem as condições que devem ser cumpridas para que as operações da Garagem Salles Estúdio Automotivo sejam realizadas corretamente.*
- **RO01** — *Disponibilidade de horários: um agendamento somente poderá ser confirmado se houver disponibilidade de horário e capacidade de atendimento.*
- **RO02** — *Identificação do cliente: um agendamento somente poderá ser registrado se o cliente estiver cadastrado e identificado no sistema.*
- **RO03** — *Identificação do veículo: um serviço ou uma permanência no estacionamento somente poderá ser registrado quando o veículo estiver identificado e vinculado ao cadastro correspondente.*
- **RO04** — *Autorização de serviços: um serviço somente poderá ser iniciado após a confirmação dos serviços solicitados pelo cliente.*
- **RO05** — *Disponibilidade de vagas: a entrada de um veículo somente poderá ser registrada quando houver vaga disponível no estacionamento.*
- **RO06** — *Cálculo do estacionamento: o valor da permanência deverá ser calculado com base nos horários de entrada e saída e na tabela de tarifas vigente.*
- **RO07** — *Registro de pagamento: um pagamento somente poderá ser confirmado após o registro do valor, da forma de pagamento e da confirmação da transação.*
- **RO08** — *Liberação do veículo: o veículo somente poderá ser liberado após a regularização dos valores devidos ou mediante autorização excepcional registrada.*
- **RO09** — *Movimentação de estoque: a saída de um produto somente poderá ser registrada se houver quantidade disponível em estoque, exceto em ajustes administrativos devidamente autorizados.*
- **RO10** — *Registro de vendas: uma venda somente poderá ser concluída após o registro dos produtos, das quantidades e dos valores correspondentes.*
- **RO11** — *Acesso ao sistema: operações de consulta, inclusão, alteração e exclusão somente poderão ser realizadas por usuários com as permissões necessárias.*
- **RO12** — *Registro de ocorrências: danos ou irregularidades identificados durante o atendimento ou estacionamento deverão ser registrados antes do encerramento da ocorrência.*
 
- **Restrições organizacionais:** *As restrições organizacionais representam as políticas internas, limitações operacionais e exigências legais que influenciam o funcionamento do sistema e a estrutura do banco de dados.*
- **REO01** — *Capacidade do estacionamento: a quantidade de veículos registrados como estacionados não poderá ultrapassar a capacidade física do estabelecimento. Essa restrição exige o controle das vagas disponíveis.*
- **REO02** — *Horário de funcionamento: os agendamentos deverão respeitar os dias e horários de funcionamento definidos pela empresa. Essa restrição permite configurar os períodos em que o sistema pode aceitar agendamentos.*
- **REO03** — *Política de preços: os serviços e o estacionamento deverão utilizar os preços e as tarifas aprovados pela empresa. Essa restrição evita cobranças indevidas e permite manter o histórico dos valores praticados.*
- **REO04** — *Política de cancelamento: os cancelamentos, atrasos e eventuais cobranças deverão obedecer às condições estabelecidas pela empresa e informadas aos clientes. Essa restrição orienta o tratamento dos agendamentos e das cobranças.*
- **REO05** — *Controle de estoque: o sistema deverá impedir que o estoque disponível fique negativo durante as operações normais. Essa restrição evita inconsistências no controle de produtos e insumos.*
- **REO06** — *Controle de acesso: as informações administrativas, financeiras e cadastrais deverão ser acessadas conforme as funções e permissões dos funcionários. Essa restrição reduz o risco de alterações indevidas e vazamento de informações.*
- **REO07** — *Proteção de dados pessoais: o tratamento dos dados dos clientes e funcionários deverá respeitar a Lei Geral de Proteção de Dados Pessoais (LGPD). Essa restrição exige controles de acesso, segurança, finalidade e retenção adequada das informações.*
- **REO08** — *Obrigações fiscais: a emissão e o armazenamento de documentos fiscais deverão seguir as exigências legais aplicáveis à atividade da empresa. Essa restrição influencia os dados que precisam ser armazenados e os registros necessários para auditoria.*
- **REO09** — *Rastreabilidade financeira: pagamentos e operações financeiras deverão manter registros suficientes para permitir conferências e auditorias. Essa restrição dificulta a perda do histórico e facilita a identificação de divergências.*
- **REO10** — *Limitações técnicas: o banco de dados deverá utilizar tipos de dados, chaves e restrições de integridade compatíveis com o sistema adotado. Essa restrição evita inconsistências e garante a confiabilidade das informações.*

---

## 5. Dicionário de Dados Conceitual (Preliminar)

Para cada entidade identificada, liste:

### 5.1 Entidade: Cliente
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_cliente | Identificador único da pessoa que compra serviços ou produtos | Obrigatório; chave primária única para cada cliente cadastrado. |
| nome | Nome completo do cliente | Obrigatório; deve conter o nome e sobrenome do cliente para identificação. |
| cpf | Número de identificação de cadastro de pessoa física | Obrigatório e único; utilizado para fins fiscais e de faturamento (Protegido por sigilo/LGPD). |
| telefone | Número de contato telefônico do cliente | Opcional; utilizado para avisos de conclusão e agendamento de serviços. |
| endereco | Endereço residencial ou comercial do cliente | Opcional; utilizado para histórico e localização quando necessário. |

### 5.2 Entidade: Veículo
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_veiculo | Identificador único do veículo no sistema | Obrigatório; chave primária da entidade veículo. |
| placa | Placa de identificação oficial do automóvel | Obrigatório e único; utilizado para agilizar a entrada e conferência no balcão. |
| modelo | Modelo do veículo (ex: BMW S1000, Onix, etc.) | Obrigatório; especifica a linha de fabricação do automóvel. |
| marca | Fabricante do veículo (ex: BMW, Chevrolet, etc.) | Obrigatório; define a montadora do automóvel. |
| cor | Cor predominante do veículo | Opcional; detalhe descritivo para conferência física no pátio. |
| ano | Ano de fabricação do veículo | Opcional; registra a idade do automóvel. |
| id_cliente | Identificador do proprietário do veículo | Obrigatório; cada cliente pode possuir um ou mais veículos vinculados. |

### 5.3 Entidade: Serviços
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_servico | Identificador único da atividade de estética automotiva | Obrigatório; chave primária do serviço. |
| nome_servico | Nome e tipo de serviço oferecido (lavagem, cristalização, etc.) | Obrigatório; define a atividade executada (ex: lavagem simples, higienização, etc.). |
| descricao | Detalhamento dos procedimentos realizados na atividade | Opcional; explica o que o serviço inclui para o cliente. |
| valor | Preço base cobrado pela execução do serviço | Obrigatório; valor financeiro unitário associado ao procedimento. |

### 5.4 Entidade: Ordem de Serviço (OS)
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_os | Número de identificação do atendimento / ordem de serviço | Obrigatório; chave primária para controle do fluxo de atendimento. |
| data_entrada | Momento em que o funcionário registra a entrada do veículo | Obrigatório; gerado automaticamente no início do processo. |
| data_saida | Momento de liberação do veículo | Obrigatório para encerramento; nenhum veículo pode ser liberado sem o pagamento registrado. |
| id_veiculo | Identificador do veículo em atendimento | Obrigatório; vincula o atendimento ao automóvel correspondente. |
| id_func | Identificador do funcionário responsável pelo registro | Obrigatório; somente funcionários autorizados podem abrir ou alterar ordens de serviço. |
| status_os | Estado atual da ordem (Em andamento, Concluído, Pago) | Obrigatório; controla o fluxo operacional do pátio. |

### 5.5 Entidade: Funcionários
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_func | Identificador único da pessoa que realiza os serviços | Obrigatório; chave primária do colaborador. |
| nome | Nome completo do funcionário | Obrigatório; identificação pessoal na equipe de 3 funcionários. |
| cargo | Função exercida na organização (Atendente, Gerente, etc.) | Obrigatório; define o nível de permissão e autorização no sistema. |

### 5.6 Entidade: Pagamento
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_pagamento | Identificador único da transação financeira | Obrigatório; chave primária do pagamento. |
| id_os | Identificador da ordem de serviço quitada | Obrigatório; vincula o pagamento diretamente ao atendimento realizado. |
| valor_total | Valor total consolidado dos serviços e produtos utilizados | Obrigatório; base de cálculo do faturamento diário. |
| metodo | Forma de pagamento utilizada (Pix, crédito, débito, dinheiro) | Obrigatório; restrito às formas aceitas pelo estabelecimento. |

### 5.7 Entidade: Produto (Estoque)
| Atributo | Descrição | Regra de negócio associada |
| :--- | :--- | :--- |
| id_produto | Identificador único do insumo ou material de venda | Obrigatório; chave primária do produto. |
| nome_produto | Nome comercial do produto ou insumo utilizado | Obrigatório; especifica o material de limpeza ou acessório. |
| quantidade | Quantidade disponível em estoque | Obrigatório; controlado para verificar se há insumo para utilização no serviço. |


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

### 1. Visão Geral do Uso de IA
* **Ferramenta utilizada:** ChatGPT (OpenAI).
* **Objetivo / Motivação:** Auxiliar na compreensão dos conceitos de modelagem de banco de dados e orientar a construção do Diagrama Entidade-Relacionamento (DER), considerando as regras de negócio e as informações obtidas na pesquisa de campo da empresa Garagem Salles.

---

### 2. Detalhamento dos Prompts, Respostas e Análises

| Item / Prompt | Resposta Recebida | Justificativa da Escolha Final | Reflexão Crítica |
| :--- | :--- | :--- | :--- |
| **Prompt 1:**<br>_"Com base no fluxograma da empresa e nas informações obtidas na pesquisa de campo, auxilie na identificação das entidades e atributos necessários para a elaboração do Diagrama Entidade-Relacionamento (DER)._ | O ChatGPT sugeriu entidades centrais como `Cliente`, `Veículo`, `Serviço`, `Agendamento`, `Estacionamento` e `Pagamento`, detalhando os atributos e chaves primárias de cada uma. | O grupo acolheu a sugestão das entidades principais por estarem em perfeita harmonia com o fluxo operacional real coletado na pesquisa de campo. | **Limites / Vieses:** A IA tendeu a propor um modelo genérico de oficinas mecânicas/lava-rápidos; foi necessário filtrar e adaptar as entidades para o escopo específico da Garagem Salles. |
| **Prompt 2:**<br>_"Explique detalhadamente como utilizar a ferramenta ou Modelo para desenvolver o modelo conceitual de banco de dados."_ | A ferramenta forneceu um guia teórico sobre as etapas do Modelo Conceitual (abstração de dados, identificação de regras de negócio e tradução para o DER). | Utilizado como referência de estudo e alinhamento conceitual para a equipe antes de iniciar o desenho técnico. | **Limites / Vieses:** Explicação de caráter muito teórico, exigindo que o grupo fizesse a ponte prática com as ferramentas de modelagem utilizadas nas aulas. |
| **Prompt 3:**<br>_"Apresente orientações passo a passo para a criação das entidades, atributos identificadores, relacionamentos e cardinalidades."_ | Forneceu um roteiro estruturado definindo a sequência lógica: mapeamento de substantivos (entidades), verbos (relacionamentos) e propriedades (atributos). | O passo a passo foi seguido pelo grupo para organizar a ordem de estruturação do diagrama conceitual, garantindo boas práticas de normalização. | **Limites / Vieses:** O método padrão da IA nem sempre prioriza as particularidades da ferramenta gráfica escolhida pelo grupo, servindo mais como um roteiro conceitual. |
| **Prompt 4:**<br>_"Gere representações visuais do modelo para facilitar a compreensão e a organização das entidades e seus respectivos atributos."_ | O modelo gerou representações em formato textual estruturado (esquemas relacionais e diagramas em Mermaid/ASCII) para ilustrar a estrutura. | Serviu como um esboço preliminar rápido antes da prototipagem final do DER na ferramenta oficial do projeto. | **Limites / Vieses:** As representações visuais em texto são limitadas para projetos complexos, exigindo validação humana e redesenho em software de diagramação dedicado. |
| **Prompt 5:**<br>_"Auxilie na definição dos relacionamentos e das cardinalidades, considerando as regras de negócio e os processos operacionais da empresa."_ | Ajudou a esclarecer cardinalidades complexas, como a relação 1 para N entre `Cliente` e `Veículo`, e N para N entre `Agendamento` e `Serviço`. | As orientações de cardinalidade foram adotadas integralmente após validação cruzada com o fluxo de atendimento da Garagem Salles. | **Limites / Vieses:** A IA não possui visão empírica do negócio; regras específicas de exceção da empresa precisaram ser ajustadas manualmente pelo grupo. |
| **Prompt 6:**<br>_"Analise o Diagrama Entidade-Relacionamento desenvolvido e identifique possíveis inconsistências, sugerindo correções para melhorar a estrutura do modelo."_ | A análise apontou pontos de melhoria, como a necessidade de tabelas associativas para resolver relacionamentos de muitos para muitos (N:N). | O grupo acatou a sugestão de refatoração estrutural para evitar redundâncias de dados e garantir a integridade referencial do banco. | **Limites / Vieses:** A validação lógica da IA é sintática e estrutural; ela não substitui a revisão crítica do professor ou a validação com o cliente real. |

---

### 3. Aprofundamento Metodológico e Governança no Uso da IA

A integração da inteligência artificial no desenvolvimento do projeto **Garagem Salles** seguiu uma abordagem de **co-criação supervisionada**. A IA não atuou como um agente autônomo de decisão, mas sim como um copiloto técnico e analítico para acelerar o levantamento de requisitos, validar conceitos de modelagem e desafiar a arquitetura proposta pelo grupo.

#### 3.1. Processo de Engenharia de Prompt e Iteração
O relacionamento com a ferramenta de IA baseou-se em ciclos iterativos de refinamento (feedback loops):
1. **Contextualização Prévia:** Em vez de solicitar soluções genéricas, os prompts iniciais sempre alimentavam a IA com o contexto específico da pesquisa de campo (ex.: fluxo de atendimento de veículos, registro de avarias e controle de pátio da Garagem Salles).
2. **Decomposição de Problemas:** O problema complexo de modelagem foi fatiado em etapas menores: primeiro a identificação de substantivos (entidades), depois a definição de propriedades (atributos) e, por fim, a lógica relacional (cardinalidades).
3. **Validação Cruzada e Refatoração:** Após a geração inicial do Diagrama Entidade-Relacionamento (DER), o grupo submetia o modelo resultante a uma nova rodada de análise crítica com a IA para detectar possíveis gargalos de normalização, redundâncias ou violações de integridade referencial.

#### 3.2. Vantagens Operacionais Observadas
* **Ganho de Produtividade:** Redução significativa no tempo gasto para estruturar o dicionário de dados inicial e padronizar a nomenclatura das chaves primárias e estrangeiras.
* **Alinhamento Conceitual:** Funcionou como um mecanismo de nivelamento técnico para a equipe, facilitando a tradução de regras de negócio abstratas em artefatos formais de banco de dados.
* **Identificação Precoce de Inconsistências:** A simulação de cenários de relacionamento (como a gestão de múltiplos serviços atrelados a um único agendamento) permitiu antecipar a necessidade de tabelas associativas antes da implementação no SGBD.

#### 3.3. Limitações, Vieses e Cuidados Críticos (Análise Crítica)
O grupo adotou uma postura de **ceticismo construtivo** diante das respostas fornecidas pela ferramenta, destacando os seguintes pontos de atenção:
* **Geração de Padrões Genéricos:** A IA tende a sugerir estruturas voltadas a grandes oficinas tradicionais ou concessionárias, o que exigiu do grupo a filtragem constante para manter o foco exclusivo no modelo operacional enxuto da Garagem Salles.
* **Ausência de Contexto Empírico:** A IA não possui percepção do ambiente real de trabalho ou das restrições físicas do espaço do cliente. Regras de exceção específicas do negócio dependeram inteiramente do julgamento humano do grupo.
* **Validação Lógica Humana:** Todas as sugestões de cardinalidade e restrições de integridade foram rigorosamente auditadas pela equipe e validadas com base na teoria de banco de dados ministrada em sala de aula, garantindo que o artefato final fosse academicamente correto e funcionalmente viável.

**Entrega final:** README.md completo + DER + Dicionário de Dados em HTML (com exceção dos cursos GTI) anexado no repositório GitHub do grupo.

