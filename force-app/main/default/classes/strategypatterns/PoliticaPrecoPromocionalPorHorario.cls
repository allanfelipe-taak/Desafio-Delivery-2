public class PoliticaPrecoPromocionalPorHorario implements PoliticaDePreco {
    private Integer horaInicio;
    private Integer horaFim;
    private Decimal desconto;

    public PoliticaPrecoPromocionalPorHorario(Integer inicio, Integer fim, Decimal descconto) {
        this.horaInicio = inicio;
        this.horaFim = fim;
        this.desconto = desconto;
    }

    public Dinheiro calcularPreco(Produto produto) {
        Integer horaAtual = DateTime.now().hour();
        if (horaAtual >= horaInicio && horaAtual <= horaFim) {
            return new PoliticaPrecoComDescontoPercentual(desconto).calcularPreco(produto);
        }
        return produto.getPrecoBase();
    }
}