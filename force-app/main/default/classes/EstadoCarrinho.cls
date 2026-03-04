public class EstadoCarrinho extends EstadoPedido {
    public override void adicionarProduto(Pedido p, Produto prod, Integer qtd) {
        p.adicionarItemInterno(prod, qtd);
    }
    public override void removerProduto(Pedido p, Produto prod) {
        p.removerItemInterno(prod);
    }
    public override void confirmar(Pedido p) {
        if (p.getItens().isEmpty()) throw new IllegalArgumentException('Carrinho vazio');
        p.setEstado(new EstadoEmProcessamento());
    }
    public override void cancelar(Pedido p) {
        p.setEstado(new EstadoCancelado());
    }
    public override void marcarComoEntregue(Pedido p) {
        throw new IllegalArgumentException('Não pode entregar um pedido em carrinho');
    }
    public override String getDescricao() { return 'CARRINHO'; }
}