$(document).ready(function(){
	// 개인일정 등록 모달창 오픈
	$('#addMeetingroomModalOpen').click(function(){
		$('#addMeetingroomModal').fadeIn();
	});
	// 개인일정 등록 버튼
	$('#addMeetingroomBtn').click(function(){
		// 입력값 유효성 검사
		if($('#addMeetingroomNoId').val().length == 0) {
			$('#addMeetingroomNoIdMsg').text('회의실 번호를 입력해주세요');
			return;
		} else {
			$('#addMeetingroomNoIdMsg').text('');
		}
		
		if($('#addMeetingroomContentId').val().length == 0) {
			$('#addMeetingroomContentIdMsg').text('회의실 상세내용을 입력해주세요');
			return;
		} else {
			$('#addMeetingroomContentIdMsg').text('');
		}
		$('#addMeetingroomForm').submit();
		$('#addMeetingroomModal').fadeOut();
	});
	
	// 모달창 닫기(공통)
    $('.close').click(function(){
		$('#addMeetingroomModal').fadeOut();
	});
});