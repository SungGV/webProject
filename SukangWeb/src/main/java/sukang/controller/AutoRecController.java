package sukang.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.domain.Department;
import sukang.domain.Isu;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;
import sukang.service.AutoRecommendationService;
import sukang.service.GuideLineService;
import sukang.service.UserMajorInfoService;

@Controller
@RequestMapping("auto")
public class AutoRecController {

    @Autowired
    private AutoRecommendationService autoRecService;

    @Autowired
    private UserMajorInfoService userMajorInfoService;

    @Autowired
    private GuideLineService guideLineService;

    /**
     * completed Subject를 뿌려주는 method
     * @param //user_id를 Jsp 에서 받을 예정임
     * @return List<Report>
     */
    @RequestMapping("findComList.do")
    @ResponseBody
    public List<Report> getCompSubjectList(String userId) {

        UserMajorInfo majorInfo = new UserMajorInfo();

        majorInfo = userMajorInfoService.getUserMajorInfoById(userId);

        if (majorInfo == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }

        List<Report> reports = userMajorInfoService.getReport(majorInfo);

        Collections.sort(reports);

        return reports;
    }

    /**
     * completed Subject를 제외한 나머지 reqSubject를 뿌려주는 method
     * @param //user_id를 Jsp 에서 받을 예정임
     * @return
     */
    @RequestMapping("reqList.do")
    @ResponseBody
    public List<Subject> getSubjectListToRec(String userId) {

        //user_id를 통해 majorInfo를 가져옴

        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);
        if (majorInfo == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }

        List<Subject> subjectListToRec = autoRecService.getListToRecSubject(majorInfo);

        List<Report> reports = userMajorInfoService.getReport(majorInfo);

