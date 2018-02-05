package sukang.dao;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;

public interface DepartmentDao {
    
    /**
     * 학과와 전공상태 조회 (depart_tb)
     * @param UsermajorInfo (departCode, admission, status)
     * @return Department
     */
    public Department readDepartInfo(UserMajorInfo majorInfo);
    
    
    /**
     * 학과에 따른 개설 과목 리스트 조회(reqsubject_tb)
     * @param Department(departCode, admission)
     * @return List<Subject>
     */
    public List<Subject> readAllClassListForMajor(Department department);
    
    
    public List<Department> readDepartInfoBySchool(String school);
    
    public List<Department> readYearInfoBySchool(String college);
    
    public Department readDepartCode(String userMajor, String userAdmin, String interest);
    
    public List<Subject> readInterest(Department department);
    /**
     * 학과코드 부르기
     * @return
     */
    public List<Department> readDepartCodeList(String college);
}
