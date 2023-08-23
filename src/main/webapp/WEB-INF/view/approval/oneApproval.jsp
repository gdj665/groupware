<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<h1>결재 상세보기</h1>
	<table class="table">
		<tr>
			<td>
				<img src="/signFile/${approvalOne.memberId}.png">
				<c:choose>
					<c:when test="${not empty approvalOne.approvalFirstComment}">
						<img src="/signFile/${approvalOne.approvalFirstId}.png">
					</c:when>
					<c:when test="${not empty approvalOne.approvalSecondComment}">
						<img src="/signFile/${approvalOne.approvalSecondId}.png">
					</c:when>
					<c:when test="${not empty approvalOne.approvalThirdComment}">
						<img src="/signFile/${approvalOne.approvalThirdId}.png">
					</c:when>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>번호</th>
			<th>${approvalOne.approvalNo}</th>
		</tr>
		<tr>
			<th>작성자아이디</th>
			<th>${approvalOne.memberId}</th>
		</tr>
		<tr>
			<th>제목</th>
			<th>${approvalOne.approvalTitle}</th>
		</tr>
		<tr>
			<th>내용</th>
			<th>${approvalOne.approvalContent}</th>
		</tr>
		<tr>
			<th>기안서 분류</th>
			<th>${approvalOne.approvalForm}</th>
		</tr>
		<tr>
			<th>현재상태</th>
			<th>${approvalOne.approvalNowStatus}</th>
		</tr>
		<tr>
			<th>최종상태</th>
			<th>${approvalOne.approvalLastStatus}</th>
		</tr>
		<tr>
			<th>1차 결재자</th>
			<th>${approvalOne.approvalFirstId}</th>
		</tr>
		<tr>
			<th>1차 결재자 댓글</th>
			<th>${approvalOne.approvalFirstComment}</th>
		</tr>
		<tr>
			<th>2차 결재자</th>
			<th>${approvalOne.approvalSecondId}</th>
		</tr>
		<tr>
			<th>2차 결재자 댓글</th>
			<th>${approvalOne.approvalSecondComment}</th>
		</tr>
		<tr>
			<th>3차 결재자</th>
			<th>${approvalOne.approvalThirdId}</th>
		</tr>
		<tr>
			<th>3차 결재자 댓글</th>
			<th>${approvalOne.approvalThirdComment}</th>
		</tr>
		<tr>
			<th>생성일</th>
			<th>${approvalOne.createdate}</th>
		</tr>
		<tr>
			<th>수정일</th>
			<th>${approvalOne.updatedate}</th>
		</tr>
		<c:forEach var="a" items="${approvalFileList}">
			<tr>
				<td>${a.approvalFileOri}</td>
				<td><a href="/approval/approvalDownload?approvalFileNo=${a.approvalFileNo}" style="cursor:pointer;">${a.approvalFileNo}다운로드</a></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 작성자만 지울수 있도록 수정 -->
	<c:if test="${approvalOne.memberId == loginMemberId}">
		<form action="/approval/updateApprovalRecall" method="post">
			<input type="hidden" name="approvalNo" value="${approvalOne.approvalNo}">
			<button type="submit" onClick="return confirm('회수하시겠습니까?')">회수하기</button>
		</form>
	</c:if>
</body>
</html>