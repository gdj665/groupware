<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회의실 관리</title>
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
							<!-- model값 받아와서 문자로 셋팅 -->
							<c:set var="m" value="${meetingroomMap}"></c:set>
							<h1>회의실 목록</h1>
							<br>
							<button class="btn btn-primary" id="addMeetingroomModalOpen">회의실 추가</button>
							<br><br>
							<table style="width: 90%;">
								<tr>
									<th class="table_cell">회의실 이름</th>
									<th class="table_cell">회의실 상세내용</th>
									<th class="table_cell">회의실 생성일</th>
									<th class="table_cell">회의실 수정일</th>
									<th class="table_cell">삭제하기</th>
								</tr>
								<c:forEach var="r" items="${m.meetingroomList}">
								<tr>
									<th class="table_cell">회의실 ${r.meetingroomNo}호</th>
									<th class="table_cell">${r.meetingroomContent}</th>		
									<th class="table_cell">${r.createdate}</th>		
									<th class="table_cell">${r.updatedate}</th>
									<th class="table_cell">
										<a href="${pageContext.request.contextPath}/group/meetingroom/deleteMeetingroom?meetingroomNo=${r.meetingroomNo}" onClick="return confirm('삭제하시겠습니까?')">삭제</a>
									</th>
								</tr>
								</c:forEach>
							</table>
							<br>
							<div style="text-align: center;">
								<c:if test="${currentPage > 1}">
									<a class="btn btn-primary" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomList?currentPage=${currentPage-1}">이전</a>
								</c:if>
								<span>&nbsp;&nbsp;&nbsp;&nbsp;${currentPage}&nbsp;&nbsp;&nbsp;&nbsp;</span>
								<c:if test="${currentPage < lastPage}">
									<a class="btn btn-primary" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomList?currentPage=${currentPage+1}">다음</a>
								</c:if>
							</div>
							
							<!-- 회의실 추가 모달 -->
							<div id="addMeetingroomModal" class="modal">
								<div class="modal_content">
									<h3>개인 일정 등록</h3>
									<form id="addMeetingroomForm" method="post" action="${pageContext.request.contextPath}/group/meetingroom/addMeetingroom">
										<table>
											<tr>
												<th>회의실 번호</th>
												<td>
													<input type="number" name="meetingroomNo" id="addMeetingroomNoId">
													<span id="addMeetingroomNoIdMsg" class="msg"></span>
												</td>
											</tr>
											<tr>
												<th>회의실 상세내용</th>
												<td>
													<input type="text" name="meetingroomContent" id="addMeetingroomContentId">
													<span id="addMeetingroomContentIdMsg" class="msg"></span>
												</td>
											</tr>
										</table>
									</form>
									<button id="addMeetingroomBtn" type="button">등록</button>
									<button class="close" type="button">닫기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>				
	</div>
	<!-- 개인 자바스크립트 -->
    <script src="${pageContext.request.contextPath}/javascript/meetingroomList.js"></script>
    <!-- 템플릿 코드 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>