public class Produto extends EntidadeBase {
    private String nome;
    private Dinheiro precoBase;
    private PoliticaDePreco politica; // COMPOSIÇÃO

    public Produto(String nome, Dinheiro precoBase, PoliticaDePreco politica) {
        super();
        this.nome = nome;
        this.precoBase = precoBase;
        this.politica = politica;
    }

    public Dinheiro calcularPrecoFinal() {
        return politica.calcularPreco(this);
    }
    
    public Dinheiro getPrecoBase() { return precoBase; }
    public String getNome() { return nome; }
}