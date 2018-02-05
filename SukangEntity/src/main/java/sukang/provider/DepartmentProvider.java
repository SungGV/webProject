package sukang.provider;

import java.util.List;

import sukang.domain.Department;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public interface DepartmentProvider {

    public Department getDepartInfo(UserMajorInfo major);
    /**
     * 사용자(성광)
     * @param school
     * @return
     */
    public List<Department> departInfoBySchool(String school);
    /**
     * 사용자(성광)
     * @param school
     * @return
     */
    public List<Department> getYearInfoBySchool(String school);
    
    /**
     * 사용자(성광)
     * @param userMajor
     * @param userAdmin
     * @return
     */
    public Department getDepartCode(String userMajor, String userAdmin, String status);
    /**
     * 학과코드 조회 
     * 사용자(종현)
     * @return
     */
    public List<Department> getDepartCodeList(String college);
}
