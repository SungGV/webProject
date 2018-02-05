package sukang.domain;

import java.util.List;

public class Ui {
    
    private List<String> showYear;
    private List<String> showMajor;
    private List<String> interest;
    private String majorStatus;
    private String userMajor;
    private String userAdminYear;
    private List<Road> keyRoad;
    private List<Road> fromRoad;
    private UserMajorInfo majorInfo;
    private String comSemester;
    private String userInterest;
    
    
    public String getUserInterest() {
        return userInterest;
    }
    public void setUserInterest(String userInterest) {
        this.userInterest = userInterest;
    }
    public String getComSemester() {
        return comSemester;
    }
    public void setComSemester(String comSemester) {
        this.comSemester = comSemester;
    }
    public UserMajorInfo getMajorInfo() {
        return majorInfo;
    }
    public void setMajorInfo(UserMajorInfo majorInfo) {
        this.majorInfo = majorInfo;
    }
    public String getMajorStatus() {
        return majorStatus;
    }
    public void setMajorStatus(String majorStatus) {
        this.majorStatus = majorStatus;
    }
    
    public String getUserMajor() {
        return userMajor;
    }
    public void setUserMajor(String userMajor) {
        this.userMajor = userMajor;
    }
    public String getUserAdminYear() {
        return userAdminYear;
    }
    public void setUserAdminYear(String userAdminYear) {
        this.userAdminYear = userAdminYear;
    }
    public List<String> getShowYear() {
        return showYear;
    }
    public void setShowYear(List<String> showYear) {
        this.showYear = showYear;
    }
    public List<String> getShowMajor() {
        return showMajor;
    }
    public void setShowMajor(List<String> showMajor) {
        this.showMajor = showMajor;
    }
    public List<String> getInterest() {
        return interest;
    }
    public void setInterest(List<String> interest) {
        this.interest = interest;
    }
    public List<Road> getKeyRoad() {
        return keyRoad;
    }
    public void setKeyRoad(List<Road> keyRoad) {
        this.keyRoad = keyRoad;
    }
    public List<Road> getFromRoad() {
        return fromRoad;
    }
    public void setFromRoad(List<Road> fromRoad) {
        this.fromRoad = fromRoad;
    }
    

    
    
}
