package com.goodee.groupware.sevice;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.groupware.mapper.BoardMapper;
import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private FileMapper fileMapper;
	
	// 게시판 리스트 출력
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
	
	// 게시물 상세보기 출력
	public Map<String,Object> getOneBoard(Board board, BoardFile boardFile) {
		Board boardOne = boardMapper.getOneBoard(board);
		List<BoardFile> boardFileList = fileMapper.getBoardFileList(boardFile);
		
		Map<String,Object> boardOneMap = new HashMap<String,Object>();
		boardOneMap.put("boardOne",boardOne);
		boardOneMap.put("boardFileList",boardFileList);
		return boardOneMap;
	}
	// 파일리스트 출력
	/*
	 * public List<BoardFile> getBoardFileList() {
	 * 
	 * return boardFileList; }
	 */
	
	// 게시물 추가
	// 게시물 추가되면서 첨부파일 있으면 폴더 저장+ DB에 저장
	public int addBoard(Board board, String path) {
		int row = boardMapper.addBoard(board);
		
		// 첨부파일 있는지 확인
		// board vo에 선언 해둔 MultipartFile의 사이즈 확인
		List<MultipartFile> boardFileList = board.getMultipartFile();
		if(row==1 && boardFileList != null && boardFileList.size()>0) {
			int boardNo = board.getBoardNo();
			
			// 첨부파일의 갯수만큼 반복
			for(MultipartFile mf : boardFileList) {
				BoardFile bf = new BoardFile();
				bf.setBoardNo(boardNo);
				bf.setBoardFileOri(mf.getOriginalFilename());
				bf.setBoardFileSize(mf.getSize());
				bf.setBoardFileType(mf.getContentType());
				
				String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
				// UUID 랜덤부여후 미들 바를 공백으로 바꾸고나서 파일 타입추가
				bf.setBoardFileSave(UUID.randomUUID().toString().replace("-","")+ext);
				
				fileMapper.addBoardFile(bf);
				
				File f = new File(path+bf.getBoardFileSave());
				
				try {
					mf.transferTo(f);
				} catch (IllegalStateException | IOException e) {
					// 어떤 예외가 발생하더라도 런타임 예외를 던진다
					e.printStackTrace();
					throw new RuntimeException();
				}
			}
		}
		return row;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
