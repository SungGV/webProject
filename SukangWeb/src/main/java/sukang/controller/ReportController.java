package sukang.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.UserMajorInfo;
import sukang.service.UserMajorInfoService;

// 성적표 컨트롤러.
@Controller
public class ReportController {

    @Autowired
    private UserMajorInfoService userMajorService;

    // 페이지를 열었을때 보여주는 화면
    @RequestMapping("report.do")
    public String checkSemester(HttpSession session, Model model, String pickedSemester) {

        String userId = (String) session.getAttribute("userId");

        UserMajorInfo major = userMajorService.getUserMajorInfoById(userId);
        if (major == null) {
            throw new RuntimeException("전공 정보가 입력되지 않았습니다.");
        }
        String semester = major.getComSemester();

        model.addAttribute("semester", semester);

        // 학기에 따른 성적표를 담은 Report형식의 리스트를 만든다
        List<Report> resultReports = new ArrayList<Report>();

        // 점수 계산에 필요한 점수와 학점 변수 선언
        double userGrade = 0;
        int userCredit = 0;

        List<Report> reports = new ArrayList<Report>();
        // major로 이수과목을 가져온다
        reports = userMajorService.getReport(major);

        // for문을 돌면서 Report안에 안에 있는 이수 학기와 사용자가 화면에서 선택한 학기를 일치시킨다
        for (Report report : reports) {
            
            Report newReport = new Report();
            double grade = report.getGrade();
            Subject subject = report.getSubject();
            int credit = subject.getCredit();
            
            
            subject.setYear(report.getCompletedSemester().substring(0, 1));
            subject.setSemester(report.getCompletedSemester().substring(1));

            newReport.setGrade(grade);
            newReport.setSubject(subject);
            newReport.setCompletedSemester(report.getCompletedSemester());
            newReport.setRetake(report.getRetake());
            
            if (report.getGrade() == 4.5) {
                newReport.setGrade2("A+");
            }
            else if (report.getGrade() == 4.0) {
                newReport.setGrade2("A0");
            }
            else if (report.getGrade() == 3.5) {
                newReport.setGrade2("B+");
            }
            else if (report.getGrade() == 3.0) {
                newReport.setGrade2("B0");
            }
            else if (report.getGrade() == 2.5) {
                newReport.setGrade2("C+");
            }
            else if (report.getGrade() == 2.0) {
                newReport.setGrade2("C0");
            }
            else if (report.getGrade() == 1.5) {
                newReport.setGrade2("D+");
            }
            else if (report.getGrade() == 1.0) {
                newReport.setGrade2("A0");
            }
            else {
                newReport.setGrade2("F");
            }

            resultReports.add(newReport);

            // 학점과 점수를 계산하는 부분
            if(report.getGrade() != 0){
                userCredit += credit;
            }
            userGrade += (grade * credit);
        }

        // gpa는 계산된 성적을 뜻함
        double gpa = userGrade / userCredit;
        double b = (Math.round(gpa * 100) / 100.00);

        model.addAttribute("credit", userCredit);
        model.addAttribute("grade", b);

        Collections.sort(resultReports);

        // 성적표리스트
        model.addAttribute("resultReports", resultReports);

        return "grade";
    }

