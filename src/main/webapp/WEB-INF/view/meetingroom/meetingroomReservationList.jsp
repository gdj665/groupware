<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css">
</head>
<body>
	<c:set var="m" value="${reservationMap}"></c:set>
	<a href="${pageContext.request.contextPath}/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth-1}&meetingroomNo=${meetingroomNo}">이전달</a>
	<span>${m.targetYear}년 ${m.targetMonth+1}월 달력</span>
	<a href="${pageContext.request.contextPath}/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth+1}&meetingroomNo=${meetingroomNo}">다음달</a>
	<br><br><br>
	<a href="${pageContext.request.contextPath}/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}">회의실 전체</a><br>
	<!-- 회의실 전체 목록 가져오기 -->
	<c:forEach var="s" items="${m.meetingroomList}">
		<a href="${pageContext.request.contextPath}/meetingroom/meetingroomReservationList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&meetingroomNo=${s.meetingroomNo}">회의실 ${s.meetingroomNo}호</a><br>
	</c:forEach>
	<br>
		<!-- 달력 시작 -->
		<table style="width: 80%; height: 500px;">
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
							<a href="#">
							<c:choose>
	                            <c:when test="${i % 7 == 0}">
									<span style="color: red;">${day}</span>
								</c:when>
								<c:when test="${i % 7 == 6}">
									<span style="color: blue;">${day}</span>
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
							</a>
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
	<!-- 예약 등록하기 -->
	<form>
		<input type="hidden" name="departmentNo">
		<table>
			<tr>
				<th>meetingroom_no</th>
				<td>
					<select>
				</td>	
			</tr>
			<tr>
				<th>meetingroom_reserve_date</th>
				<td>
					<input type="date" name="meetingroomReserveDate">
				</td>	
			</tr>
			<tr>
				<th>meetingroom_reserve_time</th>
				<td><input type="number" min="0" max="4" name="meetingroomReserveTime"></td>	
			</tr>
			
			<tr>
			
		</table>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>