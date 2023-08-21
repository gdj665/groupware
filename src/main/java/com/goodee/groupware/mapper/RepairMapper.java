package com.goodee.groupware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Repair;

@Mapper
public interface RepairMapper {
	
	// 1) as접수시 repair테이블에 추가
	int addRepair (Repair repair);
}
