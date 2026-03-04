public abstract class EntidadeBase {
    private final String id;

    public EntidadeBase() {
        this.id = EncodingUtil.base64Encode(Crypto.generateAesKey(128)).substring(0, 20);
    }

    public String getId() { return id; }

    public Boolean equals(Object obj) {
        if (obj instanceof EntidadeBase) {
            return this.id == ((EntidadeBase)obj).id;
        }
        return false;
    }
}