public class EstadoEmProcessamento extends EstadoPedido {
    public override void adicionarProduto(Pedido p, Produto prod, Integer qtd) {
        throw new IllegalArgumentException('Não é permitido alterar itens em processamento');
    }
    public override void removerProduto(Pedido p, Produto prod) {
        throw new IllegalArgumentException('Não é permitido alterar itens em processamento');
    }
    public override void confirmar(Pedido p) {
        throw new IllegalArgumentException('Pedido já está em processamento');
    }
    public override void cancelar(Pedido p) {
        p.setEstado(new EstadoCancelado());
    }
    public override void marcarComoEntregue(Pedido p) {
        p.setEstado(new EstadoEntregue());
    }
    public override String getDescricao() { return 'EM_PROCESSAMENTO'; }
}