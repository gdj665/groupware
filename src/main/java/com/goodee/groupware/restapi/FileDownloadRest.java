package com.goodee.groupware.restapi;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FileDownloadRest {
    
    @GetMapping("/board/boardDownload")
    public ResponseEntity<Object> download(HttpServletRequest request) {
    	String path = request.getServletContext().getRealPath("/boardFile/");
        
        try {
            Path filePath = Paths.get(path); // 파일 경로로부터 Path 객체 생성
            Resource resource = new InputStreamResource(Files.newInputStream(filePath)); // 파일의 입력 스트림으로부터 Resource 생성
            
            File file = new File(path); // 경로로부터 File 객체 생성
            
            HttpHeaders headers = new HttpHeaders();
            // Content-Disposition 헤더 설정으로 응답을 다운로드 가능한 첨부 파일로 처리하도록 함
            headers.setContentDisposition(ContentDisposition.builder("attachment").filename(file.getName()).build());
            
            // Resource, 헤더, HttpStatus.OK를 가진 ResponseEntity 반환
            return new ResponseEntity<Object>(resource, headers, HttpStatus.OK);
        } catch(Exception e) {
            // 예외 발생 시 HttpStatus.CONFLICT와 함께 빈 body를 가진 ResponseEntity 반환
            return new ResponseEntity<Object>(null, HttpStatus.CONFLICT);
        }
    }
}
