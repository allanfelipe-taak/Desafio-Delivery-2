public class Dinheiro {
    private final Decimal valor;

    public Dinheiro(Decimal valor){
        if (valor == null || valor < 0) throw new IllegalArgumentException('Valor inválido');
        this.valor = valor.setScale(2);
    }

    public Decimal getValor(){
        return valor;
    }

    public Dinheiro somar (Dinheiro outro){
        return new Dinheiro(this.valor + outro.valor);
    }

    public Dinheiro multiplicar (Integer qtd){
        return new Dinheiro(this.valor * qtd);
    }


}