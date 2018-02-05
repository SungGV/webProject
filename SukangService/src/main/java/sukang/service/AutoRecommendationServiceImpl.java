package sukang.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.domain.Department;
import sukang.domain.PreSubject;
import sukang.domain.Report;
import sukang.domain.Subject;
import sukang.domain.User;
import sukang.domain.UserMajorInfo;
import sukang.provider.DepartmentProvider;
import sukang.provider.SubjectProvider;
import sukang.provider.UserMajorInfoProvider;

@Service
public class AutoRecommendationServiceImpl implements AutoRecommendationService {

    @Autowired
    private UserMajorInfoProvider userProvider;
    @Autowired
    private SubjectProvider subjectProvider;
    @Autowired
    private DepartmentProvider departProvider;




    @Override
    public List<Subject> getAllClassListForMajor(UserMajorInfo majorInfo) {

        return subjectProvider.getAllClassListForMajor(majorInfo);
    }


    @Override
    public List<Subject> getListToRecSubject(UserMajorInfo majorInfo) {
        //complementSubject_tb가져옴
        List<Subject> comSubjectList = userProvider.getCompletedSubjectById(majorInfo);
        
        //reSubject_tb 가져옴
        List<Subject> allClassList  = subjectProvider.getAllClassListForMajor(majorInfo);
        
        //return 해줄 list
        List<Subject> allClassList2 = new ArrayList<Subject>();
        
        int checkFlag = 0; //중복 체크할 flag
        
        //for문을 2중으로 돌려서 중복체크를 해줌
        //중복시 flag++ 해주고 break걸어서 allClassList2에 add하지 않음
        //중복 안되는 subject만 allClassList2에 add해줌
        //최종으로 allClassList2를 return해주어 reqSubjectList를 뿌림
        for (Subject subject : allClassList) {
            //학수구분,추천학년 넣어줘야함
            String classType = subjectProvider.readClassTypeByCode(subject.getSubjectCode(), majorInfo);
            subject.setClasstype(classType);

            for (Subject subject2 : comSubjectList) {
                if (subject.getSubjectCode().equals(subject2.getSubjectCode())) {
                    checkFlag++;
                    break;
                }
            }
            if (checkFlag == 0) {
                
                allClassList2.add(subject);
            }
            else {
                checkFlag = 0;
            }
        }
        
        return allClassList2;
    }

    @Override
    public String getRecSemester(String subjectCode, String admission) {
        return subjectProvider.getRecSemester(subjectCode, admission);
        
    }


    @Override
    public void setSavedSubject(String userId, List<Subject> subjectList) {
        userProvider.updateSavedRecSubject(userId, subjectList);
        
    }


    @Override
    public List<Subject> getSavedSubject(String userId) {
        
        return userProvider.getSavedSubject(userId);
    }


    @Override
    public String getClassTypeByCode(String subjectCode, UserMajorInfo majorInfo) {
       
        return subjectProvider.readClassTypeByCode(subjectCode, majorInfo);
    }


    @Override
    public Subject getSubjectByCode(String subjectCode) {
        
        return subjectProvider.readSubjectBySubjectCode(subjectCode);
    }


    

}
