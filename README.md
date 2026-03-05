🚀 Arquitetura de Domínio 

Este projeto demonstra a evolução de um sistema de delivery simples para uma arquitetura robusta baseada em Domain-Driven Design (DDD) e Design Patterns avançados em Apex (Salesforce).

Etapa 1: Modelagem Rica (EntidadeBase).

Etapa 2: Aggregate Root (Pedido protege Itens).

Etapa 3: Strategy Pattern (Preços flexíveis).

Etapa 4: Domain Service (ProcessadorPedido e Frete).

Etapa 5: State Pattern (Ciclo de vida sem Enums).

Etapas da Arquitetura

✅  Etapa 1: O Coração do Domínio (DDD e Value Objects)Arquivos: EntidadeBase.cls, Dinheiro.cls, EntidadeBase.cls.  

Conceito DDD: Introdução de Value Objects (Objetos de Valor). O Dinheiro não é apenas um número; ele é um objeto que garante que o valor nunca seja negativo.SOLID (S - Single Responsibility): A classe Dinheiro tem apenas uma responsabilidade: cuidar da lógica matemática monetária.

Conceito Aplicado: Identidade (na base) e Value Object (no Dinheiro).

✅ Etapa 2: Integridade e Agregados (DDD)Arquivos: Pedido.cls, ItemPedido.cls. 

Conceito DDD: Aggregate Root (Raiz de Agregado). O Pedido é o "chefe" do grupo. Você não pode alterar um ItemPedido sem passar pelo Pedido.SOLID (Encapsulamento): Protegemos a lista de itens e o total, garantindo que ninguém de fora quebre as regras de cálculo do pedido.

Conceito Aplicado: Aggregate Root (O Pedido controla os Itens).

✅  Etapa 3: Flexibilidade de Regras (Strategy Pattern)Arquivos: PoliticaDePreco.cls, PoliticaPrecoPadrao.cls, PoliticaPrecoComDescontoPercentual.cls.

Conceito: Design Pattern: Strategy Pattern. Criamos uma "estratégia" para calcular o preço.SOLID (O - Open/Closed): O sistema está Aberto para novos descontos, mas Fechado para modificação no Produto.cls. Você adiciona regras sem mexer no que já funciona.

Conceito Aplicado: Strategy Pattern (Flexibilidade de preços).


✅ Etapa 4: Orquestração de Processos (Domain Service)Arquivos: ProcessadorPedido.cls, PoliticaDeFrete.cls, FreteFixo.cls, BusinessException.cls.

Conceito DDD: Domain Service. O ProcessadorPedido não é um objeto físico, é um serviço que orquestra o frete e a confirmação.SOLID (D - Dependency Inversion): O processador depende da interface PoliticaDeFrete, e não de uma classe específica. Isso permite trocar o tipo de frete facilmente.

Conceito Aplicado: Domain Service (Orquestração de frete).


 ✅ Etapa 5: Ciclo de Vida Inteligente (State Pattern)Arquivos: EstadoPedido.cls, EstadoCarrinho.cls, EstadoEmProcessamento.cls, EstadoEntregue.cls, EstadoCancelado.cls.
 
 Conceito? Design Pattern: State Pattern. O comportamento do o Pedido não sabe quais são as regras de transição. Ele apenas pergunta ao objeto estadoAtual se a ação é permitida. Isso é o Desacoplamento em sua forma mais pura. Agora depende do estado.SOLID (L - Liskov Substitution): Qualquer classe de estado (ex: EstadoEntregue) pode substituir a classe pai (EstadoPedido) sem quebrar o sistema.SOLID (I - Interface Segregation): Cada estado implementa apenas o que lhe é permitido, lançando exceções para o que é proibido.

 Conceito Aplicado: State Pattern (Ciclo de vida inteligente). 
 

  Resumo do Projeto:
"É um sistema de delivery construído com Arquitetura Limpa, onde a segurança do negócio é garantida pelo State Pattern e a flexibilidade pelo Strategy Pattern, tudo organizado sob os princípios do DDD."

Status: Não usei um simples campo de Status (PickList/String), Porque "Usei o State Pattern que pede na Etapa 5 pra eliminar os Enums para que as regras de transição fiquem protegidas dentro de objetos, impedindo que um pedido pule etapas ilegalmente". Explicação:

Transição: Ele controla para onde o pedido pode ir. O EstadoCarrinho permite ir para EstadoEmProcessamento, mas o EstadoCancelado não permite ir para lugar nenhum.

