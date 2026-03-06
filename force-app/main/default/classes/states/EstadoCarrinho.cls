public class EstadoCarrinho extends EstadoPedido {
    public override String getNome() { 
        return 'CARRINHO'; 
    }

    public override void adicionarProduto(Pedido pedido, String produtoId, Integer qtd, Dinheiro preco) {
        pedido.executarAdicao(produtoId, qtd, preco);
    }

    public override void confirmar(Pedido pedido, PoliticaDeFrete frete) {
        //  lógica de confirmação para o estado
        Dinheiro valorFrete = frete.calcularFrete(pedido);
        pedido.aplicarFrete(valorFrete);
        pedido.setEstado(new EstadoEmProcessamento());
    }

    public override void cancelar(Pedido pedido) {
        pedido.setEstado(new EstadoCancelado());
    }
}