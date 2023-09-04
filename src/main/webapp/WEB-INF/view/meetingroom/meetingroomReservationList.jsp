<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회의실 예약</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css">

<script>
	$(document).ready(function () {
		// 예약 등록 모달창 오픈
		$('#addMeetingroomReservationModalOpen').click(function(){
			$('#addMeetingroomReservationModal').fadeIn();
		});
		// 예약 등록 버튼
		$('#addMeetingroomReservationBtn').click(function(){
			// 입력값 유효성 검사
			if($('#addMeetingroomNoId').val().length == 0) {
				$('#addMeetingroomNoIdMsg').text('예약할 회의실을 선택해주세요');
				return;
			} else {
				$('#addMeetingroomNoIdMsg').text('');
			}
			
			if($('#addMeetingroomReserveDateId').val().length == 0) {
				$('#addMeetingroomReserveDateIdMsg').text('예약할 날짜를 선택해주세요');
				return;
			} else {
				$('#addMeetingroomReserveDateIdMsg').text('');
			}
			
			if($('#addMeetingroomReserveTimeId').val().length == 0) {
				$('#addMeetingroomReserveTimeIdMsg').text('예약 시간을 선택해주세요');
				return;
			} else {
				$('#addMeetingroomReserveTimeIdMsg').text('');
			}
			
			$('#addMeetingroomReservationForm').submit();
			$('#addMeetingroomReservationModal').fadeOut();
		});

// --------------------------------------------------------------------------------
	// 모달창 닫기(공통)
	$('.close').click(function(){
		$('#addMeetingroomReservationModal').fadeOut();
	});
});
	
