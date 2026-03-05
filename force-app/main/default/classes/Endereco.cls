public class Endereco {
    private final String logradouro;
    private final String numero;
    private final String bairro; // Adicionado
    private final String cidade;

    // Agora o construtor aceita 4 Strings
    public Endereco(String logradouro, String numero, String bairro, String cidade) {
        this.logradouro = logradouro;
        this.numero = numero;
        this.bairro = bairro;
        this.cidade = cidade;
    }
    
    public String getLogradouro() { return logradouro; }
    public String getNumero() { return numero; }
    public String getBairro() { return bairro; } // Adicionado
    public String getCidade() { return cidade; }
}