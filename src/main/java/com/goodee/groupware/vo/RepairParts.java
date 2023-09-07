package com.goodee.groupware.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class RepairParts {
	@NotEmpty
	private int repairPartsNo;
	@NotEmpty
	private int repairNo;
	@NotEmpty
	private int partsNo;
	@NotEmpty
	private int repairPartsCnt;
	private String createdate;
	private String updatedate;
}
