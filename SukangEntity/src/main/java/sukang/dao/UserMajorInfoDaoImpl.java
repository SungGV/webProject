package sukang.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import sukang.dao.factory.SukangSqlSessionFactory;
import sukang.dao.mapper.UserMajorInfoMapper;
import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

@Repository
public class UserMajorInfoDaoImpl implements UserMajorInfoDao {

    @Override
    public UserMajorInfo readUserMajorInfoById(String UserId) {
        
        UserMajorInfo userMajorInfo = new UserMajorInfo();
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            userMajorInfo = mapper.readUserMajorInfoById(UserId);
        }
        finally{
            sqlSession.close();
        }
        return userMajorInfo;
    }

    @Override
    public List<Subject> readCourseList(UserMajorInfo majorInfo) {

        List<Subject> subjectList = new ArrayList<Subject>();
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        Department department = new Department();
        department.setDepartCode(majorInfo.getDepartCode());
        department.setAdmission(majorInfo.getAdmission());
        
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            subjectList = mapper.readCourseList(department);
        }
        finally{
            sqlSession.close();
        } 
        
        return subjectList;
    }
    
    @Override
    public List<Subject> readDepartSubjectList(String departCode, String admission) {
        
        List<Subject> subjectList = new ArrayList<Subject>();
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        Department department = new Department();
        department.setDepartCode(departCode);
        department.setAdmission(admission);
        
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            subjectList = mapper.readCourseList(department);
        }
        finally{
            sqlSession.close();
        } 
        
        return subjectList;
    }
    
    @Override            
    public List<Report> readCompletedSubjectById(String userId) {
        List<Report> subjectList = new ArrayList<Report>();
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            subjectList = mapper.readCompletedSubjectById(userId);
        }
        finally{
            sqlSession.close();
        }
        
        return subjectList;
    }

    @Override   
    public void addUserAdditionalInfo(UserMajorInfo majorInfo) {
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            mapper.addUserAdditionalInfo(majorInfo);
        }
        finally{
            sqlSession.close();
        }
        
    }

    @Override   
    public void updateUserAdditionalInfo(UserMajorInfo majorInfo) {
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            mapper.updateUserAdditionalInfo(majorInfo);
        }
        finally{
            sqlSession.close();
        }
        
    }

    @Override
    public void deleteUserCompletedSubject(User user) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        
        try{
                UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
                mapper.deleteUserCompletedSubject(user.getUserId());
        }
        finally{
            sqlSession.close();
        }
    }

    
    
    @Override
    public void addUserCompletedSubject(User user) {
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        
        Map<String, Object> map = new HashMap<String, Object> ();
        
         List<Report> reports = user.getReport();
        
            try{
                for(Report report : reports) {
                    map.put("report", report);
                    map.put("userId", user.getUserId());
                    
                    UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
                    mapper.addUserCompletedSubject(map);
                }
            }
            finally{
                sqlSession.close();
            }
    }

    @Override
    public void insertSavedRecSubject(String userId, List<Subject> subjectList) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
    
        Map<String, Object> map = new HashMap<String, Object> ();

            try{
                for(Subject s : subjectList) {
                    map.put("userId", userId);
                    map.put("subject", s);
                    
                    UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
                    mapper.insertSavedRecSubject(map);
                }
            }
            finally{
                sqlSession.close();
            }
        
    }

    @Override
    public void deleteSavedRecSubject(String userId) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            mapper.deleteSavedRecSubject(userId);
        }
        finally{
            sqlSession.close();
        }
        
        
    }

    @Override
    public List<Subject> readSavedRecSubject(String userId) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        List<Subject> subjectList = new ArrayList<Subject>();
        
        try{
            UserMajorInfoMapper mapper = sqlSession.getMapper(UserMajorInfoMapper.class);
            subjectList = mapper.readSavedRecSubject(userId);
        }
        finally{
            sqlSession.close();
        }
        
        return subjectList;
    }

   


    
    

}
