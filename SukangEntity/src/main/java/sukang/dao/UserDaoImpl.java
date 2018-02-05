package sukang.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import sukang.dao.factory.SukangSqlSessionFactory;
import sukang.dao.mapper.UserMapper;
import sukang.domain.User;

@Repository
public class UserDaoImpl implements UserDao {


   

    @Override
    public User readUserById(String userId) {
        
        User user = new User();
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            user = mapper.readUserById(userId);
        }
        finally{
            sqlSession.close();
        }
        return user;
    }

    @Override
    public void insertUser(User user) {
        SqlSession sqlSession;
        sqlSession = SukangSqlSessionFactory.getInstance().getSqlSession();
        try{
            UserMapper mapper = sqlSession.getMapper(UserMapper.class);
            mapper.insertUser(user);
        }
        finally{
            sqlSession.close();
        }
        
    }
   
}
