package sukang.domain;

import java.util.List;

public class User {

    private String userId;
    private String password;
    private String name;
    private String birth;
    private String email;
    private String phone;
    private String address;
    
    private UserMajorInfo UserMajorInfo;
    private List<Report> Report;
    
    
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getBirth() {
        return birth;
    }
    public void setBirth(String birth) {
        this.birth = birth;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public UserMajorInfo getUserMajorInfo() {
        return UserMajorInfo;
    }
    public void setUserMajorInfo(UserMajorInfo userMajorInfo) {
        UserMajorInfo = userMajorInfo;
    }
    public List<Report> getReport() {
        return Report;
    }
    public void setReport(List<Report> report) {
        Report = report;
    }
    
    
    
    
    
}
