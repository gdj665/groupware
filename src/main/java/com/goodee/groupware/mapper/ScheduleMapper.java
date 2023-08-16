package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Schedule;

@Mapper
public interface ScheduleMapper {

	
	List<Schedule> selectScheduleListByMonth(Map<String, Object> paramMap);
	
}
