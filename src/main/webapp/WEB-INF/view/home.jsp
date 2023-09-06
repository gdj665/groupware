<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>

<body>
    <!--  사이드바 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
    <div class="body-wrapper">
      <!--  해더바 -->
      <jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
      <!-- 내용물 추가하는 곳 -->
      <div class="container-fluid">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
            <h1>home</h1>
			<h5>${memberId}</h5>
			<a href="${pageContext.request.contextPath}/group/member/workResister">근태</a><br>
			<a href="${pageContext.request.contextPath}/group/member/workCheck">근태 관리</a><br>
			<a href="${pageContext.request.contextPath}/group/schedule/scheduleList">일정</a><br>
			<a href="${pageContext.request.contextPath}/group/meetingroom/meetingroomList">회의실 목록</a>
			<a href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList">회의실 예약</a>
			<a href="${pageContext.request.contextPath}/group/board/boardList">게시판</a><br>
			<a href="${pageContext.request.contextPath}/group/approval/approvalList">결재</a><br>
			<a href="${pageContext.request.contextPath}/group/equipment/equipmentList"> 장비 목록</a><br>
			<a href="${pageContext.request.contextPath}/group/fixtures/fixturesList"> 자재 목록</a><br>
			<a href="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList"> 장비 사용내역 목록</a><br>
			<a href="${pageContext.request.contextPath}/group/repair/addRepairForm"> AS추가</a><br>
			<a href="${pageContext.request.contextPath}/group/department/departmentList">부서관리</a><br>
			<a href="${pageContext.request.contextPath}/group/hrm/hrmList">인사관리</a><br>
			<a href="${pageContext.request.contextPath}/group/address/addressList">주소록</a><br>
			<a href="${pageContext.request.contextPath}/group/member/mypage?memberId=${memberId}">마이페이지</a><br>
			<a href="${pageContext.request.contextPath}/group/logout">로그아웃</a><br>
            </div>
          </div>
        </div>
      </div>
    </div>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>