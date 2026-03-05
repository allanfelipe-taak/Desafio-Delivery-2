public class Produto extends EntidadeBase {
    private String nome;
    private Dinheiro precoBase;
    private PoliticaDePreco politica;

    // O construtor PRECISA aceitar esses 3 parâmetros exatamente nesta ordem
    public Produto(String nome, Dinheiro precoBase, PoliticaDePreco politica) {
        super(); // Gera o ID na EntidadeBase
        this.nome = nome;
        this.precoBase = precoBase;
        this.politica = politica;
    }

    public Dinheiro calcularPrecoFinal() {
        return this.politica.calcularPreco(this);
    }

    public Dinheiro getPrecoBase() { return this.precoBase; }
}