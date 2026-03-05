public class Pedido extends EntidadeBase {
    private EstadoPedido estadoAtual; 
    private Map<String, ItemPedido> itens;
    private Dinheiro total;
    private Dinheiro valorFrete;

    public Pedido() {
        super();
        this.itens = new Map<String, ItemPedido>();
        this.total = new Dinheiro(0.00);
        this.estadoAtual = new EstadoCarrinho(); // Começa no Carrinho
    }

    // --- DELEGAÇÕES (O Pedido apenas repassa para o estado) ---
    
    public void adicionarProduto(String produtoId, Integer qtd, Dinheiro preco) {
        estadoAtual.adicionarProduto(this, produtoId, qtd, preco);
    }

    public void confirmar(PoliticaDeFrete frete) {
        estadoAtual.confirmar(this, frete);
    }

    public void cancelar() {
        estadoAtual.cancelar(this);
    }

    public void entregar() {
        estadoAtual.entregar(this);
    }

    // --- MÉTODOS DE ESTADO (Chamados pelos objetos de Estado) ---

    public void setEstado(EstadoPedido novoEstado) {
        this.estadoAtual = novoEstado;
    }

    public void executarAdicao(String produtoId, Integer qtd, Dinheiro preco) {
        if (itens.containsKey(produtoId)) {
            itens.get(produtoId).setQuantidade(itens.get(produtoId).getQuantidade() + qtd);
        } else {
            itens.put(produtoId, new ItemPedido(produtoId, qtd, preco));
        }
        recalcularTotal(); 
    }

    public void recalcularTotal() {
        Dinheiro novoTotal = new Dinheiro(0.00);
        for (ItemPedido item : itens.values()) {
            novoTotal = novoTotal.somar(item.getSubtotal());
        }
        this.total = novoTotal;
    }

    public void aplicarFrete(Dinheiro frete) {
        this.valorFrete = frete;
        this.total = this.total.somar(frete);
    }

    // --- GETTERS ---

    public String getStatus() { 
        return estadoAtual.getNome(); 
    }

    public List<ItemPedido> getItens() { return itens.values(); }
    public Dinheiro getTotal() { return total; }
}