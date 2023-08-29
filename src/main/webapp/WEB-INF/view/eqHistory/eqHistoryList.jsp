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
	<h1>${memberId}님 장비 사용내역</h1>
	<table border=1>
		<tr>
			<th>장비 번호</th>
			<th>장비명</th>
			<th>대여상태</th>
			<th>대여시작일</th>
			<th>반납일</th>
			<th>대여사유</th>
			<th>반납하기</th>
		</tr>
		<c:forEach var="eqH" items="${eqHistoryListById}">
			<tr>
				<td>${eqH.equipmentHistoryNo}</td>			
				<td>${eqH.equipmentName}</td>			
				<td>${eqH.equipmentStatus}중</td>			
				<td>${eqH.equipmentBegindate}</td>			
				<td>${eqH.equipmentEnddate}</td>
        		<td>${eqH.equipmentReason}</td>
        		<c:if test="${eqH.equipmentStatus eq '대여' && eqH.equipmentEnddate == null}">
		            <td>
		                <a href="${pageContext.request.contextPath}/eqHistory/updateEquipment?equipmentNo=${eqH.equipmentNo}&equipmentStatus=비대여&equipmentHistoryNo=${eqH.equipmentHistoryNo}" onClick="return confirm('${eqH.equipmentName} 장비를 반납하시겠습니까?')">반납</a>
		            </td>
		        </c:if>
		        
		        <c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
					<c:if test="${i ==  currentPage}">
						<span style="color: red;">${i}</span>
					</c:if>
					<c:if test="${i !=  currentPage}">
						<span>${i}</span>
					</c:if>
				</c:forEach>
		        
		        <c:if test="${eqH.equipmentStatus ne '대여' || eqH.equipmentEnddate != null}">
		            <td>반납완료</td>
        		</c:if>   
			</tr>
		</c:forEach>
	</table>
	<div>
		<form action="${pageContext.request.contextPath}/eqHistory/eqHistoryList" method="get">
			<input type="text" name="equipmentName">
			<button type="submit">검색</button>
		</form>
	</div>
</body>
</html>