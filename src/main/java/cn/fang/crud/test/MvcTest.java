package cn.fang.crud.test;

import cn.fang.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块提供的测试请求功能，测试crud请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration  //能装载ioc容器
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
public class MvcTest {
    //传入Springmvc的ioc
    @Autowired
    WebApplicationContext webApplicationContext;
    //虚拟mvc请求
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();
        //请求成功以后，请求域中会有pageInfo，可以取出进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页数："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("在页面连续显示的页码："+pageInfo.getNavigatepageNums());

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee e:list){
            System.out.println("ID:"+e.getEmpId());
        }
    }
}
