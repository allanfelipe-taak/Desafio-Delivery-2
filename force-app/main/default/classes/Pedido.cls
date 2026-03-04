public class Pedido extends EntidadeBase {
    private Cliente cliente;
    private List<ItemPedido> itens;
    private EstadoPedido estado; // State Pattern (Etapa 5)
    private Dinheiro total;
    private Dinheiro frete;

    public Pedido(Cliente cliente) {
        super();
        this.cliente = cliente;
        this.itens = new List<ItemPedido>();
        this.estado = new EstadoCarrinho(); // Estado Inicial
        this.total = new Dinheiro(0);
        this.frete = new Dinheiro(0);
    }

    // Delegação de comportamento para o Estado (Etapa 5)
    public void adicionarProduto(Produto produto, Integer quantidade) {
        this.estado.adicionarProduto(this, produto, quantidade);
        recalcularTotal();
    }

    public void removerProduto(Produto produto) {
        this.estado.removerProduto(this, produto);
        recalcularTotal();
    }

    public void confirmar() {
        this.estado.confirmar(this);
    }

    public void cancelar() {
        this.estado.cancelar(this);
    }

    public void marcarComoEntregue() {
        this.estado.marcarComoEntregue(this);
    }

    // Métodos internos para o Agregado e Estados
    public void adicionarItemInterno(Produto produto, Integer quantidade) {
        for (ItemPedido item : itens) {
            if (item.getProduto().getNome().equalsIgnoreCase(produto.getNome())) {
                item.atualizarQuantidade(item.getQuantidade() + quantidade);
                return;
            }
        }
        this.itens.add(new ItemPedido(produto, quantidade));
    }

    public void removerItemInterno(Produto produto) {
        for (Integer i = 0; i < itens.size(); i++) {
            if (itens[i].getProduto().getNome().equalsIgnoreCase(produto.getNome())) {
                itens.remove(i);
                break;
            }
        }
    }

    public void recalcularTotal() {
        Dinheiro somaItens = new Dinheiro(0);
        for (ItemPedido item : itens) {
            somaItens = somaItens.somar(item.getSubtotal());
        }
        this.total = somaItens.somar(this.frete);
    }

    // Setters controlados para transição de estado
    public void setEstado(EstadoPedido novoEstado) {
        this.estado = novoEstado;
    }

    public void setFrete(Dinheiro valorFrete) {
        this.frete = valorFrete;
        recalcularTotal();
    }

    // Getters
    public List<ItemPedido> getItens() { return new List<ItemPedido>(this.itens); }
    public Dinheiro getTotal() { return this.total; }
    public String getStatusDescricao() { return this.estado.getDescricao(); }
}