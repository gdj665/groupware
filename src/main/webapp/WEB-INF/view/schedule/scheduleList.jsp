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
			if($('#addPersonalScheduleTitleId').val().length == 0) {
				$('#addPersonalScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#addPersonalScheduleTitleIdMsg').text('');
			}
			
			if($('#addPersonalScheduleContentId').val().length == 0) {
				$('#addPersonalScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#addPersonalScheduleContentIdMsg').text('');
			}
			
			if($('#addPersonalScheduleBegindateId').val().length == 0) {
				$('#addPersonalScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#addPersonalScheduleBegindateIdMsg').text('');
			}
			
			if($('#addPersonalScheduleEnddateId').val().length == 0) {
				$('#addPersonalScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#addPersonalScheduleEnddateIdMsg').text('');
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
			if($('#addDepartmentScheduleTitleId').val().length == 0) {
				$('#addDepartmentScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#addDepartmentScheduleTitleIdMsg').text('');
			}
			
			if($('#addDepartmentScheduleContentId').val().length == 0) {
				$('#addDepartmentScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#addDepartmentScheduleContentIdMsg').text('');
			}
			
			if($('#addDepartmentScheduleBegindateId').val().length == 0) {
				$('#addDepartmentScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#addDepartmentScheduleBegindateIdMsg').text('');
			}
			
			if($('#addDepartmentScheduleEnddateId').val().length == 0) {
				$('#addDepartmentScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#addDepartmentScheduleEnddateIdMsg').text('');
			}
			$('#addDepartmentScheduleForm').submit();
			$('#addDepartmentScheduleModal').fadeOut();
		});
// --------------------------------------------------------------------------------
		// 개인일정 수정 모달창 오픈
		$('.updatePersonalScheduleModalOpen').click(function(){
			var updatePersonalScheduleNo = $(this).data("updatepersonalscheduleno");
			$("#updatePersonalScheduleNoInput").val(updatePersonalScheduleNo);
			$('#updatePersonalScheduleModal').fadeIn();
		});
		// 개인일정 수정 버튼
		$('#updatePersonalScheduleBtn').click(function(){
			// 입력값 유효성 검사
			if($('#updatePersonalScheduleTitleId').val().length == 0) {
				$('#updatePersonalScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#updatePersonalScheduleTitleIdMsg').text('');
			}
			
			if($('#updatePersonalScheduleContentId').val().length == 0) {
				$('#updatePersonalScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#updatePersonalScheduleContentIdMsg').text('');
			}
			
			if($('#updatePersonalScheduleBegindateId').val().length == 0) {
				$('#updatePersonalScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#updatePersonalScheduleBegindateIdMsg').text('');
			}
			
			if($('#updatePersonalScheduleEnddateId').val().length == 0) {
				$('#updatePersonalScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#updatePersonalScheduleEnddateIdMsg').text('');
			}
			$('#updatePersonalScheduleForm').submit();
			$('#updatePersonalScheduleModal').fadeOut();
		});
