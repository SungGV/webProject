package sukang.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import sukang.domain.User;
import sukang.service.UserService;

@Controller
public class LoginController {

    @Autowired
    UserService userService;

    @RequestMapping("login.do")
    public void logout(HttpSession session, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userId = (String) req.getParameter("userId");

        //user_tb에서 userId 중복 체크
        User user = userService.getByIdUser(userId);

        //회원가입필요시
        if (user == null) {
            User u = new User();
            //if( == null) userTable에 저장 ( userId, 이름, phone, email, => 가능한한 모두 페이스북에서)
            String name = (String) req.getParameter("userName");
            u.setName(name);
            u.setUserId(userId);
            
            userService.createUser(u);
        }

            session.setAttribute("loginId", userId);
            resp.sendRedirect(req.getContextPath() + "/views/completed.jsp");
        

    }
}
