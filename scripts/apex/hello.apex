// 1. Criar Objetos de Valor e Cliente
Documento cpf = new Documento('123.456.789-00');

Endereco enderecoCli = new Endereco('Rua Central', '123', 'São Paulo', 'Apto 1'); 
Cliente ana = new Cliente('Ana Silva', cpf, enderecoCli, '11999999999');

// 2. Definir Políticas de Preço (Etapa 3)
PoliticaDePreco padrao = new PoliticaPrecoPadrao();
PoliticaDePreco comDesconto = new PoliticaPrecoDesconto(10.0); // 10% de desconto

// 3. Criar Produtos com Políticas Diferentes
Produto pizza = new Produto('Pizza', new Dinheiro(50.0), padrao);
Produto refri = new Produto('Refri', new Dinheiro(10.0), comDesconto);

// 4. Iniciar Pedido (Estado: CARRINHO)
Pedido ped = new Pedido(ana);
ped.adicionarProduto(pizza, 1); // R$ 50.00
ped.adicionarProduto(refri, 2); // R$ 18.00 (com 10% desc)

System.debug('Status: ' + ped.getStatusDescricao()); // CARRINHO
System.debug('Total Carrinho: R$' + ped.getTotal().getValor()); // 68.00

// 5. Transição de Estado (Etapa 5)
ped.confirmar(); 
System.debug('Status após confirmar: ' + ped.getStatusDescricao()); // EM_PROCESSAMENTO

// 6. Teste de Invariante (Não pode adicionar item após confirmar)
try {
    ped.adicionarProduto(pizza, 1);
} catch (Exception e) {
    System.debug('Bloqueio Correto: ' + e.getMessage()); 
}

// 7. Finalizar
ped.marcarComoEntregue();
System.debug('Status Final: ' + ped.getStatusDescricao()); // ENTREGUE