package sukang.dao;

import java.util.List;

import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface UserMajorInfoDao {
    
    
    /**
     * 유저의 아이디로 유저의 전공관련 정보 조회(majorinfo_tb)
     * @return UsermajorInfo
     */
    public UserMajorInfo readUserMajorInfoById(String userId);
    
    /**
     * 유저의 학과 및 전공상태 에 해당하는  과목리스트(reqsubject_tb) 조회
     * @param majorInfo (departCode, status, admission)
     * @return
     */
    public List<Subject> readCourseList(UserMajorInfo majorInfo);
    
    /**
     * 유저의 수료과목 리스트 조회(complement_st_tb)
     * @param getUserId
     * @return
     */
    public List<Report> readCompletedSubjectById(String userId);
    
    
    /**
     * 추천된 과목 저장
     * @param userId
     * @param subjectList
     */
    public void insertSavedRecSubject(String userId, List<Subject> subjectList);
   
    /**
     * 추천된 과목 저장 전에 삭제
     * @param userId
     */
    public void deleteSavedRecSubject(String userId);
    
    
    public List<Subject> readSavedRecSubject(String userId);

    

  
    
    /** 
     * 유저 상세정보 입력
     * @param majorInfo
     */
    public void addUserAdditionalInfo(UserMajorInfo majorInfo);

    /**
     * 유저 추가정보 수정
     * @param majorInfo
     */
    public void updateUserAdditionalInfo(UserMajorInfo majorInfo);
    /**
     * 유저 이수과목 추가
     * @param report
     * @param UserId
     */
    public void addUserCompletedSubject(User user);
    
    /**
     * 유저 이수과목 추가 전 삭제
     * @param user
     */
    public void deleteUserCompletedSubject(User user);
    
    /**
     * 학과코드와 유저입학년도로 학과별 과목조회
     * @param departCode
     * @param admission
     * @return
     */
    public List<Subject> readDepartSubjectList(String departCode, String admission);
    

}
