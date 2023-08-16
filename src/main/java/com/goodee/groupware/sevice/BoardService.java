package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.BoardMapper;
import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private FileMapper fileMapper;
	
	// 보드 리스트
	public Map<String,Object> getBoardList(int currentPage, int rowPerPage, int departmentNo) {
		
		// 페이징 첫 번째 줄
		int beginRow = (currentPage-1)*rowPerPage;
		
		// 페이징을 위한 변수 boardMap에 선언
		Map<String,Object> boardMap = new HashMap<String,Object>();
		boardMap.put("beginRow",beginRow);
		boardMap.put("rowPerPage",rowPerPage);
		boardMap.put("departmentNo",departmentNo);
		// boardMap 디버깅
		log.debug("BoardService.getBoardList() boardMap --->" + boardMap.toString());
		
		
		List<Map<String,Object>> boardList = boardMapper.getBoardList(boardMap);
		
		int boardCount = boardMapper.getBoardListCount(departmentNo);
		int lastPage = boardCount / rowPerPage;
		if((boardCount%rowPerPage) != 0) {
			lastPage++;
		}
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("boardList",boardList);
		resultMap.put("lastPage",lastPage);
		
		return resultMap;
	}
}