// --------------------------------------------------------------------------------
		// 개인일정 수정 모달창 오픈
		$('.updateDepartmentScheduleModalOpen').click(function(){
			var updateDepartmentScheduleNo = $(this).data("updatedepartmentscheduleno");
			$("#updateDepartmentScheduleNoInput").val(updateDepartmentScheduleNo);
			$('#updateDepartmentScheduleModal').fadeIn();
		});
		// 개인일정 수정 버튼
		$('#updateDepartmentScheduleBtn').click(function(){
			// 입력값 유효성 검사
			if($('#updateDepartmentScheduleTitleId').val().length == 0) {
				$('#updateDepartmentScheduleTitleIdMsg').text('일정 제목을 입력해주세요');
				return;
			} else {
				$('#updateDepartmentScheduleTitleIdMsg').text('');
			}
			
			if($('#updateDepartmentScheduleContentId').val().length == 0) {
				$('#updateDepartmentScheduleContentIdMsg').text('일정 내용을 입력해주세요');
				return;
			} else {
				$('#updateDepartmentScheduleContentIdMsg').text('');
			}
			
			if($('#updateDepartmentScheduleBegindateId').val().length == 0) {
				$('#updateDepartmentScheduleBegindateIdMsg').text('시작일을 선택해주세요');
				return;
			} else {
				$('#updateDepartmentScheduleBegindateIdMsg').text('');
			}
			
			if($('#updateDepartmentScheduleEnddateId').val().length == 0) {
				$('#updateDepartmentScheduleEnddateIdMsg').text('종료일을 선택해주세요');
				return;
			} else {
				$('#updateDepartmentScheduleEnddateIdMsg').text('');
			}
			$('#updateDepartmentScheduleForm').submit();
			$('#updateDepartmentScheduleModal').fadeOut();
		});
// --------------------------------------------------------------------------------
		// 모달창 닫기(공통)
	    $('.close').click(function(){
			$('#addPersonalScheduleModal').fadeOut();
			$('#addDepartmentScheduleModal').fadeOut();
			$('#updatePersonalScheduleModal').fadeOut();
			$('#updateDepartmentScheduleModal').fadeOut();
		});
