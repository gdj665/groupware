package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Schedule;

@Mapper
public interface ScheduleMapper {

	// 월 별 일정
	List<Schedule> getScheduleList(Map<String, Object> paramMap);
	
	// 월 별 부서일정
	List<Schedule> getDepartmentScheduleList(Map<String, Object> paramMap);
	
	// 일 별 일정 상세보기
	List<Map<String, Object>> getOneSchedule(Map<String, Object> paramMap);
	
	// 일정 추가
	int addSchedule(Schedule schedule);
	
	// 부서장 유무 확인
	int getMemberLevelCount(Schedule schedule);
	
	// 일정 삭제
	int deleteSchedule(Schedule schedule);
	
	// 일정 수정
	int updateSchdule(Schedule schedule);
	
	// 오늘의 개인일정과 부서일정
	List<Schedule> getTodaySchduleList(Map<String, Object> paramMap);
}
