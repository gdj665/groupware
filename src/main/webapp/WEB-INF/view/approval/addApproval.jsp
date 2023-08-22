<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 문서 작성</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
<script>
	$(document).ready(function() {
		$('#uploadForm').submit(function() {
			// 첨부파일 갯수 제한
			const fileInput = $('#fileInput')[0];
			if (fileInput.files.length > 5) {
				alert("최대 5개의 파일만 업로드할 수 있습니다.");
				return false; // 폼 제출 방지
			}
	
	        // 업로드된 파일들의 크기를 확인
	        const maxFileSize = 50 * 1024 * 1024;
	
	        let totalSize = 0;
	        for (let i = 0; i < fileInput.files.length; i++) {
	            totalSize += fileInput.files[i].size;
	        }
	
	        if (totalSize > maxFileSize) {
	            alert("최대 50MB의 파일만 업로드할 수 있습니다.");
	            return false; // 폼 제출 방지
	        }
	    });
		// 파일 선택 시 파일명 표시
		$('#fileInput').change(function() {
			const selectedFiles = [];
			for (let i = 0; i < this.files.length; i++) {
				selectedFiles.push(this.files[i].name);
			}
			// 각 파일 출력후에 <br>태그로 개행(text 타입에서 \n으로는 개행이 되지않음)
			$('#selectedFiles').html(selectedFiles.join("<br>"));
		});
	
		const selectElement = document.getElementById("approvalForm");
		
		selectElement.addEventListener("change", function () {
			if (selectElement.value === "") {
				selectElement.setAttribute("required", "required");
			} else {
				selectElement.removeAttribute("required");
			}
		});
	
		// 모달창 이벤트 -------------------------------------
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		$('#partsAddBtn').click(function(){
			$('#addPartsForm').submit();
			$('.modal').fadeOut();
		});
		
		$('#close').click(function(){
			$('.modal').fadeOut();
		});
		$('.modal').click(function(){
			$('.modal').fadeOut();
		});
		$('.modal_content').click(function(event) {
	        event.stopPropagation(); // 이벤트 전파 중단
	    });
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
	    $('#rightArrowButtonFirst').click(function() {
	        if (selectedCheckbox !== null) {
	            const memberIdInputFirst = $('#memberIdInputFirst');
	            const memberNameInputFirst = $('#memberNameInputFirst');
	            const memberId = $(selectedCheckbox).val();
	            const memberName = $(selectedCheckbox).parent().text().trim();
	            memberIdInputFirst.val(memberId);
	            memberNameInputFirst.val(memberName);
	        }
	    });
	    // 오른쪽 화살표 버튼 동작 구현
	    $('#rightArrowButtonSecond').click(function() {
	        if (selectedCheckbox !== null) {
	            const memberIdInputSecond = $('#memberIdInputSecond');
	            const memberNameInputSecond = $('#memberNameInputSecond');
	            const memberId = $(selectedCheckbox).val();
	            const memberName = $(selectedCheckbox).parent().text().trim();
	            memberIdInputSecond.val(memberId);
	            memberNameInputSecond.val(memberName);
	        }
	    });
	    // 오른쪽 화살표 버튼 동작 구현
	    $('#rightArrowButtonThird').click(function() {
	        if (selectedCheckbox !== null) {
	            const memberIdInputThird = $('#memberIdInputThird');
	            const memberNameInputThird = $('#memberNameInputThird');
	            const memberId = $(selectedCheckbox).val();
	            const memberName = $(selectedCheckbox).parent().text().trim();
	            memberIdInputThird.val(memberId);
	            memberNameInputThird.val(memberName);
	        }
	    });
	});
</script>
</head>
<body>
	<h1>결재 문서 작성</h1>
	<form action="/approval/addApproval" method="post" enctype="multipart/form-data" id="uploadForm">
		<table class="table">
			<tr>
				<th>기안서 종류</th>
				<td>
					<select name = "approvalForm" id = "approvalForm" required="required">
						<option value="">===선택해주세요===</option>
						<option value="1기안서">기안서</option>
						<option value="2지출결의서">지출결의서</option>
						<option value="3휴가계획서">휴가계획서</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="approvalTitle">
				</td>
			</tr>
			<tr>
				<!-- session 추가 -->
				<th>작성자</th>
				<td><c:out value="${sessionScope.loginMember}"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="approvalContent" rows="3" cols="50"></textarea>
				</td>
			</tr>
			<tr>
                <th>1차 결재자</th>
                <td></td>
            </tr>
            <tr>
                <th>2차 결재자</th>
                <td></td>
            </tr>
            <tr>
                <th>3차 결재자</th>
                <td></td>
            </tr>
			<tr>
				<td>
					<input type="file" name="multipartFile" id="fileInput" multiple>
				</td>
			</tr>
			<tr>
                <th>선택한 파일</th>
                <td id="selectedFiles"></td>
            </tr>
		</table>
		<button type="submit">결재 진행</button>
	</form>
	
	<!-- 모달창 열기 버튼 -->
	<button id="open">모달창 열기</button>
	<div class="modal">
		<div class="modal_content">
			<div class="row">
				<div class="col-lg-4">
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
		                                                <li><label>
		                                                	<input type="checkbox" value="${a.memberId}" class="member-checkbox">&nbsp;${a.memberName}
		                                                </label></li>
		                                            </c:if>
		                                        </c:forEach>
		                                        <c:forEach var="c" items="${departmentList}">
		                                            <c:if test="${d.departmentId eq c.departmentParentId}">
		                                                <li>
		                                                	<a href="#" class="toggle-link">${c.departmentId}</a>
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
            	
            	<!-- 화살표 출력 -->
	            <div class="col-lg-4">
			        <div class="arrow-buttons">
			            <button id="rightArrowButton1">&rarr;</button>
			            <button id="rightArrowButton2">&rarr;</button>
			            <button id="rightArrowButton3">&rarr;</button>
			        </div>
			    </div>
		    
		        <!-- 세 번째 컨테이너 내용 -->
			    <div class="col-lg-4">
			        <h3>이동할 부서 선택</h3>
			        <form id="updateForm" action="/department/updateDepartment" method="post">
			            <table>
			                <tr>
			                    <td>직원 아이디</td>
			                    <td>
			                        <input type="text" value="" name="memberId" id="memberIdInputFirst">
			                    </td>
			                </tr>
			                <tr>
			                    <td>직원 이름</td>
			                    <td>
			                        <input type="text" value="" name="memberName" id="memberNameInputFirst" readonly>
			                    </td>
			                </tr>
			                <tr>
			                    <td>직원 아이디</td>
			                    <td>
			                        <input type="text" value="" name="memberId" id="memberIdInputSecond">
			                    </td>
			                </tr>
			                <tr>
			                    <td>직원 이름</td>
			                    <td>
			                        <input type="text" value="" name="memberName" id="memberNameInputSecond" readonly>
			                    </td>
			                </tr>
			                <tr>
			                    <td>직원 아이디</td>
			                    <td>
			                        <input type="text" value="" name="memberId" id="memberIdInputThird">
			                    </td>
			                </tr>
			                <tr>
			                    <td>직원 이름</td>
			                    <td>
			                        <input type="text" value="" name="memberName" id="memberNameInputThird" readonly>
			                    </td>
			                </tr>
			            </table>
			            <button type="submit">업데이트</button>
			        </form>
			    </div>
			</div><!-- row -->
		</div><!-- modal_content -->
	</div><!-- modal -->
</body>
</html>