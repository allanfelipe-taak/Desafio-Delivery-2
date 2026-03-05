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