package sukang.domain;

import java.util.List;

public class PreSubject {

    private Subject subject;
    private List<Subject> preSubject;              //선수과목 리스트
    
    
    public Subject getSubject() {
        return subject;
    }
    public void setSubject(Subject subject) {
        this.subject = subject;
    }
    public List<Subject> getPreSubject() {
        return preSubject;
    }
    public void setPreSubject(List<Subject> preSubject) {
        this.preSubject = preSubject;
    }
    
    
}
