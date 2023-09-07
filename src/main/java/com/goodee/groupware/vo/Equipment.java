package com.goodee.groupware.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Equipment {
	@NotEmpty
	private int equipmentNo;
	@NotEmpty
	private String equipmentName;
	@NotEmpty
	private String equipmentLastInspect;
	@NotEmpty
	private int equipmentInspectCycle;
	@NotEmpty
	private String equipmentStatus;
	@NotEmpty
	private String equipmentContent;
	private String createdate;
	private String updatedate;
}
