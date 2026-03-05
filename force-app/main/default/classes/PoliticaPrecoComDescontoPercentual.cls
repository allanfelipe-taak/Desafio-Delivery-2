public class PoliticaPrecoComDescontoPercentual implements PoliticaDePreco {
    private Decimal percentual;

    public PoliticaPrecoComDescontoPercentual(Decimal percentual) {
        if (percentual > 100) throw new IllegalArgumentException('Desconto não pode ser > 100%');
        this.percentual = percentual;
    }

    public Dinheiro calcularPreco(Produto produto) {
        Decimal fator = (100 - percentual) / 100;
        return new Dinheiro(produto.getPrecoBase().getValor() * fator);
    }
}