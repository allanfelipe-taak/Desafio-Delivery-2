Arquitetura de Domínio 
Este projeto demonstra a evolução de um sistema de delivery simples para uma arquitetura robusta baseada em Domain-Driven Design (DDD) e Design Patterns avançados em Apex (Salesforce).

Etapa 1: Modelagem Rica (VOs e EntidadeBase).

Etapa 2: Aggregate Root (Pedido protege Itens).

Etapa 3: Strategy Pattern (Preços flexíveis).

Etapa 4: Domain Service (ProcessadorPedido e Frete).

Etapa 5: State Pattern (Ciclo de vida sem Enums).

Etapas da Arquitetura
Etapa 1: Modelagem Rica (Domain-Driven Design)
Substituímos o uso de tipos primitivos por uma modelagem que protege a integridade dos dados desde o nascimento do objeto:

EntidadeBase: Classe abstrata que garante uma identidade única (UUID) imutável para todas as entidades.

Value Objects (VOs): Criação de Dinheiro, Documento e Endereco. São objetos imutáveis que se autovalidam, impedindo valores negativos ou CPFs inválidos.

Pessoa e Cliente: Reestruturação hierárquica onde o Cliente herda comportamentos de Pessoa, utilizando os novos VOs.

Etapa 2: Pedido como Aggregate Root
O Pedido passou a ser o "Cofre" do sistema, controlando todas as suas partes internas:

Encapsulamento Total: ItemPedido não pode ser manipulado fora do contexto do Pedido.

Proteção de Invariantes: Regras que impedem quantidades nulas, itens duplicados ou confirmação de pedidos vazios.

Total Derivado: O valor total é uma consequência dos itens e não pode ser alterado manualmente.

 Etapa 3: Polimorfismo de Preço (Strategy Pattern)
Eliminamos os ifs de desconto, tornando o sistema aberto para novas regras de negócio sem alteração de código core:

Interface PoliticaDePreco: Define a abstração para qualquer cálculo de valor.

Estratégias Concretas: Implementação de PoliticaPrecoPadrao, PoliticaPrecoDesconto e PromocionalPorHorario.

Composição: O Produto delega o cálculo para a política injetada, respeitando o Open/Closed Principle.

Etapa 4: Serviço de Domínio (Domain Service)
Separamos o "quem eu sou" (Entidade) do "o que eu faço" (Processo):

ProcessadorPedido: Um maestro que orquestra ações complexas como confirmações e cancelamentos.

Política de Frete: Introdução da interface PoliticaDeFrete, permitindo que o frete seja calculado de forma independente (Fixo, Grátis ou Percentual).

Fluxo Controlado: O serviço garante que o pedido só avance se todas as regras de negócio forem satisfeitas.

 Etapa 5: Ciclo de Vida Inteligente (State Pattern)
Removemos completamente os Enums e lógicas condicionais de status, substituindo por comportamento polimórfico:

Hierarquia de Estados: O Pedido delega suas ações para classes como EstadoCarrinho, EstadoEmProcessamento e EstadoEntregue.

Blindagem de Transição: Tentativas de alterar um pedido após a confirmação disparam exceções automáticas baseadas no estado atual.

Fim da Lógica Condicional: O Pedido não pergunta mais "em qual status estou", ele apenas executa a ação e o estado atual responde.




 Diferenciais Arquiteturais (SOLID & DDD)
Diferente de sistemas básicos, o DelivFast 2 foi construído com foco em segurança de estado e extensibilidade:

1. Modelagem Rica com Value Objects (VOs)
Substituímos tipos primitivos (String, Double) por objetos que possuem regras de negócio próprias e são imutáveis:

Dinheiro: Garante que valores monetários nunca sejam negativos e centraliza cálculos financeiros.

Documento: Valida e protege a identidade (CPF) do cliente.

Endereço: Estrutura de dados imutável para localização.

2. Pedido como Aggregate Root
O Pedido atua como a raiz do agregado, protegendo a integridade de todos os ItemPedido:

Encapsulamento: Itens não podem ser alterados fora do Pedido.

Invariantes: O Pedido impede estados inválidos, como quantidades negativas ou duplicidade de produtos.

3. Design Patterns Aplicados
Strategy Pattern: O cálculo de preços é delegado para a interface PoliticaDePreco, permitindo novos tipos de desconto sem alterar o código existente (Open/Closed Principle).

State Pattern: O ciclo de vida do pedido é controlado por classes de estado (EstadoCarrinho, EstadoEmProcessamento, etc.), eliminando ifs complexos e protegendo transições de status.


 Como Executar os Testes
Para validar a robustez do sistema, utilize o script de execução anônima abaixo. Note que o sistema lançará exceções caso regras de negócio (Invariantes) sejam violadas:

APEX
// Exemplo de teste de fluxo completo e proteção de estado
Pedido ped = new Pedido(ana);
ped.adicionarProduto(pizza, 1); 
ped.confirmar(); // Transiciona para EM_PROCESSAMENTO

try {
    ped.adicionarProduto(refri, 1); // Bloqueado pelo State Pattern
} catch (Exception e) {
    System.debug('Bloqueio de Segurança: ' + e.getMessage()); 
}

Conclusão Técnica
Este projeto prova a aplicação prática do Open/Closed Principle e do Dependency Inversion, resultando em um código modular, testável e pronto para o crescimento do negócio.
