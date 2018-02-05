package sukang.dao;

import sukang.domain.User;

public interface UserDao {
    
   public void insertUser(User user);
   /**
    * 유저정보 조회(user_tb)
    * @param userId
    * @return
    */
   public User readUserById(String userId);
}
