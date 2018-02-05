package sukang.domain;

public class Road {
    
    private int key; // 과목코드
    private String text; // 과목명
    private String classType;   // "전필/전선/기초" 에 따른 색
    private boolean from;  // 선수과목 여부
    private String category; //학수구분에 따른 설정
    private int preInt;  // 선수과목 정리된 코드(2자리 숫자)
    private int subInt;  // 개설과목 정리된 코드(2자리 숫자)
    
    public int getKey() {
        return key;
    }
    public void setKey(int key) {
        this.key = key;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }
    public String getClassType() {
        return classType;
    }
    public void setClassType(String classType) {
        this.classType = classType;
    }
    public boolean isFrom() {
        return from;
    }
    public void setFrom(boolean from) {
        this.from = from;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public int getPreInt() {
        return preInt;
    }
    public void setPreInt(int preInt) {
        this.preInt = preInt;
    }
    public int getSubInt() {
        return subInt;
    }
    public void setSubInt(int subInt) {
        this.subInt = subInt;
    }
    
}
