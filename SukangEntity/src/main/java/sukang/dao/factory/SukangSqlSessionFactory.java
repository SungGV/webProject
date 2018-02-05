package sukang.dao.factory;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;



public class SukangSqlSessionFactory {

    private static SukangSqlSessionFactory instance;
    private SqlSessionFactory sqlSessionFactory;
    private final String resource = "mybatis-config.xml";
    
    
    /**
     * 기본 생성자
     */
    private SukangSqlSessionFactory() {
        //호출 할 때 마다 새로운 팩토리 생성을 막기 위한 private 조치
    }
    
    public static SukangSqlSessionFactory getInstance() {
        // 처음일때는 null이니까 처음에는 객채 생성해준다
        if(instance == null) {
            instance = new SukangSqlSessionFactory();
        }
        return instance;
    }
    
    /**
     * SqlSessiondmf 반환한다.
     * @return
     * @throws IOException 
     */
    public SqlSession getSqlSession() {
        if(sqlSessionFactory == null) {
        Reader reader;
        
        try {
            reader = Resources.getResourceAsReader(resource);
        }
        
        catch(IOException e) {
           throw new RuntimeException(resource + "파일 로드중 에러가 발생했습니다");
        }
        
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        }
        return sqlSessionFactory.openSession(true);
        
    }
}
