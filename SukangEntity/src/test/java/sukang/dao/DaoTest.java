package sukang.dao;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Road;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public class DaoTest {
    
    @Test
    public void readUserMajorInfoByIdTest(){
        String userId = "sungjin@naver.com";
        UserMajorInfoDao dao = new UserMajorInfoDaoImpl();
        
        UserMajorInfo majorInfo = dao.readUserMajorInfoById(userId);
        
        System.out.println(majorInfo.getUserId());
        System.out.println(majorInfo.getMajor());
        System.out.println(majorInfo.getComSemester());
    }
    
    @Test
    public void readCourseListTest(){
        String departcode = "AJ001";
        String status = "전공심화";
        UserMajorInfo majorInfo = new UserMajorInfo();
        majorInfo.setDepartCode(departcode);
        majorInfo.setStatus(status);
        majorInfo.setAdmission("2014");
        
        UserMajorInfoDao dao = new UserMajorInfoDaoImpl();
        
        List<Subject> subjectList = new ArrayList<Subject>();
        
        subjectList = dao.readCourseList(majorInfo);
        
        
        for(Subject subject : subjectList){
            System.out.println(subject.getSubjectName());
        }
    }
    
    @Test
    public void readCompletedSubjectByIdTest(){
        List<Report> report = new ArrayList<Report>();
        
        String userId = "sungjin@naver.com";
        
        UserMajorInfoDao dao = new UserMajorInfoDaoImpl();
        
        report = dao.readCompletedSubjectById(userId);
        
        for(Report reports : report){
           // System.out.println(subject.getGrade());
            //List<Subject> subject = reports.getSubject();
            
            System.out.println(reports.getCompletedSemester() + ",  " +
                    reports.getRetake() + ",  " + reports.getGrade()
                    + reports.getSubjectCode());
             
         /*   for(Subject subjects : subject) {
                System.out.println(subjects.getSubjectName() + ", "
                    + subjects.getCredit());
        }*/
            }
            
            
    }
    
    @Test
    public void addUserAdditionalInfoTest() {
        UserMajorInfoDao dao = new UserMajorInfoDaoImpl();
        UserMajorInfo major = new UserMajorInfo();
        major.setInterest("프로그래밍");
        major.setComSemester("2");
        major.setMajor("통계");
        major.setStatus("전공심화");
        major.setAdmission("2014");
        major.setDepartCode("AJ001");
        major.setUserId("test");
        major.setCollege("좋은대학");
        major.setStudentId("84545");
        dao.addUserAdditionalInfo(major);
        
    }
    @Test
    public void addUserCompletedSubjetTest() {
        UserMajorInfoDao dao = new UserMajorInfoDaoImpl();
        User user = new User();
        Report report = new Report();
        report.setSubjectCode("B001");
        report.setGrade(4);
        report.setCompletedSemester("12");
        report.setRetake("2");
        List<Report> list = new ArrayList<Report> ();
        list.add(report);
        
        user.setReport(list);
        user.setUserId("kimsung0922@gmail.com");
        
        dao.addUserCompletedSubject(user);
    }
    
    /////////////////////////////Subject//////////////////////
    
    @Test
    public void readSubjectBySubjectCodeTest(){
        String subjectCode = "M001";
        
        SubjectDao dao = new SubjectDaoImpl();
        
        Subject subject = dao.readSubjectBySubjectCode(subjectCode);
        
        System.out.println(subject.getSubjectName()); 
    }
    
    @Test
    public void readPreSubjectListBySubjectCodeTest(){
        String subjectCode = "S003";
        
        SubjectDao dao = new SubjectDaoImpl();
        
        List<Subject> subjectList = new ArrayList<Subject>();
        
        subjectList = dao.readPreSubjectListBySubjectCode(subjectCode);
        
        for(Subject subject : subjectList){
            System.out.println(subject.getSubjectName());
        }
    }
    
    @Test
    public void readClassTypeByCodeTest(){
        UserMajorInfo majorInfo = new UserMajorInfo();
        majorInfo.setAdmission("2014");
        majorInfo.setMajor("미디어");
        String subjectCode = "M001";
        
        SubjectDao dao = new SubjectDaoImpl();
        
        String classType = dao.readClassTypeByCode(subjectCode, majorInfo);
        
        System.out.println(classType);
    }
    
    @Test
    public void readRecSemesterByCodeTest(){
        String subjectCode = "M001";
        String admission = "2014";
        
        SubjectDao dao = new SubjectDaoImpl();
        
        int recSemester = dao.readRecSemesterByCode(subjectCode, admission);
        
        System.out.println(recSemester);
    }
    
    ////////////////////////////department////////////////////////
    
    @Test
    public void readDepartInfoTest(){
      
        UserMajorInfo majorInfo = new UserMajorInfo();
 
        majorInfo.setDepartCode("AJ001");
        majorInfo.setAdmission("2013");
        majorInfo.setStatus("전공심화");
        
        DepartmentDao dao = new DepartmentDaoImpl();
        Department department = dao.readDepartInfo(majorInfo);
        
        System.out.println(department.getNeedCreditForGraduation());
    }
    
    @Test
    public void readAllClassListForMajorTest(){
        DepartmentDao dao = new DepartmentDaoImpl();
        Department department = new Department();
        department.setAdmission("2013");
        department.setDepartCode("AJ001");
        
        List<Subject> subjectList = dao.readAllClassListForMajor(department);
        
        for(Subject s : subjectList){
            System.out.println(s.getSubjectName()+ ", " + s.getSubjectCode() + ", " + s.getCredit() + s.getInterest());
        }
    }
    
    @Test
    public void readDepartInfoBySchool() {
        
        DepartmentDao dao = new DepartmentDaoImpl();
        String college = "AJ001";
        
        List<Department> list = dao.readDepartInfoBySchool(college);
        
        for(Department lists : list) {
            System.out.println(lists.getDepartCode());
        }
       
    }
    
    @Test
    public void readDepartCode() {
        
        DepartmentDao guide = new DepartmentDaoImpl();

        Department depart = guide.readDepartCode("미디어", "2013");
        System.out.println(depart.getDepartCode());
    }
    
    /**
     * From 기본값 false 
     */
    @Test
    public void readRoad() {
        
        Road road = new Road();
        
        System.out.println(road.isFrom());
    }
}
