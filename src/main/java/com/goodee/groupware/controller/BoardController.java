package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.BoardService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j 
public class BoardController {
	@Autowired
	private BoardService boardService;
	@GetMapping("board/boardList")
	   public String getBoardList(Model model, 
	                        @RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
	                        @RequestParam(name ="rowPerPage", defaultValue = "3") int rowPerPage,
	                        @RequestParam(name="departmentNo",defaultValue = "999") int departmentNo) {
	      Map<String, Object> resultMap = boardService.getBoardList(currentPage, rowPerPage, departmentNo);
	      
	      // Model에 addAttribute를 사용하여 view에 값을 보낸다.
	      // 자재 리스트
	      model.addAttribute("boardList", resultMap.get("boardList"));
	      
	      // 페이징 변수 값
	      model.addAttribute("currentPage", currentPage);
	      model.addAttribute("lastPage", resultMap.get("lastPage"));
	      
	      return "/board/boardList";
	   }

}
