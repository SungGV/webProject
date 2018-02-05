package sukang.service;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sukang.domain.Department;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public class UserMajorInfoServiceTest {

    @Test
    public void test() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        UserMajorInfoService service = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        
        User user = new User();
        UserMajorInfo major = new UserMajorInfo();
        major.setDepartCode("학과정보");
        major.setStatus("학과상태");
        user.setUserMajorInfo(major);
        
        service.getDepartInfo(user);
        
        //완료!
    }
    
    @Test
    public void readDepartInfoTest(){
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        UserMajorInfoService service = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        
        String college = "AJ";
      
        List<Department> list = service.departInfoBySchool(college);
        
        for(Department lists : list) {
            System.out.println(lists.getMajor());
        }
       
    }
    
    @Test
    public void readYearInfoTest(){
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        UserMajorInfoService service = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        
        String college = "AJ";
      
        List<Department> list = service.getYearInfoBySchool(college);
        
        for(Department lists : list) {
            System.out.println(lists.getAdmission());
        }
       
    }
}
