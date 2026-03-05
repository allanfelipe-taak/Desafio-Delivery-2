public class FreteFixo implements PoliticaDeFrete {
    private Decimal valor;
    public FreteFixo(Decimal valor) { this.valor = valor; }
    
    public Dinheiro calcularFrete(Pedido pedido) {
        return new Dinheiro(this.valor);
    }
}