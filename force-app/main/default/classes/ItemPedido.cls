public class ItemPedido {
    private Produto produto;
    private Integer quantidade;
    private Dinheiro subtotal;

    public ItemPedido(Produto produto, Integer quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
        // Agora chamamos o cálculo polimórfico
        this.subtotal = produto.calcularPrecoFinal().multiplicar(quantidade);
    }

    public void atualizarQuantidade(Integer novaQtd) {
        this.quantidade = novaQtd;
        this.subtotal = this.produto.calcularPrecoFinal().multiplicar(this.quantidade);
    }

    public Produto getProduto() { return this.produto; }
    public Integer getQuantidade() { return this.quantidade; }
    public Dinheiro getSubtotal() { return this.subtotal; }
}