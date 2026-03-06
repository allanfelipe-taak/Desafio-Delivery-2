public abstract class EstadoPedido {
    public abstract String getNome();

    public virtual void adicionarProduto(Pedido pedido, String produtoId, Integer qtd, Dinheiro preco) {
        throw new BusinessException('Não é permitido adicionar produtos neste estado.');
    }

    public virtual void confirmar(Pedido pedido, PoliticaDeFrete frete) {
        throw new BusinessException('Não é possível confirmar o pedido neste estado.');
    }

    public virtual void entregar(Pedido pedido) {
        throw new BusinessException('Não é possível entregar o pedido neste estado.');
    }

    public virtual void cancelar(Pedido pedido) {
        throw new BusinessException('Não é possível cancelar o pedido neste estado.');
    }
}