package sukang.provider;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.dao.DepartmentDao;
import sukang.domain.Department;
import sukang.domain.PreSubject;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

@Service
public class DepartmentProviderImpl implements DepartmentProvider {
    
    @Autowired
    private DepartmentDao departDao;


    @Override
    public Department getDepartInfo(UserMajorInfo major) {
      
        
        return departDao.readDepartInfo(major);
    }

    @Override
    public List<Department> departInfoBySchool(String school) {
        
        return departDao.readDepartInfoBySchool(school);
    }


    @Override
    public List<Department> getYearInfoBySchool(String school) {
        
        return departDao.readYearInfoBySchool(school);
    }

    @Override
    public Department getDepartCode(String userMajor, String userAdmin, String status) {
       
        return departDao.readDepartCode(userMajor, userAdmin, status);
    }

    @Override
    public List<Department> getDepartCodeList(String college) {
        
        return departDao.readDepartCodeList(college);
    }

}
