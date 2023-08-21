<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
</head>
<script>
$(document).ready(function () {
	
    // 부서 선택시 ajax 비동기 팀 리스트 출력  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    $('#bigDepartment').change(function () {
        if ($('#bigDepartment').val() == '') {
            $('#littleDepartment').empty();
            $('#littleDepartment').append('<option value="">==팀 선택==</option>');
        } else {
            $.ajax({
                url: '/rest/departmentList',
                type: 'get',
                data: {
                    departmentId: $('#bigDepartment').val() // 선택한 부서의 값 전달
                },
                success: function (data) {
                    $('#littleDepartment').empty();
                    $('#littleDepartment').append('<option value="">==팀 선택==</option>');
                    // 받아온 팀 리스트를 옵션으로 추가
                    data.teamDepartmentList.forEach(function (item, index) {
                        $('#littleDepartment').append('<option value="' + item.departmentNo + '">' + item.departmentId + '</option>');
                    });
                }
            });
        }
    });

 // ul li 숨기고 보이는 기능  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    $('.toggle-link').click(function (e) {
        e.preventDefault();

        // 클릭한 요소의 하위 ul 요소를 활성화/비활성화합니다.
        $(this).next('ul').toggleClass('active');

        // 아이콘 방향을 변경합니다.
        $(this).toggleClass('active');
    });

   
    
    // 왼쪽 화살표 버튼 동작 구현
    $('#leftArrowButton').click(function() {
        $('#memberIdInput').val("");
        $('#memberNameInput').val(""); // 수정된 부분
    });

    let selectedCheckbox = null; // 선택된 체크박스를 추적하는 변수

 // 체크박스 클릭 이벤트
    $('.member-checkbox').click(function() {
        // 다른 체크박스 선택 해제
        $('.member-checkbox').not(this).prop('checked', false);

        // 클릭한 체크박스 선택
        $(this).prop('checked', true);
        
        selectedCheckbox = this; // 선택된 체크박스 저장
    });

    // 오른쪽 화살표 버튼 동작 구현
    $('#rightArrowButton').click(function() {
        if (selectedCheckbox !== null) {
            const memberIdInput = $('#memberIdInput');
            const memberNameInput = $('#memberNameInput');
            const memberName = $(selectedCheckbox).parent().text().trim();
            const memberId = $(selectedCheckbox).val();
            memberIdInput.val(memberId);
            memberNameInput.val(memberName);
        }
    });
    // 모달창 이벤트 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$('#addDepartmentLink').click(function(){
		$('.modal').fadeIn();
	}) 
	$('#addDepartmentBtn').click(function(){
		//입력값 유효성 검사
		// 부서 선택
		if($('#addDepartmentId').val().length == 0){
			$('#addDepartmentParentMsg').text('상위 부서를 선택해주세요');
			return;
		}else{
			$('#addDepartmentParentMsg').text('');
		}
		// 추가할 부서
		if($('#addDepartmentId').val().length == 0){
			$('#addDepartmentIdMsg').text('추가할 부서명을 입력해주세요');
			return;
    	}else{
    		$('#addDepartmentIdMsg').text('');
    	}
            // 폼 데이터 가져오기
            var formData = $("#addDepartmentForm").serialize();

            // Ajax 요청 설정
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/department/addDepartment", // 요청을 보낼 URL
                data: formData, // 폼 데이터
                success: function(response) {
                    // 성공 시 동작
                    console.log("요청 성공");
                    console.log(response); // 서버로부터의 응답 데이터 출력
                    if(response == 1){
                    	alert("부서 추가 완료되었습니다.");
                    } else {
                    	alert("부서 추가에 실패했습니다..");
                    }
                },
                error: function(xhr, status, error) {
                    // 실패 시 동작
                    console.error("요청 실패: " + status + ", " + error);
                    alert("부서 추가에 실패했습니다..");
                }
            });
        
    	$('.modal').fadeOut();
	});
	
	$('#close').click(function(){
		$('.modal').fadeOut();
	});
	
	
	// 부서 이동 ajax 비동기 -- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$("#updateForm").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        // 폼 데이터 가져오기
        var formData = $(this).serialize();

        // Ajax 요청 설정
        $.ajax({
            type: "POST",
            url: "/department/updateDepartment", // 요청을 보낼 URL
            data: formData, // 폼 데이터
            success: function(response) {
                // 성공 시 동작
                console.log("요청 성공");
                console.log(response); // 서버로부터의 응답 데이터 출력
                if(response == 1){
                	alert("부서 이동 완료되었습니다.");
                } else {
                	alert("부서 이동에 실패했습니다..");
                }
            },
            error: function(xhr, status, error) {
                // 실패 시 동작
                console.error("요청 실패: " + status + ", " + error);
                alert("부서 이동에 실패했습니다..");
            }
        });
    });
	
	 // 모달창2 이벤트 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$('#deleteDepartmentLink').click(function(){
		$('.modal2').fadeIn();
	}) 
	  // 부서 삭제 버튼 클릭 시의 동작 설정
    $("#deleteDepartmentBtn").click(function() {
        // 선택된 체크박스의 값을 배열로 가져오기
        var selectedDepartments = $("input[name='departmentNo']:checked").map(function() {
            return $(this).val();
        }).get();

        // 선택된 부서가 없으면 중단
        if (selectedDepartments.length === 0) {
            alert("삭제할 부서를 선택해주세요.");
            return;
        }
        $('#addPartsForm').submit();
		$('.modal2').fadeOut();
    });
	$('#close2').click(function(){
		$('.modal2').fadeOut();
	});
});
</script>
<body>
<h1 class="text-center mt-4">부서관리</h1>
<div class="text-center mt-3">
<!-- "부서추가" 버튼 -->
<button id="addDepartmentLink" class="btn btn-primary">부서추가</button>
<!-- "부서삭제" 버튼 -->
<button id="deleteDepartmentLink" class="btn btn-primary">부서삭제</button>

