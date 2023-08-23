<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		$('#addPersonalScheduleModalOpen').click(function(){
			$('#addPersonalScheduleModal').fadeIn();
		});
		// 개인일정 등록 버튼
		$('#addPersonalScheduleBtn').click(function(){
			// 입력값 유효성 검사
			if($('#personalScheduleTitleId').val().length == 0) {
				$('#personalScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#personalScheduleTitleIdMsg').text('');
			}
			
			if($('#personalScheduleContentId').val().length == 0) {
				$('#personalScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#personalScheduleContentIdMsg').text('');
			}
			
			if($('#personalScheduleBegindateId').val().length == 0) {
				$('#personalScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#personalScheduleBegindateIdMsg').text('');
			}
			
			if($('#personalScheduleEnddateId').val().length == 0) {
				$('#personalScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#personalScheduleEnddateIdMsg').text('');
			}
			$('#addPersonalScheduleForm').submit();
			$('#addPersonalScheduleModal').fadeOut();
		});
		
// --------------------------------------------------------------------------------		
		// 부서일정 등록 모달창 오픈
		$('#addDepartmentScheduleModalOpen').click(function(){
			$('#addDepartmentScheduleModal').fadeIn();
		});
		// 부서일정 등록 버튼
		$('#addDepartmentScheduleBtn').click(function(){
			// 입력값 유효성 검사
			if($('#departmentScheduleTitleId').val().length == 0) {
				$('#departmentScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#departmentScheduleTitleIdMsg').text('');
			}
			
			if($('#departmentScheduleContentId').val().length == 0) {
				$('#departmentScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#departmentScheduleContentIdMsg').text('');
			}
			
			if($('#departmentScheduleBegindateId').val().length == 0) {
				$('#departmentScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#departmentScheduleBegindateIdMsg').text('');
			}
			
			if($('#departmentScheduleEnddateId').val().length == 0) {
				$('#departmentScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#departmentScheduleEnddateIdMsg').text('');
			}
			$('#addDepartmentScheduleForm').submit();
			$('#addDepartmentScheduleModal').fadeOut();
		});
		
		// 모달창 닫기(공통)
	    $('.close').click(function(){
			$('#addPersonalScheduleModal').fadeOut();
			$('#addDepartmentScheduleModal').fadeOut();
		});
		
		// 부서장 권한 검사
		var fail = "${fail}";
		if (fail === '실패') {
			alert('권한이 없습니다.');
		}
		console.log(fail);
	});
</script>
</head>
<body>
	<!-- model값 받아와서 문자로 셋팅 -->
	<c:set var="m" value="${scheduleMap}"></c:set>
	
	<a href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth-1}&scheduleCategory=${m.scheduleCategory}">이전달</a>
	<span>${m.memberId}님의 ${m.targetYear}년 ${m.targetMonth+1}월 달력</span>
	<a href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth+1}&scheduleCategory=${m.scheduleCategory}">다음달</a>
	<br><br><br>
	<button id="addPersonalScheduleModalOpen">개인일정 등록</button>
	<button id="addDepartmentScheduleModalOpen">부서일정 등록</button>
	
	<br><br><br>
	<a style="color:orange" href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=부서">부서</a>
	<a style="color:green" href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=개인">개인</a>
	<br><br><br>
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
						<td class="table_cell">
							<div style="text-align: left;">
								<a style="color: black;" href="${pageContext.request.contextPath}/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${d}&scheduleCategory=${m.scheduleCategory}">
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
										<a href="${pageContext.request.contextPath}/schedule/updatePersonalSchedule?scheduleNo=${c.scheduleNo}">
											<span style="color:green">${c.scheduleCategory} ${c.scheduleTitle}(시작일)</span>
										</a>
									</c:if>
									<c:if test="${c.scheduleCategory == '부서'}">
										<a href="${pageContext.request.contextPath}/schedule/updateDepartmentSchedule?scheduleNo=${c.scheduleNo}">
											<span style="color:orange">${c.scheduleCategory} ${c.scheduleTitle}(시작일)</span>
										</a>	
									</c:if>
								</div>
								</c:if>
								<c:if test="${d == (fn:substring(c.scheduleEnddate,8,10))}">
								<div>
									<c:if test="${c.scheduleCategory == '개인'}">
											<span style="color:green">${c.scheduleCategory} ${c.scheduleTitle}(종료일)</span>
									</c:if>
									<c:if test="${c.scheduleCategory == '부서'}">
											<span style="color:orange">${c.scheduleCategory} ${c.scheduleTitle}(종료일)</span>
									</c:if>
								</div>
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
	
	<!-- 개인일정 등록 모달 -->
	<div id="addPersonalScheduleModal" class="modal">
		<div class="modal_content">
			<h3>개인 일정 등록</h3>
			<form id="addPersonalScheduleForm" method="post" action="${pageContext.request.contextPath}/schedule/addPersonalSchedule">
				<input type="hidden" name="memberId" value="${m.memberId}">
				<input type="hidden" name="scheduleCategory" value="개인">
				<table>
					<tr>
						<th>일정 제목</th>
						<td>
							<input type="text" name="scheduleTitle" id="personalScheduleTitleId">
							<span id="personalScheduleTitleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="personalScheduleContentId">
							<span id="personalScheduleContentIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 시작일</th>
						<td>
							<input type="date" name="scheduleBegindate" id="personalScheduleBegindateId">
							<span id="personalScheduleBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="personalScheduleEnddateId">
							<span id="personalScheduleEnddateIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addPersonalScheduleBtn" type="button">등록</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
	<!-- 부서일정 등록 모달 -->
	<div id="addDepartmentScheduleModal" class="modal">
		<div class="modal_content">
			<h3>부서일정 등록</h3>
			<form id="addDepartmentScheduleForm" method="post" action="${pageContext.request.contextPath}/schedule/addDepartmentSchedule">
				<input type="hidden" name="memberId" value="${m.memberId}">
				<input type="hidden" name="scheduleCategory" value="부서">
				<table>
					<tr>
						<th>일정 제목</th>
						<td>
							<input type="text" name="scheduleTitle" id="departmentScheduleTitleId">
							<span id="departmentScheduleTitleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="departmentScheduleContentId">
							<span id="departmentScheduleContentIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 시작일</th>
						<td>
							<input type="date" name=scheduleBegindate id="departmentScheduleBegindateId">
							<span id="departmentScheduleBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="departmentScheduleEnddateId">
							<span id="departmentScheduleEnddateIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addDepartmentScheduleBtn" type="button">등록</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
</body>
</html>