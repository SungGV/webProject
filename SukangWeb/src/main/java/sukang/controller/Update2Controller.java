package sukang.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.dao.UserMajorInfoDao;
import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.Ui;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.provider.UserMajorInfoProvider;
import sukang.service.AutoRecommendationService;
import sukang.service.GuideLineService;
import sukang.service.RoadMapService;
import sukang.service.UserMajorInfoService;

@Controller
public class Update2Controller {
    
    @Autowired
    private UserMajorInfoService majorService;
    @Autowired
    private GuideLineService guideService;
    @Autowired
    private RoadMapService roadService;
    @Autowired
    private AutoRecommendationService autoService;
    @Autowired
    private UserMajorInfoDao userDao;

    @RequestMapping("showOriginalInfo.do")
    public String showOriginalInfo(HttpSession session, Model model) {
        //userId로 기존 정보 받아와서 먼저 뿌려줌.
        //학교, 학번, 학부, 입학년도, 이수학기, 추가전공여부, 관심사, (추가전공학과는 보류)
        String userId = (String)session.getAttribute("userId");

        UserMajorInfo userMajor = majorService.getUserMajorInfoById(userId);
        
        List<Report> lists = userDao.readCompletedSubjectById(userId);
        List<Subject> subjects = autoService.getAllClassListForMajor(userMajor);
        
        
        List<Report> listReport = new ArrayList<Report> ();
        List<Subject> untakenReport = new ArrayList<Subject> ();
        boolean flag = false;
        for(Subject subject : subjects) {        
           flag = false;
            for(Report list : lists) {
                if(list.getSubjectCode().equals(subject.getSubjectCode())) {
                    Report report = new Report();
                    Subject sub = new Subject();
                    
                    sub.setCredit(list.getSubject().getCredit());
                    sub.setSubjectName(list.getSubject().getSubjectName());
                    sub.setClasstype(subject.getClasstype());
                    sub.setYear(list.getCompletedSemester().substring(0,1));
                    sub.setInterest(userId);
                    
                    report.setCompletedSemester(list.getCompletedSemester().substring(1,2));
                    report.setGrade(list.getGrade());
                    report.setSubjectCode(list.getSubjectCode());
                    report.setRetake(list.getRetake());
                    report.setSubject(sub);
           
                    listReport.add(report);
                    
                    flag = true;
                }
            }
            if(flag == false) {
                Subject sub = new Subject();
                
                sub.setClasstype(subject.getClasstype());
                sub.setSubjectName(subject.getSubjectName());
                sub.setCredit(subject.getCredit());
                sub.setSubjectCode(subject.getSubjectCode());
                
                untakenReport.add(sub);
            }
        }
        
        
        model.addAttribute("listReport", listReport);
        model.addAttribute("report", untakenReport);
        model.addAttribute("yyear", userMajor.getComSemester().substring(0,1));
 
        return "update2";
    }
    
    @ResponseBody
    @RequestMapping("saveUpdated.do")
    public String saveUpdated(String values, String userId) throws JsonParseException, JsonMappingException, IOException {
        User user = new User();
        ObjectMapper om = new ObjectMapper();
        List<Report> listRep = new ArrayList<Report>();
        List<Report> subs = om.readValue(values, new TypeReference<List<Report>>() {
        });

        for (Report sub : subs) {
            // 가공시 필요한 객채 및 리스트 생성
            Report report = new Report();
            
            

            // 이수학기 조합을 위한 설정
            String year = sub.getSubject().getYear();
            String semester = sub.getSubject().getSemester();
            String comSemester = year + semester;

            report.setCompletedSemester(comSemester);
            report.setGrade(sub.getGrade());
            report.setSubjectCode(sub.getSubject().getSubjectCode());
            
            if (sub.getRetake() == null) {
                report.setRetake("0");
            }
            else {
                report.setRetake(sub.getRetake());
            }

            listRep.add(report);

            user.setReport(listRep);
            user.setUserId(userId);

        }
        
        

        majorService.setUserCompletedSubject(user);
        return "completed";
    }
    
    

}
