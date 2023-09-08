<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<!-- 자재추가는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
			<h5 class="card-title fw-semibold mb-4">${memberId}님 장비 사용내역</h5>
			<table class="table table-hover">
				<thead class="table-active">
					<tr>
						<th>장비 번호</th>
						<th>장비명</th>
						<th>대여상태</th>
						<th>대여시작일</th>
						<th>반납일</th>
						<th>대여사유</th>
						<th>반납하기</th>
					</tr>
				</thead>
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
				                <a href="${pageContext.request.contextPath}/group/eqHistory/updateEquipment?equipmentNo=${eqH.equipmentNo}&equipmentStatus=비대여&equipmentHistoryNo=${eqH.equipmentHistoryNo}" onClick="return confirm('${eqH.equipmentName} 장비를 반납하시겠습니까?')">반납</a>
				            </td>
				        </c:if>
				        <c:if test="${eqH.equipmentStatus ne '대여' || eqH.equipmentEnddate != null}">
				            <td>반납완료</td>
		        		</c:if>   
					</tr>
				</c:forEach>
			</table>
			<div>
				<br>
				<form action="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList" method="get">
					<div class="input-group" style="width:25% !important;">
						<input type="text" class="form-control"  name="equipmentName" placeholder="장비명으로 검색">
						<button class="btn btn-primary" type="submit">검색</button>
					</div>
				</form>
				
				<ul class="pagination" style="justify-content: center;">
				    <c:if test="${currentPage > 1}">
				        <li class="page-item">
				            <a href="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList?currentPage=${currentPage-1}&partsName=${param.partsName}" class="page-link">이전</a>
				        </li>
				    </c:if>
				    
				    <c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
				        <li class="page-item">
				            <c:if test="${i ==  currentPage}">
				                <span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
				            </c:if>
				            <c:if test="${i !=  currentPage}">
				                <a href="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList?currentPage=${i}&partsName=${param.partsName}" class="page-link">${i}</a>
				            </c:if>
				        </li>
				    </c:forEach>
				    
				    <c:if test="${currentPage < lastPage}">
				        <li class="page-item">
				            <a href="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList?currentPage=${currentPage+1}&partsName=${param.partsName}" class="page-link">다음</a>
				        </li>
				    </c:if>
				</ul>
			</div>
       	</div>
   	</div>
<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>