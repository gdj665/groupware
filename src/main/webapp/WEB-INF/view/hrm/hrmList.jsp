<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hrm.css">

<!-- 카카오API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- excel api : sheetjs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script>
window.onload = function(){
	  $("#address_kakao").click(function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	                $('#addMemberAddress').val(data.address) // 주소 넣기
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
<script>
$(document).ready(function() {
    // "사원 상세보기" 링크를 클릭했을 때의 처리
    $("body").on("click", ".oneHrm", function(event) {
        event.preventDefault(); // 기본 링크 동작을 막습니다.

        var memberId = $(this).data("memberid"); // 소문자 memberId를 대문자 MemberId로 변경

        $.ajax({
            type: "GET",
            url: "/rest/getOneMember",
            data: { memberId: memberId },
            success: function(response) {
                var memberData = response[0];

                // 필드에 값 대입
                $("#memberId").val(memberData.memberId);
                $("#departmentId").val(memberData.departmentId);
                $("#memberName").val(memberData.memberName);
                $("#memberAddress").val(memberData.memberAddress);
                $("#memberEmail").val(memberData.memberEmail);
                $("#memberGender").val(memberData.memberGender);
                $("#memberBirth").val(memberData.memberBirth);
                $("#memberPhone").val(memberData.memberPhone);
                $("#memberRank2").text(memberData.memberRank.substring(1)); // 첫 번째 글자(숫자) 제외한 나머지
                $("#memberLevel2").text(memberData.memberLevel.substring(1)); 
                $("#memberHiredate").val(memberData.memberHiredate);
                $("#memberId2").val(memberData.memberId);

                $(".modal2").show(); // 모달 창 보이기
            },
            error: function() {
                alert("사원 데이터 가져오기에 실패했습니다.");
            }
        });
    });

    // 모달을 닫기
    $("#close2").click(function() {
        $(".modal2").hide(); // 모달 창 숨기기
    });

 // "수정" 버튼 클릭 처리
    $("#updateMemberBtn").click(function() {
    	 // 직급 검사
        var memberRank = $('#updateMemberRank').val();
        if (memberRank === "") {
            alert("직급을 선택해주세요.");
            return;
        }

        // 직무 레벨 검사
        var memberLevel = $('#updateMemberLevel').val();
        if (memberLevel === "") {
            alert("직무 레벨을 선택해주세요.");
            return;
        }

        // 폼을 제출합니다
        $("#updateMember").submit();
    });
 
 
 	// 사원리스트 엑셀 다운로드
    // 엑셀 다운로드 버튼을 클릭했을 때 실행되는 함수
    $('#excelBtn').click(function() {
       // 서버로 AJAX 요청을 보냄
       $.ajax({
          url: '/rest/getMemberList', // 서버의 '/excel' URL로 요청을 보냄
          type: 'get', // GET 요청 방식
          dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
          success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
             let arr = [];
             // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
             data.forEach(function(item) {
                arr.push([item.memberId, item.departmentId, item.memberLevel, item.memberName]); // 사원아이디 부서이름 직급 이름을 하나의 배열로 묶어서 arr 배열에 추가
             });

             // 엑셀 파일 생성
             let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
             book.SheetNames.push('사원목록'); // 시트 이름 '사원목록' 추가

             // 데이터가 들어있는 2차원 배열로부터 시트 생성
             let sheet = XLSX.utils.aoa_to_sheet([['사원아이디', '부서이름','직급','이름']].concat(arr));
             // 위에서 만든 시트를 엑셀 파일에 추가
             book.Sheets['사원목록'] = sheet;

             // 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
             let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

             // 엑셀 파일을 Blob 형태로 변환하여 다운로드
             let blob = new Blob([buf], { type: 'application/octet-stream' });
             // 다운로드할 파일의 이름을 'test.xlsx'로 설정하여 다운로드
             saveAs(blob, '사원목록.xlsx');
          }
       });
    });
});
</script>


</head>
<body>
	<h1 class="text-center mt-4">사원관리</h1>
		<div class="container">
			<!-- "부서추가" 버튼 -->
			<button id="addHrmLink" class="btn btn-primary">사원 추가</button>
			<!-- 엑셀 다운로드 버튼 -->
   			<button id="excelBtn" class="btn btn-primary">엑셀 다운로드</button>
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
	                    <td>${m.departmentId} : <a href="#" class="oneHrm" data-memberId="${m.memberId}">${m.memberName}</a></td>
	                    <td>
	                        <ul>
	                            <c:forEach var="c" items="${memberList}">
	                                <c:if test="${m.departmentNo eq c.departmentParentNo and c.memberLevel eq '2팀장'}">
	                                    <li>${c.departmentId} : <a href="#" class="oneHrm" data-memberId="${c.memberId}">${c.memberName}</a></li>
	                                </c:if>
	                            </c:forEach>
	                        </ul>
	                    </td>
	                    <td>
	                        <ul>
	                            <c:forEach var="c" items="${memberList}">
	                                <c:if test="${m.departmentNo eq c.departmentParentNo and c.memberLevel ne '2팀장'}">
	                                    <li>${c.departmentId} : <a href="#" class="oneHrm" data-memberId="${c.memberId}">${c.memberName}</a></li>
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
	
	<!-- 사원 상세보기 모달창 html -->
	
	<div class="modal2">
		<div class="modal_content2">
			<h3>사원 상세보기 </h3>
			<form id="updateMember" action="${pageContext.request.contextPath}/hrm/updateMember" method="post">
				
				<table>
					<tr>
						<td>직원 아이디 </td>
						<td>
							<input type="text" name="memberId" id="memberId"  readonly="readonly">
						</td>
					</tr>
					
	                <tr>
	                    <td>팀</td>
	                    <td>
							<input type="text" id="departmentId" readonly="readonly">
	                    </td>
	                </tr>
	               <tr>
	                	<td>직원 이름</td>
	                	<td>
	                		<input type="text" name="memberName" id="memberName"  readonly="readonly">
	                	</td>
	                </tr>
	                <tr>
	                	<td>직원 주소</td>
	                	<td>
	                		<input type="text" name="memberAddress"  id="memberAddress"  readonly="readonly"> 
	                	</td>
	                </tr>
	                <tr>
	                	<td>직원 이메일</td>
	                	<td>
	                		<input type="text" name="memberEmail"  id="memberEmail"  readonly="readonly">
	                	</td>
	                </tr>
	                <tr>
	                	<td>성별</td>
	                	<td>
							<input type="text" name="memberGender" id="memberGender" readonly="readonly">
	                	</td>
	                </tr>
	                <tr>
	                	<td>생년월일</td>
	                	<td>
							<input type="text" name="memberBirth"  id="memberBirth" readonly="readonly">
	                	</td>
	                </tr>
  	                <tr>
	                	<td>전화번호</td>
	                	<td>
							<input type="number" name="memberPhone" id="memberPhone"  readonly="readonly">
	                	</td>
	                </tr>
	                <tr>
	                	<td>현재 직급 : <span id="memberRank2"></span> </td>
	                	<td>
							<select id="updateMemberRank" name="memberRank">
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
	                	<td>현재 직무 레벨 : <span id="memberLevel2"></span></td>
	                	<td>
							<select id="updateMemberLevel" name="memberLevel">
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
	                		<input type="text" name="memberHiredate"  id="memberHiredate" readonly="readonly">
	                	</td>
	                </tr>
				</table>
			</form>
				<div class="button-container">
				    <button id="updateMemberBtn" type="button">수정</button>
				    <button id="close2" type="button"
				    
				    
				    
				    
				    
				    
				    >닫기</button>
				    <form action="${pageContext.request.contextPath}/hrm/deleteMember" method="post">
				        <input type="hidden" id="memberId2"  name="memberId">
				        <button type="submit">퇴사</button>
				    </form>
				</div>
		</div>
	</div>
</body>
</html>