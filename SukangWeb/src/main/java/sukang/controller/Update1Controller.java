package sukang.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.domain.Department;
import sukang.domain.Subject;
import sukang.domain.Ui;
import sukang.domain.UserMajorInfo;
import sukang.service.AutoRecommendationService;
import sukang.service.GuideLineService;
import sukang.service.RoadMapService;
import sukang.service.UserMajorInfoService;

@Controller
public class Update1Controller {
    
    @Autowired
    private UserMajorInfoService majorService;
    @Autowired
    private GuideLineService guideService;
    @Autowired
    private RoadMapService roadService;
    @Autowired
    private AutoRecommendationService auotoService;

    @ResponseBody
    @RequestMapping("showOriginalInfo2.do")
    public UserMajorInfo showOriginalInfo2(HttpSession session) {
        //userId로 기존 정보 받아와서 먼저 뿌려줌.
        //학교, 학번, 학부, 입학년도, 이수학기, 추가전공여부, 관심사, (추가전공학과는 보류)
        String userId = (String)session.getAttribute("userId");
        UserMajorInfo majorInfo = majorService.getUserMajorInfoById(userId);
        
        return majorInfo;
    }
    
    @ResponseBody
    @RequestMapping("addInfo3.do")
    public Ui showCompletion(HttpSession session, String college, String userMajor, String userAdminYear, String majorStatus, String comsemester) {

        // 1. 사용자가 학교를 선택하면 학교에 대한 value를 약식으로 받아온다
        //    value는 학과 코드 앞의두자리와 똑같이 지정한다
        //    ex) 아주대학은 AJ, 백석대학은 BS.. 
        //    DB에는 약식으로 받아온 value가 저장되고 화면에는 학교 이름이 나타난다
        String userId = (String) session.getAttribute("userId");
        UserMajorInfo majorInfo = majorService.getUserMajorInfoById(userId);
        userMajor = majorInfo.getMajor();
        userAdminYear = majorInfo.getAdmission();
        comsemester = majorInfo.getComSemester();
        majorStatus = majorInfo.getStatus();
        String userInterest = majorInfo.getInterest();
        
        Ui ui = new Ui();
        
        ui.setMajorInfo(majorInfo);

        List<Department> majors = majorService.departInfoBySchool(college);
        List<Department> admission = majorService.getYearInfoBySchool(college);

        List<String> year = new ArrayList<String>();
        List<String> major = new ArrayList<String>();

        for (Department aMajor : majors) {
            major.add(aMajor.getMajor());
        }

        for (Department aAdmission : admission) {

            year.add(aAdmission.getAdmission());
        }

        List<String> interest = new ArrayList<String>();

        // 관심사 구분
        if (userMajor != null && userAdminYear != null && !"majorNull".equals(userMajor) && !"adminNull".equals(userAdminYear) && majorStatus != null) {

            if ("1".equals(majorStatus)) {
                majorStatus = "복수전공";
            }
            else if ("2".equals(majorStatus)) {
                majorStatus = "부전공";
            }
            else if ("3".equals(majorStatus)) {
                majorStatus = "편입";
            }
            else {
                majorStatus = "전공심화";
            }

            Department depart = guideService.getDepartCode(userMajor, userAdminYear, majorStatus);

            String userDepartCode = depart.getDepartCode();

            List<Subject> interests = roadService.getInterest(userDepartCode, userAdminYear);
            for (Subject a : interests) {
                interest.add(a.getInterest());
            }

        }

        ui.setShowMajor(major);

        ui.setShowYear(year);

        ui.setUserMajor(userMajor);

        ui.setUserAdminYear(userAdminYear);

        ui.setMajorStatus(majorStatus);
        
        ui.setInterest(interest);
        
        ui.setComSemester(comsemester);
        
        ui.setUserInterest(userInterest);

        return ui;
    }
    
    @RequestMapping("addUserInfo2.do")
    public String saveFirstInfo(HttpSession session, Model model, String userId, String school, String studentId, String major, String admission,
            String comSemester, String status, String additionalMajor, String interest, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        userId = (String) session.getAttribute("userId");
        

        if ("1".equals(status)) {
            status = "복수전공";
        }
        else if ("2".equals(status)) {
            status = "부전공";
        }
        else if ("3".equals(status)) {
            status = "편입";
        }
        else {
            status = "전공심화";
        }
        //기존 정보 유무 체크용
        UserMajorInfo ordinaryInfo = majorService.getUserMajorInfoById(userId);

        //test용
        UserMajorInfo userMajor = new UserMajorInfo();
        userMajor.setUserId(userId);
        userMajor.setCollege(school);
        userMajor.setStudentId(studentId);
        userMajor.setMajor(major);
        userMajor.setAdmission(admission);
        userMajor.setComSemester(comSemester);
        userMajor.setStatus("전공심화"); // DB value 처리 필요함
        userMajor.setInterest(interest);

        Department depart = guideService.getDepartCode(major, admission, status);
        
        String userDepartCode = depart.getDepartCode();
        userMajor.setDepartCode(userDepartCode);

        if (ordinaryInfo == null) {
            majorService.setUserAdditionalInfo(userMajor);
        }
        else {
            majorService.updateUserAdditionalInfo(userMajor);
        }

        // 화면에 보여줄 내용(이수여부, 학년, 학기, 이수구분, 과목명 , 성적

        // 입력 받아야될 정보들  subCode, userId, grade,semester,retake
        // subcode, userId는 이미 받아왓고. 나머지는 입력받으면되고
        
        return "redirect:/showOriginalInfo.do";
    }
    

}
