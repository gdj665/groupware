<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>근태관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
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
		            <c:set var="im" value="${workInfoMap}"></c:set>
					<c:set var="cm" value="${workCheckMap}"></c:set>
					<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">근태 현황</div>
					<table class="table table-hover">
						<tr>
							<!-- 미출근 -->
							<th style="width: 10%">미출근</th>
							<td>
								<c:forEach var="wil" items="${im.workCheckInfoList}">
									<c:if test="${empty wil.workBegin && empty wil.workAnnual}">
										&nbsp;${wil.memberName}&nbsp;
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<!-- 출근 -->
							<th style="width: 10%">출근</th>
							<td>
								<c:forEach var="wil" items="${im.workCheckInfoList}">
									<c:if test="${not empty wil.workBegin && empty wil.workEnd}">
										&nbsp;${wil.memberName}&nbsp;
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<!-- 퇴근 -->
							<th style="width: 10%">퇴근</th>
							<td>
								<c:forEach var="wil" items="${im.workCheckInfoList}">
									<c:if test="${not empty wil.workEnd}">
										&nbsp;${wil.memberName}&nbsp;
									</c:if>
								</c:forEach>
							</td>
						</tr>	
						<tr>
							<!-- 연차 -->
							<th style="width: 10%">연차</th>
							<td>
								<c:forEach var="wil" items="${im.workCheckInfoList}">
									<c:if test="${wil.workAnnual eq 'Y'}">
										&nbsp;${wil.memberName}&nbsp;
									</c:if>
								</c:forEach>
							</td>
						</tr>
					</table>
					<input type="hidden" value="${tagetYear}" id="targetYear">
					<input type="hidden" value="${targetMonth}" id="targetMonth">
					<canvas id="target2" style="width:100%;max-width:700px"></canvas>
            	</div>
          	</div>
        </div>
	</div>
    <script src="${pageContext.request.contextPath}/javascript/workCheck.js"></script>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>