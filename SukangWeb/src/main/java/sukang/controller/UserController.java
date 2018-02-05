package sukang.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import sukang.service.UserService;

@Controller
public class UserController {
    
    @Autowired
    private UserService service;
    
    @RequestMapping("user.do")
    public String create() {
        
        return "user";
    }
}
