package sukang.service;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface UserMajorInfoService {

    /**
     * 유저 추가정보 입력(학사정보)
     * 사용자(성광)
     * @param majorInfo
     */
    public void setUserAdditionalInfo(UserMajorInfo majorInfo);
    
    /**
     * 유저 추가 정보 수정
     * 사용자(성진)
     * @param majorInfo
     */
    public void updateUserAdditionalInfo(UserMajorInfo majorInfo);
    /**
     * 학사 정보 조회
     * 사용자(성광)
     * @param UserId
     * @return Department
     */
    public Department getDepartInfo(UserMajorInfo major);
    /**
     * 학사 정보 조회(UserId)
     * 사용자(성진, 종현, 성광)
     * @param user
     * @return user
     */
    public UserMajorInfo getUserMajorInfoById(String userId);
    
    /**
     * 학과 정보 조회(school)
     * 사용자(성광)
     * @param school
     * @return List<Department>
     */
    public List<Department> departInfoBySchool(String school);
    
    /**
     * 사용자(성광)
     * @param college
     * @return
     */
    public List<Department> getYearInfoBySchool(String college);
    
    
    /**
     * grade에서 수료한 과목 조회
     * 사용자(성진, 성광)
     * @param major
     * @return
     */
    public List<Report> getReport(UserMajorInfo major);
    
    
    
    ////////////////////////////////////////////////////////////////////
    
    /**
     * 유저 추가정보 입력(이수과목)
     * @param report
     * @param UserId
     */
    public void setUserCompletedSubject(User user);
   /* 
 
    public List<Subject> getCompletedSubjectById(String UserId);
    
    public List<Integer> percentReqTotal(String userId);
    
    *//**
     * 전공필수 수강 현황
     * @param userId
     * @return
     *//*
    public List<Integer> percentReqMajor(String userId);
    
    *//**
     * 전공선택 수강 현황
     * @param userId
     * @return
     *//*
    public List<Integer> percentReqSelection(String userId);
    
    *//**
     * 기초과목 수강 현황
     * @param userId
     * @return
     *//*
    public List<Integer> percentReqPrimary(String userId);
*/
    
}
