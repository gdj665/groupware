<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>예약 내역</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css">	
</head>
<body>
	<!--  사이드바 -->
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<!--  해더바 -->
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<!-- 내용물 추가하는 곳 -->
		<div class="container-fluid">
       		<div class="card">
           		<div class="card-body">
					<div class="container-wrapper">
						<div class="container">
						<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">부서 예약 정보</div>
						<br>
							<table style="width: 100%;">
								<tr>
									<th class="table_cell">회의실 이름</th>
									<th class="table_cell">회의실 예약 날짜</th>
									<th class="table_cell">회의실 예약 시간</th>
									<th class="table_cell">회의실 예약 상태</th>
								</tr>
								<c:forEach var="h" items="${reservationHistoryList}">
									<tr>
										<th class="table_cell">회의실 ${h.meetingroomNo}호</th>
										<th class="table_cell">${h.meetingroomReserveDate}</th>
										<th class="table_cell">
											<c:if test="${h.meetingroomReserveTime == '1'}">
												<span>10:00 - 12:00</span>
											</c:if>
											<c:if test="${h.meetingroomReserveTime == '2'}">
												<span>13:00 - 15:00</span>
											</c:if>
											<c:if test="${h.meetingroomReserveTime == '3'}">
												<span>15:00 - 17:00</span>
											</c:if>
											<c:if test="${h.meetingroomReserveTime == '4'}">
												<span>17:00 - 19:00</span>
											</c:if>
										</th>
										<th class="table_cell">
											<a href="${pageContext.request.contextPath}/group/meetingroom/updateMeetingroomReservation?meetingroomReserveNo=${h.meetingroomReserveNo}" onClick="return confirm('예약취소 하시겠습니까?')">
												<c:if test="${h.meetingroomReserveStatus == 'Y'}">
													<span>예약중</span>
												</c:if>
											</a>
											<c:if test="${h.meetingroomReserveStatus == 'N'}">
												<span>예약취소</span>
											</c:if>
										</th>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 템플릿 코드 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>