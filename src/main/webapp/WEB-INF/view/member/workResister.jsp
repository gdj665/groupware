<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
			<div class="container-wrapper">
				<div class="container">
					<c:set var="m" value="${workMap}"></c:set>
					<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">근태 관리</div>
					<br>
					<a class="btn text-white" style="background-color:green;" href="${pageContext.request.contextPath}/group/member/workBegin?memberId=${m.memberId}">출근</a>
					<a class="btn text-white" style="background-color:orange;" href="${pageContext.request.contextPath}/group/member/workEnd?memberId=${m.memberId}">퇴근</a>
					<div style="text-align: center;">
						<h1>
							<a href="${pageContext.request.contextPath}/group/member/workResister?targetYear=${m.targetYear}&targetMonth=${m.targetMonth - 1}">
								<img style="width: 80px;" src="${pageContext.request.contextPath}/img/previous.jpg">
							</a>
							${m.targetYear}년 ${m.targetMonth+1}월
							<a href="${pageContext.request.contextPath}/group/member/workResister?targetYear=${m.targetYear}&targetMonth=${m.targetMonth + 1}">
								<img style="width: 80px;" src="${pageContext.request.contextPath}/img/next.jpg">
							</a>
						</h1>
					</div>
					<br><br>
					<table style="width: 1000px; height: 500px;">
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
							<c:forEach var="i" begin="0" end="${m.totalTd -1}" step="1">
								<c:if test="${i != 0 && i %7 == 0}">
									</tr><tr>
								</c:if>
								<!-- 값을 변수로 셋팅 -->
								<c:set var="d" value="${i - m.beginBlank + 1}"></c:set>
								<c:choose>
									<c:when test="${d > 0 && d <= m.lastDate}">
										<td class="table_cell" style="background-color: ${d == todayDate and (m.targetMonth + 1) == todayMonth ? '#FFF5E0' : 'transparent'};">
											<div style="text-align: left;">
												<a style="color: black;">
													<c:choose>
														<c:when test="${i % 7 == 0}">
															<span style="color: red;">${d}</span>
														</c:when>
														
														<c:when test="${i % 7 == 6}">
		                                        <c:set var="isHoliday" value="false"></c:set>
			                                        <c:forEach items="${getHolidayList}" var="holiday">
			                                            <c:if test="${d == fn:substring(holiday.locdate, 6, 8)}">
			                                                <c:set var="isHoliday" value="true"></c:set>
			                                            </c:if>
			                                        </c:forEach>
			                                        <c:choose>
			                                            <c:when test="${isHoliday}">
			                                                <span style="color: red;">${d}</span>
			                                            </c:when>
			                                            <c:otherwise>
			                                                <span style="color: blue;">${d}</span>
			                                            </c:otherwise>
			                                        </c:choose>
			                                  	</c:when>
					                            <c:otherwise>
					                            	<!-- 공휴일 여부 검사 -->
					                                <c:set var="isHoliday" value="false"></c:set>
					                                <c:forEach items="${getHolidayList}" var="holiday">
					                                    <c:if test="${d == fn:substring(holiday.locdate, 6, 8)}">
					                                        <span style="color: red;">${d}</span>
					                                        <c:set var="isHoliday" value="true"></c:set>
					                                    </c:if>
					                                </c:forEach>
					                                <!-- 공휴일이 아닌 경우 검은색으로 표시 -->
					                                <c:if test="${not isHoliday}">
					                                	<span>${d}</span>
					                                </c:if>
					                            </c:otherwise>
													</c:choose>
												</a>
											</div>
										
											<c:forEach var="c" items="${m.workList}">
												<c:if test="${d == (fn:substring(c.workDate,8,10))}">
													<!-- 출근 표시 -->
												<c:if test="${not empty c.workBegin}">
													<div>
														<span style="color:green;">출근시간: ${c.workBegin}</span>
													</div>
												</c:if>
												<!-- 퇴근 표시 -->
												<c:if test="${not empty c.workEnd}">
													<div>
														<span style="color:orange;">퇴근시간: ${c.workEnd}</span>
													</div>
												</c:if>
												<!-- 연차 표시 -->
												<c:if test="${c.workAnnual eq 'Y'}">
													<div>
														<span style="color:red;">연차</span>
													</div>
												</c:if>
											</c:if>
											</c:forEach>
										<!-- 공휴일에 빨간색으로 공휴일 이름 표시 -->
				                           <c:forEach items="${getHolidayList}" var="holiday">
					                           <c:if test="${d == fn:substring(holiday.locdate, 6, 8)}">
					                           		<span style="color:red;">${holiday.dateName}</span>
					                           </c:if>
				                           </c:forEach>	
										</td>
									</c:when>
									
									<c:when test="${d < 1}">
										<td class="table_cell" style="color:gray">${m.preEndDate + d}</td>
									</c:when>
										
									<c:otherwise>
										<td class="table_cell" style="color:gray">${d - m.lastDate}</td>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>