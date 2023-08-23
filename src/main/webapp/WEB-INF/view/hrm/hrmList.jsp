<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<style>
    .container {
        border: 1px solid #ccc;
        padding: 20px;
        margin-bottom: 20px;
        height: 400px;
        overflow-y: scroll; /* 내용이 넘칠 경우 스크롤 생성 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: left;
    }

    th {
        background-color: #f2f2f2;
    }

    ul {
        margin: 0;
        padding-left: 20px;
    }

    li {
        list-style-type: none;
        margin: 5px 0;
    }
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
	.modal2 {
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
	        margin: 5% auto;
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
	    /* 모달2 내용 스타일 */
	.modal_content2 {
	    background-color: white;
	    margin: 5% auto;
	    padding: 20px;
	    border: 1px solid #888;
	    width: 50%;
	    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
	    border-radius: 5px;
	    max-height: 500px;
	}
	
	/* 제목 스타일 */
	.modal_content2 h3 {
	    margin-top: 0;
	}
	
	/* 폼 스타일 */
	.modal_content2 form {
	    margin-top: 20px;
	    overflow-y: auto; /* 스크롤 생성 */
	    max-height: 300px;
	    
	}
	
	/* 테이블 스타일 */
	.modal_content2 table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	/* 테이블 셀 스타일 */
	.modal_content2 td {
	    padding: 8px;
	    border-bottom: 1px solid #ddd;
	}
	
	/* 입력 필드 스타일 */
	.modal_content2 input[type="text"],
	.modal_content2 input[type="date"] {
	    width: 100%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 3px;
	}
	
	/* 메시지 스타일 */
	.modal_content2 .msg {
	    color: red;
	    font-size: 12px;
	}
	
	/* 버튼 스타일 */
	.modal_content2 button {
	    margin-top: 10px;
	    padding: 8px 15px;
	    border: none;
	    background-color: #007bff;
	    color: white;
	    cursor: pointer;
	    border-radius: 3px;
	}
	
	.modal_content2 button.close {
	    background-color: #ccc;
	}
	
	.modal_content2 button:hover {
	    background-color: #0056b3;
	}
</style>

<!-- 카카오API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
window.onload = function(){
	  $("#address_kakao").click(function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	                $('#address_kakao').val(data.address) // 주소 넣기
	            }
	        }).open();
	    });
	}
</script>
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
    // 모달창 이벤트 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$('#addHrmLink').click(function(){
		$('.modal').fadeIn();
	}) 
	$('.modal').click(function() {
			$('.modal').fadeOut();
		});
		$('.modal_content').click(function(event) {
			event.stopPropagation(); // 이벤트 전파 중단
		});
	$('#addHrmBtn').click(function(){
		//입력값 유효성 검사
		 // 부서 선택 검사
    var bigDepartment = $('#bigDepartment').val();
    if (bigDepartment === "") {
        alert("부서를 선택해주세요.");
        return;
    }

    // 팀 선택 검사
    var littleDepartment = $('#littleDepartment').val();
    if (littleDepartment === "") {
        alert("팀을 선택해주세요.");
        return;
    }

    // 이름 검사
    var memberName = $('#addMemberName').val();
    if (memberName === "") {
        alert("이름을 입력해주세요.");
        return;
    }
    
	// 이름 검사
	var memberEmail = $('#addMemberEmail').val();
    if (memberName === "") {
        alert("이름을 입력해주세요.");
        return;
    }

    // 생년월일 검사
    var memberBirth = $('#addMemberBirth').val();
    if (memberBirth === "") {
        alert("생년월일을 입력해주세요.");
        return;
    }

    // 전화번호 검사
    var memberPhone = $('#addMemberPhone').val();
    if (memberPhone === "") {
        alert("전화번호를 입력해주세요.");
        return;
    }

    // 직급 검사
    var memberRank = $('select[name="memberRank"]').val();
    if (memberRank === "") {
        alert("직급을 선택해주세요.");
        return;
    }

    // 직무 레벨 검사
    var memberLevel = $('select[name="memberLevel"]').val();
    if (memberLevel === "") {
        alert("직무 레벨을 선택해주세요.");
        return;
    }

    // 입사 날짜 검사
    var memberHiredate = $('#addMemberHiredate').val();
    if (memberHiredate === "") {
        alert("입사 날짜를 입력해주세요.");
        return;
    }
		$('#addHrmForm').submit();
    	$('.modal').fadeOut();
	});
	
	$('#close').click(function(){
		$('.modal').fadeOut();
	});
});
</script>

