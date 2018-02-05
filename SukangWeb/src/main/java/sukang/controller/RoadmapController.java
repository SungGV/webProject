package sukang.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.dao.SubjectDao;
import sukang.domain.Department;
import sukang.domain.Isu;
import sukang.domain.Road;
import sukang.domain.Subject;
import sukang.domain.Ui;
import sukang.domain.UserMajorInfo;
import sukang.service.GuideLineService;
import sukang.service.RoadMapService;
import sukang.service.UserMajorInfoService;

// 로드맵 컨트롤러
@Controller
public class RoadmapController {

    @Autowired
    private RoadMapService roadService;
    @Autowired
    private GuideLineService guideLineService;
    @Autowired
    private UserMajorInfoService userService;
    @Autowired
    private SubjectDao sub;

    // 리스트를 리턴하며 ajax를 사용한다
    @RequestMapping("loadList.do")
    @ResponseBody
    public Ui showRoadMap(HttpSession session, String major) {
        
        String userId = (String) session.getAttribute("userId");
        List<Road> mapList = roadService.getAllSubjectListForMajor(userId);

        UserMajorInfo majorInfo = roadService.getUserMajorInfoById(userId);
        if(majorInfo == null) {
            throw new RuntimeException("과목 정보가 입력되지 않았습니다.");
        }

        List<Subject> lists = roadService.getAllClassListForMajor(majorInfo);
        List<Road> roadList = new ArrayList<Road>();
        List<Subject> subCodeList = new ArrayList<Subject>();
        List<Subject> preSubList = new ArrayList<Subject>();
        
        List<Subject> preSubs = sub.readPreSubject();
        List<Subject> distinctPre = sub.readDistinctPreSubject();
        
      
        int numInt =0;
        for(Subject preSub : preSubs) {
 
            Subject subject2 = new Subject();
            subject2.setSubjectCode(preSub.getSubjectCode());
            subCodeList.add(subject2);              
        }
        
        for(Subject aa : distinctPre) {
            Subject subject1 = new Subject();
            subject1.setPreSubjectCode(aa.getPreSubjectCode());
            preSubList.add(subject1);
        }
        
        
   
        
        for(Subject preSubCode : preSubList) {
            boolean flag=false;
            
            Subject subject = new Subject();
            for(Subject subCode : subCodeList) {
                if(preSubCode.getPreSubjectCode().equals(subCode.getSubjectCode())) {
                    flag=true;
                    break;
                }
            }
            if(flag == false){
                subject.setSubjectCode(preSubCode.getPreSubjectCode());
                subCodeList.add(subject);
            }
        }
        
        for(Subject list: lists) {
            for(Subject subCode : subCodeList) {
                if(subCode.getSubjectCode().equals(list.getSubjectCode())) {
                    
                    Road road = new Road();
                    numInt = Integer.parseInt(subCode.getSubjectCode().substring(3,6));
                    road.setKey(numInt);
                    
                    Subject subName = sub.readSubjectName(subCode.getSubjectCode());
                    road.setText(subName.getSubjectName());
                    
                    if("기초".equals(list.getClassType())) {
                        road.setCategory("BasicSub"); 
                    }
                    else if("전필".equals(list.getClassType())) {
                        road.setCategory("DesiredEvent");
                    }
                    else {
                        road.setCategory("");
                    }
                    roadList.add(road);
                }
            }
        }

        
        Ui ui = new Ui();
        ui.setKeyRoad(roadList);
        ui.setFromRoad(mapList);
        return ui;
    }


}
