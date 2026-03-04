public class EstadoCancelado extends EstadoPedido {
    public override void adicionarProduto(Pedido p, Produto prod, Integer qtd) {
        throw new IllegalArgumentException('Pedido cancelado');
    }
    public override void removerProduto(Pedido p, Produto prod) {
        throw new IllegalArgumentException('Pedido cancelado');
    }
    public override void confirmar(Pedido p) {
        throw new IllegalArgumentException('Pedido cancelado');
    }
    public override void cancelar(Pedido p) {
        throw new IllegalArgumentException('Pedido já está cancelado');
    }
    public override void marcarComoEntregue(Pedido p) {
        throw new IllegalArgumentException('Não é possível entregar um pedido cancelado');
    }
    public override String getDescricao() { return 'CANCELADO'; }
}