package sukang.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;

public class AutoRecommendationServiceTest {

    @Test
    public void test() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        AutoRecommendationService service = ac.getBean("autoRecommendationServiceImpl", AutoRecommendationServiceImpl.class);

        service.getCompletedSubject("ss");

        User user = new User();
        UserMajorInfo major = new UserMajorInfo();
        major.setDepartCode("학과정보");
        major.setStatus("학과상태");
        user.setUserMajorInfo(major);

        service.getAllClassListForMajor(user);

    }

    @Test
    public void getCompSubjectListTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        AutoRecommendationService service = ac.getBean("autoRecommendationServiceImpl", AutoRecommendationServiceImpl.class);
        UserMajorInfoService majorService = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoService.class);
        

        //user_id를 Jsp 에서 받을 예정임
        
        /*String userId = "sungjin@naver.com";
        UserMajorInfo usermajor = majorService.getUserMajorInfoById(userId);
        List<Subject> subjectList = service.getCompletedSubject(usermajor);
        
        for(Subject s : subjectList){
            
            System.out.println(s.getInterest());
           
        }*/
        
        String userId = "sungjin@naver.com";
        UserMajorInfo major = majorService.getUserMajorInfoById(userId);
        
        List<Report> reports = new ArrayList<Report>();
        reports = majorService.getReport(major);
        
        for(Report r : reports){
            Subject s = r.getSubject();
            System.out.println(s.getSubjectName());
            System.out.println(s.getCredit());
            System.out.println(s.getClasstype());
            System.out.println(s.getInterest());
            System.out.println("=============");
            System.out.println(r.getCompletedSemester());
            System.out.println(r.getRetake());
            
        }
    }

    @Test
    public void getSubjectListToRecTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        UserMajorInfoService userMajorInfoService = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        AutoRecommendationService autoReqService = ac.getBean("autoRecommendationServiceImpl", AutoRecommendationServiceImpl.class);

        User user = new User();
        user.setUserId("sungjin@naver.com");
        UserMajorInfo userMajorInfo = userMajorInfoService.getUserMajorInfoById(user.getUserId());
        user.setUserMajorInfo(userMajorInfo);

        List<Subject> list = autoReqService.getListToRecSubject(user);
        
        for(Subject s : list){
            System.out.println(s.getSubjectName());
        }

    }
    
    @Test
    public void getAllClassListForMajorTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
      //  UserMajorInfoService userMajorInfoService = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        AutoRecommendationService autoReqService = ac.getBean("autoRecommendationServiceImpl", AutoRecommendationServiceImpl.class);
    
        UserMajorInfo userMajor = new UserMajorInfo();
        userMajor.setDepartCode("AJ001");
        userMajor.setAdmission("2013");
        List<Subject> subjects = autoReqService.getAllClassListForMajor(userMajor);
        
       
        
            
            for(Subject subject : subjects) {

                //학수구분도 리스트에 담아야됨
                System.out.println(subject.getSubjectCode() + ", " +
             
                subject.getClasstype() + ", " +
                subject.getSubjectName() + ", " +
                subject.getCredit());
                

            }
        
    }
}
