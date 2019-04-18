package cn.fang.crud.test;

import cn.fang.crud.bean.Department;
import cn.fang.crud.bean.Employee;
import cn.fang.crud.dao.DepartmentMapper;
import cn.fang.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 * 1.导入SpringTest模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCURD(){
        //1.创建SpringIOC容器
        //2.从容器中获取mapper
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
//        1.插入几个部门
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));
//        2.生成员工数据
        employeeMapper.insertSelective(new Employee(null,"tom","M","tom@qq.com",1));
//        3.批量插入多个员工；使用可以执行批量操作的sqlSession，
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            String uuid = UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Employee(null,uuid,"M",uuid+"@gmail.com",1));
        }
//        4.删除指定编号员工
        employeeMapper.deleteByPrimaryKey(2);
//        5.更新员工信息
        employeeMapper.updateByPrimaryKeySelective(new Employee(3,"fang","M","dang@163.com",2));
    }
}
