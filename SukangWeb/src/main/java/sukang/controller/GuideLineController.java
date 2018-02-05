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

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;
import sukang.service.GuideLineService;
import sukang.service.UserMajorInfoService;

// 요람 컨트롤러
@Controller
public class GuideLineController {

    @Autowired
    private GuideLineService guideLineService;
    @Autowired
    private UserMajorInfoService userService;

    // 리턴은 String타입으로 jsp를 리턴하고 과목 list를 setAttribute하여 jsp로 넘긴다
    @RequestMapping("yolam.do")
    public String showGuideLine(HttpSession session, Model model, String departCode) {
        String userId = (String) session.getAttribute("userId");
        UserMajorInfo majorInfo = userService.getUserMajorInfoById(userId);

        if (majorInfo == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }
        String college = majorInfo.getDepartCode().substring(0, 2);

        List<Report> reportList = userService.getReport(majorInfo);
        //List<Department> departCodeList = guideLineService.getDepartCodeList(college);
        //String departCode2 = departCode;
        
/*        for (Department a : departCodeList) {
            String aaa = a.getMajor();

            if (departCode2.equals(aaa)) {
                departCode2 = a.getDepartCode();
            }

        }*/

        UserMajorInfo major = userService.getUserMajorInfoById(userId);

        List<Subject> departSubjectList = guideLineService.yolam(userId);
            
        departSubjectList = guideLineService.getDepartSubjectList(departCode, major.getAdmission(), major);

        
        for (Subject s : departSubjectList) {
            
            s.setYear(s.getSemester().substring(0, 1));
            s.setSemester((s.getSemester().substring(1, 2)));
            for (Report r : reportList) {
                if (s.getSubjectCode().equals(r.getSubject().getSubjectCode())) {
                    s.setRecommended(true); //이수 여부 표시 플레그
                }
            }

        }

        Collections.sort(departSubjectList);
        //String departName = major.getMajor();

        model.addAttribute("subjectList", departSubjectList);
        //model.addAttribute("departName", departName);
        // model.addAttribute("departCodeList", departCodeList);
        return "yorlam";

    }

    @RequestMapping("showDepart.do")
    @ResponseBody
    public List<Department> showDepartmentBycollege(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        UserMajorInfo majorInfo = userService.getUserMajorInfoById(userId);

        String college = majorInfo.getDepartCode().substring(0, 2);

        List<Department> departCodeList = guideLineService.getDepartCodeList(college);

        return departCodeList;
    }

}
