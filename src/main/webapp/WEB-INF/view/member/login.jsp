<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	<script>
	$(document).ready(function() {
		function checkMember(){
		    // AJAX 요청 보내기
		    $.ajax({
		      url: '/checkMember', // 중복 체크를 수행하는 서블릿 주소
		      type: 'post',
		      data: { 'memberId': $('#memberId').val(),
		    	  'memberPw': $('#memberPw').val()}, // 서버로 보낼 데이터
		      dataType: 'json',
		      success: function(response) {
		        // 중복 여부에 따라 처리
		        if (response == 1) {
		          $('#loginForm').submit();
		        } else {
		          alert("없는 아이디 이거나 틀린 비밀번호 입니다.");
		        }
		      },
		      error: function(response) {
		        // 에러 처리
		        console.log(error);
		        alert("로그인에 실패하였습니다.");
		      }
			})
		};
//		pw 입력 후 enter 누르면 로그인 버튼 눌러지게 설정
		$("#memberPw").keyup(function(event){
		 if(event.which === 13){
		 $("#loginBtn").click();
		 }
		})
//		로그인 버튼 누르면 AJAX 실행
		$("#loginBtn").click(checkMember);
		});
	
	</script>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="/login" method="post" id="loginForm">
		아이디 : <input type="text" name="memberId" id="memberId" value="${saveLoginId}"><input type="checkbox" name="saveId" ${saveId}><br>
		비번 : <input type="password" name="memberPw" id="memberPw"><br>
		<button type="button" id="loginBtn">로그인</button>
	</form>
</body>
</html>