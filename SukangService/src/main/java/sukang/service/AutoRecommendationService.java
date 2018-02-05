package sukang.service;

import java.util.List;

import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface AutoRecommendationService {
    
   
    
   
    /**
     * 학과 전체과목 리스트 조회(departCode, status, adminYear)
     * 사용자 : 김성광(addtionalController)
     * @param user
     * @return List<Subject>
     */
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo);
   
    /**
     * User가 수료한 과목 이외의 모든 학과에 있는 과목 list
     * 사용자 : 김성진(auto)
     * @param user (userId)
     * @return List<Subject>
     */
    public List<Subject> getListToRecSubject(UserMajorInfo majorInfo);
    
    /**
     * 해당 과목 추천 학기 출력
     * 사용자 : 김성진(auto)
     * @param subjectCode
     * @param admission(입학년도)
     * @return String
     */
    public String getRecSemester(String subjectCode, String admission);
    

    /**
     * 추천된 과목 저장
     * 사용자 : 김성진(auto)
     * @param userId
     * @param subjectList
     */
    public void setSavedSubject(String userId, List<Subject> subjectList);
    
    /**
     * 추천된 과목 받아오기
     * 사용자 : 김성진(auto)
     * @param userId
     * @return
     */
    public List<Subject> getSavedSubject(String userId);

    
    /**
     * 학과 코드로 선수과목 가져오기
     * 사용자 : 김성진(auto)
     * @param subjectCode
     * @param majorInfo
     * @return
     */
    public String getClassTypeByCode(String subjectCode, UserMajorInfo majorInfo);
    
    /**
     * 과목 코드로 과목 기본정보 조회
     * 사용자 : 김성진(auto)
     * @param subjectCode
     * @return
     */
    public Subject getSubjectByCode(String subjectCode);
}
