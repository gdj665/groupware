package com.goodee.groupware.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.MeetingroomService;
import com.goodee.groupware.sevice.ScheduleService;
import com.goodee.groupware.vo.Meetingroom;
import com.goodee.groupware.vo.MeetingroomReserve;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MeetingroomController {
	@Autowired
	MeetingroomService meetingroomService;
	@Autowired
	ScheduleService scheduleService;
	
// ----- 회의실 목록 -----	
	@GetMapping("/meetingroom/meetingroomList")
	public String getMeetingroomList(HttpSession session , Model model, Member member,
									@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(name ="rowPerPage", defaultValue = "3") int rowPerPage) {
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		// 권한 유효성 검사
		if(!memberLevel.equals("4관리자")) { // 관리자가 아니면 홈으로 되돌아간다.
			log.debug("\u001B[31m"+"관리자가 아닙니다"+"\u001B[0m");
			return "redirect:/home";
		}
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> meetingroomMap = new HashMap<>();
		meetingroomMap = meetingroomService.getMeetingroomList(currentPage, rowPerPage);
		log.debug("\u001B[31m"+"MeetingroomController.getmeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("meetingroomMap", meetingroomMap);
		
		// 페이징 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", meetingroomMap.get("lastPage"));
		
		return "/meetingroom/meetingroomList";
	}

// ----- 회의실 추가 ------	
	@GetMapping("/meetingroom/addMeetingroom")
	public String addMeetingroom(HttpSession session) {
		 
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		if(!memberLevel.equals("4관리자")) { // 관리자가 아니면 홈으로 되돌아간다.
			log.debug("\u001B[31m"+"관리자가 아닙니다"+"\u001B[0m");
			return "redirect:/home";
		}
		return "/meetingroom/addMeetingroom";
	}
	
	@PostMapping("/meetingroom/addMeetingroom")
	public String addMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		
		// 회의실 추가
		row = meetingroomService.addMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomController.addMeetingroom() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomList";
	}
	
// ----- 회의실 삭제 -----	
	@GetMapping("/meetingroom/deleteMeetingroom")
	public String deleteMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		row = meetingroomService.deleteMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomController.deleteMeetingroom() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomList";
	}

// ----- 회의실 별 예약 조회 -----
	@GetMapping("/meetingroom/meetingroomReservationList")
	public String getMeetingroomReservationList(HttpSession session, Model model,
															@RequestParam(required = false, name = "targetYear") Integer targetYear,		
															@RequestParam(required = false, name = "targetMonth") Integer targetMonth,
															@RequestParam(required = false, name = "meetingroomNo") Integer meetingroomNo) {
		log.debug("\u001B[31m"+"targetYear : "+ targetYear+"\u001B[0m");
		log.debug("\u001B[31m"+"targetMonth : "+ targetMonth+"\u001B[0m");
		log.debug("\u001B[31m"+"meetingroomNo : "+ meetingroomNo+"\u001B[0m");
		
		// 세션 부서 번호 저장
		int departmentNo = (Integer) session.getAttribute("departmentNo");
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> reservationMap = new HashMap<>();
		reservationMap = meetingroomService.getMeetingroomReservationList(meetingroomNo, targetYear, targetMonth);
		log.debug("\u001B[31m"+"MeetingroomController.getMeetingroomReservationList() ReservationMap : "+ reservationMap.toString()+"\u001B[0m");
		
		// 요청한 매개값을 담아 서비스를 호출
		List<Map<String, String>> getHolidayList = new ArrayList<>();
		getHolidayList = scheduleService.getHolidayList(targetYear, targetMonth);
		
		model.addAttribute("reservationMap", reservationMap);
		model.addAttribute("getHolidayList", getHolidayList);
		model.addAttribute("meetingroomNo", meetingroomNo);
		model.addAttribute("departmentNo", departmentNo);
		
		return "/meetingroom/meetingroomReservationList";
	}
	
// ----- 회의실 예약 등록 -----
	@PostMapping("/meetingroom/addMeetingroomReservation")
	public String addMeetingroomReservation(MeetingroomReserve meetingroomReserve) {
		int row = 0;
		row = meetingroomService.addMeetingroomReservation(meetingroomReserve);
		log.debug("\u001B[31m"+"meetingroomController.addMeetingroomReservation() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomReservationList";
	}
	
// ----- 회의실 예약/취소 조회 -----
	@GetMapping("/meetingroom/meetingroomReservationHistory")
	public String getReservationHistory(HttpSession session, Model model, MeetingroomReserve meetingroomReserve) {
		// 세션 부서 번호 저장
		int departmentNo = (Integer) session.getAttribute("departmentNo");
		meetingroomReserve.setDepartmentNo(departmentNo);
		
		// 요청한 매개값을 담아 서비스를 호출
		List<MeetingroomReserve> reservationHistoryList = new ArrayList<>();
		reservationHistoryList = meetingroomService.getReservationHistory(meetingroomReserve);
		log.debug("\u001B[31m"+"MeetingroomController.getReservationHistory() reservationHistoryList : "+ reservationHistoryList.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("reservationHistoryList", reservationHistoryList);
		model.addAttribute("departmentNo", departmentNo);
		return "/meetingroom/meetingroomReservationHistory";
	}
	
// ----- 회의시 예약 상태 취소로 변경 -----	
	@GetMapping("meetingroom/updateMeetingroomReservation")
	public String updateMeetingroomReservation(MeetingroomReserve meetingroomReserve) {
		int row = 0;
		row = meetingroomService.updateMeetingroomReservation(meetingroomReserve);
		log.debug("\u001B[31m"+"meetingroomController.updateMeetingroomReservation() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomReservationHistory";
	}
}