        for (Subject s : subjectListToRec) {
                s.setClasstype(autoRecService.getClassTypeByCode(s.getSubjectCode(), majorInfo));
        }
        
        
        return subjectListToRec;
    }

    
    /**
     * 삭제 이후 completed Subject를 제외한 나머지 reqSubject를 뿌려주는 method
     * @param //user_id를 Jsp 에서 받을 예정임
     * @return
     */
    @RequestMapping("reqList2.do")
    @ResponseBody
    public List<Subject> getSubjectListToRec2(String userId) {

        //user_id를 통해 majorInfo를 가져옴

        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);
        if (majorInfo == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }

        List<Subject> subjectListToRec = autoRecService.getListToRecSubject(majorInfo);

        List<Report> reports = userMajorInfoService.getReport(majorInfo);

        for (Subject s : subjectListToRec) {
                s.setClasstype(autoRecService.getClassTypeByCode(s.getSubjectCode(), majorInfo));
        }
        
        for(Report r : reports){
            
            if(r.getRetake().equals("1")){
                Subject s2 = r.getSubject();
                s2.setRetake(r.getRetake());
                
                subjectListToRec.add(s2);
            }
        }
        return subjectListToRec;
    }
    
    
    
    //뿌린 후에 jsp에서 추천학기는 하드코딩으로 뿌림
    /**
     * 추천과목 뿌려주는 알고리즘이 포함된 method
     * @return
     */
    @RequestMapping("recAlgorithm.do")
    @ResponseBody
    public List<Subject> getRecSubjectList(String userId) {

        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);
        if (majorInfo == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }
        List<Subject> subjectListToRec = autoRecService.getListToRecSubject(majorInfo);
        List<Subject> reqList = new ArrayList<Subject>();

        //실제 수강 과목과 추천된 과목 추가
        List<Report> reports = userMajorInfoService.getReport(majorInfo);
        List<Subject> reportList = new ArrayList<Subject>();

        for (Report r : reports) {
            reportList.add(r.getSubject());

        }

        //reTake , semester(학년,학기), 선수과목 가져와야함.
        for (Subject s : subjectListToRec) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //전필, 기초인 경우 그냥 넣어줌(무조건 들어야 하므로)
            if (s.getClasstype().equals("전필") || s.getClasstype().equals("기초")) {
                reqList.add(s);
                reportList.add(s); //추천된 과목 수료한 과목으로.

            }

        }

        List<Subject> selectionList = new ArrayList<Subject>();
        //전선과목만 따로 for문 돌려주기위함
        for (Subject s : subjectListToRec) {
            if (s.getClasstype().equals("전선")) {
                s.setPreSubjectList(guideLineService.getPreSubject(s.getSubjectCode()));
                selectionList.add(s);

            }
        }

        ///////////////학기별 (선수과목수강여부, 관심사, 추천학기 체크)///////////////
        //1-1학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 11 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }

                }
            }
        }

        //1-2학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 12 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //2-1학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 21 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //2-2학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 22 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //3-1학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 31 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //3-2학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));
            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {

                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {

                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 32 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //4-1학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 41 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        //4-2학기
        for (Subject s : selectionList) {
            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;
                        }
                    }
                }
            }
            else {
                presubjectFlag = true;
            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //관심사 체크(일치하는부분만)
                if (s.getInterest().equals(majorInfo.getInterest())) {
                    //추천학기 순으로 넣어줌
                    int semester = Integer.parseInt(s.getSemester());
                    if (semester <= 42 && !s.isRecommended()) {
                        s.setRecommended(true);
                        reqList.add(s);
                        reportList.add(s);

                    }
                }
            }
        }

        /////////////관심사별 (선수과목수강여부, 관심사, 추천학기 체크)///////////////
        //1-1학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 11 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        //1-2학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 12 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        //2-1학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 21 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        //2-2학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 22 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }
        //3-1학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 31 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        //3-2학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());

                if (semester <= 32 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        //4-1학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 41 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }
        //4-2학기
        for (Subject s : selectionList) {

            s.setSemester(autoRecService.getRecSemester(s.getSubjectCode(), majorInfo.getAdmission()));

            //선수과목수강여부 flag
            boolean presubjectFlag = false;
            if (s.getPreSubjectList() != null) {
                for (Subject subject : s.getPreSubjectList()) {
                    for (Subject subject2 : reportList) {
                        if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                            presubjectFlag = true;

                        }
                    }
                }
            }
            else {
                presubjectFlag = true;

            }
            //선수과목 수강 여부 체크
            if (presubjectFlag == true) {
                //추천학기 순으로 넣어줌
                int semester = Integer.parseInt(s.getSemester());
                if (semester <= 42 && !s.isRecommended()) {
                    s.setRecommended(true);
                    reqList.add(s);
                    reportList.add(s);
                }

            }
        }

        return reqList;
    }

    //추천받은 과목 으로 졸업여부 확인하는 alert
    @RequestMapping("alertBeforeSet.do")
    @ResponseBody
    public Isu alertBeforeSet(HttpSession session, String values) throws JsonParseException, JsonMappingException, IOException {
        String userId = (String) session.getAttribute("userId");

        Isu isu = new Isu();

        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);
        Department department = guideLineService.getDepartInfo(majorInfo);
        List<Report> reportList = userMajorInfoService.getReport(majorInfo);

        int forBasic = 0;
        int forMajor = 0;
        int forSelective = 0;
        int forGraduation = 0;

        for (Report report : reportList) {

            if (report.getGrade() > 0) {
                if (report.getSubject().getClasstype().equals("기초")) {
                    forBasic += report.getSubject().getCredit();
                }
                else if (report.getSubject().getClasstype().equals("전필")) {
                    forMajor += report.getSubject().getCredit();
                }
                else if (report.getSubject().getClasstype().equals("전선")) {
                    forSelective += report.getSubject().getCredit();
                }

                forGraduation += report.getSubject().getCredit();
            }
        }

        ObjectMapper om = new ObjectMapper();
        List<Subject> subs = om.readValue(values, new TypeReference<List<Subject>>() {
        });

        int savedBasic = 0;
        int savedMajor = 0;
        int savedSelection = 0;
        int savedGraduation = 0;

        for (Subject s : subs) {
            String subjectCode = s.getSubjectCode();

            if (subjectCode.substring(0, 1).equals("P")) {
                subjectCode = s.getSubjectCode().substring(1);
            }

            s.setSubjectCode(subjectCode);

            String classType = autoRecService.getClassTypeByCode(subjectCode, majorInfo);
            Subject subject = autoRecService.getSubjectByCode(subjectCode);

            if (classType.equals("전필")) {
                savedMajor += subject.getCredit();
            }
            else if (classType.equals("전선")) {
                savedSelection += subject.getCredit();
            }
            else {
                savedBasic += subject.getCredit();
            }

            savedGraduation += subject.getCredit();
        }

        //필요 학점 - 이수한 학점 
        isu.setNeedCreditForBasic(department.getNeedCreditForBasic() - forBasic);
        isu.setNeedCreditForGraduation(department.getNeedCreditForGraduation() - forGraduation);
        isu.setNeedCreditForRequirement(department.getNeedCreditForRequirement() - forMajor);
        isu.setNeedCreditForSelective(department.getNeedCreditForSelective() - forSelective);

        //추천받은 학점
        isu.setComBasicCredit(savedBasic);
        isu.setComMajorCredit(savedMajor);
        isu.setComSelecionCredit(savedSelection);
        isu.setComTotalCredit(savedGraduation);

        isu.setRemainedBasic(savedBasic + forBasic - department.getNeedCreditForBasic());
        isu.setRemainedReq(savedMajor + forMajor - department.getNeedCreditForRequirement());
        isu.setRemainedSelect(savedSelection + forSelective - department.getNeedCreditForSelective());
        isu.setRemainedTotal(savedGraduation + forGraduation - department.getNeedCreditForGraduation());

        return isu;
    }

    //update를 하고 이를 토대로 추천해준거 저장해주는 table만들기
    @RequestMapping("setRecData.do")
    public String setRecData(String values, HttpSession session) throws JsonParseException, JsonMappingException, IOException {
        String userId = (String) session.getAttribute("userId");

        ObjectMapper om = new ObjectMapper();
        List<Subject> subs = om.readValue(values, new TypeReference<List<Subject>>() {
        });

        for (Subject s : subs) {
            String subjectCode = s.getSubjectCode();

            if (subjectCode.substring(0, 1).equals("P")) {
                subjectCode = s.getSubjectCode().substring(1);
            }

            s.setSubjectCode(subjectCode);
        }

        autoRecService.setSavedSubject(userId, subs);

        return "autoRec";
    }

    @RequestMapping("showSaved.do")
    @ResponseBody
    public List<Subject> showSavedSubject(HttpSession session) {

        String userId = (String) session.getAttribute("userId");

        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);

        List<Subject> savedList = autoRecService.getSavedSubject(userId);

        List<Report> comList = userMajorInfoService.getReport(majorInfo);

        for (Subject s : savedList) {
            for (Report r : comList) {
                if (r.getSubjectCode().equals(s.getSubjectCode())) {
                    s.setRetake(r.getRetake());
                }
                s.setClasstype(autoRecService.getClassTypeByCode(s.getSubjectCode(), majorInfo));
            }
        }

        return savedList;

    }

}