// --------------------------------------------------------------------------------		
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
	<span>${m.targetYear}년 ${m.targetMonth+1}월 달력</span>
	<a href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth+1}&scheduleCategory=${m.scheduleCategory}">다음달</a>
	<br><br>
	<button id="addPersonalScheduleModalOpen">개인일정 등록</button>
	<button id="addDepartmentScheduleModalOpen">부서일정 등록</button>
	<br><br><br>
	<a style="color:orange" href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=부서">부서</a>
	<a style="color:green" href="${pageContext.request.contextPath}/schedule/scheduleList?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&scheduleCategory=개인">개인</a>
	<br><br>
	<!-- 달력 시작 -->
	<table style="width: 1000px; height: 500px;">
		<!-- 달력 상단 요일 표시 -->
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
			    <c:set var="day" value="${i - m.beginBlank + 1}" />
			    <c:choose>
			        <c:when test="${day > 0 && day <= m.lastDate}">
			            <td class="table_cell">
			                <div style="text-align: left;">
			                    <a style="color: black;" href="${pageContext.request.contextPath}/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${day}&scheduleCategory=${m.scheduleCategory}">
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
			                        <!-- 개인이면 초록색, 부서면 오렌지색 -->
			                        <br>
		                            <c:forEach var="c" items="${m.scheduleList}">
		                                <c:if test="${day == (fn:substring(c.scheduleBegindate,8,10))}">
		                                    <c:if test="${c.scheduleCategory == '개인'}">
		                                        <a href="#" class="updatePersonalScheduleModalOpen" data-updatePersonalScheduleNo="${c.scheduleNo}">
		                                            <span style="color:green">${c.scheduleCategory} ${c.scheduleTitle}(시작)</span><br>
		                                        </a>
		                                    </c:if>
		                                    <c:if test="${c.scheduleCategory == '부서'}">
		                                        <a href="#" class="updateDepartmentScheduleModalOpen" data-updateDepartmentScheduleNo="${c.scheduleNo}">
		                                            <span style="color:orange">${c.scheduleCategory} ${c.scheduleTitle}(시작)</span><br>
		                                        </a>	
		                                    </c:if>
		                                </c:if>
		                            </c:forEach>
			                    </a>
			                </div>
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
							<input type="text" name="scheduleTitle" id="addPersonalScheduleTitleId">
							<span id="addPersonalScheduleTitleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="addPersonalScheduleContentId">
							<span id="addPersonalScheduleContentIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 시작일</th>
						<td>
							<input type="date" name="scheduleBegindate" id="addPersonalScheduleBegindateId">
							<span id="addPersonalScheduleBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="addPersonalScheduleEnddateId">
							<span id="addPersonalScheduleEnddateIdMsg" class="msg"></span>
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
							<input type="text" name="scheduleTitle" id="addDepartmentScheduleTitleId">
							<span id="addDepartmentScheduleTitleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="addDepartmentScheduleContentId">
							<span id="addDepartmentScheduleContentIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 시작일</th>
						<td>
							<input type="date" name=scheduleBegindate id="addDepartmentScheduleBegindateId">
							<span id="addDepartmentScheduleBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="addDepartmentScheduleEnddateId">
							<span id="addDepartmentScheduleEnddateIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addDepartmentScheduleBtn" type="button">등록</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
	<!-- 개인일정 수정 모달 -->
	<div id="updatePersonalScheduleModal" class="modal">
		<div class="modal_content">
			<h3>개인일정 수정</h3>
			<form id="updatePersonalScheduleForm" method="post" action="${pageContext.request.contextPath}/schedule/updatePersonalSchedule">
				<input type="hidden" name="scheduleNo" id="updatePersonalScheduleNoInput" value="updatePersonalScheduleNoInput">
				<input type="hidden" name="memberId" value="${m.memberId}">
				<table>
					<tr>
						<th>일정 제목</th>
						<td>
							<input type="text" name="scheduleTitle" id="updatePersonalScheduleTitleId">
							<span id="updatePersonalScheduleTitleIdMsg" class="msg"></span>
						</td>	
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="updatePersonalScheduleContentId">
							<span id="updatePersonalScheduleContentIdMsg" class="msg"></span>
						</td>	
					</tr>
					<tr>	
						<th>일정 시작일</th>
						<td>
							<input type="date" name=scheduleBegindate id="updatePersonalScheduleBegindateId">
							<span id="updatePersonalScheduleBegindateIdMsg" class="msg"></span>
						</td>	
					</tr>	
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="updatePersonalScheduleEnddateId">
							<span id="updatePersonalScheduleEnddateIdMsg" class="msg"></span>
						</td>	
					</tr>
				</table>
			</form>
			<button id="updatePersonalScheduleBtn" type="button">수정</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
	<!-- 부서일정 수정 모달 -->
	<div id="updateDepartmentScheduleModal" class="modal">
		<div class="modal_content">
		<h3>부서 일정 수정</h3>
			<form id="updateDepartmentScheduleForm" method="post" action="${pageContext.request.contextPath}/schedule/updateDepartmentSchedule">
				<input type="hidden" name="scheduleNo" id="updateDepartmentScheduleNoInput" value="updateDepartmentScheduleNoInput">
				<input type="hidden" name="memberId" value="${m.memberId}">
				<table>
					<tr>
						<th>일정 제목</th>
						<td>
							<input type="text" name="scheduleTitle" id="updateDepartmentScheduleTitleId">
							<span id="updateDepartmentScheduleTitleIdMsg" class="msg"></span>
						</td>	
					</tr>
					<tr>
						<th>일정 상세 내용</th>
						<td>
							<input type="text" name="scheduleContent" id="updateDepartmentScheduleContentId">
							<span id="updateDepartmentScheduleContentIdMsg" class="msg"></span>
						</td>	
					</tr>
					<tr>	
						<th>일정 시작일</th>
						<td>
							<input type="date" name=scheduleBegindate id="updateDepartmentScheduleBegindateId">
							<span id="updateDepartmentScheduleBegindateIdMsg" class="msg"></span>
						</td>	
					</tr>	
					<tr>
						<th>일정 종료일</th>
						<td>
							<input type="date" name=scheduleEnddate id="updateDepartmentScheduleEnddateId">
							<span id="updateDepartmentScheduleEnddateIdMsg" class="msg"></span>
						</td>	
					</tr>
				</table>
			</form>
			<button id="updateDepartmentScheduleBtn" type="button">수정</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>