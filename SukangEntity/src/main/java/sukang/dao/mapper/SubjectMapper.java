package sukang.dao.mapper;

import java.util.List;
import java.util.Map;

import sukang.domain.PreSubject;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface SubjectMapper {

    /**
     * 학과 코드로 과목정보 조회
     * @param subjectCode
     * @return
     */
   public Subject readSubjectBySubjectCode(String subjectCode);
    
    /**
     * 선수과목 리스트 조회
     * @return List<Subject>
     */
    public List<Subject> readPreSubjectList(String subjectCode);
    
    /**
     * 선수과목리스트 죄다조회
     * @return
     */
    public List<Subject> readPreSubject();
    /**
     * 학과코드로 추천학기 조회(int형)
     * @param subjectCode
     * @return
     */
    public String readRecSemesterByCode(Map<String, String> map);
    public int readRecSemesterByCodee(String subjectCode);
    /**
     * 학과코드로 학수구분 조회(string형)
     * @param subjectCode
     * @return
     */
    public String readClassTypeByCode(Map<String, Object> map);
    
    public List<Subject> getRelationCode(String subjectCode);
    
    public Subject readSubjectName(String subjectCode);
    
    public List<Subject> readDistinctPreSubject();
    
    
}
