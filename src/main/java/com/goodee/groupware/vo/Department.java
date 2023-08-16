package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Department {
	private int departmentNo;
	private String departmentId;
	private int departmentParentNo;
	private String createdate;
	private String updatedate;
}
