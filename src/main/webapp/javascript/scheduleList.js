	$(document).ready(function(){
	// 개인일정 등록 모달창 오픈
	$('#addPersonalScheduleModalOpen').click(function(){
		$('#addPersonalScheduleModal').fadeIn();
	});
	// 개인일정 등록 버튼
	$('#addPersonalScheduleBtn').click(function(){
		// 입력값 유효성 검사
		if($('#addPersonalScheduleTitleId').val().length == 0) {
			$('#addPersonalScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
			return;
		} else {
			$('#addPersonalScheduleTitleIdMsg').text('');
		}
		
		if($('#addPersonalScheduleContentId').val().length == 0) {
			$('#addPersonalScheduleContentIdMsg').text('일정 내용을 입력해주세요');
			return;
		} else {
			$('#addPersonalScheduleContentIdMsg').text('');
		}
		
		if($('#addPersonalScheduleBegindateId').val().length == 0) {
			$('#addPersonalScheduleBegindateIdMsg').text('시작일을 선택해주세요');
			return;
		} else {
			$('#addPersonalScheduleBegindateIdMsg').text('');
		}
		
		if($('#addPersonalScheduleEnddateId').val().length == 0) {
			$('#addPersonalScheduleEnddateIdMsg').text('종료일을 선택해주세요');
			return;
		} else {
			$('#addPersonalScheduleEnddateIdMsg').text('');
		}
		$('#addPersonalScheduleForm').submit();
		$('#addPersonalScheduleModal').fadeOut();
	});
// --------------------------------------------------------------------------------		
	// 부서일정 등록 모달창 오픈
	$('#addDepartmentScheduleModalOpen').click(function(){
		$('#addDepartmentScheduleModal').fadeIn();
	});
	// 부서일정 등록 버튼
	$('#addDepartmentScheduleBtn').click(function(){
		// 입력값 유효성 검사
		if($('#addDepartmentScheduleTitleId').val().length == 0) {
			$('#addDepartmentScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
			return;
		} else {
			$('#addDepartmentScheduleTitleIdMsg').text('');
		}
		
		if($('#addDepartmentScheduleContentId').val().length == 0) {
			$('#addDepartmentScheduleContentIdMsg').text('일정 내용을 입력해주세요');
			return;
		} else {
			$('#addDepartmentScheduleContentIdMsg').text('');
		}
		
		if($('#addDepartmentScheduleBegindateId').val().length == 0) {
			$('#addDepartmentScheduleBegindateIdMsg').text('시작일을 선택해주세요');
			return;
		} else {
			$('#addDepartmentScheduleBegindateIdMsg').text('');
		}
		
		if($('#addDepartmentScheduleEnddateId').val().length == 0) {
			$('#addDepartmentScheduleEnddateIdMsg').text('종료일을 선택해주세요');
			return;
		} else {
			$('#addDepartmentScheduleEnddateIdMsg').text('');
		}
		$('#addDepartmentScheduleForm').submit();
		$('#addDepartmentScheduleModal').fadeOut();
	});
// --------------------------------------------------------------------------------
	// 개인일정 수정 모달창 오픈
	$('.updatePersonalScheduleModalOpen').click(function(){
		var updatePersonalScheduleNo = $(this).data("updatepersonalscheduleno");
		$("#updatePersonalScheduleNoInput").val(updatePersonalScheduleNo);
		$('#updatePersonalScheduleModal').fadeIn();
	});
	// 개인일정 수정 버튼
	$('#updatePersonalScheduleBtn').click(function(){
		// 입력값 유효성 검사
		if($('#updatePersonalScheduleTitleId').val().length == 0) {
			$('#updatePersonalScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
			return;
		} else {
			$('#updatePersonalScheduleTitleIdMsg').text('');
		}
		
		if($('#updatePersonalScheduleContentId').val().length == 0) {
			$('#updatePersonalScheduleContentIdMsg').text('일정 내용을 입력해주세요');
			return;
		} else {
			$('#updatePersonalScheduleContentIdMsg').text('');
		}
		
		if($('#updatePersonalScheduleBegindateId').val().length == 0) {
			$('#updatePersonalScheduleBegindateIdMsg').text('시작일을 선택해주세요');
			return;
		} else {
			$('#updatePersonalScheduleBegindateIdMsg').text('');
		}
		
		if($('#updatePersonalScheduleEnddateId').val().length == 0) {
			$('#updatePersonalScheduleEnddateIdMsg').text('종료일을 선택해주세요');
			return;
		} else {
			$('#updatePersonalScheduleEnddateIdMsg').text('');
		}
		$('#updatePersonalScheduleForm').submit();
		$('#updatePersonalScheduleModal').fadeOut();
	});
// --------------------------------------------------------------------------------
	// 개인일정 수정 모달창 오픈
	$('.updateDepartmentScheduleModalOpen').click(function(){
		var updateDepartmentScheduleNo = $(this).data("updatedepartmentscheduleno");
		$("#updateDepartmentScheduleNoInput").val(updateDepartmentScheduleNo);
		$('#updateDepartmentScheduleModal').fadeIn();
	});
	// 개인일정 수정 버튼
	$('#updateDepartmentScheduleBtn').click(function(){
		// 입력값 유효성 검사
		if($('#updateDepartmentScheduleTitleId').val().length == 0) {
			$('#updateDepartmentScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
			return;
		} else {
			$('#updateDepartmentScheduleTitleIdMsg').text('');
		}
		
		if($('#updateDepartmentScheduleContentId').val().length == 0) {
			$('#updateDepartmentScheduleContentIdMsg').text('일정 내용을 입력해주세요');
			return;
		} else {
			$('#updateDepartmentScheduleContentIdMsg').text('');
		}
		
		if($('#updateDepartmentScheduleBegindateId').val().length == 0) {
			$('#updateDepartmentScheduleBegindateIdMsg').text('시작일을 선택해주세요');
			return;
		} else {
			$('#updateDepartmentScheduleBegindateIdMsg').text('');
		}
		
		if($('#updateDepartmentScheduleEnddateId').val().length == 0) {
			$('#updateDepartmentScheduleEnddateIdMsg').text('종료일을 선택해주세요');
			return;
		} else {
			$('#updateDepartmentScheduleEnddateIdMsg').text('');
		}
		$('#updateDepartmentScheduleForm').submit();
		$('#updateDepartmentScheduleModal').fadeOut();
	});
// --------------------------------------------------------------------------------
	// 모달창 닫기(공통)
    $('.close').click(function(){
		$('#addPersonalScheduleModal').fadeOut();
		$('#addDepartmentScheduleModal').fadeOut();
		$('#updatePersonalScheduleModal').fadeOut();
		$('#updateDepartmentScheduleModal').fadeOut();
	});
});