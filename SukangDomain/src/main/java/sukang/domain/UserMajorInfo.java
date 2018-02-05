package sukang.domain;

public class UserMajorInfo {

    private String userId;
    private String status;                      // 전공상태
    private String admission;               // 입학년도
    private String college;                      // 학교명
    private String studentId;                 // 학번
    private String major;                       // 전공
    private String comSemester;  // 이수학기
    private String interest;                     // 관심사
    private String departCode;       // 학과 코드
    
    
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getStudentId() {
        return studentId;
    }
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    public String getMajor() {
        return major;
    }
    public void setMajor(String major) {
        this.major = major;
    }
    public String getInterest() {
        return interest;
    }
    public void setInterest(String interest) {
        this.interest = interest;
    }
    
    public String getCollege() {
        return college;
    }
    public void setCollege(String college) {
        this.college = college;
    }
    public String getComSemester() {
        return comSemester;
    }
    public void setComSemester(String comSemester) {
        this.comSemester = comSemester;
    }
    public String getAdmission() {
        return admission;
    }
    public void setAdmission(String admission) {
        this.admission = admission;
    }
    public String getDepartCode() {
        return departCode;
    }
    public void setDepartCode(String departCode) {
        this.departCode = departCode;
    }
    
}
