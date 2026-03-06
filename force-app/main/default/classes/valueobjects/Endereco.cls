public class Endereco {
    private final String logradouro;
    private final String numero;
    private final String bairro; // Adicionado para  o PedidoTest sem isso estava dando ero meu codigo antes
    private final String cidade;

    // Agora o construtor aceita 4 Strings Adicionado bairro para o PedidoTest sem isso estava dando ero meu codigo antes
    public Endereco(String logradouro, String numero, String bairro, String cidade) {
        this.logradouro = logradouro;
        this.numero = numero;
        this.bairro = bairro;
        this.cidade = cidade;
    }
    
    public String getLogradouro() { return logradouro; }
    public String getNumero() { return numero; }
    public String getBairro() { return bairro; } // Adicionado para  o PedidoTest sem isso estava dando ero meu codigo antes 
    public String getCidade() { return cidade; }
}