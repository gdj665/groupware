package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class BoardFile {
	private int boardFileNo;
	private int boardNo;
	private String boardFileOri;
	private String boardFileSave;
	private String boardFileType;
	private int boardFileSize;
	private String createdate;
	private String updatedate;
}
