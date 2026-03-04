public abstract class EstadoPedido {
    public abstract void adicionarProduto(Pedido p, Produto prod, Integer qtd);
    public abstract void removerProduto(Pedido p, Produto prod); // Estava faltando!
    public abstract void confirmar(Pedido p);
    public abstract void cancelar(Pedido p); // Estava faltando!
    public abstract void marcarComoEntregue(Pedido p); // Estava faltando!
    public abstract String getDescricao(); // Estava faltando!
}