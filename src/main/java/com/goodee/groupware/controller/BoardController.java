package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

	// 1.) 부서별 게시물 리스트 출력
	@GetMapping("/group/board/boardList")
	public String getBoardList(
		Model model, 
		@RequestParam(name = "departmentNo", defaultValue = "0") int departmentNo,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "5") int rowPerPage,
		@RequestParam(name = "searchWord", required = false) String searchWord,
		HttpSession session) {
		
		// 세션에서 departmentNo받아와서 처리
		if(departmentNo==-1) {
			departmentNo = (Integer) session.getAttribute("departmentNo");
			departmentNo = departmentNo/100*100;
			log.debug("BoardController.getBoardList-->부서게시판 실행");
		}
		String memberId = (String)session.getAttribute("loginMember");
		// 서비스에서 값 받아와서 resultMap에 저장
		Map<String, Object> resultMap = boardService.getBoardList(currentPage,rowPerPage,searchWord,departmentNo);

		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		model.addAttribute("boardList", resultMap.get("boardList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("memberId", memberId);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));

		return "/board/boardList";
	}
	
	// 2.) 게시물 상세 출력
	@GetMapping("/group/board/boardOne")
	public String getOneBoard(Model model,Board board,BoardFile boardFile, HttpSession session) {
		
		// 세션에서 아이디값 받아오기
		String memberId = (String) session.getAttribute("loginMember");
		
		Map<String, Object> boardOneMap = boardService.getOneBoard(board, boardFile);
		model.addAttribute("boardOne",boardOneMap.get("boardOne"));
		model.addAttribute("boardFileList",boardOneMap.get("boardFileList"));
		model.addAttribute("memberId",memberId);
		
		return "/board/boardOne";
	}
	
	// 4.) 게시물 추가
	@GetMapping("/group/board/addBoard")
	public String addBoard(Model model,HttpSession session) {
		String memberId = (String)session.getAttribute("loginMember");
		model.addAttribute("memberId", memberId);
		
		return "/board/addBoard";
	}
	@PostMapping("/group/board/addBoard")
	public String addBoard(HttpServletRequest request,Board board, HttpSession session) { 
		
		int loginDepartmentNo = (Integer) session.getAttribute("departmentNo");
		loginDepartmentNo = loginDepartmentNo/100*100;
		String loginMemberId = (String) session.getAttribute("loginMember");
		
		board.setMemberId(loginMemberId);
		board.setDepartmentNo(loginDepartmentNo);
		
		// 파일 이 저장될 경로 설정
		String path = request.getServletContext().getRealPath("/boardFile/");
		int row = boardService.addBoard(board,path);
		log.debug("BoardController.AddRow --> "+row);
		
		return "redirect:/group/board/boardList?departmentNo="+loginDepartmentNo;
	}
	
	// 3.) 게시물 삭제
	@PostMapping("/group/board/deleteBoard")
	public String deleteBoard(HttpServletRequest request,Board board,BoardFile boardFile, HttpSession session) {
		
		// 파일이 저장되어 있는경로
		String path = request.getServletContext().getRealPath("/boardFile/");
		
		String loginMemberId = (String) session.getAttribute("loginMember");
		board.setMemberId(loginMemberId);
		
		int row = boardService.deleteBoard(path, boardFile, board);
		// 디버깅
		log.debug("BoardControllerDeleteRow --> "+row);
		
		return "redirect:/group/board/boardList";
	}
}
