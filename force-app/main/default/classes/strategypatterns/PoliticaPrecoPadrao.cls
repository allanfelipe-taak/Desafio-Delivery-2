public class PoliticaPrecoPadrao implements PoliticaDePreco {
    public Dinheiro calcularPreco(Produto produto) {
        return produto.getPrecoBase();
    }
}