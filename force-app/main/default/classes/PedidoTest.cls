@isTest
public class PedidoTest {
    
    @isTest
    static void deveCalcularTotalComDiferentesPoliticas() {
        // 1. Setup - Corrigido nome 'end' para 'enderecoCli' e adicionado 4 parâmetros
        Documento cpf = new Documento('123.456.789-00');
        Endereco enderecoCli = new Endereco('Rua A', '10', 'Apto 1', 'São Paulo'); 
        Cliente ana = new Cliente('Ana Silva', cpf, enderecoCli, '11999999999');
        
        PoliticaDePreco padrao = new PoliticaPrecoPadrao();
        PoliticaDePreco desconto = new PoliticaPrecoDesconto(10.0);
        
        Produto pizza = new Produto('Pizza', new Dinheiro(50.0), padrao);
        Produto refri = new Produto('Refri', new Dinheiro(10.0), desconto);
        
        Pedido ped = new Pedido(ana);
        ped.adicionarProduto(pizza, 1); 
        ped.adicionarProduto(refri, 2); 
        
        System.assertEquals(68.00, ped.getTotal().getValor(), 'O cálculo com Strategy falhou');
    }

    @isTest
    static void deveBloquearAdicaoDeItemEmEstadoInvalido() {
        // Setup corrigido com os 4 parâmetros de endereço
        Endereco e = new Endereco('R', '1', 'C', 'Cidade');
        Pedido ped = new Pedido(new Cliente('Teste', new Documento('111'), e, '1'));
        ped.adicionarProduto(new Produto('Pizza', new Dinheiro(50.0), new PoliticaPrecoPadrao()), 1);
        
        ped.confirmar(); 
        
        try {
            ped.adicionarProduto(new Produto('Refri', new Dinheiro(10.0), new PoliticaPrecoPadrao()), 1);
            System.assert(false, 'Deveria ter lançado uma exceção de estado');
        } catch (Exception err) {
            System.assert(err.getMessage().contains('Não é permitido alterar itens'), 'Mensagem de erro incorreta');
        }
    }
}