public class Endereco {
    private final String logradouro;
    private final String numero;
    private final String cidade;
    private final String complemento;

    public Endereco(String logradouro, String numero, String cidade, String complemento)
    {
        this.logradouro = logradouro;
        this.numero = numero;
        this.cidade = cidade;
        this.complemento = complemento;
    }

    // Apenas get sem set para garantir imutabilidade da classe

    public String getLogradouro() {
        return logradouro;
    }

    public String getNumero() {
        return numero;
    }

    public String getCidade() {
        return cidade;
    }

    public String getComplemento() {
        return complemento;
    }
}