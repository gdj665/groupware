package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.FixturesService;
import com.goodee.groupware.vo.Parts;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FixturesController {
	@Autowired private FixturesService fixturesService;
	
	// 1) 자재 리스트 
	@GetMapping("/fixtures/fixturesList")
	public String getFixturesList(Model model, 
								@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
								@RequestParam(name ="rowPerPage", defaultValue = "5") int rowPerPage,
								@RequestParam(name ="partsName", required = false) String partsName) {
		// 서비스 호출
		Map<String, Object> resultMap = fixturesService.getFixturesList(currentPage, rowPerPage, partsName);
		log.debug("FixturesController.getFixturesList() resultMap --->" + resultMap.toString());
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 자재 리스트
		model.addAttribute("fixturesList", resultMap.get("fixturesList"));
		// 자재 추가시 상위 카테고리 리스트
		model.addAttribute("partsCategoryList", resultMap.get("partsCategoryList"));
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));
		
		return "/fixtures/fixturesList";
	}
	
	// 2) parts 추가
	@PostMapping("/fixtures/addParts")
	public String addParts(Parts parts) {
		// 추가 서비스 호출
		int row = fixturesService.addParts(parts);
		
		log.debug("FixturesController.addParts parts --->" + parts.toString());
		if(row > 0) {
			log.debug("FixturesController.addParts() row --->" + row + "입력성공"); 
		} else {
			log.debug("FixturesController.addParts() row --->" + row + "입력실패"); 
		}
		return "redirect:/fixtures/fixturesList";
	}
	
	// 3) parts 삭제
	@GetMapping("/fixtures/deleteParts")
	public String deleteParts(Parts parts) {
		// 삭제 서비스 호출
		int row = fixturesService.deleteParts(parts);
		
		log.debug("FixturesController.addParts parts --->" + parts.toString());
		if(row > 0) {
			log.debug("FixturesController.deleteParts() row --->" + row + "삭제성공"); 
		} else {
			log.debug("FixturesController.deleteParts() row --->" + row + "삭제실패"); 
		}
		return "redirect:/fixtures/fixturesList";
	}
}
