<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 모달 컨테이너 스타일 */
	.modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 모달 내용 스타일 */
    .modal_content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        border-radius: 5px;
    }

    /* 제목 스타일 */
    .modal_content h3 {
        margin-top: 0;
    }

    /* 폼 스타일 */
    .modal_content form {
        margin-top: 20px;
    }

    /* 테이블 스타일 */
    .modal_content table {
        width: 100%;
        border-collapse: collapse;
    }

    /* 테이블 셀 스타일 */
    .modal_content td {
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    /* 입력 필드 스타일 */
    .modal_content input[type="text"],
    .modal_content input[type="date"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    /* 메시지 스타일 */
    .modal_content .msg {
        color: red;
        font-size: 12px;
    }

    /* 버튼 스타일 */
    .modal_content button {
        margin-top: 10px;
        padding: 8px 15px;
        border: none;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        border-radius: 3px;
    }

    .modal_content button.close {
        background-color: #ccc;
    }

    .modal_content button:hover {
        background-color: #0056b3;
    }
    
	
	.table_cell {
		border: 1px solid;
		border-color: black;
		width:100px;
		height: 50px;
	}
	
</style>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
			<td class="table_cell">회의실${r.meetingroomNo}</td>
			<td class="table_cell">${r.meetingroomContent}</td>		
			<td class="table_cell">${r.createdate}</td>		
			<td class="table_cell">${r.updatedate}</td>
			<td class="table_cell">
				<a href="${pageContext.request.contextPath}/meetingroom/deleteMeetingroom?meetingroomNo=${r.meetingroomNo}">삭제</a>
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