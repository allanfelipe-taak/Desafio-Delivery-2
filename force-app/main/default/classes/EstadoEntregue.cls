public class EstadoEntregue extends EstadoPedido {
    public override void adicionarProduto(Pedido p, Produto prod, Integer qtd) {
        throw new IllegalArgumentException('Pedido já entregue');
    }
    public override void removerProduto(Pedido p, Produto prod) {
        throw new IllegalArgumentException('Pedido já entregue');
    }
    public override void confirmar(Pedido p) {
        throw new IllegalArgumentException('Pedido já entregue');
    }
    public override void cancelar(Pedido p) {
        throw new IllegalArgumentException('Não é possível cancelar um pedido entregue');
    }
    public override void marcarComoEntregue(Pedido p) {
        throw new IllegalArgumentException('Pedido já está entregue');
    }
    public override String getDescricao() { return 'ENTREGUE'; }
}