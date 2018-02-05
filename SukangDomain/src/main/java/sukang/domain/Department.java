package sukang.domain;

import java.util.List;

public class Department {

    private String depart;
    private String departCode;
    private String admission;
    private String major;
    private String status;
    private int needCreditForRequirement;             //전필필요학점
    private int needCreditForSelective;               //전선필요학점
    private int needCreditForBasic;                   //기초필요학점
    private int needCreditForGraduation;              //필요총학점
    private List<Subject> subject;
    
   
    public String getDepart() {
        return depart;
    }
    public void setDepart(String depart) {
        this.depart = depart;
    }
    public String getDepartCode() {
        return departCode;
    }
    public void setDepartCode(String departCode) {
        this.departCode = departCode;
    }
    public int getNeedCreditForRequirement() {
        return needCreditForRequirement;
    }
    public void setNeedCreditForRequirement(int needCreditForRequirement) {
        this.needCreditForRequirement = needCreditForRequirement;
    }
    public int getNeedCreditForSelective() {
        return needCreditForSelective;
    }
    public void setNeedCreditForSelective(int needCreditForSelective) {
        this.needCreditForSelective = needCreditForSelective;
    }
    public int getNeedCreditForBasic() {
        return needCreditForBasic;
    }
    public void setNeedCreditForBasic(int needCreditForBasic) {
        this.needCreditForBasic = needCreditForBasic;
    }
    public int getNeedCreditForGraduation() {
        return needCreditForGraduation;
    }
    public void setNeedCreditForGraduation(int needCreditForGraduation) {
        this.needCreditForGraduation = needCreditForGraduation;
    }
    public List<Subject> getSubject() {
        return subject;
    }
    public void setSubject(List<Subject> subject) {
        this.subject = subject;
    }
    public String getAdmission() {
        return admission;
    }
    public void setAdmission(String admission) {
        this.admission = admission;
    }
    public String getMajor() {
        return major;
    }
    public void setMajor(String major) {
        this.major = major;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    
   
    
}
