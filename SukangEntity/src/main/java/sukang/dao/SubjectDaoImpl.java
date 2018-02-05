package sukang.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import sukang.dao.factory.SukangSqlSessionFactory;
import sukang.dao.mapper.SubjectMapper;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

@Repository
public class SubjectDaoImpl implements SubjectDao {

    @Override
    public Subject readSubjectBySubjectCode(String subjectCode) {
        Subject subject;

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();

        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subject = mapper.readSubjectBySubjectCode(subjectCode);
        }
        finally{
            sqlSession.close();
        }

        return subject;
    }

    @Override
    public List<Subject> readPreSubjectListBySubjectCode(String subjectCode) {

        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subjectList = mapper.readPreSubjectList(subjectCode);
        }
        finally{
            sqlSession.close();
        }

        return subjectList;
    }
    @Override
    public List<Subject> readPreSubject() {
        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subjectList = mapper.readPreSubject();
        }
        finally{
            sqlSession.close();
        }

        return subjectList;
    }

    @Override
    public String readRecSemesterByCode(String subjectCode, String admission) {
        
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();

        Map<String, String> map = new HashMap<String, String>();
        map.put("subjectCode", subjectCode);
        map.put("admission", admission);

        String recSemester=null;
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            recSemester = mapper.readRecSemesterByCode(map);
        }
        finally{
            sqlSession.close();
        }
        return recSemester;
    }
    
   

    @Override
    public String readClassTypeByCode(String subjectCode, UserMajorInfo majorInfo) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("subjectCode", subjectCode);
        map.put("majorInfo", majorInfo);

        String classType;
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            classType = mapper.readClassTypeByCode(map);
        }
        finally{
            sqlSession.close();
        }
        return classType;
    }

    @Override
    public List<Subject> getRelationCode(String subjectCode) {
        
        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subjectList = mapper.getRelationCode(subjectCode);
        }
        finally{
            sqlSession.close();
        }

        return subjectList;
    }

    @Override
    public Subject readSubjectName(String subjectCode) {
        Subject subject = new Subject();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subject = mapper.readSubjectName(subjectCode);
        }
        finally{
            sqlSession.close();
        }

        return subject;
    }

    @Override
    public List<Subject> readDistinctPreSubject() {
        
        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            SubjectMapper mapper = sqlSession.getMapper(SubjectMapper.class);
            subjectList = mapper.readDistinctPreSubject();
        }
        finally{
            sqlSession.close();
        }

        return subjectList;
    }

}
