package cn.fang.crud.service;

import cn.fang.crud.bean.Department;
import cn.fang.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    /**
     * 查询员工数据
     * @return
     */
    public List<Department> getAll(){
        return departmentMapper.selectByExample(null);
    }
}