Bloqueio: Se você tentar uma ação proibida para aquele status, o objeto de estado lança a BusinessException que você configurou.

Manutenção: Com essa estrutura, se o negócio mudar, não precisa caçar ifs espalhados pelo código: apenas mexe na classe específica da regra (ex: FreteFixo ou EstadoCarrinho).

Exceções de Negócio: A classe "BusinessException" não é um erro de sistema (bug), mas sim uma trava de segurança que comunica ao usuário que uma regra de negócio foi violada.

📚 Conclusão Técnica
Este projeto prova a aplicação prática do Open/Closed Principle e do Dependency Inversion, resultando em um código modular, testável e pronto para o crescimento do negócio.


OBS: Validação e Testes

🧪 Validação e Testes

Para garantir que a arquitetura respeita as regras de negócio, o projeto foi validado de duas formas:

1. Testes Unitários (`@isTest`)
A classe `PedidoTest.cls` garante a cobertura lógica e a integridade dos contratos.
Caminho" Valida a criação, adição de itens com Strategy e fluxo de estados até a entrega.
Caminho de Exceção: Valida se a `BusinessException` é lançada ao tentar violar uma regra de estado (ex: adicionar item após confirmação).

2. Script de Execução (Anonymous Apex)
O script abaixo pode ser usado para simular uma jornada real de compra no Console do Salesforce vc encontra essa parte do codigo seguindo as pastas apex > helo.apex e logo em seguida Execute Anonymous Apex.

// 1. Criar Objetos de Valor e Cliente (Etapa 1)
Documento cpf = new Documento('123.456.789-00');
// Ajustado para 4 parâmetros como sua classe Endereco agora exige
Endereco enderecoCli = new Endereco('Rua Central', '123', 'Bairro Centro', 'São Paulo'); 
Cliente ana = new Cliente('Ana Silva', cpf, enderecoCli, '11999999999');

// 2. Definir Políticas de Preço (Etapa 3 - Strategy)
PoliticaDePreco padrao = new PoliticaPrecoPadrao();
// Verifique se sua classe chama 'PoliticaPrecoDesconto' ou 'PoliticaPrecoComDescontoPercentual'
PoliticaDePreco comDesconto = new PoliticaPrecoComDescontoPercentual(10.0); 

// 3. Criar Produtos
Produto pizza = new Produto('Pizza Especial', new Dinheiro(50.0), padrao);
Produto refri = new Produto('Refri Gelado', new Dinheiro(10.0), comDesconto);

// 4. Iniciar Pedido
Pedido ped = new Pedido(); 

// 5. Adicionar Itens (Ajustado para a assinatura do seu método)
// Aqui pegamos o ID, a quantidade e o resultado do cálculo da estratégia de preço
ped.adicionarProduto(pizza.getId(), 1, pizza.calcularPrecoFinal()); 
ped.adicionarProduto(refri.getId(), 2, refri.calcularPrecoFinal());

System.debug('--- TESTE DE ARQUITETURA ---');
System.debug('Status Inicial: ' + ped.getStatus()); // Deve imprimir CARRINHO
System.debug('Total do Pedido: R$ ' + ped.getTotal().getValor()); // Deve ser 68.00

// 6. Transição de Estado (Etapa 4/5)
// Ajustado: Passando 10.0 (Decimal) em vez de new Dinheiro(10.0)
ped.confirmar(new FreteFixo(10.0)); 

System.debug('Status após confirmar: ' + ped.getStatus()); 
// ...

// 7. Teste de Invariante (Segurança da Arquitetura)
try {
    System.debug('Tentando adicionar produto em pedido confirmado...');
    // Ajustado para a assinatura correta: (ID, Quantidade, Preço)
    ped.adicionarProduto(pizza.getId(), 1, pizza.calcularPrecoFinal());
} catch (BusinessException e) {
    System.debug('✅ Bloqueio de Segurança Funcional: ' + e.getMessage()); 
} catch (Exception e) {
    System.debug('✅ Bloqueio: ' + e.getMessage());
}

// 8. Finalizar Fluxo
ped.entregar(); // Verifique se o método é 'entregar()' ou 'marcarComoEntregue()'
System.debug('Status Final: ' + ped.getStatus()); // Deve ser ENTREGUE
System.debug('--- TESTE FINALIZADO COM SUCESSO ---');