package sukang.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sukang.domain.UserMajorInfo;
import sukang.service.UserMajorInfoService;

@Controller
public class LogoutController {
    
    @Autowired
    private UserMajorInfoService userMajorInfoService;
    
    
    @RequestMapping("logout.do")
    public void logout(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        session.invalidate();
        
        
       
        resp.sendRedirect(req.getContextPath());
        
        
    }
    
    @RequestMapping("confirm.do")
    @ResponseBody
    public boolean confirm(HttpSession session){
        
        String userId = (String) session.getAttribute("userId");
        
        UserMajorInfo majorInfo = userMajorInfoService.getUserMajorInfoById(userId);
        
        if(majorInfo == null){
            return false;
        }
        else{
            return true;
        }
        
    }
}
