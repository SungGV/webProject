package sukang.dao;

import java.util.List;

import sukang.domain.PreSubject;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface SubjectDao {
    
    /**
     * 과목 코드로 기본 과목 목록 조회(subject_tb)
     * @param subjectCode
     * @return Subject
     */
   public Subject readSubjectBySubjectCode(String subjectCode);
   
    /**
     * 과목 코드로 선수과목 목록 조회(presubject_tb)
     * @param subjectCode
     * @return List<Subject>
     */
    public List<Subject> readPreSubjectListBySubjectCode(String subjectCode);
    
    /**
     * 전체선수과목조회
     * @return List<Subject>
     */
    public List<Subject> readPreSubject();
    /**
     * 학과코드로 추천학기 조회(recSemester_tb)
     * 과목 코드, 입학연도 로 추천학기 조회(recSemester_tb)
     * @param subjectCode, admission
     * @return Integer
     */
    public String readRecSemesterByCode(String subjectCode, String admission);

    
    
    /**
     * 과목 코드, 전공정보 로 학수구분 조회(classtype_tb)
     * @param subjectCode, majorInfo(admission, major에 따른)
     * @return String
     */
    public String readClassTypeByCode(String subjectCode, UserMajorInfo majorInfo);

    
    
    /**
     * 과목 코드 로 선수과목 코드, 선수과목 명 조회
     * @param subjectCode
     * @return
     */
    public List<Subject> getRelationCode(String subjectCode);
    
    public Subject readSubjectName(String subjectCode);
    
    public List<Subject> readDistinctPreSubject();
    
   
    
    
    
  
   
}
