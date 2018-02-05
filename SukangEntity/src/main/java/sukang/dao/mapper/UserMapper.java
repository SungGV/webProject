package sukang.dao.mapper;

import sukang.domain.User;

public interface UserMapper {

    /**
     * 회원가입
     */
    public void insertUser(User user);

    public User readUserById(String userId);

}
