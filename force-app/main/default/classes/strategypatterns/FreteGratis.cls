public class FreteGratis implements PoliticaDeFrete {
    public Dinheiro calcularFrete(Pedido pedido) {
        return new Dinheiro(0.00);
    }
}