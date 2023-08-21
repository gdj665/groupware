<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
	<script>
//			비밀번호 정규식 -> 8자리 이상 하나 이상 문자, 하나 이상 특수문자, 하나 이상 숫자	
			const reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
			$(document).ready(function(){
				$("#pwBtn").click(function(){
					let newPw = $("#newMemberPw").val();
					let checkPw = $("#checkMemberPw").val();
					if(reg.test(newPw) === false){
						alert("비밀번호 규정에 맞지 않습니다.")
					} else if(newPw != checkPw){
						alert("비밀번호가 다릅니다.")
					} else {
						checkMember();
					}
				})
				$("#checkMemberPw").keyup(function(event){
					 if(event.which === 13){
					 $("#pwBtn").click();
					 }
				})
				/* 비밀 번호 체크 */
				function checkMember(){
				    // AJAX 요청 보내기
				    $.ajax({
				      url: '/checkMember', // 중복 체크를 수행하는 서블릿 주소
				      type: 'post',
				      data: { 'memberId': $('#memberId').val(),
				    	  'memberPw': $('#memberPw').val()}, // 서버로 보낼 데이터
				      dataType: 'json',
				      success: function(response) {
				        // 비번 체크
				        if (response == 1) {
				        	/* 비밀 번호 확인되면 업데이트 실행 */
				          updatePw();
				        } else {
				          alert("비밀번호가 틀렸습니다.");
				          return;
				        }
				      },
				      error: function(response) {
				        // 에러 처리
			        	console.log(error);	
					    alert("비밀번호 확인에 실패했습니다.");
				      }
					})
				};
				/* 비밀번호 업데이트 */
				function updatePw(){
					// AJAX 요청 보내기
				    $.ajax({
				      url: '/updateMemberPw', // pw 업데이트하는 서블릿 주소
				      type: 'post',
				      data: { 'memberId': $('#memberId').val(),
				    	  'memberPw': $('#newMemberPw').val()}, // 서버로 보낼 데이터
				      dataType: 'json',
				      success: function(response) {
				        // 중복 여부에 따라 처리
				        if (response == 1) {
				          alert("비밀번호가 변경되었습니다.");
				        } else {
					      alert("비밀번호 변경에 실패했습니다.");
				        }
				      },
				      error: function(response) {
				        // 에러 처리
				       	  console.log(error);	
						  alert("비밀번호 변경에 실패했습니다.");
				      }
					})
				}
			})
		</script>
</head>
<body>
	<c:set var="m" value="${member}"></c:set>
	<h1>mypage</h1>
	<form action="/member/updateMypage" method="post">
		<input type="hidden" value="${m.memberId}" name="memberId" id="memberId">
		${m.memberId}<br>
		
		<!-- 비번 수정 -->
		비밀번호 수정(모달 aJax 비동기)<br>
		기존 비번 : <input type="password" id="memberPw"><br>
		새 비번 입력 : <input type="password" id="newMemberPw"><br>
		새 비번 확인 : <input type="password" id="checkMemberPw"><br>
		<button type="button" id="pwBtn">수정</button><br>
		
		${m.departmentNo}<br>
		<input type="text" value="${m.memberName}" name="memberName" required="required"><br>
		${m.memberGender}<br>
		<input type="text" value="${m.memberPhone}" maxlength="11" name="memberPhone" required="required"><br>
		<input type="text" value="${m.memberEmail}" name="memberEmail" required="required"><br>
		<input type="text" value="${m.memberAddress}" name="memberAddress" required="required"><br>
		<button type="button" id="updateBtn">수정</button>
		<a href="/member/mypage?memberId=${m.memberId}">취소</a>
	</form>
</body>
</html>