package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Member {
	int cnt;
	String memberId;
	int departmentNo;
	int departmentParentNo;
	String memberPw;
	String memberName;
	String memberAddress;
	String memberEmail;
	String memberBirth;
	String memberGender;
	String memberPhone;
	String memberSignFile;
	String memberRank;
	String memberLevel;
	String memberHiredate;
	String createdate;
	String updatedate;
}
