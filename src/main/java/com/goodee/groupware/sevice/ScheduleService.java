package com.goodee.groupware.sevice;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.ScheduleMapper;
import com.goodee.groupware.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ScheduleService {
	@Autowired
	private ScheduleMapper scheduleMapper;
	
// ----- 달력 출력 + 월 별 일정 정보 조회 -----
	public Map<String, Object> getScheduleList(int departmentNo, String memberId, Integer targetYear, Integer targetMonth, String scheduleCategory){
		
		// 달력 API 가져오기
		Calendar firstDate = Calendar.getInstance();
		
		// 오늘 날짜를 1일로 셋팅
		firstDate.set(Calendar.DATE, 1); 
		
		if(targetYear != null && targetMonth != null) { // 매개값으로 날짜가 넘어오면
			firstDate.set(Calendar.YEAR, targetYear);
			firstDate.set(Calendar.MONTH, targetMonth);
			// API에서 Month 값으로 12가 들어오면 내년으로 바뀌고, -1이 들어오면 작년으로 바뀜
		}
		// 다시 세팅된 값이 존재 할 수 있으므로 값을 다시 저장
		targetYear = firstDate.get(Calendar.YEAR);
		targetMonth = firstDate.get(Calendar.MONTH);
		
		// 요청된 날짜의 1일의 요일을 이용하여 달력에 출력되는 시작 공백 수를 구함
		int beginBlank = firstDate.get(Calendar.DAY_OF_WEEK)-1;
		
		// 요청된 날짜의 월의 마지막 일 구하기
		int lastDate = firstDate.getActualMaximum(Calendar.DATE);
		
		// 마지막 일 이후 달력에 출력되는 공백 수를 구함
		int endBlank = 0;
		if((beginBlank + lastDate)%7 != 0) { // 출력 될 총 칸 수가 7로 나누어 떨어지지 않으면
			endBlank = 7 - ((beginBlank + lastDate)%7);
			// 부족한 칸 수만큼 공백 수를 더해주면 7로 나누어 떨어짐
		}
		int totalTd = beginBlank + lastDate + endBlank; // 출력 될 총 칸 수 
		
		// 전월 마지막 일 구하기
		Calendar preDate = Calendar.getInstance();
		preDate.set(Calendar.YEAR, targetYear);
		preDate.set(Calendar.MONTH, targetMonth - 1);
		int preEndDate = preDate.getActualMaximum(Calendar.DATE);
		
		// Map에 담아서 Controller로 넘기기
		Map<String, Object> scheduleMap = new HashMap<String, Object>();
		scheduleMap.put("targetYear", targetYear);
		scheduleMap.put("targetMonth", targetMonth);
		scheduleMap.put("beginBlank", beginBlank);
		scheduleMap.put("lastDate", lastDate);
		scheduleMap.put("endBlank", endBlank);
		scheduleMap.put("totalTd", totalTd);
		scheduleMap.put("preEndDate", preEndDate);
		scheduleMap.put("memberId", memberId);
		scheduleMap.put("scheduleCategory", scheduleCategory);
		scheduleMap.put("departmentNo,", departmentNo);
		
		// 매개변수 값들을 Map에 담음
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1); // targetMonth에 +1을 해주어야한다
		paramMap.put("memberId", memberId);
		paramMap.put("scheduleCategory", scheduleCategory);
		paramMap.put("departmentNo", departmentNo);
		
		// 월 별 일정 정보 조회 
		List<Schedule> scheduleList = new ArrayList<>();
		scheduleList = scheduleMapper.getScheduleList(paramMap);	
		// Map에 담아서 넘기기
		scheduleMap.put("scheduleList", scheduleList);
		log.debug("\u001B[31m"+"ScheduleService.getScheduleList() scheduleMap : "+ scheduleMap.toString()+"\u001B[0m");

		return scheduleMap;
	}
	
