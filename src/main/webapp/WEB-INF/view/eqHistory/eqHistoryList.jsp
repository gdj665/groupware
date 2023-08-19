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
	<h1>장비 사용내역목록</h1>
	<button id="open">장비 추가</button>
	<table border=1>
		<tr>
			<th>대여 번호</th>
			<th>장비명</th>
			<th>장비상태</th>
			<th>대여시작일</th>
			<th>반납예정일</th>
			<th>반납하기</th>
		</tr>
		<c:forEach var="eh" items="${eqHistoryListById}">
			<tr>
				<td>${eh.equipmentHistoryNo}</td>			
				<td>${eh.equipmentName}</td>			
				<td>${eh.equipmentStatus}</td>			
				<td>${eh.equipmentBegindate}</td>			
				<td>${eh.equipmentEnddate}</td>
				<c:if test="${eh.equipmentStatus eq '대여'}">
					<td>
						<a href="${pageContext.request.contextPath}/eqHistory/updateEquipment?equipmentNo=${eh.equipmentNo}&equipmentStatus=비대여" onClick="return confirm('${e.equipmentName} 반납하시겠습니까?')">반납</a>
					</td>			
				</c:if>	
				<c:if test="${eh.equipmentStatus ne '대여'}">
					<td></td>
				</c:if>		
			</tr>
		</c:forEach>
	</table>
</body>
</html>