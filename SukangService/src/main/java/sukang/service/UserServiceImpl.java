package sukang.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sukang.dao.UserDao;
import sukang.domain.User;
import sukang.provider.DepartmentProvider;
import sukang.provider.SubjectProvider;
import sukang.provider.UserMajorInfoProvider;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserDao dao;
    @Autowired
    private UserMajorInfoProvider userProvider;
    @Autowired
    private DepartmentProvider depart;
    @Autowired
    private SubjectProvider subject;

    @Override
    public User getByIdUser(String userId) {
        
        // TODO Auto-generated method stub
        return userProvider.getUserById(userId);
    }

    @Override
    public void createUser(User user) {
        dao.insertUser(user);
        
    }

   
 
}