// ----- 일 별 전체 일정 상세보기 조회 -----
	public Map<String, Object> getOneSchedule(int departmentNo, String memberId, Integer targetYear, Integer targetMonth, Integer targetDate, String scheduleCategory){
	
		// Map에 담아서 Conntroller로 넘기기
		Map<String, Object> oneScheduleMap = new HashMap<String, Object>();
		oneScheduleMap.put("targetYear", targetYear);
		oneScheduleMap.put("targetMonth", targetMonth);
		oneScheduleMap.put("targetDate", targetDate);
		oneScheduleMap.put("memberId", memberId);
		oneScheduleMap.put("scheduleCategory", scheduleCategory);
		oneScheduleMap.put("departmentNo", departmentNo);
		
		// 매개변수 값들을 Map에 담음
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1);
		paramMap.put("targetDate", targetDate);
		paramMap.put("memberId", memberId);
		paramMap.put("scheduleCategory", scheduleCategory);
		paramMap.put("departmentNo", departmentNo);
		
		// 일 별 전체 일정 상세보기
		List<Map<String, Object>> oneScheduleList = new ArrayList<>();
		oneScheduleList = scheduleMapper.getOneSchedule(paramMap);
		oneScheduleMap.put("oneScheduleList", oneScheduleList);
		
		log.debug("\u001B[31m"+"ScheduleService.getOneSchedule() oneScheduleMap : "+ oneScheduleMap.toString()+"\u001B[0m");
		
		return oneScheduleMap;
	}
	
// ----- 개인 일정 추가 -----
	public int addPersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleMapper.addSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleService.addPersonalSchedule() row : "+row+"\u001B[0m");
		return row;
	}
	
// ----- 부서 일정 추가(부서장만 추가 가능) -----
	public int addDepartmentSchedule(Schedule schedule){
		int cnt = 0;
		int row = 0;
		
		// 부서장 유무 조회
		cnt = scheduleMapper.getMemberLevelCount(schedule);
		log.debug("\u001B[31m"+"ScheduleService.addDepartmentSchedule() cnt : "+cnt+"\u001B[0m");
		if(cnt > 0) { // 부서장이 맞으면
			row = scheduleMapper.addSchedule(schedule); // 일정 추가
		} 
		log.debug("\u001B[31m"+"ScheduleService.addDepartmentSchedule() row : "+row+"\u001B[0m");
		return row; 
	}

//  ----- 개인 일정 삭제 -----
	public int deletePersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleMapper.deleteSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleService.deletePersonalSchedule() row : "+row+"\u001B[0m");
		return row;
	}
	
// ----- 부서 일정 삭제 -----
	public int deleteDepartmentSchedule(Schedule schedule) {
		int cnt = 0;
		int row = 0;
		
		// 부서장 유무 조회
		cnt = scheduleMapper.getMemberLevelCount(schedule);
		log.debug("\u001B[31m"+"ScheduleService.deleteDepartmentSchedule() cnt : "+cnt+"\u001B[0m");
		if(cnt > 0) { // 부서장이 맞으면
			row = scheduleMapper.deleteSchedule(schedule);
		}
		log.debug("\u001B[31m"+"ScheduleService.deleteDepartmentSchedule() row : "+row+"\u001B[0m");
		return row;
	}
	
// ----- 개인 일정 수정 -----
	public int updatePersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleMapper.updateSchdule(schedule);
		log.debug("\u001B[31m"+"ScheduleService.updatePersonalSchedule() row : "+row+"\u001B[0m");
		return row;
	}
	
	
// ----- 부서 일정 수정 -----
	public int updateDepartmentSchedule(Schedule schedule) {
		int row = 0;
		int cnt = 0;
		
		// 부서장 유무 조회
		cnt = scheduleMapper.getMemberLevelCount(schedule);
		log.debug("\u001B[31m"+"ScheduleService.updateDepartmentSchedule() cnt : "+cnt+"\u001B[0m");
		if(cnt > 0) { // 부서장이 맞으면
			row = scheduleMapper.updateSchdule(schedule);
		}
		log.debug("\u001B[31m"+"ScheduleService.updateDepartmentSchedule() row : "+row+"\u001B[0m");
		return row;
	}
}
