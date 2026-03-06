// Pessoa (Abstrata)
public abstract class Pessoa extends EntidadeBase {
    private String nome;
    private final Documento documento;

    protected Pessoa(String nome, Documento documento) {
        if (String.isBlank(nome)) throw new IllegalArgumentException('Nome obrigatório');
        this.nome = nome;
        this.documento = documento;
    }

    public abstract String getTipoPessoa();
    public String getNome() { return nome; }
    public Documento getDocumento() { return documento; }
}