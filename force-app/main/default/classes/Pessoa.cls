public abstract class Pessoa extends EntidadeBase {
    private String nome;
    private final Documento documento;

    public Pessoa(String nome, Documento documento) {
        super();
        if (String.isBlank(nome)) throw new IllegalArgumentException('Nome inválido');
        this.nome = nome;
        this.documento = documento;
    }

    public abstract String getTipoPessoa();
    public String getNome() { return nome; }
    public Documento getDocumento() { return documento; }
}