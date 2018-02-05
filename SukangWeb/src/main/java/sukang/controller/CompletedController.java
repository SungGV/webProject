package sukang.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.domain.Department;
import sukang.domain.Isu;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;
import sukang.service.GuideLineService;
import sukang.service.UserMajorInfoService;
import sukang.service.UserService;

//이수상황 컨트롤러
@Controller
public class CompletedController {

    @Autowired
    private UserMajorInfoService majorInfoService;

    @Autowired
    private GuideLineService guideLineService;

    @Autowired
    private UserService userService;

    // 리스트를 리턴하며 ajax를 사용함
    @ResponseBody
    @RequestMapping("completed.do")
    public Isu showCompletion(HttpSession session, String userId) {
        session.setAttribute("userId", userId);
        Isu isu = new Isu();

        UserMajorInfo majorInfo = majorInfoService.getUserMajorInfoById(userId);
        //추가 정보가 없을 경우
        Department department = guideLineService.getDepartInfo(majorInfo);
        if (majorInfo == null || department == null) {
            isu.setNeedCreditForGraduation(0);
            return isu;
        }

        List<Report> reportList = majorInfoService.getReport(majorInfo);
        
        isu.setNeedCreditForBasic(department.getNeedCreditForBasic());
        isu.setNeedCreditForGraduation(department.getNeedCreditForGraduation());
        isu.setNeedCreditForRequirement(department.getNeedCreditForRequirement());
        isu.setNeedCreditForSelective(department.getNeedCreditForSelective());

        int basicCredit = 0;
        int forGraduation = 0;
        int forSelective = 0;

        for (Report report : reportList) {

            if (report.getGrade() > 0) {
                if (report.getSubject().getClasstype().equals("기초")) {

                    basicCredit += report.getSubject().getCredit();

                }
                else if (report.getSubject().getClasstype().equals("전필")) {
                    forGraduation += report.getSubject().getCredit();
                }
                else if (report.getSubject().getClasstype().equals("전선")) {
                    forSelective += report.getSubject().getCredit();
                }
            }
        }
        isu.setComBasicCredit(basicCredit);
        isu.setComMajorCredit(forGraduation);
        isu.setComSelecionCredit(forSelective);
        isu.setComTotalCredit(basicCredit + forGraduation + forSelective);

        return isu;
    }

}
