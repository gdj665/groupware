package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Meetingroom;
import com.goodee.groupware.vo.MeetingroomReserve;

@Mapper
public interface MeetingroomMapper {
	// 회의실 목록 조회(관리자만 조회 가능)
	List<Meetingroom> getMeetingroomList(Map<String,Object> paramMap);
	
	// 회의실 목록의 총 행 개수
	int getMeetingroomListRow();
	
	// 회의실 추가
	int addMeetingroom(Meetingroom meetingroom);
	
	// 삭제할 회의실의 예약중, 예약취소 유무
	int getReservationStatusCount(Meetingroom meetingroom);
	
	// 회의실 삭제
	int deleteMeetingroom(Meetingroom meetingroom);
	
	// 모든 회의실 조회
	List<Meetingroom> getAllMeetingroomList();
// ----------------------------------------------------------------------
	// 회의실 별 예약 전체 조회
	List<MeetingroomReserve> getMeetingroomReservationList(Map<String,Object> paramMap);
	
	// 회의실 예약 유무
	int getReservationCount(MeetingroomReserve meetingroomReserve);
	
	// 회의실 예약 등록
	int addMeetingroomReservation(MeetingroomReserve meetingroomReserve);
	
	// 회의실 예약/취소 조회
	List<MeetingroomReserve> getReservationHistory(MeetingroomReserve meetingroomReserve);
	
	// 회의실 예약 상태 취소로 변경
	int updateMeetingroomReservation(MeetingroomReserve meetingroomReserve);
}
