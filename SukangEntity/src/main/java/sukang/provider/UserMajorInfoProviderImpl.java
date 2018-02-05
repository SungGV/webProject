package sukang.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.dao.SubjectDao;
import sukang.dao.UserDao;
import sukang.dao.UserMajorInfoDao;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

@Service
public class UserMajorInfoProviderImpl implements UserMajorInfoProvider {

    @Autowired
    private UserMajorInfoDao userDao;
    @Autowired
    private UserDao uDao;
    @Autowired
    private SubjectDao subjectDao;

    @Override
    public List<Report> getReport(UserMajorInfo majorInfo) {
        List<Report> reportList = new ArrayList<Report>();
       
        reportList = userDao.readCompletedSubjectById(majorInfo.getUserId());
        
        

        //report에 있는 code로 subject의 기본정보를 받아옴
        for (Report report : reportList) {
            Subject subject = new Subject();
            subject = subjectDao.readSubjectBySubjectCode(report.getSubjectCode());
            subject.setClasstype(subjectDao.readClassTypeByCode(report.getSubjectCode(), majorInfo));
            report.setSubject(subject);
        }
        
        return reportList;
    }
    
    
    @Override
    public List<Subject> getCompletedSubjectById(UserMajorInfo majorInfo) {
        List<Report> reportList = userDao.readCompletedSubjectById(majorInfo.getUserId());
        List<Subject> comSubjectList = new ArrayList<Subject>();

        Subject s2 = new Subject();
        
        //report에 있는 code로 subject의 기본정보를 받아옴
        for (Report report : reportList) {
            s2 = subjectDao.readSubjectBySubjectCode(report.getSubjectCode());
            s2.setClasstype(subjectDao.readClassTypeByCode(report.getSubjectCode(), majorInfo));
            s2.setRetake(report.getRetake());
            
            comSubjectList.add(s2);
            
        }
        
        return comSubjectList;
    }

    @Override
    public UserMajorInfo getUserMajorInfoById(String userId) {
        
        return userDao.readUserMajorInfoById(userId);
    }

    @Override
    public void setUserAdditionalInfo(UserMajorInfo majorInfo) {
        
        userDao.addUserAdditionalInfo(majorInfo);
    }

    public void updateUserAdditionalInfo(UserMajorInfo majorInfo){
        userDao.updateUserAdditionalInfo(majorInfo);
       
    }
    
    @Override
    public User getUserById(String userId) {
        
        // TODO Auto-generated method stub
        return uDao.readUserById(userId);
    }


    @Override
    public void setUserCompletedSubject(User user) {
        userDao.deleteUserCompletedSubject(user);
        
        userDao.addUserCompletedSubject(user);
        
    }


    @Override
    public void updateSavedRecSubject(String userId, List<Subject> subjectList) {
        userDao.deleteSavedRecSubject(userId);
        
        userDao.insertSavedRecSubject(userId, subjectList);
        
    }


    @Override
    public List<Subject> getSavedSubject(String userId) {
        
        return userDao.readSavedRecSubject(userId);
    }
    

}
