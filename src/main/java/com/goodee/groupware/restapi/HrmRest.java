package com.goodee.groupware.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.HrmService;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@CrossOrigin
@RestController
public class HrmRest {
	@Autowired
	private HrmService hrmService;
	
	@GetMapping("/rest/getOneMember")
	public List<Map<String,Object>> getOneMember2(@RequestParam(name = "memberId") String memberId){
		log.debug("getOneMember2.memberId() -->" + memberId);
	    List<Map<String,Object>> getOneMember = hrmService.getOneMember2(memberId);
	    log.debug("getOneMember2.getOneMember() -->" + getOneMember);
	    return getOneMember;
	}
	@GetMapping("/rest/getMemberList")
	public List<Map<String,Object>> getMemberListExcel() {
		List<Map<String,Object>> getMemberListExcel = hrmService.getMemberList();
		return getMemberListExcel;
		
	}
	

}