    // select박스에서 학기를 선택 했을때 user가 원하는 학기의 성적표를 보여주기 위한 매소드
    @RequestMapping("showReportCard")
    public String showReport(HttpSession session, Model model, String pickedSemester) {
        String userId = (String) session.getAttribute("userId");

        UserMajorInfo major = userMajorService.getUserMajorInfoById(userId);
        String semester = major.getComSemester();

        model.addAttribute("semester", semester);

        // 학기에 따른 성적표를 담은 Report형식의 리스트를 만든다
        List<Report> resultReports = new ArrayList<Report>();

        // 점수 계산에 필요한 점수와 학점 변수 선언
        double userGrade = 0;
        int userCredit = 0;

        List<Report> reports = new ArrayList<Report>();
        // major로 이수과목을 가져온다
        reports = userMajorService.getReport(major);

        // for문을 돌면서 Report안에 안에 있는 이수 학기와 사용자가 화면에서 선택한 학기를 일치시킨다
        for (Report report : reports) {

            if (report.getCompletedSemester().equals(pickedSemester)) {

                Report newReport = new Report();
                double grade = report.getGrade();
                Subject subject = report.getSubject();
                int credit = subject.getCredit();

                subject.setYear(report.getCompletedSemester().substring(0, 1));
                subject.setSemester(report.getCompletedSemester().substring(1));

                newReport.setGrade(grade);
                newReport.setSubject(subject);
                newReport.setCompletedSemester(report.getCompletedSemester());
                newReport.setRetake(report.getRetake());
                
                if (report.getGrade() == 4.5) {
                    newReport.setGrade2("A+");
                }
                else if (report.getGrade() == 4.0) {
                    newReport.setGrade2("A0");
                }
                else if (report.getGrade() == 3.5) {
                    newReport.setGrade2("B+");
                }
                else if (report.getGrade() == 3.0) {
                    newReport.setGrade2("B0");
                }
                else if (report.getGrade() == 2.5) {
                    newReport.setGrade2("C+");
                }
                else if (report.getGrade() == 2.0) {
                    newReport.setGrade2("C0");
                }
                else if (report.getGrade() == 1.5) {
                    newReport.setGrade2("D+");
                }
                else if (report.getGrade() == 1.0) {
                    newReport.setGrade2("A0");
                }
                else {
                    newReport.setGrade2("F");
                }
                
                resultReports.add(newReport);

                // 학점과 점수를 계산하는 부분
                if(report.getGrade() != 0){
                    userCredit += credit;
                }
                userGrade += (grade * credit);

            }
            else if (pickedSemester.equals("total")) {
                Report newReport = new Report();
                double grade = report.getGrade();
                Subject subject = report.getSubject();
                int credit = subject.getCredit();

                subject.setYear(report.getCompletedSemester().substring(0, 1));
                subject.setSemester(report.getCompletedSemester().substring(1));

                newReport.setGrade(grade);
                newReport.setSubject(subject);
                newReport.setCompletedSemester(report.getCompletedSemester());
                newReport.setTypeOfClass(report.getTypeOfClass());
                newReport.setRetake(report.getRetake());
                
                if (report.getGrade() == 4.5) {
                    newReport.setGrade2("A+");
                }
                else if (report.getGrade() == 4.0) {
                    newReport.setGrade2("A0");
                }
                else if (report.getGrade() == 3.5) {
                    newReport.setGrade2("B+");
                }
                else if (report.getGrade() == 3.0) {
                    newReport.setGrade2("B0");
                }
                else if (report.getGrade() == 2.5) {
                    newReport.setGrade2("C+");
                }
                else if (report.getGrade() == 2.0) {
                    newReport.setGrade2("C0");
                }
                else if (report.getGrade() == 1.5) {
                    newReport.setGrade2("D+");
                }
                else if (report.getGrade() == 1.0) {
                    newReport.setGrade2("A0");
                }
                else {
                    newReport.setGrade2("F");
                }
                resultReports.add(newReport);
                // 전체과목
                // 학점과 점수를 계산하는 부분
                if(report.getGrade() != 0){
                    userCredit += credit;
                }
                userGrade += (grade * credit);

            }
        }

        // gpa는 계산된 성적을 뜻함
        double gpa = userGrade / userCredit;
        double b = (Math.round(gpa * 100) / 100.00);

        model.addAttribute("credit", userCredit);
        model.addAttribute("grade", b);

        // 학년, 학기 구분을 위한 substring
        String studentYear = pickedSemester.substring(0, 1);
        String studentSemester = pickedSemester.substring(1, 2);
        Collections.sort(resultReports);

        // 성적표리스트
        model.addAttribute("resultReports", resultReports);
        // 학년
        model.addAttribute("studentYear", studentYear);
        // 학기
        model.addAttribute("studentSemester", studentSemester);

        return "grade";
    }
}
