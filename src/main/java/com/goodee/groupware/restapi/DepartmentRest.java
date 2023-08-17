package com.goodee.groupware.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.DepartmentService;
import com.goodee.groupware.vo.Department;

@CrossOrigin
@RestController
public class DepartmentRest {
    @Autowired
    private DepartmentService departmentService;

    @GetMapping("rest/departmentList")
    public Map<String, Object> getTeamDepartmentList(@RequestParam String departmentId) {
        // Department 객체를 생성하여 departmentId를 설정
        Department department = new Department();
        int departmentNo = Integer.parseInt(departmentId);
        department.setDepartmentNo(departmentNo);

        // 서비스 메서드 호출하여 팀 리스트 조회
        Map<String, Object> teamResultMap = departmentService.getTeamDepartment(department);
        
        return teamResultMap;
    }
}
