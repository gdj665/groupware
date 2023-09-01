$(document).ready(function(){
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
		
		// 장비 대여 모달창 
	    $(".statusOpenModal").click(function() {
	        var equipmentNo = $(this).data("equipmentno");
	        var equipmentName = $(this).data("equipmentname");
	        var loginId = $(this).data("loginid");
	        $("#equipmentNoInput").val(equipmentNo); // 모달 내의 input 요소에 장비번호 설정
	        $("#equipmentNameInput").val(equipmentName); // 모달 내의 input 요소에 장비이름 설정(보여주기식)
	        $("#loginIdInput").val(loginId); // 대여자 Id값(세션에서 받아옴)
	        $('#equipmentBegindateId').val(preDate); // 대여시작일은 현재 날짜	        
	        $('.modal').fadeIn();
	    });
		
	 	// 장비 대여 추가 버튼
		$('#addEqHistroyBtn').click(function(){
			
			if($('#equipmentReasonId').val().length == 0) {
				$('#equipmentReasonIdMsg').text('대여사유를 작성해주세요');
				return;
			} else {
				$('#equipmentReasonIdMsg').text('');
			}
			
			// alert창 확인
			if(!confirm($('#equipmentReasonId').val()+ '장비를 대여하시겠습니까?')) {
				return false;
			}
			
			$('#addEqHistoryForm').submit();
			$('.modal').fadeOut();
		});
	 	
		// 오류 메시지를 초기화하고 입력란에 포커스를 줄 때 사용되는 함수
		function clearErrorMessage(inputElement, errorMessageElement) {
			// 입력란의 클래스에서 'error' 클래스를 제거하여 스타일을 초기화한다
		    inputElement.removeClass('error');
		    // 오류 메시지 요소의 내용을 빈 문자열로 설정하여 메시지를 지웁니다
		    errorMessageElement.text('');
		}
		// 해당 부분이 focus될시
		$('#equipmentReasonId').focus(function() {
			// clearErrorMessage 함수를 호출하여 해당 입력란과 관련된 오류 메시지를 지웁니다
		    clearErrorMessage($(this), $('#equipmentReasonIdMsg'));
		});
			
		// 모달창 닫기
	    $('.close').click(function(){
			$('.modal').fadeOut();
		});
	});