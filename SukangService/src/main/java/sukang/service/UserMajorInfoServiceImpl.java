package sukang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.provider.DepartmentProvider;
import sukang.provider.SubjectProvider;
import sukang.provider.UserMajorInfoProvider;

@Service
public class UserMajorInfoServiceImpl implements UserMajorInfoService {

    @Autowired
    private UserMajorInfoProvider userProvider;
    @Autowired
    private DepartmentProvider depart;
    @Autowired
    private SubjectProvider subject;
    
    
    @Override
    public List<Report> getReport(UserMajorInfo majorInfo) {
        
        return userProvider.getReport(majorInfo);
        
    }

    @Override
    public UserMajorInfo getUserMajorInfoById(String UserId) {
        
        return userProvider.getUserMajorInfoById(UserId);
    }

    @Override
    public void setUserAdditionalInfo(UserMajorInfo majorInfo) {
        userProvider.setUserAdditionalInfo(majorInfo);
        
    }

    public void updateUserAdditionalInfo(UserMajorInfo majorInfo) {
        userProvider.updateUserAdditionalInfo(majorInfo);
        
    }
    
    @Override
    public void setUserCompletedSubject(User user) {
        userProvider.setUserCompletedSubject(user);
        
        
    }

    @Override
    public List<Department> departInfoBySchool(String school) {
        
        return depart.departInfoBySchool(school);
    }

    @Override
    public List<Department> getYearInfoBySchool(String college) {
        
        return depart.getYearInfoBySchool(college);
    }



    @Override
    public Department getDepartInfo(UserMajorInfo major) {
        return depart.getDepartInfo(major);
    }

   

}
