package sukang.provider;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.PreSubject;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface UserMajorInfoProvider {

    /**
     * 유저의 전공 정보 가지고 성적목록 조회
     * @param majorInfo
     * @return List<Report>
     *   // 사용자 : 김성진, 김성광
     */
    public List<Report> getReport(UserMajorInfo majorInfo);
    
    /**
     * 유저의 전공 정보 가지고 수료과목 목록 조회
     * @param majorInfo
     * @return List<Subject>
     *   // 사용자 : 김성진
     */
    public List<Subject> getCompletedSubjectById(UserMajorInfo majorInfo);
   
    /**
     * 유저 아이디 가지고, 유저 전공 정보 조회
     * @param userId
     * @return UserMajorInfo
     *  // 사용자 : 박종현, 김성진, 김성광, 김승찬
     */
    public UserMajorInfo getUserMajorInfoById(String userId);
    
    /**
     * 유저 아이디 가지고, 유저 정보 조회
     * @param userId
     * @return User
     */
    public User getUserById(String userId);
  
    /**
     * 유저 전공정보 가지고 추가정보 입력 처리
     * @param majorInfo
     *   // 사용자 : 김성광
     */
    public void setUserAdditionalInfo(UserMajorInfo majorInfo);
    
    /**
     * 추가정보 수정
     * @param majorInfo
     */
    public void updateUserAdditionalInfo(UserMajorInfo majorInfo);
    
    /**
     * 유저 정보 가지고 수료과목 입력 처리
     * @param user
     */
    public void setUserCompletedSubject(User user);
    
    /**
     * 추천 후에 추천된 것 저장
     * 사용자 : 김성진
     * @param userId
     * @param subjectList
     */
    public void updateSavedRecSubject(String userId, List<Subject> subjectList);
    
    
    /**
     * 추천 후 저장된 것 불러오기
     * 사용자: 김성진
     * @param userId
     * @return
     */
    public List<Subject> getSavedSubject(String userId);

    
}
