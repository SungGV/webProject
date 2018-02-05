package sukang.service;

import java.util.List;

import sukang.domain.Road;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface RoadMapService {

    /**
     * 사용자 전공 정보 조회
     * @param UserId
     * @return UserMajorInfo
     */
    public UserMajorInfo getUserMajorInfoById(String UserId);

    /**
     * 선수 과목 리스트 조회
     * @param subjectCode
     * @return List<Subject>
     */
    public List<Subject> getPreSubjectList(String subjectCode);
    
    /**
     * 학과 전체과목 리스트 조회(departCode, status, adminYear)
     * @param user
     * @return List<Subject>
     */
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo);
    
   /**
    * @param departCode
    * @param userAdminYear
    * @return
    *  //사용자 : 김성광
    */
    public List<Subject> getInterest(String departCode, String userAdminYear);
    
    
    /**
     * use컨트롤러 RoadMap컨트롤러 
     * user의 학과 코드를 받아와서 ,
     * 학과에따른 개설과목 목록 을
     * 선수 과목을 분류하여 controller 로 보내는 method
     * @param userId
     * @return List<Subject>
     *   //사용자 : 김승찬
     */
    public List<Road> getAllSubjectListForMajor(String userId);
    
    /**
     * 과목 코드로 선수 과목 코드, 과목 코드, 과목명 을 받는 메소드
     * @param subjectCode
     * @return
     *   //사용자 : 김승찬
     */
    public List<Subject> getRelationCode(String subjectCode);
    
}
