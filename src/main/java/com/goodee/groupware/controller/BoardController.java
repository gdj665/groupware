package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.BoardService;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class BoardController {
	@Autowired
	private BoardService boardService;

// 게시물 리스트 출력
	@GetMapping("board/boardList")
	public String getBoardList(
		Model model, 
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "3") int rowPerPage,
		@RequestParam(name = "departmentNo", defaultValue = "999") int departmentNo) {
		
		Map<String, Object> resultMap = boardService.getBoardList(currentPage, rowPerPage, departmentNo);

		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		model.addAttribute("boardList", resultMap.get("boardList"));

		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));

		return "/board/boardList";
	}
// 게시물 상세출력
	@GetMapping("board/boardOne")
	public String getOneBoard(Model model,Board board,BoardFile boardFile) {
		Map<String, Object> boardOneMap = boardService.getOneBoard(board, boardFile);
		model.addAttribute("boardOne",boardOneMap.get("boardOne"));
		model.addAttribute("boardFileList",boardOneMap.get("boardFileList"));
		return "/board/boardOne";
	}
	
// 게시물 추가하기
	@GetMapping("/board/addBoard")
	public String addBoard() {
		return "board/addBoard";
	}
	@PostMapping("/board/addBoard")
	public String addBoard(HttpServletRequest request,Board board) { 
		//매개값으로 request객체를 받는다 <- request api를 직접 호출하기 위해서
		// 파일 이 저장될 경로 설정
		String path = request.getServletContext().getRealPath("/boardFile/");
		int row = boardService.addBoard(board,path);
		System.out.println("BoardControllerRow --> "+row);
		return "redirect:/board/boardList";
	}
}
