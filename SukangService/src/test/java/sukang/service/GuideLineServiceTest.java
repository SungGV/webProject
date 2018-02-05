package sukang.service;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;


public class GuideLineServiceTest {

    @Test
    public void getUserMajorInfoById() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        GuideLineService service = ac.getBean("guideLineServiceImpl", GuideLineServiceImpl.class);
        UserMajorInfoServiceImpl uservice = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        UserServiceImpl sservice = ac.getBean("userServiceImpl", UserServiceImpl.class);
        RoadMapServiceImpl Rservice = ac.getBean("roadMapServiceImpl", RoadMapServiceImpl.class);

        User user = sservice.getByIdUser("sungjin@naver.com");
        UserMajorInfo major = uservice.getUserMajorInfoById("sungjin@naver.com");
        System.out.println(major.getAdmission());
       // System.out.println("1st");

        user.setUserMajorInfo(major);
        
        List<Subject> departSubjectList = service.getDepartSubjectList("AJ001", "2013");
      /*  List<Subject> preList;
        for(Subject s1 : departSubjectList){
            preList =  Rservice.getPreSubjectList(s1.getSubjectCode());
            String aaa = "  ,  ";
            for(Subject sss : preList){
                aaa =  sss.getSubjectName()+aaa;
                
            }
            s1.setPreSubject(aaa);
        }*/
        
        //유저의 학과의대한 학점, 과목명,심화구분,학기 조회가능
        //subject_tb불러옴
        List<Subject> aList = service.getCourseList(user);
        System.out.println("2st");
        //List<Subject> aaList = service.getDepartSubjectList("AJ001", major.getAdmission());
      
        
        //선수과목리스트를 가져옴
        // presubject_tb 불러옴
//        List<Subject> bList = service.getPreSubject();
        //System.out.println(bList.size());

    /*    for(Subject s : aList){
            System.out.print("관심사");
            System.out.println(s.getInterest());
        }*/

        
     /*   for(int i = 0; i < aList.size(); i++){
            for(int j = 0; j <bList.size(); j++){
                if(aList.get(i).getSubjectCode().equals(bList.get(j).getSubjectCode()) ){
                    aList.get(i).setPreSubject(bList.get(j).getPreSubject()); 
                }
            }
        }*/
      /*  for(Subject s : aList){
            s.setClasstype(service.getClassType(s.getSubjectCode(), major));
            s.setSemester(service.getRecSemester(s.getSubjectCode(), major.getAdmission()));
        }*/
     
        
        
        
        
        
        
/*        List<Subject> preList;
        List<String> preListString = new ArrayList<String>();
        
        for(Subject s1 : aList){
            preList =  Rservice.getPreSubjectList(s1.getSubjectCode());
            String aaa = "    ";
            for(Subject sss : preList){
                aaa =  sss.getSubjectName()+aaa;
                
            }
            s1.setPreSubject(aaa);
        }
      
        */
        
        
   /*     for(Subject s : aList){
            for(Subject a : aList){
                s.getPreSubject()
            }
        }*/
      /* for(Subject s : aList){
           System.out.print(s.getPreSubject() + "presubject\t");
       }*/
        for(Subject s : departSubjectList){
            System.out.print(s.getAdmission() + ": admission\t");
            System.out.print(s.getClasstype() + ": classtype\t");
            System.out.print(s.getCredit() + ": credit\t");
            System.out.print(s.getInterest() + ": interest\t");
            System.out.print(s.getSemester() + ": semester\t");    
            System.out.print(s.getPreSubject() + "presubject\t");
            System.out.print(s.getSubjectCode() + ": subjectcode\t");
            System.out.print(s.getSubjectName() + ": subjectname\t");
            System.out.println("");
        }
    }
    
    @Test
    public void getUserInfoByIdTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        GuideLineService service = ac.getBean("guideLineServiceImpl", GuideLineServiceImpl.class);
        UserMajorInfoServiceImpl uservice = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
        UserServiceImpl sservice = ac.getBean("userServiceImpl", UserServiceImpl.class);
        RoadMapServiceImpl Rservice = ac.getBean("roadMapServiceImpl", RoadMapServiceImpl.class);
       
        
        List<Subject> departSubjectList = service.getDepartSubjectList("AJ001", "2013");
        List<Subject> preList;
        for(Subject s1 : departSubjectList){
            preList =  Rservice.getPreSubjectList(s1.getSubjectCode());
            String aaa = "  ,  ";
            for(Subject sss : preList){
                aaa =  sss.getSubjectName()+aaa;
                
            }
            s1.setPreSubject(aaa);
        }
        
    }
    
    @Test
    public void getUserInfoByIdTest() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        UserMajorInfoServiceImpl uservice = ac.getBean("userMajorInfoServiceImpl", UserMajorInfoServiceImpl.class);
       
        
        UserMajorInfo major = uservice.getUserMajorInfoById("sungjin@naver.com");
        
        System.out.println(major.getAdmission());
    }
    
    

}
