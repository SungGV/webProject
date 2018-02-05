package sukang.service;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface GuideLineService {
    
    /**
     * 요람정보가 담긴 리스트 
     * @param userId
     * @return
     * 사용자 : 박종현
     */
    public List<Subject> yolam(String userId);
   
    /**
     * 학과별 조회
     * @return
     * 사용자:박종현
     */
    public List<Department> getDepartCodeList(String college);
    /**
     * 선수과목리스트 죄다조회
     * @return List<Subject>
     * 사용자 : 김성진
     */
    public List<Subject> getPreSubject(String subjectCode);
    
    /**
    *
    * @param userMajor
    * @param userAdmin
    * @return
    * 사용자 : 김성광
    */
   public Department getDepartCode(String userMajor, String userAdmin, String status);
   /**
    * 학과별로 과목리스트 조회
    * @return List<Subject>
    * 사용자 : 박종현
    */
   public List<Subject> getDepartSubjectList(String departCode, String admission, UserMajorInfo major);
   
 
    
  
    

 
    
  
    
    
    
    


    /**
    *  학과정보 조회. User 타입의 파라미터로 보내지만 provider에서
    *  UserMajorInfo 형태의  status, adminYear, departCode로 변환하여 조회한다
    * @param user
    * @return Department
    */
   public Department getDepartInfo(UserMajorInfo majorInfo);
   /**
    * 과목코드로 학수구분 조회
    * @param subjectCode
    * @param majorInfo
    * @return
    */
  // public String getClassType(String subjectCode, UserMajorInfo majorInfo); 
   /**
    * 학과 과목리스트 조회(status, adminYear, departCode)
    * @param user
    * @return List<Subject>
    */
   //public List<Subject> getCourseList(User user);
   /**
    * 학사 정보 조회
    * @param UserId
    * @return UserMajorInfo
    */
  // public UserMajorInfo getUserMajorInfoById(String UserId);
   //public String getRecSemester(String subjectCode, String admission);
}
