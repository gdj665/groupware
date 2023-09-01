<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css">
<script>
	$(document).ready(function(){
		// 개인일정 등록 모달창 오픈
		$('#addMeetingroomModalOpen').click(function(){
			$('#addMeetingroomModal').fadeIn();
		});
		// 개인일정 등록 버튼
		$('#addMeetingroomBtn').click(function(){
			// 입력값 유효성 검사
			if($('#addMeetingroomNoId').val().length == 0) {
				$('#addMeetingroomNoIdMsg').text('회의실 번호를 입력해주세요');
				return;
			} else {
				$('#addMeetingroomNoIdMsg').text('');
			}
			
			if($('#addMeetingroomContentId').val().length == 0) {
				$('#addMeetingroomContentIdMsg').text('회의실 상세내용을 입력해주세요');
				return;
			} else {
				$('#addMeetingroomContentIdMsg').text('');
			}
			$('#addMeetingroomForm').submit();
			$('#addMeetingroomModal').fadeOut();
		});
		
		// 모달창 닫기(공통)
	    $('.close').click(function(){
			$('#addMeetingroomModal').fadeOut();
		});
	});
</script>
</head>
<body>
	<!-- model값 받아와서 문자로 셋팅 -->
	<c:set var="m" value="${meetingroomMap}"></c:set>
	<a href="${pageContext.request.contextPath}/home">뒤로가기</a>
	<br><br>
	<button id="addMeetingroomModalOpen">회의실 추가</button>
	<br><br>
	<table style="width: 80%;">
		<tr>
			<th class="table_cell">회의실 이름</th>
			<th class="table_cell">회의실 상세내용</th>
			<th class="table_cell">회의실 생성일</th>
			<th class="table_cell">회의실 수정일</th>
			<th class="table_cell">삭제하기</th>
		</tr>
		<c:forEach var="r" items="${m.meetingroomList}">
		<tr>
			<td class="table_cell">회의실 ${r.meetingroomNo}호</td>
			<td class="table_cell">${r.meetingroomContent}</td>		
			<td class="table_cell">${r.createdate}</td>		
			<td class="table_cell">${r.updatedate}</td>
			<td class="table_cell">
				<a href="${pageContext.request.contextPath}/meetingroom/deleteMeetingroom?meetingroomNo=${r.meetingroomNo}" onClick="return confirm('삭제하시겠습니까?')">삭제</a>
			</td>
		</tr>
		</c:forEach>
	</table>
	<c:if test="${currentPage > 1}">
		<a
			href="${pageContext.request.contextPath}/meetingroom/meetingroomList?currentPage=${currentPage-1}">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a
			href="${pageContext.request.contextPath}/meetingroom/meetingroomList?currentPage=${currentPage+1}">다음</a>
	</c:if>
	
	<!-- 회의실 추가 모달 -->
	<div id="addMeetingroomModal" class="modal">
		<div class="modal_content">
			<h3>개인 일정 등록</h3>
			<form id="addMeetingroomForm" method="post" action="${pageContext.request.contextPath}/meetingroom/addMeetingroom">
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
</body>
</html>