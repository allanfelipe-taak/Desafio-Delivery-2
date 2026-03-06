public class ProcessadorPedido {
    public void confirmar(Pedido pedido, PoliticaDeFrete frete) {
        // Agora o pedido sabe se pode confirmar baseado no seu estado
        pedido.confirmar(frete); 
    }

    public void cancelar(Pedido pedido) {
        pedido.cancelar();
    }
}