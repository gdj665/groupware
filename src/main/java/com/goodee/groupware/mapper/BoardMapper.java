package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Board;

@Mapper
public interface BoardMapper {
	
	// 1.) 부서별 게시물 리스트 출력
	List<Map<String,Object>> getBoardList(Map<String, Object>map);
	
	// 1.1) 게시판 리스트 행 수량 출력
	int getBoardListCount(Map<String, Object>map);
	
	// 2.) 게시물 상세 출력
	Board getOneBoard(Board board);
	
	// 3.) 게시물 삭제
	int deleteBoard(Board board);
	
	// 4.) 게시물 추가
	int addBoard(Board board);
}
