package sukang.provider;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.PreSubject;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface SubjectProvider {
 
   // public Department getDepartInfo(User user);
    /**
     * 선수과목리스트를 불러옴
     * @param subjectCode
     * @return
     * 사용자 : 박종현
     */
    public List<Subject> getPreSubjectList(String subjectCode);
    
    /**
     * 모든클래스를 가져옴
     * @param majorInfo
     * @return
     * 사용자 : 박종현, 김성진, 김승찬, 김성광
     */
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo);
    
    /**
     * 과목 기본정보 조회
     * 사용자 : 김성진
     * @param subjectCode
     * @return
     */
    public Subject readSubjectBySubjectCode(String subjectCode);
    
    /**
     * 학수구분 조회
     * @param subjectCode
     * @param majorInfo
     * @return
     * 사용자 : 김성진, 김승찬
     */
    public String readClassTypeByCode(String subjectCode, UserMajorInfo majorInfo);
    
    /**
     * 전체과목을 불러옴
     * @param user
     * @return
     *//*
    public List<Subject> getAllClassListForMajor(User user);*/
    /**
     * 전체 선수과목리스트불러옴
     * @return
     * 사용자 : 김성진
     */
    public List<Subject> getPreSubject(String subjectCode);
    /**
     * 과목코드와 입학년도로 학수구분을 부름
     * @param subjectCode
     * @param majorInfo
     * @return
     * 사용자 : 박종현
     */
    public String getClassType(String subjectCode, UserMajorInfo majorInfo);
    /**
     * 
     * @param subjectCode
     * @param admission
     * @return
     * 사용자 : 박종현, 김성진
     */
    public String getRecSemester(String subjectCode, String admission);
    /**
     * 관심사 조회
     * @param departCode
     * @param userAdminYear
     * @return
     * 사용자 : 김성광
     */
    public List<Subject> getInterest(String departCode, String userAdminYear);
    /**
     * 학과코드와 유저입학년도로 학과별 과목리스트 조회
     * @param departCode
     * @param admission
     * @return
     * 사용자 : 박종현
     */
    public List<Subject> getDepartSubjectList(String departCode, String admission);

    
    /**
     * 학과에 따른 개설과목 코드로 선수과목 코드 를 조회
     * @param subjectCode
     * @return
     *  사용자 : 김승찬
     */
    public List<Subject> getRelationCode(String subjectCode);
}