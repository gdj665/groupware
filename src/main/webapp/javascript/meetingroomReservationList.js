	$(document).ready(function () {
		// 예약 등록 모달창 오픈
		$('#addMeetingroomReservationModalOpen').click(function(){
			$('#addMeetingroomReservationModal').fadeIn();
		});
		// 예약 등록 버튼
		$('#addMeetingroomReservationBtn').click(function(){
			// 입력값 유효성 검사
			if($('#addMeetingroomNoId').val().length == 0) {
				$('#addMeetingroomNoIdMsg').text('예약할 회의실을 선택해주세요');
				return;
			} else {
				$('#addMeetingroomNoIdMsg').text('');
			}
			
			if($('#addMeetingroomReserveDateId').val().length == 0) {
				$('#addMeetingroomReserveDateIdMsg').text('예약할 날짜를 선택해주세요');
				return;
			} else {
				$('#addMeetingroomReserveDateIdMsg').text('');
			}
			
			if($('#addMeetingroomReserveTimeId').val().length == 0) {
				$('#addMeetingroomReserveTimeIdMsg').text('예약 시간을 선택해주세요');
				return;
			} else {
				$('#addMeetingroomReserveTimeIdMsg').text('');
			}
			
			$('#addMeetingroomReservationForm').submit();
			$('#addMeetingroomReservationModal').fadeOut();
		});

// --------------------------------------------------------------------------------
	// 모달창 닫기(공통)
	$('.close').click(function(){
		$('#addMeetingroomReservationModal').fadeOut();
	});
});