</head>
<body>
	<h1 class="text-center mt-4">사원관리</h1>
		<div class="container">
			<!-- "부서추가" 버튼 -->
			<button id="addHrmLink" class="btn btn-primary">사원 추가</button>
			<!-- "부서삭제" 버튼 -->
			<button id="deleteDepartmentLink" class="btn btn-primary">사원 수정</button>
		 	<hr>
	    <table>
	        <tr>
	            <th>부서장</th>
	            <th>팀장</th>
	            <th>팀원</th>
	        </tr>
	        <c:forEach var="m" items="${memberList}">
	            <c:if test="${m.departmentParentNo eq 0}">
	                <tr>
	                    <td>${m.departmentId} : ${m.memberName}</td>
	                    <td>
	                        <ul>
	                            <c:forEach var="c" items="${memberList}">
	                                <c:if test="${m.departmentNo eq c.departmentParentNo and c.memberLevel eq '2팀장'}">
	                                    <li>${c.departmentId} : ${c.memberName}</li>
	                                </c:if>
	                            </c:forEach>
	                        </ul>
	                    </td>
	                    <td>
	                        <ul>
	                            <c:forEach var="c" items="${memberList}">
	                                <c:if test="${m.departmentNo eq c.departmentParentNo and c.memberLevel ne '2팀장'}">
	                                    <li>${c.departmentId} : ${c.memberName}</li>
	                                </c:if>
	                            </c:forEach>
	                        </ul>
	                    </td>
	                </tr>
	            </c:if>
	        </c:forEach>
	    </table>
</div>

	<!-- 사원 추가 모달창 html -->
	
	<div class="modal">
		<div class="modal_content">
			<h3>사원 추가</h3>
			<form id="addHrmForm" action="${pageContext.request.contextPath}/hrm/addHrm" method="post">
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
	                        <select name="departmentNo" id="littleDepartment">
	                            <option value="">=== 선택 ===</option>
	                            <!-- 서버에서 받아온 팀 리스트를 반복하여 옵션 생성 -->
	                            <c:forEach var="team" items="${teamDepartmentList}">
	                                <option value="${team.departmentNo}">${team.departmentId}</option>
	                            </c:forEach>
	                        </select>
	                    </td>
	                </tr>
	               <tr>
	                	<td>직원 이름</td>
	                	<td>
	                		<input type="text" name="memberName" id="addMemberName" placeholder="이름을 입력하세요" required="required">
	                	</td>
	                </tr>
	                <tr>
	                	<td>직원 주소</td>
	                	<td>
	                		<textarea name ="memberAddress" id="addMemberAddress" cols ="33" rows="5" placeholder="주소입력" class="single-textarea" required="required" ></textarea> &nbsp; 
	                		<button class="btn btn-primary" id="address_kakao">주소검색</button>
	                	</td>
	                </tr>
	                <tr>
	                	<td>직원 이메일</td>
	                	<td>
	                		<input type="text" name="memberEmail" id="addMemberEmail" placeholder="이메일을 입력하세요" required="required">
	                	</td>
	                </tr>
	                <tr>
	                	<td>성별</td>
	                	<td>
							<input type="radio" name="memberGender" value="남" checked="checked" required="required">남
							<input type="radio" name="memberGender" value="여" required="required">여
	                	</td>
	                </tr>
	                <tr>
	                	<td>생년월일</td>
	                	<td>
							<input type="date" name="memberBirth" id="addMemberBirth" required="required">
	                	</td>
	                </tr>
  	                <tr>
	                	<td>전화번호</td>
	                	<td>
							<input type="number" name="memberPhone" id="addMemberPhone" placeholder="전화번호을 입력하세요" required="required">
	                	</td>
	                </tr>
	                <tr>
	                	<td>직급</td>
	                	<td>
							<select id="memberRank" name="memberRank">
								<option value="">=== 직급 ===</option>
								<option value="1사원">=== 사원 ===</option>
								<option value="2대리">=== 대리 ===</option>
								<option value="3과장">=== 과장 ===</option>
								<option value="4차장">=== 차장 ===</option>
								<option value="5부장">=== 부장 ===</option>
								<option value="6이사">=== 이사 ===</option>
							</select>
	                	</td>
	                </tr>
	                <tr>
	                	<td>직무 레벨</td>
	                	<td>
							<select id="memberLevel" name="memberLevel">
								<option value="">=== 직무 레벨 ===</option>
								<option value="1팀원">=== 팀원 ===</option>
								<option value="2팀장">=== 팀장 ===</option>
								<option value="3부서장">=== 부서장 ===</option>
								<option value="4관리자">=== 관리자 ===</option>
							</select>
	                	</td>
	                </tr>
	                <tr>
	                	<td>입사 날짜</td>
	                	<td>
	                		<input type="date" name="memberHiredate" required="required" id="addMemberHiredate">
	                	</td>
	                </tr>
				</table>
			</form>
				<button id="addHrmBtn" type="button">추가</button>
				<button id="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>