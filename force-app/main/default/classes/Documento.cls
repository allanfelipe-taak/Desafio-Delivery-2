public class Documento {
    private final String valor;

    public Documento(String valor) {
        if (String.isBlank(valor) ) throw new IllegalArgumentException('Documento não pode ser vaizo');
        this.valor = valor;
    }
    public String getValor() {
        return valor;
    }
}