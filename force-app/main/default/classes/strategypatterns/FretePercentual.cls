public class FretePercentual implements PoliticaDeFrete {
    private Decimal percentual;
    public FretePercentual(Decimal percentual) { this.percentual = percentual; }

    public Dinheiro calcularFrete(Pedido pedido) {
        Decimal totalItens = pedido.getTotal().getValor();
        return new Dinheiro(totalItens * (this.percentual / 100));
    }
}