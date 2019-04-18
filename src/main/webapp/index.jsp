<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>员工列表</title>
    <%
        application.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 添加员工的模态框 -->
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <%--加上name属性使springmvc自动获取--%>
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender0_add_input" value="F"> 女
                            </label>

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改员工的模态框 -->
<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_update_static" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <%--加上name属性使springmvc自动获取--%>
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_update_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender0_update_input" value="F"> 女
                            </label>

                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="add_emp_modal_btn">新增</button>
            <button class="btn btn-danger" id="del_all_btn">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"/></th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>operation</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--分页--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页导航条--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord, currentPage, pageSize;
    //1.页面加载完成后，直接发送一个ajax请求，取得分页数据
    $(function () {
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条
                build_page_nav(result);
            }
        });
    }

    //解析显示员工
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // alert(item.empName);
            var checkBox = $("<td></td>").append("<input type='checkbox' class='check_item'/>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == "M" ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("emp-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("emp-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBox)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptTd)
                .append(btnTd)
                .appendTo("#emps_table");
        })
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append(" 当前第" + result.extend.pageInfo.pageNum + " 页，总共"
            + result.extend.pageInfo.pages + "页，总共" + result.extend.pageInfo.total + "条记录");
        totalRecord = result.extend.pageInfo.total;
        pageSize = result.extend.pageInfo.pageSize;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        //上一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href", "#"));
        if (result.extend.pageInfo.hasPreviousPage != true) {
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        } else {
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
            firstPageLi.click(function () {
                to_page(1);
            });
        }
        //下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href", "#"));
        //尾页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));
            numLi.click(function () {
                to_page(item);
            });
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").attr("aria-label", "Page navigation").append(ul);
        $("#page_nav_area").append(navEle).addClass("col-md-6");
    }

    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮，弹出模态框
    $("#add_emp_modal_btn").click(function () {
        //表单完整重置（数据和样式）
        reset_form("#addEmpModal form");
        get_depts("#dept_add_select");
        $("#addEmpModal").modal({
            backdrop: "static"
        });
    })

    //发出ajax请求，获取部门信息并解析显示在下拉列表中
    function get_depts(ele) {
        //清空下拉列表
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                // console.log(result);
                //{"code":100,"msg":"处理成功!",
                // "extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                $.each(result.extend.depts, function (index, item) {
                    $(ele).append($("<option></option>").append(item.deptName).attr("value", item.deptId));
                })
            }
        });
    }

    //显示校验信息
    function show_validate_msg(ele, status, msg) {
        $(ele).parent().removeClass("has-success has-error")
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //检验表单数据
    function validate_add_form() {
        //使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位中文或者4-16位英文和数字的组合！");
            show_validate_msg("#empName_add_input", "error", "用户名必须是2-5位中文或者4-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }
        var email = $("#email_add_input").val();
        var regEmal = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regEmal.test(email)) {
            // alert("邮箱格式错误！");
            show_validate_msg("#email_add_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;
    }

    //绑定change事件，发送ajax请求，校验用户名是否可用
    $("#empName_add_input").change(function () {
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + this.value,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用")
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", "用户名不可用")
                    $("#emp_save_btn").attr("ajax-va", "error");
                }

            }
        });
    });

    //点击保存
    $("#emp_save_btn").click(function () {
        //对数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //1.模态框中表单数据交给服务器进行保存
        //2.发送ajax请求保存员工
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        // alert($("#addEmpModal form").serialize())
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#addEmpModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //当保存成功，关闭对话框，来到最后一页显示信息
                if (result.code == 100) {
                    $("#addEmpModal").modal("hide");
                    //发送ajax请求显示最后一页数据
                    to_page(totalRecord + 1);//分页插件保证查询的范围
                } else {
                    //显示失败信息
                    if (result.extend.errorMap.email == undefined) {
                        show_validate_msg("#email_add_input", "error", "邮箱格式错误");
                    }
                    if (result.extend.errorMap.empName == undefined) {
                        show_validate_msg("#empName_add_input", "error", "用户名必须是2-5位中文或者4-16位英文和数字的组合");
                    }
                }
            }
        });
    });

    //1.因为在按钮创建之前就绑定了事件，所以绑定不上
    //2.可以在创建按钮时绑定事件
    //3.on()方法
    // $(".edit_btn").click(function () {
    //     alert("edit");
    // })
    $(document).on("click", ".edit_btn", function () {
        //1.查出员工信息
        //2.查出部门信息
        get_depts("#dept_update_select");
        getEmp($(this).attr("emp-id"));
        $("#updateEmpModal").modal({
            backdrop: "static"
        });
        $("#emp_update_btn").attr("emp-id", $(this).attr("emp-id"));
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var emp = result.extend.emp;
                $("#empName_update_static").text(emp.empName);
                $("#email_update_input").val(emp.email);
                $("#updateEmpModal input[name=gender]").val([emp.gender]);
                $("#updateEmpModal select").val([emp.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmal = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regEmal.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式错误");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //发送ajax请求
        /**
         * 如果直接发送ajax PUT请求
         * 请求体中有数据，但是Employee对象封装不上
         * 导致sql拼接成 update tbl_emp where emp_id=104
         *
         * 原因：Tomcat 将请求体中的数据，封装成一个map。
         * request.getParameter("empName")就会从map中取值
         * SpringMvc封装POJO对象时，会把每个属性的值调用request.getParameter()方法
         *
         * Ajax  不能直接发送PUT请求，会导致请求体中的数据都get不到
         * Tomcat只有POST请求才会封装
         */
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("emp-id"),
            type: "POST",
            // data:$("#updateEmpModal form").serialize()+"&_method=PUT",
            data: $("#updateEmpModal form").serialize() + "&_method=PUT",
            success: function (result) {
                // alert(result.msg);
                //1.关闭模态框
                $("#updateEmpModal").modal("hide");
                //2.回到页面
                to_page(currentPage);
            }
        })
    });

    //单个删除
    $(document).on("click", ".del_btn", function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + empName + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("emp-id"),
                type: "DELETE",
                success: function (result) {
                    // alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            })
        }
    });

    //全选/全不选
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //原生的属性使用prop，自定义的使用attr
        // alert($(this).prop("checked"));
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否选满
        if ($(".check_item:checked").length == pageSize) {
            $("#check_all").prop("checked", true);
        } else {
            $("#check_all").prop("checked", false);
        }
    });

    //批量删除
    $("#del_all_btn").click(function () {
        var empNames = "";
        var ids = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+"，";
            ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        ids = ids.substring(0,ids.length-1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/emp/"+ids,
                type: "DELETE",
                success: function (result) {
                    // alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            })
        }
    });

</script>
</body>
</html>