</div>
<div class="container-wrapper">
    <div class="container">
        <div>
        	<h3>이동할 사원 선택</h3>
            <ul class="main-list">
                <li>
                    <!-- 최상위 회사 --> <a href="#" class="toggle-link">회사</a>
                    <ul class="sub-list">
                        <c:forEach var="d" items="${departmentList}">
                            <c:if test="${d.departmentParentId eq '회사'}">
                                <li><a href="#" class="toggle-link">${d.departmentId}</a>
                                    <ul class="sub-list">
                                        <c:forEach var="a" items="${memberList}">
                                            <c:if test="${d.departmentNo eq a.departmentNo}">
                                                <li><label> <input type="checkbox" value="${a.memberId}" class="member-checkbox">&nbsp;${a.memberName}
                                                </label></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:forEach var="c" items="${departmentList}">
                                            <c:if test="${d.departmentId eq c.departmentParentId}">
                                                <li><a href="#" class="toggle-link">${c.departmentId}</a>
                                                    <ul class="sub-list">
                                                        <c:forEach var="t" items="${memberList}">
                                                            <c:if test="${c.departmentNo eq t.departmentNo}">
                                                                <li><label> <input type="checkbox" value="${t.memberId}" class="member-checkbox">&nbsp;${t.memberName}
                                                                </label></li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul></li>
                                            </c:if>
                                        </c:forEach>
                                    </ul></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="arrow-buttons">
            <button id="leftArrowButton">&larr;</button>
            <button id="rightArrowButton">&rarr;</button>
        </div>
    </div>
    <div class="container">
        <!-- 세 번째 컨테이너 내용 -->
        <h3>이동할 부서 선택</h3>
        <form id="updateForm" action="/department/updateDepartment" method="post">
            <table>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="bigDepartment" id="bigDepartment">
                            <option value="">===   부서 선택   ===</option>
                            <option value="100">인사 부</option>
                            <option value="200">서비스 부</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>팀</td>
                    <td>
                        <select name="littleDepartment" id="littleDepartment">
                            <option value="">=== 선택 ===</option>
                            <!-- 서버에서 받아온 팀 리스트를 반복하여 옵션 생성 -->
                            <c:forEach var="team" items="${teamDepartmentList}">
                                <option value="${team.departmentNo}">${team.departmentId}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>직원 아이디</td>
                    <td>
                        <input type="text" value="" name="memberId" id="memberIdInput">
                    </td>
                </tr>
                <tr>
                    <td>직원 이름</td>
                    <td>
                        <input type="text" value="" name="memberName" id="memberNameInput" readonly>
                    </td>
                </tr>
            </table>
            <button type="submit">업데이트</button>
        </form>
    </div>
</div>
<!-- 부서 추가 모달창 html -->

<div class="modal">
	<div class="modal_content">
		<h3>부서 추가</h3>
		<form id="addDepartmentForm" action="${pageContext.request.contextPath}/department/addDepartment" method="post">
			<table>
				<tr>
					<td>부서목록</td>
					<td>
						<select name="departmentParentNo" id="addDepartmentId">
                            <option value="">===   부서 선택   ===</option>
                            <option value="100">인사 부</option>
                            <option value="200">서비스 부</option>
                        </select>
                        <span id="addDepartmentParentMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td>추가할 부서 이름</td>
					<td>
						<input id="addDepartmentId" type="text" name="departmentId">
						<span id="addDepartmentIdMsg" class="msg"></span>
					</td>
				</tr>
			</table>
		</form>
			<button id="addDepartmentBtn" type="button">추가</button>
			<button id="close" type="button">닫기</button>
	</div>
</div>
<!-- 부서 삭제 모달창 html -->
<div class="modal2">
	<div class="modal_content2">
		<h3>부서 삭제</h3>
		<h6>부서 삭제를 하시려면 부서인원을 모두 이동 후 삭제가능합니다.</h6>
		<form id="deleteDepartmentForm" action="${pageContext.request.contextPath}/department/deleteDepartment" method="post">
			<table>
				<tr>
					<td>삭제 가능 부서 목록</td>
				</tr>
				<c:forEach var="od" items="${getDeleteOnDepartmentList}">
				<tr>
					<td><input type="checkbox" value="${od.departmentNo}" name="departmentNo">&nbsp;&nbsp;&nbsp; ${od.departmentNo}</td>
					<td>${od.departmentId}</td>
				</tr>
				</c:forEach>
			</table>	
		</form>
		<button id="deleteDepartmentBtn" type="button">삭제</button>
		<button id="close2" type="button">닫기</button>
	</div>
</div>
</body>
</html>
