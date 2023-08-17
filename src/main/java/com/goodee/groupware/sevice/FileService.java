package com.goodee.groupware.sevice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class FileService {
	@Autowired
	private FileMapper fileMapper;
	
	public BoardFile getOneBoardFile(int boardFileNo) {
		return fileMapper.getOneBoardFile(boardFileNo);
	}
}
