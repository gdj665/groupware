package com.goodee.groupware.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Department {
	private int departmentNo;
	@NotEmpty
	private String departmentId;
	private int departmentParentNo;
	private String createdate;
	private String updatedate;
}