</script>
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
							<!-- model값 받아와서 문자로 셋팅 -->
							<c:set var="m" value="${reservationMap}"></c:set>
							<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">회의실 예약 현황</div>
							<div style="text-align: right;">
								<button class="btn text-white" style="background-color:orange;" id="addMeetingroomReservationModalOpen">예약 등록</button>
							</div>
							<!-- 회의실 전체 목록 가져오기 -->
							<a class="btn btn-primary" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}">전체</a>
							<c:forEach var="s" items="${m.meetingroomList}">
								<a class="btn btn-primary" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&meetingroomNo=${s.meetingroomNo}">${s.meetingroomNo}호</a>
							</c:forEach>
							<br><br>
							<div style="text-align: center;">
								<h1>
									<a href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth-1}&meetingroomNo=${meetingroomNo}">이전달</a>
									<span>${m.targetYear}년 ${m.targetMonth+1}월 달력</span>
									<a href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth+1}&meetingroomNo=${meetingroomNo}">다음달</a>
								</h1>
							</div>
							<br>
								<!-- 달력 시작 -->
								<table style="width: 90%; height: 500px;">
								<tr>
									<th class="table_cell" style="color: red;">일</th>
									<th class="table_cell">월</th>
									<th class="table_cell">화</th>
									<th class="table_cell">수</th>
									<th class="table_cell">목</th>
									<th class="table_cell">금</th>
									<th class="table_cell" style="color: blue;">토</th>
								</tr>
								<tr>
									<!-- totalTd 전까지 반복해야 하므로 -1 해야함 -->
									<c:forEach var="i" begin="0" end="${m.totalTd - 1}" step="1">
										<!-- 일주일이 끝나면 새로운 행으로 이동 -->
									    <c:if test="${i != 0 && i % 7 == 0}">
									        </tr><tr>
									    </c:if>
									    <c:set var="day" value="${i - m.beginBlank + 1}"></c:set>
									    <c:choose>
									        <c:when test="${day > 0 && day <= m.lastDate}">
									            <td class="table_cell">
									            <div style="text-align: left;">
													<c:choose>
							                            <c:when test="${i % 7 == 0}">
															<span style="color: red;">${day}</span>
														</c:when>
														<c:when test="${i % 7 == 6}">
				                                        <c:set var="isHoliday" value="false" />
					                                        <c:forEach items="${getHolidayList}" var="holiday">
					                                            <c:if test="${day == fn:substring(holiday.locdate, 6, 8)}">
					                                                <c:set var="isHoliday" value="true"></c:set>
					                                            </c:if>
					                                        </c:forEach>
					                                        <c:choose>
					                                            <c:when test="${isHoliday}">
					                                                <span style="color: red;">${day}</span>
					                                            </c:when>
					                                            <c:otherwise>
					                                                <span style="color: blue;">${day}</span>
					                                            </c:otherwise>
					                                        </c:choose>
					                                  	</c:when>
							                            <c:otherwise>
							                            	<!-- 공휴일 여부 검사 -->
							                                <c:set var="isHoliday" value="false"></c:set>
							                                <c:forEach items="${getHolidayList}" var="holiday">
							                                    <c:if test="${day == fn:substring(holiday.locdate, 6, 8)}">
							                                        <span style="color: red;">${day}</span>
							                                        <c:set var="isHoliday" value="true"></c:set>
							                                    </c:if>
							                                </c:forEach>
							                                <!-- 공휴일이 아닌 경우 검은색으로 표시 -->
							                                <c:if test="${not isHoliday}">
							                                    <span>${day}</span>
							                                </c:if>
							                            </c:otherwise>
													</c:choose>
									            </div>
												<c:forEach var="r" items="${m.reserveList}">
													<c:if test="${day == (fn:substring(r.meetingroomReserveDate,8,10))}">
														<span>회의실 ${r.meetingroomNo}호</span>
														<span>(${r.meetingroomReserveTime}타임)</span><br>
													</c:if>
												</c:forEach>
							                 	<!-- 공휴일에 빨간색으로 공휴일 이름 표시 -->
						                           <c:forEach items="${getHolidayList}" var="holiday">
						                           	<c:if test="${day == fn:substring(holiday.locdate, 6, 8)}">
						                           		<span style="color:red;">${holiday.dateName}</span>
						                           	</c:if>
						                           </c:forEach>
									            </td>
									        </c:when>
									        <c:when test="${day < 1}">
									            <td class="table_cell" style="color: gray;">${m.preEndDate + day}</td>
									        </c:when>
									        <c:otherwise>
									            <td class="table_cell" style="color: gray;">${day - m.lastDate}</td>
									        </c:otherwise>
									    </c:choose>
									</c:forEach>
								</tr>
							</table>
							<br>
							
							<!-- 예약 등록 버튼 클릭시 모달 -->
							<div id="addMeetingroomReservationModal" class="modal">
								<div class="modal_content">
								<h3>회의실 예약</h3>
									<form id="addMeetingroomReservationForm" method="post" action="${pageContext.request.contextPath}/group/meetingroom/addMeetingroomReservation">
										<input type="hidden" name="departmentNo" value="${departmentNo}">
										<table>
											<tr>
												<th>회의실 이름</th>
												<td>
													<select name="meetingroomNo" id="addMeetingroomNoId">
														<option>== 선택하기 ==</option>
														<c:forEach var="s" items="${m.meetingroomList}">
															<option value="${s.meetingroomNo}">회의실&nbsp;${s.meetingroomNo}호</option>
														</c:forEach>
													</select>
													<span id="addMeetingroomNoIdMsg" class="msg"></span>
												</td>	
											</tr>
											<tr>
												<th>회의실 예약 날짜</th>
												<td>
													<input type="date" name="meetingroomReserveDate" id="addMeetingroomReserveDateId">
													<span id="addMeetingroomReserveDateIdMsg" class="msg"></span>
												</td>	
											</tr>
											<tr>
												<th>회의실 예약 시간</th>
												<td>
													<select name="meetingroomReserveTime" id="addMeetingroomReserveTimeId">
														<option value="1">10:00 - 12:00</option>
														<option value="2">13:00 - 15:00</option>
														<option value="3">15:00 - 17:00</option>
														<option value="4">17:00 - 19:00</option>
													</select>
													<span id="addMeetingroomReserveTimeIdMsg" class="msg"></span>
												</td>	
											</tr>
										</table>
										<button id="addMeetingroomReservationBtn" type="button">예약</button>
										<button class="close" type="button">닫기</button>
									</form>
								</div>
							</div>
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