package sukang.service;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import sukang.domain.User;

public class UserServiceTest {

    User user = new User();
    UserService service = new UserServiceImpl();
    
    @Test
    public void testCreate() {
        
        /*ApplicationContext ac = new ClassPathXmlApplicationContext("dispatcher-servlet.xml");
        BookService service = ac.getBean("bookServiceImpl", BookServiceImpl.class);*/
        
        
    }
}
