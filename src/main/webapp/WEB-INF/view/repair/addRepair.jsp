<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addRepair.css">
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<!-- 장비추가는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
       		<h5 class="card-title fw-semibold mb-4">AS추가</h5>
			<form id="addRepairForm" action="${pageContext.request.contextPath}/group/repair/addRepair" method="post">
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
				<button class="btn btn-primary" id="addRepairBtn" type="button">AS접수</button>
			</form>
			<br>
		</div>
   	</div>
<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/javascript/addRepair.js"></script>
</body>
</html>