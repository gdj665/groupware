<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, tr, td , th{border: 1px solid; border-color: black;}
</style>
</head>
<body>
	<!-- model값 받아와서 문자로 셋팅 -->
	<c:set var="m" value="${scheduleMap}"></c:set>
	
	<a href="/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth-1}&scheduleCategory=${m.scheduleCategory}">이전달</a>
	<span>${m.memberId}님의 ${m.targetYear}년 ${m.targetMonth+1}월 달력</span>
	<a href="/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth+1}&scheduleCategory=${m.scheduleCategory}">다음달</a>
	<br><br><br>
	
	<a href="/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}">전체</a>
	<a href="/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=부서">부서</a>
	<a href="/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=개인">개인</a>
	<br>
	<table style="width: 1000px; height: 500px;">
		<tr>
			<th style="width: 15%;">일</th>
			<th>월</th>
			<th>화</th>
			<th style="width: 15%;">수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
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
						<td>
							<div style="text-align: left;">
								<a style="color: black;" href="/schedule/scheduleSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${d}">
									<c:choose>
										<c:when test="${i % 7 == 0}">
											<span style="color: red;">${d}</span>
										</c:when>
										<c:when test="${i % 7 == 6}">
											<span style="color: blue;">${d}</span>
										</c:when>
										<c:otherwise>
											<span>${d}</span>
										</c:otherwise>
									</c:choose>
								</a>
							</div>
						
							<c:forEach var="c" items="${m.scheduleList}">
								<c:if test="${d == (fn:substring(c.scheduleBegindate,8,10))}">
								<div>
									<c:if test="${c.scheduleCategory == '개인'}">
										<a href="">
											<span style="color:green">${c.scheduleCategory} ${c.scheduleTitle}(시작)</span>
										</a>
									</c:if>
									<c:if test="${c.scheduleCategory == '부서'}">
										<a href="">
											<span style="color:orange">${c.scheduleCategory} ${c.scheduleTitle}(시작)</span>
										</a>
									</c:if>
								</div>
								</c:if>
							</c:forEach>
						</td>
					</c:when>
					
					<c:when test="${d < 1}">
						<td style="color:gray">${m.preEndDate + d}</td>
					</c:when>
							
					<c:otherwise>
						<td style="color:gray">${d - m.lastDate}</td>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</tr>
	</table>
	
	
</body>
</html>