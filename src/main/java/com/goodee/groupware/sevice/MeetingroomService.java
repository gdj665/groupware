package com.goodee.groupware.sevice;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.MeetingroomMapper;
import com.goodee.groupware.vo.Meetingroom;
import com.goodee.groupware.vo.MeetingroomReserve;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class MeetingroomService {
	@Autowired
	private MeetingroomMapper meetingroomMapper;
	
// ----- 회의실 목록 출력 -----	
	public Map<String, Object> getMeetingroomList(int currentPage, int rowPerPage) {
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		
		// 매개변수 값들을 Map에 담음
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		
		// 회의실 목록 조회
		List<Meetingroom> meetingroomList = new ArrayList<>();
		meetingroomList = meetingroomMapper.getMeetingroomList(paramMap);
		
		// 회의실 목록의 총 행의 개수
		int meetingroomListRow = 0;
		meetingroomListRow = meetingroomMapper.getMeetingroomListRow();
		
		// 마지막 페이지 구하기
		int lastPage = meetingroomListRow / rowPerPage;
		if(meetingroomListRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		// Map에 담아서 controller로 넘기기
		Map<String, Object> meetingroomMap = new HashMap<>(); 
		meetingroomMap.put("meetingroomList", meetingroomList);
		meetingroomMap.put("lastPage", lastPage);
		
		log.debug("\u001B[31m"+"MeetingroomService.getMeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		return meetingroomMap;
	}

// ----- 회의실 추가 -----	
	public int addMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		row = meetingroomMapper.addMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomService.addMeetingroom() row : "+row+"\u001B[0m");
		return row;
	}
	
	
// ----- 회의실 삭제 -----	
	public int deleteMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		row = meetingroomMapper.deleteMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomService.deleteMeetingroom() row : "+row+"\u001B[0m");
		return row;
	}
	
// ----- 회의실 별 예약 조회 -----	
	public Map<String, Object> getMeetingroomReservationList(Integer meetingroomNo, Integer targetYear, Integer targetMonth){
		
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
		Map<String, Object> reservationMap = new HashMap<String, Object>();		
		reservationMap.put("targetYear", targetYear);
		reservationMap.put("targetMonth", targetMonth);
		reservationMap.put("beginBlank", beginBlank);
		reservationMap.put("lastDate", lastDate);
		reservationMap.put("endBlank", endBlank);
		reservationMap.put("totalTd", totalTd);
		reservationMap.put("preEndDate", preEndDate);
		// reservationMap.put("departmentNo,", departmentNo);		
		reservationMap.put("meetingroomNo", meetingroomNo);
		
		// 매개변수 값들을 Map에 담음
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("targetYear", targetYear);
		paramMap.put("targetMonth", targetMonth + 1); // targetMonth에 +1을 해주어야한다
		paramMap.put("meetingroomNo", meetingroomNo);
				
		// 회의실 별 예약 전체 조회
		List<MeetingroomReserve> reserveList = new ArrayList<>();		
		reserveList = meetingroomMapper.getMeetingroomReservationList(paramMap);
		
		// 모든 회의실 조회
		List<Meetingroom> meetingroomList = new ArrayList<>();
		meetingroomList = meetingroomMapper.getAllMeetingroomList();
		
		// Map에 담아서 넘기기
		reservationMap.put("reserveList", reserveList);
		reservationMap.put("meetingroomList", meetingroomList);
		
		log.debug("\u001B[31m"+"MeetingroomService.getMeetingroomReservationList() reservationMap : "+ reservationMap.toString()+"\u001B[0m");
		return reservationMap;
	}
	
// ----- 회의실 예약 등록 -----	
	public int addMeetingroomReservation(MeetingroomReserve meetingroomReserve) {
		int cnt = 0;
		int row = 0;
		
		// 회의실 예약 유무 조회
		cnt = meetingroomMapper.getReservationCount(meetingroomReserve);
		log.debug("\u001B[31m"+"MeetingroomService.addMeetingroomReservation() cnt : "+cnt+"\u001B[0m");
		if(cnt == 0) { // 예약 되어있지 않으면(예약 가능 상태이면)
			row = meetingroomMapper.addMeetingroomReservation(meetingroomReserve);
		}
		log.debug("\u001B[31m"+"MeetingroomService.getReservationCount() row : "+row+"\u001B[0m");
		return row;
	}
	
// ----- 회의실 예약/취소 조회 -----	
	public List<MeetingroomReserve> getReservationHistory(MeetingroomReserve meetingroomReserve){
		// Map에 담아서 Controller로 넘기기
		List<MeetingroomReserve> reservationHistoryList = new ArrayList<>();
		reservationHistoryList = meetingroomMapper.getReservationHistory(meetingroomReserve);
		log.debug("\u001B[31m"+"MeetingroomService.reservationHistoryList() reservationHistoryList : "+ reservationHistoryList.toString()+"\u001B[0m");
		
		return reservationHistoryList;
	}
	
// ----- 회의실 예약 상태 취소로 변경 -----	
	public int updateMeetingroomReservation(MeetingroomReserve meetingroomReserve) {
		int row = 0;
		
		// 회의실 예약 상태 변경
		row = meetingroomMapper.updateMeetingroomReservation(meetingroomReserve);
		log.debug("\u001B[31m"+"MeetingroomService.updateMeetingroomReservation() row : "+row+"\u001B[0m");
		return row;
	}
}
