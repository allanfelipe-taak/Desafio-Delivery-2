Arquitetura de Domínio 

Este projeto demonstra a evolução de um sistema de delivery simples para uma arquitetura robusta baseada em Domain-Driven Design (DDD) e Design Patterns avançados em Apex (Salesforce).

Etapa 1: Modelagem Rica (EntidadeBase).

Etapa 2: Aggregate Root (Pedido protege Itens).

Etapa 3: Strategy Pattern (Preços flexíveis).

Etapa 4: Domain Service (ProcessadorPedido e Frete).

Etapa 5: State Pattern (Ciclo de vida sem Enums).

Este repositório registra como transformei um sistema de delivery comum em uma estrutura profissional, aplicando DDD e Design Patterns para resolver problemas reais de código.

Etapas da Arquitetura

 Etapa 1: Blindando os dados (Dinheiro e Endereço)
Nesta fase, parei de usar Decimal e String para tudo. Criei a classe Dinheiro para garantir que nenhum valor nasça negativo no sistema. Também usei a EntidadeBase para dar uma identidade única (ID) a cada objeto, garantindo que um Pedido seja único do começo ao fim.

O que aprendi: Dados importantes não podem ser apenas números; eles precisam de regras próprias (Value Objects).

 Etapa 2: O Pedido como "Chefe" (Aggregate Root)
Aqui apliquei o conceito de Agregado. O Pedido.cls passou a controlar totalmente seus itens. Ninguém de fora consegue mexer em um ItemPedido sem passar pelo Pedido, o que protege o cálculo do valor total.

O que aprendi: Encapsulamento real é quando o objeto principal protege a integridade dos seus dados internos.

Etapa 3: Preços que mudam sem quebrar o código (Strategy)
Em vez de encher a classe Produto de if/else para dar descontos, usei o Strategy Pattern. Agora, se eu quiser criar um "Desconto de Natal", só crio uma classe nova sem tocar no código que já está rodando (respeitando o princípio Open/Closed).

 Etapa 4: Organizando o Frete (Domain Service)
Criei o ProcessadorPedido para cuidar da parte "burocrática". Ele usa o frete (como o FreteFixo) para finalizar o pedido. Usei interfaces aqui para que o sistema não dependa de um frete específico, facilitando a troca no futuro.

Etapa 5: Inteligência de Status (State Pattern)
O maior desafio foi aqui: eliminei os Enums de status. Agora, o status do pedido é um objeto (ex: EstadoCarrinho). Isso impede que o pedido "pule" etapas ilegalmente. Se alguém tentar entregar um pedido que ainda está no carrinho, o próprio objeto de estado barra a ação e lança a minha BusinessException. O comportamento do o Pedido não sabe quais são as regras de transição. Ele apenas pergunta ao objeto estadoAtual se a ação é permitida. Isso é o Desacoplamento em sua forma mais pura. Agora depende do estado.SOLID (L - Liskov Substitution): Qualquer classe de estado (ex: EstadoEntregue) pode substituir a classe pai (EstadoPedido) sem quebrar o sistema.SOLID (I - Interface Segregation): Cada estado implementa apenas o que lhe é permitido, lançando exceções para o que é proibido.


Por que fiz isso? Para tirar a complexidade de validação de dentro do Pedido e deixar o ciclo de vida do software muito mais seguro e fácil de manter.

 
 

  Resumo do Projeto:
"É um sistema de delivery construído com Arquitetura Limpa, onde a segurança do negócio é garantida pelo State Pattern e a flexibilidade pelo Strategy Pattern, tudo organizado sob os princípios do DDD."

Status: Não usei um simples campo de Status (PickList/String), Porque "Usei o State Pattern que pede na Etapa 5 pra eliminar os Enums para que as regras de transição fiquem protegidas dentro de objetos, impedindo que um pedido pule etapas ilegalmente". Explicação:

Transição: Ele controla para onde o pedido pode ir. O EstadoCarrinho permite ir para EstadoEmProcessamento, mas o EstadoCancelado não permite ir para lugar nenhum.

Bloqueio: Se você tentar uma ação proibida para aquele status, o objeto de estado lança a BusinessException que você configurou.

Manutenção: Com essa estrutura, se o negócio mudar, não precisa caçar ifs espalhados pelo código: apenas mexe na classe específica da regra (ex: FreteFixo ou EstadoCarrinho).

Exceções de Negócio: A classe "BusinessException" não é um erro de sistema (bug), mas sim uma trava de segurança que comunica ao usuário que uma regra de negócio foi violada.




Conclusão Técnica
Este projeto está pronto para Validação e Testes seguindo o roteiro abaixo:




Validação e Testes

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