package cn.fang.crud.controller;

import cn.fang.crud.bean.Department;
import cn.fang.crud.bean.Msg;
import cn.fang.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工CRUD请求
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> depts = departmentService.getAll();
//        PageInfo pageInfo = new PageInfo(depts,5);
        return Msg.success().add("depts",depts);
    }
}
