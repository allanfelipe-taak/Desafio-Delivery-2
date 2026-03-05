public class ItemPedido {
    private String produtoId;
    private Integer quantidade;
    private Dinheiro precoUnitario;
    private Dinheiro subtotal;

    public ItemPedido(String produtoId, Integer quantidade, Dinheiro precoUnitario) {
        this.produtoId = produtoId;
        this.precoUnitario = precoUnitario;
        setQuantidade(quantidade); // Isso já calcula o subtotal
    }

    private void calcularSubtotal() {
        // Corrigido: o método multiplicar recebe a quantidade
        this.subtotal = this.precoUnitario.multiplicar(this.quantidade); 
    }

    public void setQuantidade(Integer novaQuantidade) {
        if (novaQuantidade <= 0) throw new BusinessException('Quantidade deve ser positiva');
        this.quantidade = novaQuantidade;
        calcularSubtotal();
    }

    public String getProdutoId() { return produtoId; }
    public Integer getQuantidade() { return quantidade; }
    public Dinheiro getSubtotal() { return subtotal; }
}