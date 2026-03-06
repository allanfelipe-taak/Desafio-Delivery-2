public class Cliente extends Pessoa {
    private Endereco endereco;
    private String telefone;

    public Cliente(String nome, Documento documento, Endereco endereco, String telefone) {
        super(nome, documento);
        this.endereco = endereco;
        this.telefone = telefone;
    }

    public override String getTipoPessoa() {
        return 'CLIENTE';
    }

    public Endereco getEndereco() { return endereco; }
    public String getTelefone() { return telefone; }
}