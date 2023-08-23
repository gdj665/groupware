package com.goodee.groupware.sevice;


import java.io.File;
import java.io.FileOutputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.datetime.standard.DateTimeFormatterRegistrar;
import org.springframework.stereotype.Service;

import com.goodee.groupware.mapper.MemberMapper;
import com.goodee.groupware.vo.Member;
import com.goodee.groupware.vo.Work;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	public Member checkMember(Member member) {
		return memberMapper.checkMember(member);
	}

	public int updatePw(Member member) {
		return memberMapper.updatePw(member);
	}
	
	public int updateOneMember(Member member) {
		return memberMapper.updateOneMember(member);
	}
	
	public int updateSign(String memberId, String sign, String path) {
		String type = ".png";
		String data = sign.split(",")[1];
		byte[] image = Base64.decodeBase64(data);
		String memberSignFile = memberId + type;
		log.debug("memberService updateSign" + memberSignFile);
		int row = 0;
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberSignFile(memberSignFile);
		
		File f = new File(path + memberSignFile);
		
		try {
			FileOutputStream fileOutputStream = new FileOutputStream(f);
			fileOutputStream.write(image);
			fileOutputStream.close();
			row = memberMapper.updateSign(member);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return row;
	}
	
//	개인 근태 출력
	public Map<String, Object> getWorkList(String memberId, Integer targetYear, Integer targetMonth) {

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
		Map<String, Object> workMap = new HashMap<String, Object>();
		workMap.put("targetYear", targetYear);
		workMap.put("targetMonth", targetMonth);
		workMap.put("beginBlank", beginBlank);
		workMap.put("lastDate", lastDate);
		workMap.put("endBlank", endBlank);
		workMap.put("totalTd", totalTd);
		workMap.put("preEndDate", preEndDate);
		workMap.put("memberId", memberId);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1);
		ArrayList<Work> workList = (ArrayList)memberMapper.getWorkList(paramMap);
		workMap.put("workList", workList);
		return workMap;
	}
	
//	출근 입력
	public int addWorkBegin(String memberId) {
//		시간 구하기
		LocalTime time = LocalTime.now();
		int hour = time.getHour();
		int minute = time.getMinute();
		int second = time.getSecond();
		String nowTime = hour + ":" + minute + ":" + second;
		
//		오늘 날짜
		LocalDate day = LocalDate.now();
		int year = day.getYear();
		int month = day.getMonthValue();
		int date = day.getDayOfMonth();
		String today = year + "-" + month + "-" + date;
		Work work = new Work();
		work.setMemberId(memberId);
		work.setWorkBegin(nowTime);
		work.setWorkDate(today);
		if(memberMapper.checkWork(work) != 0) {
			return 0;
		}
		return memberMapper.addWorkBegin(work);
	}

//	퇴근 입력
	public int addWorkEnd(String memberId) {
//		시간 구하기
		LocalTime time = LocalTime.now();
		int hour = time.getHour();
		int minute = time.getMinute();
		int second = time.getSecond();
		String nowTime = hour + ":" + minute + ":" + second;
		
//		오늘 날짜
		LocalDate day = LocalDate.now();
		int year = day.getYear();
		int month = day.getMonthValue();
		int date = day.getDayOfMonth();
		String today = year + "-" + month + "-" + date;
		Work work = new Work();
		work.setMemberId(memberId);
		work.setWorkEnd(nowTime);
		work.setWorkDate(today);
		return memberMapper.addWorkEnd(work);
	}
	
//	연차 입력
	public int addWorkAnnual(Work work) {
		return memberMapper.addWorkAnnual(work);
	}
	
//	개인 근태 출력
	public Map<String, Object> getWorkCheckList(String memberId, Integer targetYear, Integer targetMonth) {
		
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
		
		
		// Map에 담아서 Controller로 넘기기
		Map<String, Object> workMap = new HashMap<String, Object>();
		workMap.put("targetYear", targetYear);
		workMap.put("targetMonth", targetMonth);
		workMap.put("memberId", memberId);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1);
		ArrayList<Work> workList = (ArrayList)memberMapper.getWorkList(paramMap);
		workMap.put("workList", workList);
		return workMap;
	}

}
