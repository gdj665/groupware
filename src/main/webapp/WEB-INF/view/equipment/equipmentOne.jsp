<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			<td>점검주기</td>
			<td>${equipmentOne.nextinspect}개월</td>
		</tr>
		<tr>
			<td>설명</td>
			<td>${equipmentOne.equipmentContet}</td>
		</tr>
	</table>
	<br>
	
	<table border=1>
		<tr>
			<th>대여 번호</th>
			<th>장비 번호</th>
			<th>아이디(대여자)</th>
			<th>대여시작일</th>
			<th>반납일</th>
		</tr>
		<c:forEach var="eh" items="${eqHistoryList}">
			<tr>
				<td>${eh.equipmentHistoryNo}</td>			
				<td>${eh.equipmentName}</td>			
				<td>${eh.memberId}</td>			
				<td>${eh.equipmentBegindate}</td>			
				<td>${eh.equipmentEnddate}</td>			
			</tr>
		</c:forEach>
	</table>
	<div>
		<form
			action="${pageContext.request.contextPath}/equipment/equipmentOne" method="get">
			<input type="hidden" name="equipmentNo" value="${equipmentOne.equipmentNo}">
			<input type="text" name="memberId">
			<button type="submit">검색</button>
		</form>
	</div>
</body>
</html>