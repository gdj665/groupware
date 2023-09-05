<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
</head>
<style>
	
</style>
<body>	
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
	        	<div class="card">
					<!-- 장비추가는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
	        		<h5 class="card-title fw-semibold mb-4">장비관리</h5>
	        		<span style="text-align: right;">
						<c:if test="${memberLevel > 1}">
							<button class="btn btn-primary" id="open">장비 추가</button>
						</c:if>
						<button class="btn btn-success" id="excelBtn">엑셀 다운</button>
	        		</span>
					<br>
					<table border=1>
						<tr>
							<th>장비번호</th>
							<th>장비명</th>
							<th>마지막 점검일</th>
							<th>점검예정일</th>
							<th>점검</th>
							<th>대여</th>
							<!-- 비활성화는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
							<c:if test="${memberLevel > 1}">
								<th>비활성화</th>
							</c:if>
						</tr>
						<c:forEach var="e" items="${equipmentList}">
						<tr>
							<td><a href="${pageContext.request.contextPath}/group/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentNo}</a></td>
							<td><a href="${pageContext.request.contextPath}/group/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentName}</a></td>
							<td>${e.equipmentLastInspect}</td>
							<td>
								<!-- dateColor이라는 변수를 선언후 daysUntilNextInspect가 <0보다 작으면 점검예정일이 지났으므로 red를 넣고 <= 30 30일이내면 pink 나머지는 black으로 한다 -->
								<c:set var="dateColor" value="${e.daysUntilNextInspect < 0 ? 'red' : e.daysUntilNextInspect <= 30 ? 'orange' : 'black'}" />
					              	<span style="color: ${dateColor};">${e.nextinspect}</span>
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/group/equipment/updateEqInspect?equipmentNo=${e.equipmentNo}" onClick="return confirm('${e.equipmentName} 점검하시겠습니까?')" class="inspect-link">점검하기</a>
							</td>
							<!-- 대여중인 상품은 대여 불가 대여중아닌 상품만 대여 가능 -->
							<c:if test="${e.equipmentStatus eq '대여'}">
								<td>${e.equipmentStatus}중</td>
							</c:if>
							<c:if test="${e.equipmentStatus ne '대여'}">
								<td>
									<a href="#" class="statusOpenModal" data-equipmentNo="${e.equipmentNo}" data-equipmentName="${e.equipmentName}" 
									data-loginId="${memberId}">${e.equipmentStatus}</a>
								</td>
							</c:if>
							<!-- 비활성화는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
							<c:if test="${e.equipmentStatus eq '비대여' && memberLevel > 1}">
								<td><a href="${pageContext.request.contextPath}/group/equipment/updateEquipment?equipmentNo=${e.equipmentNo}"
									onClick="return confirm('${e.equipmentName} 비활성 하시겠습니까?')">비활성</a>
								</td>
							</c:if>
						</tr>
						</c:forEach>
					</table>
					<br>
					<!-- 페이징 -->
				    <form action="${pageContext.request.contextPath}/group/equipment/equipmentList" method="get">
						<div class="input-group" style="width:25% !important;">
					        <input type="text" class="form-control" style="width:30% !important;" name="equipmentName" placeholder="장비명으로 검색">
					        <button class="btn btn-primary" type="submit">검색</button>
						</div>
				    </form>
				
					<ul class="pagination" style="justify-content: center;">
					    <c:if test="${currentPage > 1}">
					        <li class="page-item">
					            <a href="${pageContext.request.contextPath}/group/equipment/equipmentList?currentPage=${currentPage-1}&equipmentName=${param.equipmentName}" class="page-link">이전</a>
					        </li>
					    </c:if>
					    
					    <c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
					        <li class="page-item">
					            <c:if test="${i ==  currentPage}">
					                <span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
					            </c:if>
					            <c:if test="${i !=  currentPage}">
					                <a href="${pageContext.request.contextPath}/group/equipment/equipmentList?currentPage=${i}&equipmentName=${param.equipmentName}" class="page-link">${i}</a>
					            </c:if>
					        </li>
					    </c:forEach>
					    
					    <c:if test="${currentPage < lastPage}">
					        <li class="page-item">
					            <a href="${pageContext.request.contextPath}/group/equipment/equipmentList?currentPage=${currentPage+1}&equipmentName=${param.equipmentName}" class="page-link">다음</a>
					        </li>
					    </c:if>
					</ul>
	        	</div>
	    	</div>
		</div>
	</div>

	<!-- 장비추가 모달 -->
	<div class="modal">
		<div class="modal_content">
			<h3>장비 추가</h3>
			<form id="addEquipmentForm" action="${pageContext.request.contextPath}/group/equipment/addEquipment" method="post">
				<input type="hidden" name="equipmentStatus" value="비대여" readonly="readonly">
				<table>
					<tr>
						<td>장비명</td>
						<td>
							<input type="text" name="equipmentName" id="equipmeNameId">
							<span id="equipmeNameIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>점검주기</td>
						<td>
							<input type="number" name="equipmentInspectCycle" id="equipmentInspectCycleId">개월
							<span id="equipmentInspectCycleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>설명</td>
						<td>
							<textarea id="equipmentContentId" rows="2" cols="60" name="equipmentContent"></textarea>
							<span id="equipmentContentIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addEquipmentBtn" type="button">추가</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
	<!-- 장비 대여 모달 -->
	<div class="statusModal">
		<div class="modal_content">
			<h3>장비 대여</h3>
			<form id="addEqHistoryForm" action="${pageContext.request.contextPath}/group/eqHistory/addEqHistory" method="post">
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
<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/javascript/equipmentList.js"></script>
</body>
</html>