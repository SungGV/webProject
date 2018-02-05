package sukang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.domain.Road;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.provider.DepartmentProvider;
import sukang.provider.SubjectProvider;
import sukang.provider.UserMajorInfoProvider;
@Service
public class RoadMapServiceImpl implements RoadMapService {

    @Autowired
    private UserMajorInfoProvider userMajorInfoProvider;
    @Autowired
    private DepartmentProvider departProvider;
    @Autowired
    private SubjectProvider subjectProvider;
    
    @Override
    public UserMajorInfo getUserMajorInfoById(String UserId) {
        
        return userMajorInfoProvider.getUserMajorInfoById(UserId);
    }

    @Override
    public List<Subject> getPreSubjectList(String subjectCode) {
        
        return subjectProvider.getPreSubjectList(subjectCode);
    }
    
    @Override
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo) {
        //
        return subjectProvider.getAllClassListForMajor(majorInfo);
    }

    @Override
    public List<Subject> getInterest(String departCode, String userAdminYear) {
        
        return subjectProvider.getInterest(departCode, userAdminYear);
    }

    /**
     *  1차 처리>> 학과에 따른 개설 과목을 학기별로 정렬해서 list
     * -> 유저의 학과정보/입학년도 를 가지고, 
     * -> 학과의 개설과목을 학기 순으로(내림차순) 정렬한 뒤에, 과목명으로 list 담기.
     * 
     *  2차 처리>> 개설과목 중 선수 과목 check , 
     * 추후 jsp에서 과목 배치하는 데이터 처리 에서 {from: key ,to: key} 에 
     * 선수과목의 key와 개설과목의 key에 사용할 list //
     * -> 과목코드 한개 한개를 선수과목 여부를 확인하여,
     * -> 선수과목이 있을 시, 선수과목 코드를 가지고 
     * -> 선수과목명 을 list 로 담기.
     * {@inheritDoc}
     */
    @Override
    public List<Road> getAllSubjectListForMajor(String userId) {
        
        // 유저 아이디 임의로 부여j
        //userId = "659692387481461";
       // UserMajorInfo majorInfo = new UserMajorInfo();
        UserMajorInfo majorInfo = userMajorInfoProvider.getUserMajorInfoById(userId);
      
        
        // 유저 전공 정보(학과코드, 입학년도) 가지고 
        // 학과에 따른  개설과목 목록에서 과목코드 얻은 후,
        // 과목테이블에서 과목명 조회하여 List<Subject> 에 담기
        
        // reqSubject_tb 가져옴
        List<Subject> departSubjectList = subjectProvider.getAllClassListForMajor(majorInfo);
        // return 해줄 list
        List<Road> departMajor = new ArrayList<Road>();
        
      
        int preInt = 0;
        int subInt = 0;
        
        for(Subject subjects : departSubjectList) {
            //학수구분 넣어줘서 과목마다  "기초/전필/전선" 자동 구분
            String classType = subjectProvider.readClassTypeByCode(subjects.getSubjectCode(), majorInfo);
            
            subjects.setClassType(classType);
        }
       

        for(Subject a : departSubjectList){

            List<Subject> preSubjectList = subjectProvider.getRelationCode(a.getSubjectCode());

            if(preSubjectList.size() != 0) {
                

                for(Subject b : preSubjectList) {
                    Road road = new Road();
             
                   
                    String preSubCode = b.getPreSubjectCode().substring(3, 6);
                    String subCode = b.getSubjectCode().substring(3, 6);

                    preInt = Integer.parseInt(preSubCode);
                    subInt = Integer.parseInt(subCode);

                   // System.out.println("subCode: " + subInt + " presubCode: " + preInt);

                    road.setPreInt(preInt);
                    road.setSubInt(subInt);

                    departMajor.add(road);
                }
            }

        }

        return departMajor;


    }

    @Override
    public List<Subject> getRelationCode(String subjectCode) {
        //
        return subjectProvider.getRelationCode(subjectCode);
    }
}














