package com.goodee.groupware.sevice;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

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
	
	// 1.) 부서별 게시물 리스트 출력
	public Map<String,Object> getBoardList(int currentPage, int rowPerPage, String searchWord, int departmentNo) {
		
		// 페이징 첫 번째 줄 변수 선언 
		int beginRow = (currentPage-1)*rowPerPage;
		
		// 부서별 게시물 리스트 출력을 위한 변수 Map 생성
		Map<String,Object> boardMap = new HashMap<String,Object>();
		boardMap.put("beginRow",beginRow);
		boardMap.put("rowPerPage",rowPerPage);
		boardMap.put("searchWord",searchWord);
		boardMap.put("departmentNo",departmentNo);
		// 1.) 부서별 게시물 리스트 출력
		List<Map<String,Object>> boardList = boardMapper.getBoardList(boardMap);
		// 디버깅
		log.debug("BoardService.getBoardList().boardMap --->" + boardMap.toString());
		log.debug("BoardService.getBoardList().boardList --->" + boardList.toString());
		
		
		// 부서별 게시물 리스트 행 출력을 위한 변수 Map 생성
		Map<String,Object> boardMapCount = new HashMap<String,Object>();
		boardMapCount.put("searchWord",searchWord);
		boardMapCount.put("departmentNo",departmentNo);
		// 1.1) 게시판 리스트 행 수량 출력
		int boardCount = boardMapper.getBoardListCount(boardMapCount);
		int lastPage = boardCount / rowPerPage; 
		if((boardCount%rowPerPage) != 0) { 
			lastPage++; 
		}
		// 페이지 네비게이션 페이징
		int pagePerPage = 5;
		
		// 마지막 페이지 구하기
		// 최소페이지,최대페이지 구하기
		int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
		int maxPage = minPage + (pagePerPage -1);
		
		// maxPage가 마지막 페이지를 넘어가지 않도록 함
		if(maxPage > lastPage) {
			maxPage = lastPage;
		}
		// 디버깅
		log.debug("BoardService.getBoardList().boardMapCount --->" + boardCount);
		
		// 부서별 게시물 리스트와 마지막 페이지 값 resultMap 선언 후 삽입
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("boardList",boardList);
		resultMap.put("lastPage",lastPage);
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		
		return resultMap;
	}
	
	// 2.) 게시물 상세 출력
	public Map<String,Object> getOneBoard(Board board, BoardFile boardFile) {
		
		// 2.) 게시물 상세 출력
		Map<String,Object> boardOne = boardMapper.getOneBoard(board);
		// 1.) 게시물 첨부파일 리스트 출력
		List<BoardFile> boardFileList = fileMapper.getBoardFileList(boardFile);
		// 디버깅
		log.debug("BoardService.getOneBoard().boardOne --->" + boardOne);
		log.debug("BoardService.getOneBoard().boardFileList --->" + boardFileList);
		
		// 게시물 상세 출력정보와 게시물 번호에 해당하는 첨부파일 리스트 boardOneMap에 담기
		Map<String,Object> boardOneMap = new HashMap<String,Object>();
		boardOneMap.put("boardOne",boardOne);
		boardOneMap.put("boardFileList",boardFileList);
		
		return boardOneMap;
	}
	
	// 3.) 게시물 삭제
	public int deleteBoard(String path, BoardFile boardFile, Board board) {
		List<BoardFile> boardFileList = fileMapper.getBoardFileList(boardFile);
		
		if(boardFileList.size()>0) {
			int deleteFileRow = fileMapper.deleteBoardFile(boardFile);
			if(deleteFileRow>0) {
				for(BoardFile i : boardFileList) {
					File file = new File(path+i.getBoardFileSave());
					file.delete();
				}
			}
		}
		int deleteBoardRow = boardMapper.deleteBoard(board);
		return deleteBoardRow;
	}
	
	// 4.) 게시물 추가
	public int addBoard(Board board, String path) {
		
		// 4.) 게시물 추가
		int row = boardMapper.addBoard(board);
		
		// 게시물 추가되면서 첨부파일 있으면 폴더 저장+ DB에 저장
		// board vo에 선언 해둔 MultipartFile의 사이즈 확인
		List<MultipartFile> boardFileList = board.getMultipartFile();
		if(row==1) {
			
			// Stream Api사용 및 선언
			// 스트림 api 사용하지 않을시에boardFileList가 계속 사이즈가 1로 출력
			List<MultipartFile> validBoardFileList = boardFileList.stream()
					// 파일들 중 사이즈가 0초과거나 null이 아닌것 필터링
	                .filter(file -> file != null && file.getSize() > 0)
	                // 필터링한 파일리스트를 다시 새로운 리스트로 만들어서 validBoardFileList에 선언
	                .collect(Collectors.toList());
					// 디버깅
					log.debug("validBoardFileList-->"+validBoardFileList);
					log.debug("validBoardFileListsize-->"+validBoardFileList.size());
			
			if (!validBoardFileList.isEmpty()) {
				
				// addBoard가 insert된 후의 boardNo를 가져와서 파일 업로드 실행
				int boardNo = board.getBoardNo();
				log.debug("BoardService.addBoard().boardNo-->"+boardNo);
				
				// 첨부파일의 갯수만큼 반복
				for(MultipartFile mf : boardFileList) {
					BoardFile bf = new BoardFile();
					bf.setBoardNo(boardNo);
					bf.setBoardFileOri(mf.getOriginalFilename());
					bf.setBoardFileSize(mf.getSize());
					bf.setBoardFileType(mf.getContentType());
					
					// 파일 타입 추출
					String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
					// UUID 랜덤부여후 미들 바를 공백으로 바꾸고나서 파일 타입추가
					bf.setBoardFileSave(UUID.randomUUID().toString().replace("-","")+ext);
					
					// 3.) 게시물 첨부파일 추가
					fileMapper.addBoardFile(bf);
					
					// 파일 경로 받아와서 파일 추가
					File f = new File(path+bf.getBoardFileSave());
					
					try {
						mf.transferTo(f);
					} catch (IllegalStateException | IOException e) {
						// 어떤 예외가 발생하더라도 런타임 예외를 던진다
						e.printStackTrace();
						throw new RuntimeException();
					}// catch문
				}// for문
			}// if문
		}// if문
		return row;
	}
	
}
