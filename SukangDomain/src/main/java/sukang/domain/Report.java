package sukang.domain;

public class Report implements Comparable<Report>{

    private double grade;
    private String typeOfClass;                     // 학수구분
    private String completedSemester;
    private String retake;                       // 재수강 신청여부
    private String subjectCode;
    private Subject subject;
    private UserMajorInfo userMajorInfo;
    private String grade2;


    public String getGrade2() {
        return grade2;
    }
    public void setGrade2(String grade2) {
        this.grade2 = grade2;
    }
    public double getGrade() {
        return grade;
    }
    public void setGrade(double grade) {
        this.grade = grade;
    }
    public String getTypeOfClass() {
        return typeOfClass;
    }
    public void setTypeOfClass(String typeOfClass) {
        this.typeOfClass = typeOfClass;
    }
    public String getCompletedSemester() {
        return completedSemester;
    }
    public void setCompletedSemester(String completedSemester) {
        this.completedSemester = completedSemester;
    }    
    public String getRetake() {
        return retake;
    }
    public void setRetake(String retake) {
        this.retake = retake;
    }
    public Subject getSubject() {
        return subject;
    }
    public void setSubject(Subject subject) {
        this.subject = subject;
    }
    public UserMajorInfo getUserMajorInfo() {
        return userMajorInfo;
    }
    public void setUserMajorInfo(UserMajorInfo userMajorInfo) {
        this.userMajorInfo = userMajorInfo;
    }
    public String getSubjectCode() {
        return subjectCode;
    }
    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }
    
    @Override
    public int compareTo(Report o) {
        if (this.getCompletedSemester().compareTo(o.getCompletedSemester()) == 0) {
           /* if (this.getTypeOfClass().compareTo(o.getTypeOfClass()) == 0) {
                return 0;
            }
            else {
                return this.getTypeOfClass().compareTo(o.getTypeOfClass());
            }*/
            return 0;
        }
        else {
            return this.getCompletedSemester().compareTo(o.getCompletedSemester());
        }
       

    }
    
}
