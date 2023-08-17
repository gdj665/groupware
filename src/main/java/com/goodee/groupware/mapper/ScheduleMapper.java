package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Schedule;

@Mapper
public interface ScheduleMapper {

	// 월 별 일정
	List<Schedule> getScheduleList(Map<String, Object> paramMap);
	
	// 일 별 일정 상세보기
	List<Map<String, Object>> getOneSchedule(Map<String, Object> paramMap);
}
