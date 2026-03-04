public class ProcessadorPedido {
    public void confirmar(Pedido p, PoliticaDeFrete frete) {
        if (p.getItens().isEmpty()) throw new IllegalArgumentException('Pedido vazio');
        // Lógica de confirmação e aplicação de frete
    }
}