package sukang.service;

import sukang.domain.User;

public interface UserService {

    
    /**
     * 유저 아이디로 유저객체 받아오기
     * 사용자: 김성진(login)
     * @param userId
     * @return
     */
    public User getByIdUser(String userId);
    
    /**
     * 페이스북으로 최초 로그인시 회원가입 실시
     * @param user
     */
    public void createUser(User user);
}
