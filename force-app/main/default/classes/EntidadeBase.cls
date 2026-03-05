public abstract class EntidadeBase {
    private final String id;

    protected EntidadeBase() {
        
        Blob b = Crypto.generateAesKey(128);
        String h = EncodingUtil.convertToHex(b);
        this.id = h.substring(0,8) + '-' + h.substring(8,12) + '-' + h.substring(12,16) + '-' + h.substring(16,20) + '-' + h.substring(20);
    }

    public String getId() {
        return this.id;
    }

    public Boolean equals(Object obj) {
        if (obj instanceof EntidadeBase) {
            EntidadeBase other = (EntidadeBase)obj;
            return this.id == other.id;
        }
        return false;
    }

    public Integer hashCode() {
        
        return System.hashCode(this.id);
    }
}