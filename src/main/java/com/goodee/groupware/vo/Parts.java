package com.goodee.groupware.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Parts {
	@NotEmpty
	private int partsNo;
	@NotEmpty
	private int partsCategoryNo;
	@NotEmpty
	private String partsName;
	@NotEmpty
	private int partsCnt;
	@NotEmpty
	private int partsPrice;
	@NotEmpty
	private String partsContent;
	private String createdate;
	private String updatedate;
}
