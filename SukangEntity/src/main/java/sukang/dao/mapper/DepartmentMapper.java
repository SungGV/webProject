package sukang.dao.mapper;

import java.util.List;
import java.util.Map;

import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface DepartmentMapper {
   
    
    /**
     * 학과와 전공상태 조회 
     * @return Department
     */
    public Department readDepartInfo(UserMajorInfo majorInfo);
    
    
    /**
     * 학과에 따른 개설 과목 리스트 조회
     * @param department (해당 유저의 admission, departCode사용)
     * @return List<Subject>
     */
    public List<Subject> readAllClassListForMajor(Department department);
    
    
    public List<Department> readDepartInfoBySchool(String school);
    
    public List<Department> readYearInfoBySchool(String college);
    
    public Department readDepartCode(Map<String, String> map);
    
    public List<Subject> readInterest(Department department);
    /**
     * 학과별 코드 조회
     * @return
     */
    public List<Department> readDepartCodeList(String college);
}
