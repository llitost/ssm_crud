package cn.fang.crud.controller;

import cn.fang.crud.bean.Employee;
import cn.fang.crud.bean.Msg;
import cn.fang.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 单个和批量皆可
     * 批量删除：1-2-3
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        //批量删除
        if(ids.contains("-")){
            String[] strings = ids.split("-");
            List<Integer> list = new ArrayList<>();
            for(String s:strings){
                list.add(Integer.valueOf(s));
            }
            employeeService.deleteBatch(list);
        }else{
            employeeService.deleteEmp(Integer.valueOf(ids));
        }
        return Msg.success();
    }

    /**
     * 员工更新
     * 配置上HttpPutFormContentFilter
     * 作用：将请求体中的数据重新包装成map
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        if(employee!=null){
            return Msg.success().add("emp",employee);
        }else {
            return Msg.fail();
        }
    }

    /**
     * 员工保存
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     * @return
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError f : errors) {
                System.out.println("错误的字段名："+f.getField());
                System.out.println("错误信息："+f.getDefaultMessage());
                map.put(f.getField(),f.getDefaultMessage());
            }
            return Msg.fail().add("errorMap",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名字是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(empName.matches(regx)==false){
            return Msg.fail().add("va_msg","用户名必须是2-5位中文或者4-16位英文和数字的组合");
        }
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success().add("va_msg","用户名可用");
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 导入Jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageIfo交给页面就行了
        //可传入连续显示的页数，封装了详细的分页信息
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 查询员工数据（分页查询）
     * @return
     */
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页查询
        //在查询之前只需调用,传入页码及大小
        PageHelper.startPage(pn,5);
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageIfo交给页面就行了
        //可传入连续显示的页数，封装了详细的分页信息
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
