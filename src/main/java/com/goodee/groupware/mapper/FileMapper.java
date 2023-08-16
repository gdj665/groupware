package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.BoardFile;

@Mapper
public interface FileMapper {
	
	// 게시물 추가
	int addBoardFile(BoardFile boardFile);
	
	// 게시물 삭제
	int deleteBoardFile(BoardFile boardFile);
	
	// 게시물 리스트 출력
	List<BoardFile> getBoardFileList(BoardFile boardFile);
}
