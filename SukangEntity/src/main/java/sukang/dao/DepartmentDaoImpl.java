package sukang.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import sukang.dao.factory.SukangSqlSessionFactory;
import sukang.dao.mapper.DepartmentMapper;
import sukang.dao.mapper.UserMajorInfoMapper;
import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

@Repository
public class DepartmentDaoImpl implements DepartmentDao {

    @Override
    public Department readDepartInfo(UserMajorInfo majorInfo) {

        Department department = new Department();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();


        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            department = mapper.readDepartInfo(majorInfo);
        }
        finally{
            sqlSession.close();
        }
        return department;

    }

    @Override
    public List<Subject> readAllClassListForMajor(Department department) {

        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            subjectList = mapper.readAllClassListForMajor(department);
        }
        finally{
            sqlSession.close();
        }
        return subjectList;
    }

    @Override
    public List<Department> readDepartInfoBySchool(String school) {

        List<Department> depart = new ArrayList<Department>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            depart = mapper.readDepartInfoBySchool(school);
        }
        finally{
            sqlSession.close();
        }

        return depart;

    }

    @Override
    public List<Department> readYearInfoBySchool(String college) {
        List<Department> depart = new ArrayList<Department>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            depart = mapper.readYearInfoBySchool(college);
        }
        finally{
            sqlSession.close();
        }

        return depart;
    }

    @Override
    public Department readDepartCode(String userMajor, String userAdmin, String status) {
        Department department = new Department();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();

        Map<String, String> map = new HashMap<String, String>();
        map.put("userMajor", userMajor);
        map.put("userAdmin", userAdmin);
        map.put("status", status);

        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            department = mapper.readDepartCode(map);
        }
        finally{
            sqlSession.close();
        }

        return department;
    }

    @Override
    public List<Subject> readInterest(Department department) {

        List<Subject> subjectList = new ArrayList<Subject>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();

        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            subjectList = mapper.readInterest(department);
        }
        finally{
            sqlSession.close();
        } 

        return subjectList;
    }

    @Override
    public List<Department> readDepartCodeList(String college) {
        List<Department> departmentList = new ArrayList<Department>();

        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();

        try{
            DepartmentMapper mapper = sqlSession.getMapper(DepartmentMapper.class);
            departmentList = mapper.readDepartCodeList(college);
        }
        finally{
            sqlSession.close();
        } 

        return departmentList;
    }

}
