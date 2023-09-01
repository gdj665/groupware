$(document).ready(function(){
		
		// 미 입력시 text출력된 곳 focus할시 text지우기
		function clearErrorMessage(inputElement, errorMessageElement) {
		    inputElement.removeClass('error');
		    errorMessageElement.text('');
		}
		$('#repairProductCategoryId').focus(function() {
		    clearErrorMessage($(this), $('#repairProductCategoryIdMsg'));
		});

		$('#repairProductNameId').focus(function() {
		    clearErrorMessage($(this), $('#repairProductNameIdMsg'));
		});

		$('#receivingDateId').focus(function() {
		    clearErrorMessage($(this), $('#receivingDateIdMsg'));
		});

		$('#repairReceivingReasonId').focus(function() {
		    clearErrorMessage($(this), $('#repairReceivingReasonIdMsg'));
		});
		
		
		// button클릭시 유효성검사
		$('#addRepairBtn').click(function(){
			
			if($('#repairProductCategoryId').val() == '=선택하기=') {
				$('#repairProductCategoryIdMsg').text('제품분류를 선택해주세요');
				return;
			} else {
				
				$('#repairProductCategoryIdMsg').text('');
			}
			
			if($('#repairProductNameId').val().length == 0) {
				$('#repairProductNameIdMsg').text('제품명을 작성해주세요');
				return;
			} else {
				$('#repairProductNameIdMsg').text('');
			}
			
			if($('#receivingDateId').val().length == 0) {
				$('#receivingDateIdMsg').text('입고일을 선택해주세요');
				return;
			} else {
				$('#receivingDateIdMsg').text('');
			}
			
			if($('#repairReceivingReasonId').val().length == 0) {
				$('#repairReceivingReasonIdMsg').text('입고사유를 작성해주세요');
				return;
			} else {
				$('#repairReceivingReasonIdMsg').text('');
			}
			
			// 예 아니오 확인
			if(!confirm($('#repairProductNameId').val()+'제품을 AS 접수하시겠습니까?')) {
				return false;
			}
			
			$('#addRepairForm').submit();
			
		});
		
	});