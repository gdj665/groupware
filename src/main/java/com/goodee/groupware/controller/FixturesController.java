package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
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
	@GetMapping("/group/fixtures/fixturesList")
	public String getFixturesList(Model model, 
								HttpSession session,
								@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
								@RequestParam(name ="rowPerPage", defaultValue = "5") int rowPerPage,
								@RequestParam(name ="partsName", required = false) String partsName) {
		// 서비스 호출
		Map<String, Object> resultMap = fixturesService.getFixturesList(currentPage, rowPerPage, partsName);
		log.debug("FixturesController.getFixturesList() resultMap --->" + resultMap.toString());
		
		// 장비 추가 및 비활성화는 팀장급만 가능하도록 세션에서 Level값 가져옴 
		String Level = (String) session.getAttribute("memberLevel");
		// 앞에 숫자만 사용하여 비교하도록 int값으로 파싱함
		int memberLevel = Integer.parseInt(Level.substring(0, 1));
		String memberId = (String) session.getAttribute("loginMember");
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 자재 리스트
		model.addAttribute("fixturesList", resultMap.get("fixturesList"));
		// 자재 추가시 상위 카테고리 리스트
		model.addAttribute("partsCategoryList", resultMap.get("partsCategoryList"));
		// 자재 추가 및 비활성화를 위해 level값 보냄
		model.addAttribute("memberLevel", memberLevel);
		model.addAttribute("memberId", memberId);
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));
		
		
		return "/fixtures/fixturesList";
	}
	
	// 2) parts 추가
	@PostMapping("/group/fixtures/addParts")
	public String addParts( Parts parts) {
		
		// 추가 서비스 호출
		int row = fixturesService.addParts(parts);
		
		log.debug("FixturesController.addParts parts --->" + parts.toString());
		if(row > 0) {
			log.debug("FixturesController.addParts() row --->" + row + "입력성공"); 
		} else {
			log.debug("FixturesController.addParts() row --->" + row + "입력실패"); 
		}
		return "redirect:/group/fixtures/fixturesList";
	}
	
	// 3) parts 비활성화
	@GetMapping("/group/fixtures/updatePartsAlive")
	public String updatePartsAlive( Parts parts) {
		
		
		// 비활성화 서비스 호출
		int row = fixturesService.updatePartsAlive(parts);
		
		log.debug("FixturesController.updatePartsAlive Param parts --->" + parts.toString());
		if(row > 0) {
			log.debug("FixturesController.updatePartsAlive() row --->" + row + "삭제성공"); 
		} else {
			log.debug("FixturesController.updatePartsAlive() row --->" + row + "삭제실패"); 
		}
		return "redirect:/group/fixtures/fixturesList";
	}
}
