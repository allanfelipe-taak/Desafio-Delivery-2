public class EstadoEmProcessamento extends EstadoPedido {
    // Este método é obrigatório porque está na classe pai
    public override String getNome() { 
        return 'EM_PROCESSAMENTO'; 
    }

    public override void entregar(Pedido pedido) {
        pedido.setEstado(new EstadoEntregue());
    }

    public override void cancelar(Pedido pedido) {
        pedido.setEstado(new EstadoCancelado());
    }
}