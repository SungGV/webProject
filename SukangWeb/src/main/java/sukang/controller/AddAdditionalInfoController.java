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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.domain.Department;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.Ui;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.service.AutoRecommendationService;
import sukang.service.GuideLineService;
import sukang.service.RoadMapService;
import sukang.service.UserMajorInfoService;

@Controller
public class AddAdditionalInfoController {

    @Autowired
    private UserMajorInfoService service;
    @Autowired
    private GuideLineService guide;
    @Autowired
    private RoadMapService road;
    @Autowired
    private AutoRecommendationService auto;

    @ResponseBody
    @RequestMapping("addInfo.do")
    public Ui showCompletion(String college, String userMajor, String userAdminYear, String majorStatus) {

        // 1. 사용자가 학교를 선택하면 학교에 대한 value를 약식으로 받아온다
        //    value는 학과 코드 앞의두자리와 똑같이 지정한다
        //    ex) 아주대학은 AJ, 백석대학은 BS.. 
        //    DB에는 약식으로 받아온 value가 저장되고 화면에는 학교 이름이 나타난다

        List<Department> majors = service.departInfoBySchool(college);
        List<Department> admission = service.getYearInfoBySchool(college);

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

            Department depart = guide.getDepartCode(userMajor, userAdminYear, majorStatus);

            String userDepartCode = depart.getDepartCode();

            List<Subject> interests = road.getInterest(userDepartCode, userAdminYear);
            for (Subject a : interests) {
                interest.add(a.getInterest());
            }

        }

        Ui ui = new Ui();

        ui.setShowMajor(major);

        ui.setShowYear(year);

        ui.setUserMajor(userMajor);

        ui.setUserAdminYear(userAdminYear);

        ui.setMajorStatus(majorStatus);
        
        ui.setInterest(interest);

        return ui;
    }

    @RequestMapping("addUserInfo.do")
    public String saveFirstInfo(HttpSession session, Model model, String userId, String school, String studentId, String major, String admission,
            String comSemester, String status, String additionalMajor, String interest) {
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
        UserMajorInfo ordinaryInfo = service.getUserMajorInfoById(userId);

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

        Department depart = guide.getDepartCode(major, admission, status);
        
        String userDepartCode = depart.getDepartCode();
        userMajor.setDepartCode(userDepartCode);

        if (ordinaryInfo == null) {
            service.setUserAdditionalInfo(userMajor);
        }
        else {
            service.updateUserAdditionalInfo(userMajor);
        }

        ////////////////////////////////////

        // departCode, admission으로 조회
        List<Subject> subjects = auto.getAllClassListForMajor(userMajor);
        List<Subject> subjectList = new ArrayList<Subject>();

        for (Subject subject : subjects) {

            Subject sub = new Subject();
            sub.setClasstype(subject.getClasstype());
            sub.setSubjectName(subject.getSubjectName());
            sub.setCredit(subject.getCredit());
            sub.setSubjectCode(subject.getSubjectCode());
            sub.setInterest(userId); // 유저 아이디를 담을떄가 없어서 여기다가 담앗음....
            subjectList.add(sub);

        }
        


        model.addAttribute("subjectList", subjectList);
        model.addAttribute("yyear", comSemester.substring(0,1));

        // 화면에 보여줄 내용(이수여부, 학년, 학기, 이수구분, 과목명 , 성적

        // 입력 받아야될 정보들  subCode, userId, grade,semester,retake
        // subcode, userId는 이미 받아왓고. 나머지는 입력받으면되고
        return "additional2";
    }

    @RequestMapping("saveSecondPage.do")
    @ResponseBody
    public String saveSecondPage(String values, String userId) throws JsonParseException, JsonMappingException, IOException {
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

            
            if(sub.getRetake() != null) {
                report.setRetake(sub.getRetake());
            }
            else if(sub.getGrade() == 0){
                report.setRetake("1");
            }
            else {
                report.setRetake("0");
            }

            listRep.add(report);

            user.setReport(listRep);
            user.setUserId(userId);


        }

        service.setUserCompletedSubject(user);
        return "completed";
    }
}
