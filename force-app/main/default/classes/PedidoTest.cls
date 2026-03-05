@IsTest
public class PedidoTest {
    
    @IsTest
    static void deveSeguirFluxoCompletoComSucesso() {
        // Setup
        Produto p = new Produto('Pizza', new Dinheiro(50), new PoliticaPrecoPadrao());
        Pedido ped = new Pedido();
        
        // Execução
        ped.adicionarProduto(p.getId(), 1, p.calcularPrecoFinal());
        ped.confirmar(new FreteFixo(10));
        ped.entregar();
        
        // Asserção (Verificação)
        System.assertEquals('ENTREGUE', ped.getStatus(), 'O pedido deveria estar entregue');
        System.assertEquals(60.00, ped.getTotal().getValor(), 'O valor total deveria ser 60 (50 produto + 10 frete)');
    }

    @IsTest
    static void naoDevePermitirAdicionarProdutoAposConfirmado() {
        // Setup
        Produto p = new Produto('Pizza', new Dinheiro(50), new PoliticaPrecoPadrao());
        Pedido ped = new Pedido();
        ped.adicionarProduto(p.getId(), 1, p.calcularPrecoFinal());
        ped.confirmar(new FreteFixo(10));
        
        // Verificação da Exception
        try {
            ped.adicionarProduto(p.getId(), 1, p.calcularPrecoFinal());
            System.assert(false, 'Deveria ter lançado uma BusinessException');
        } catch (BusinessException e) {
            System.assertEquals('Não é permitido adicionar produtos neste estado.', e.getMessage());
        }
    }
}