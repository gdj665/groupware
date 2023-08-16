package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Equipment {
	private int equipmentNo;
	private String equipmentName;
	private String equipmentLastInspect;
	private int inspectCycle;
	private String equipmentStatus;
	private String equipmentContent;
	private String createdate;
	private String updatedate;
}
