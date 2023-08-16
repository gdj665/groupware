package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.FixturesService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FixturesController {
	@Autowired private FixturesService fixturesService;
	
	// 자재 리스트 
	@GetMapping("fixtures/fixturesList")
	public String getFixturesList(Model model, 
								@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
								@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(name ="partsName", required = false) String partsName) {
		// 서비스 호출
		Map<String, Object> resultMap = fixturesService.getFixturesList(currentPage, rowPerPage, partsName);
		log.debug("FixturesController.getFixturesList() resultMap --->" + resultMap.toString());
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 자재 리스트
		model.addAttribute("fixturesList", resultMap.get("fixturesList"));
		
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		
		return "/fixtures/fixturesList";
	}
}
