package sukang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.provider.DepartmentProvider;
import sukang.provider.SubjectProvider;
import sukang.provider.UserMajorInfoProvider;

@Service
public class GuideLineServiceImpl implements GuideLineService {

    @Autowired
    private UserMajorInfoProvider userProvider;
    @Autowired
    private SubjectProvider subjectProvider;
    @Autowired
    private DepartmentProvider departProvider;
    
    @Override
    public List<Subject> getPreSubject(String subjectCode) {
        // TODO Auto-generated method stub
        return subjectProvider.getPreSubject(subjectCode);
    }
    
    
   /* @Override
    public UserMajorInfo getUserMajorInfoById(String UserId) {//유저의 학과코드반환
        
        return userProvider.getUserMajorInfoById(UserId);
    }*/

    /*@Override
    public List<Subject> getCourseList(User user) {//유저의 필요과목리스트 조회
        return subjectProvider.getAllClassListForMajor(user.getUserMajorInfo());
    }*/

    @Override
    public Department getDepartInfo(UserMajorInfo majorInfo) {//유저의 학사정보
        
        return departProvider.getDepartInfo(majorInfo);
    }

    @Override
    public Department getDepartCode(String userMajor, String userAdmin, String status) {
        
        return departProvider.getDepartCode(userMajor, userAdmin, status);
    }


   

   /* @Override
    public String getClassType(String subjectCode, UserMajorInfo majorInfo) {
        // TODO Auto-generated method stub
        return subjectProvider.getClassType(subjectCode, majorInfo);
    }*/

    
  /*  @Override
    public String getRecSemester(String subjectCode, String admission) {
        
        // TODO Auto-generated method stub
        return subjectProvider.getRecSemester(subjectCode, admission);
    }*/

    @Override
    public List<Subject> yolam(String userId) {//종현 나의 학과과목리스트
        UserMajorInfo major = userProvider.getUserMajorInfoById(userId);// ID로 UserMajor객체조회
        //유저의 학과의대한 학점, 과목명,심화구분,학기 조회가능
        //subject_tb불러옴
        List<Subject> subjectList = subjectProvider.getAllClassListForMajor(major); //user학과에 대한 과목리스트
        //선수과목리스트를 가져옴
        // presubject_tb 불러옴
        //List<Subject> preSubjectList = subjectProvider.getPreSubject(); //선수과목리스트
        
       
        for(Subject s : subjectList){
            s.setClasstype(subjectProvider.getClassType(s.getSubjectCode(), major));//학수구분을 입력함
            s.setSemester(subjectProvider.getRecSemester(s.getSubjectCode(), major.getAdmission()));//학기를 입력함
        }
       
        List<Subject> preList;
        for(Subject s1 : subjectList){ //선수과목이 코드로 불려와 이름으로 변환
            preList =  subjectProvider.getPreSubjectList(s1.getSubjectCode());
            
            String aaa = "";
            int count = 0;
            
            for(Subject s : preList){
                aaa += s.getSubjectName();
                count++;
                if(count < preList.size()){
                    aaa += " , ";
                }
                
            }
            s1.setPreSubject(aaa);
        }
    
        return subjectList;
    }
    
    @Override
    public List<Department> getDepartCodeList(String college){//종현 학과
        
      return departProvider.getDepartCodeList(college);
      
    }


    @Override
    public List<Subject> getDepartSubjectList(String departCode, String admission, UserMajorInfo major) {
        List<Subject> departSubjectList = subjectProvider.getDepartSubjectList(departCode, admission);
        
        for(Subject s : departSubjectList){
            s.setClasstype(subjectProvider.getClassType(s.getSubjectCode(), major));//학수구분을 입력함
            s.setSemester(subjectProvider.getRecSemester(s.getSubjectCode(), major.getAdmission()));//학기를 입력함
        }
        List<Subject> preList;
        for(Subject s1 : departSubjectList){ //선수과목이 코드로 불려와 이름으로 변환
            preList =  subjectProvider.getPreSubjectList(s1.getSubjectCode());
            
            String aaa = "";
            int count = 0;
            
            for(Subject s : preList){
                aaa += s.getSubjectName();
                count++;
                if(count < preList.size()){
                    aaa += " , ";
                }
                
            }
            s1.setPreSubject(aaa);
        }
        
        return departSubjectList;
    }


 
    
}
