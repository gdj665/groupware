<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<h2>장비 상세보기</h2>
	<table>
		<tr>
			<td>장비번호</td>
			<td>${equipmentOne.equipmentNo}</td>
		</tr>
		<tr>
			<td>장비명</td>
			<td>${equipmentOne.equipmentName}</td>
		</tr>
		<tr>
			<td>마지막 점검일</td>
			<td>${equipmentOne.equipmentLastInspect}</td>
		</tr>
		<tr>
			<td>대여 상태</td>
			<c:if test="${equipmentOne.equipmentStatus eq '대여'}">
				<td>${equipmentOne.equipmentStatus}</td>
			</c:if>
			
			<c:if test="${equipmentOne.equipmentStatus ne '대여'}">
				<td><a href="#" class="statusOpenModal" data-equipmentNo="${equipmentOne.equipmentNo}" data-equipmentName="${equipmentOne.equipmentName}" data-loginId="${memberId}">${equipmentOne.equipmentStatus}</a></td>
			</c:if>
		</tr>
		<tr>
			<td>점검주기</td>
			<td>${equipmentOne.nextinspect}개월</td>
		</tr>
		<tr>
			<td>설명</td>
			<td>${equipmentOne.equipmentContet}</td>
		</tr>
	</table>
	
	<!-- 장비 대여 모달 -->
	<div class="modal">
		<div class="modal_content">
			<h3>장비 대여</h3>
			<form id="addEqHistoryForm" action="${pageContext.request.contextPath}/eqHistory/addEqHistory" method="post">
				<input type="hidden" name="equipmentNo" id="equipmentNoInput" value="equipmentNoInput">
				<input type="hidden" name="equipmentStatus" value="대여">
				<table>
					<tr>
						<td>장비명</td>
						<td>
							<input type="text" id="equipmentNameInput" value="equipmentNameInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>대여자ID</td>
						<td>
							<input type="text" name="memberId" id="loginIdInput" value="loginIdInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>대여시작일</td>
						<td>
							<input id="equipmentBegindateId" type="date" name="equipmentBegindate" readonly="readonly">
							<span id="equipmentBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>대여 사유</td>
						<td>	
							<textarea id="equipmentReasonId" rows="5" cols="50" name="equipmentReason"></textarea>
							<span id="equipmentReasonIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addEqHistroyBtn" type="button">대여</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	<br>
	
	<table border=1>
		<tr>
			<th>대여 번호</th>
			<th>장비 번호</th>
			<th>대여자</th>
			<th>대여시작일</th>
			<th>반납일</th>
			<th>대여 사유</th>
		</tr>
		<c:forEach var="eh" items="${eqHistoryList}">
			<tr>
				<td>${eh.equipmentHistoryNo}</td>			
				<td>${eh.equipmentName}</td>			
				<td>${eh.memberName}</td>			
				<td>${eh.equipmentBegindate}</td>			
				<td>${eh.equipmentEnddate}</td>			
				<td>${eh.equipmentReason}</td>			
			</tr>
		</c:forEach>
	</table>
	<div>
		<form
			action="${pageContext.request.contextPath}/equipment/equipmentOne" method="get">
			<input type="hidden" name="equipmentNo" value="${equipmentOne.equipmentNo}">
			<input type="text" name="memberName">
			<button type="submit">검색</button>
		</form>
	</div>
<script src="${pageContext.request.contextPath}/javascript/equipmentOne.js"></script>
</body>
</html>