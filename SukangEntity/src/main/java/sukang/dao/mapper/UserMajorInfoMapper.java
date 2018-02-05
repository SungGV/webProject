package sukang.dao.mapper;

import java.util.List;
import java.util.Map;

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface UserMajorInfoMapper {

    public UserMajorInfo readUserMajorInfoById(String userId);
    
    public List<Subject> readCourseList(Department department);
    
    public List<Report> readCompletedSubjectById(String userId);
    
    public void updateUserAdditionalInfo(UserMajorInfo majorInfo);
    
    public void addUserAdditionalInfo(UserMajorInfo majorInfo);
    
    public void deleteUserCompletedSubject(String userId);
    
    public void addUserCompletedSubject(Map<String, Object> map);
    
    public void insertSavedRecSubject(Map<String, Object> map);
    
    public void deleteSavedRecSubject(String userId);
    
    public List<Subject> readSavedRecSubject(String userId);
}
