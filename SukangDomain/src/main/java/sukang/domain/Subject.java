package sukang.domain;

import java.util.List;

public class Subject implements Comparable<Subject> {

    private String subjectCode; //과목코드
    private String subjectName; //과목명
    private int credit; //학점
    private String interest; //심화구분
    private String year; //학년
    private String semester; //학기
    private List<Subject> preSubjectList;//선수과목명
    private String preSubject;
    private String preSubjectCode;
    private String classType;//학수구분
    private String admission; //입학년도
    private String retake; //재수강 여부 (자동추천에서만 쓰임)
    private boolean recommended;

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public List<Subject> getPreSubjectList() {
        return preSubjectList;
    }

    public void setPreSubjectList(List<Subject> preSubjectList) {
        this.preSubjectList = preSubjectList;
    }

    public String getPreSubject() {
        return preSubject;
    }

    public void setPreSubject(String preSubject) {
        this.preSubject = preSubject;
    }

    public String getClasstype() {
        return classType;
    }

    public void setClasstype(String classType) {
        this.classType = classType;
    }

    public String getAdmission() {
        return admission;
    }

    public void setAdmission(String admission) {
        this.admission = admission;
    }

    public String getRetake() {
        return retake;
    }

    public void setRetake(String retake) {
        this.retake = retake;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
    }

    public boolean isRecommended() {
        return recommended;
    }

    public void setRecommended(boolean recommended) {
        this.recommended = recommended;
    }
    

    public String getPreSubjectCode() {
        return preSubjectCode;
    }

    public void setPreSubjectCode(String preSubjectCode) {
        this.preSubjectCode = preSubjectCode;
    }

    @Override
    public int compareTo(Subject o) {
        if (this.getYear().compareTo(o.getYear()) == 0) {
            if (this.getSemester().compareTo(o.getSemester()) == 0) {
                if(this.getClasstype().compareTo(o.getClasstype()) == 0){
                    return 0;
                }
                else{
                    return this.getClasstype().compareTo(o.getClasstype());
                }
            }
            else {
                return this.getSemester().compareTo(o.getSemester());
            }
        }
        else {
            return this.getYear().compareTo(o.getYear());
        }

    }

}
