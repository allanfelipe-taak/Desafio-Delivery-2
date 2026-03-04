public class PoliticaPrecoDesconto implements PoliticaDePreco {
    private Decimal percentual;
    public PoliticaPrecoDesconto(Decimal p) { this.percentual = p; }
    public Dinheiro calcularPreco(Produto produto) {
        Decimal fator = 1 - (percentual / 100);
        return new Dinheiro(produto.getPrecoBase().getValor() * fator);
    }
}
