package sukang.provider;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.dao.DepartmentDao;
import sukang.dao.SubjectDao;
import sukang.dao.UserMajorInfoDao;
import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
@Service
public class SubjectProviderImpl implements SubjectProvider {

    @Autowired
    private SubjectDao subjectDao;
    @Autowired
    private DepartmentDao departDao;
    @Autowired
    private UserMajorInfoDao usermajorInfoDao;
    

    /*@Override
    public Department getDepartInfo(User user) {
       UserMajorInfo majorInfo = user.getUserMajorInfo();
       
       
        return departDao.readDepartInfo(majorInfo);
    }*/

    @Override
    public List<Subject> getPreSubjectList(String subjectCode) {        
        
        return subjectDao.readPreSubjectListBySubjectCode(subjectCode);
    }

    @Override
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo) {
        

        return usermajorInfoDao.readCourseList(majorInfo);
        
    }

   /* @Override
    public Subject readSubjectBySubjectCode(String subjectCode) {
        
        return subjectDao.readSubjectBySubjectCode(subjectCode);
    }*/

    /**
     * 학수구분 조회
     * @param SubjectCode , MajorInfo(admission, major)
     * 
     */
    @Override
    public String readClassTypeByCode(String subjectCode, UserMajorInfo majorInfo) {
        // 
        return subjectDao.readClassTypeByCode(subjectCode, majorInfo);
    }

    @Override
    public List<Subject> getInterest(String departCode, String userAdminYear) {
        Department depart = new Department();
        depart.setDepartCode(departCode);
        depart.setAdmission(userAdminYear);
       
        return departDao.readInterest(depart);
    }

   /* @Override
    public List<Subject> getAllClassListForMajor(User user) {
        // TODO Auto-generated method stub
        return null;
    }*/
//
    @Override
    public List<Subject> getPreSubject(String subjectCode) {
        // TODO Auto-generated method stub
        return subjectDao.readPreSubjectListBySubjectCode(subjectCode);
    }

    @Override
    public String getClassType(String subjectCode, UserMajorInfo majorInfo) {
        // TODO Auto-generated method stub
        return subjectDao.readClassTypeByCode(subjectCode, majorInfo);
    }

    @Override
    public String getRecSemester(String subjectCode, String admission) {
        return subjectDao.readRecSemesterByCode(subjectCode, admission);
    }

    @Override
    public List<Subject> getDepartSubjectList(String departCode, String admission) {
        return usermajorInfoDao.readDepartSubjectList(departCode, admission);
        // TODO Auto-generated method stub
    }

    @Override
    public List<Subject> getRelationCode(String subjectCode) {
        //
        return subjectDao.getRelationCode(subjectCode);
    }

    @Override
    public Subject readSubjectBySubjectCode(String subjectCode) {
        
        return subjectDao.readSubjectBySubjectCode(subjectCode);
    }
}