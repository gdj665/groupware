package com.goodee.groupware.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FileController {
	@Autowired
	private FileMapper fileMapper;

	@GetMapping("/board/boardDownload")
	// boardFileNo 값 받아오기(name을 통해 넘겨진상태)
	public ResponseEntity<Resource> boardDownload (@RequestParam("boardFileNo") int boardFileNo, HttpServletRequest request) {
		
		// 실제 파일이 저장된 경로(saveFileName 앞까지)
		String path = request.getServletContext().getRealPath("/boardFile/");

		try {
			// boardFileNo를 사용하여 실제 파일 정보를 가져옴
			BoardFile boardFile = fileMapper.getOneBoardFile(boardFileNo);

			if (boardFile != null) {
				
				// 파일 경로 생성(저장되어 있는 파일을 폴더 안에 들어가서 경로 확인)
				Path filePath = Paths.get(path + boardFile.getBoardFileSave());
				// 파일의 입력 스트림으로부터 리소스 생성(InputStreamResoure란 파일데이터를 읽을 수 있는 입력스트림을 가지고있는 리소스)
				Resource resource = new InputStreamResource(Files.newInputStream(filePath));
				// 파일 다운로드를 위한 헤더 생성
				HttpHeaders headers = new HttpHeaders();
				log.debug("boardFile.getBoardFileType-->"+boardFile.getBoardFileType());
				
				String boardFileOriName = boardFile.getBoardFileOri();
				// 파일 명을 ISO-8859-1 타입으로 바꾸어서 인코딩 오류 해결 (PDF이름 정상 출력)
				String encodedFileName = new String(boardFileOriName.getBytes("UTF-8"), "ISO-8859-1");
				headers.setContentDisposition(ContentDisposition.builder("attachment").filename(encodedFileName).build());
				// 디버깅
				log.debug("FileDownloadRest-->게시판 파일 다운로드 성공");
				
				// 성공적으로 다운로드되면 F12를 누르고 네트워크탭에서 Status확인을 통해 세부사항 확인가능 (Status 200이면 성공!)
				return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
				
			} else {
				// 파일 정보를 찾을 수 없을 때는 HttpStatus.NOT_FOUND를 반환
				return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
			}
		} catch (Exception e) {
			// 예외처리
			return new ResponseEntity<Resource>(HttpStatus.CONFLICT);
		}
	}
	
	
	// approval File 다운로드------------------------------------------------------------------------------------------------------------
	
	@GetMapping("/approval/approvalDownload")
	// approvalFileNo 값 받아오기(name을 통해 넘겨진상태)
	public ResponseEntity<Resource> approvalDownload (@RequestParam("approvalFileNo") int approvalFileNo, HttpServletRequest request) {
		
		// 실제 파일이 저장된 경로(saveFileName 앞까지)
		String path = request.getServletContext().getRealPath("/approvalFile/");
		
		try {
			// approvalFileNo를 사용하여 실제 파일 정보를 가져옴
			ApprovalFile approvalFile = fileMapper.getOneApprovalFile(approvalFileNo);
			
			if (approvalFile != null) {
				
				// 파일 경로 생성(저장되어 있는 파일을 폴더 안에 들어가서 경로 확인)
				Path filePath = Paths.get(path + approvalFile.getApprovalFileSave());
				// 파일의 입력 스트림으로부터 리소스 생성(InputStreamResoure란 파일데이터를 읽을 수 있는 입력스트림을 가지고있는 리소스)
				Resource resource = new InputStreamResource(Files.newInputStream(filePath));
				
				// 파일 다운로드를 위한 헤더 생성
				HttpHeaders headers = new HttpHeaders();
				// 디버깅
				log.debug("boardFile.getApprovalFileType-->"+approvalFile.getApprovalFileType());
				
				String approvalFileOriName = approvalFile.getApprovalFileOri();
				// 파일 명을 ISO-8859-1 타입으로 바꾸어서 인코딩 오류 해결 (PDF이름 정상 출력)
				String encodedFileName = new String(approvalFileOriName.getBytes("UTF-8"), "ISO-8859-1");
				headers.setContentDisposition(ContentDisposition.builder("attachment").filename(encodedFileName).build());
				log.debug("FileDownloadRest-->게시판 파일 다운로드 성공");
				
				// 성공적으로 다운로드되면 F12를 누르고 네트워크탭에서 Status확인을 통해 세부사항 확인가능 (Status 200이면 성공!)
				return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
				
			} else {
				// 파일 정보를 찾을 수 없을 때는 HttpStatus.NOT_FOUND를 반환
				return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
			}
		} catch (Exception e) {
			// 예외처리
			return new ResponseEntity<Resource>(HttpStatus.CONFLICT);
		}
	}
}
