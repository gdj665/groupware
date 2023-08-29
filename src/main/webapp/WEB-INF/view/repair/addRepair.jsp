<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	/* 메시지 스타일 */
    .msg {
    	font-weight: bold;
        color: red;
        font-size: 14px;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
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
</script>
</head>
<body>
	<h1>AS추가</h1>
	<form id="addRepairForm" action="${pageContext.request.contextPath}/repair/addRepair" method="post">
		<input type="hidden" value="대기중" readonly="readonly" required="required">
		<table>
			<tr>
				<td>제품분류</td>
				<td>
					<select id="repairProductCategoryId" name="repairProductCategory" required="required">
						<option>=선택하기=</option>
						<option value="노트북">노트북</option>
						<option value="데스크탑">데스크탑</option>
						<option value="스마트폰">스마트폰</option>
					</select>
					<span id="repairProductCategoryIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>
					<input id="repairProductNameId" type="text" name="repairProductName" required="required">
					<span id="repairProductNameIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>입고날짜</td>
				<td>
					<input id="receivingDateId" type="date" name="receivingDate" required="required">
					<span id="receivingDateIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>입고사유</td>
				<td>
					<textarea id="repairReceivingReasonId" rows="5" cols="30" name="repairReceivingReason" required="required"></textarea>
					<span id="repairReceivingReasonIdMsg" class="msg"></span>
				</td>
			</tr>
		</table>
		<button id="addRepairBtn" type="button">AS접수</button>
	</form>
</body>
</html>