package sukang.service;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sukang.domain.Road;
import sukang.domain.Subject;

public class RoadMapServiceTest {

    @Test
    public void test() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        RoadMapService service = ac.getBean("roadMapServiceImpl", RoadMapServiceImpl.class);
        
        List<Subject> interests = service.getInterest("AJ001", "2013");
        for(Subject interest : interests) {
            System.out.println(interest.getInterest());
        }
        
        //완료
    }
    
    
    // 학과에 따른 개설 과목 Test
    @Test
    public void getAllSubjectListForMajor() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        RoadMapService service = ac.getBean("roadMapServiceImpl", RoadMapServiceImpl.class);
        List<Road> subjects = service.getAllSubjectListForMajor("659692387481461");
       
        System.out.println(subjects.size());
        
        for(Road subject : subjects) {
            
            System.out.println(subject.getClassType());
        }
        // 완료
    }
    
    
    
}
