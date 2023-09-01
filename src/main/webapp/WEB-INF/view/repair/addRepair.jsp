<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	
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
	
<script src="${pageContext.request.contextPath}/javascript/addRepair.js"></script>
</body>
</html>