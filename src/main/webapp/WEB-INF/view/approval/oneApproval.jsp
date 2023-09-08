<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<!-- 타이틀 -->
				<div class="list-title">결재 상세보기</div>
				<!-- 본문 내용 -->
				<div class="detail-content">
					<div class="row">
						<!-- 결재 상태출력 -->
						<div class="col-sm-5">
							<div class="row">
								<div class="col-sm-6">
									<label class="form-label">현재상태</label><br>
									<p class="approval-status">${approvalOne.approvalNowStatus}</p>
								</div>
								<div class="col-sm-6">
									<label class="form-label">최종상태</label><br>
									<p class="approval-status">${approvalOne.approvalLastStatus}</p>
								</div>
							</div>
						</div>
						<div class="col-sm-2">
						</div>
						<!-- 사인이미지 출력 -->
						<div class="col-sm-5">
							<div class="row">
								<div class= "col-sm-3">
									<table class="sign-table">
										<tr>
											<td>작성자</td>
										</tr>
										<tr>
											<td>
												<img src="/signFile/${approvalOne.memberId}.png">
											</td>
										</tr>
										<tr>
											<td>${approvalOne.memberName}</td>
										</tr>
									</table>
								</div>
								<c:choose>
									<c:when test="${not empty approvalOne.approvalFirstComment}">
										<div class= "col-sm-3">
											<table class="sign-table">
												<tr>
													<td>1차 결재자</td>
												</tr>
												<tr>
													<td>
														<img src="/signFile/${approvalOne.approvalFirstId}.png">
													</td>
												</tr>
												<tr>
													<td>${approvalOne.approvalFirstName}</td>
												</tr>
											</table>
										</div>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${not empty approvalOne.approvalSecondComment}">
										<div class= "col-sm-3">
											<table class="sign-table">
												<tr>
													<td>2차 결재자</td>
												</tr>
												<tr>
													<td>
														<img src="/signFile/${approvalOne.approvalSecondId}.png">
													</td>
												</tr>
												<tr>
													<td>${approvalOne.approvalSecondName}</td>
												</tr>
											</table>
										</div>
									</c:when>
								</c:choose>
								<c:choose>
									<c:when test="${not empty approvalOne.approvalThirdComment}">
										<div class= "col-sm-3">
											<table class="sign-table">
												<tr>
													<td>3차 결재자</td>
												</tr>
												<tr>
													<td>
														<img src="/signFile/${approvalOne.approvalThirdId}.png">
													</td>
												</tr>
												<tr>
													<td>${approvalOne.approvalThirdName}</td>
												</tr>
											</table>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div><!-- ./사인이미지 출력 종료 -->
					</div><br>
					<!-- 중간 컨텐츠 출력 -->
					<div class="row">
						<div class="col-sm-4">
							<label class="form-label">번호</label>
							<input type="text" class="form-control" value="${approvalOne.approvalNo}" readonly="readonly"><br>
						</div>
						<div class="col-sm-4">
							<label class="form-label">생성일</label>
							<input type="text" class="form-control" value="${approvalOne.createdate}" readonly="readonly"><br>
						</div>
						<div class="col-sm-4">
							<label class="form-label">최종 수정일</label>
							<input type="text" class="form-control" value="${approvalOne.updatedate}" readonly="readonly"><br>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6">
							<label class="form-label">기안서 분류</label>
							<input type="text" class="form-control" value="${approvalOne.approvalForm}" readonly="readonly"><br>
						</div>
						<div class="col-sm-6">
							<label class="form-label">작성자</label>
							<input type="text" class="form-control" value="${approvalOne.memberName}" readonly="readonly"><br>
						</div>
					</div>
						
					<!-- 본문 내용 -->
					<label class="form-label">제목</label>
					<input type="text" class="form-control" value="${approvalOne.approvalTitle}" readonly="readonly"><br>
					<label class="form-label">내용</label>
					<textarea class="form-control" rows="20" cols="50" readonly="readonly">${approvalOne.approvalContent}</textarea><br>
					
					<!-- 파일 다운로드 -->
					<label class="form-label">첨부파일 목록</label><br>
					<c:forEach var="a" items="${approvalFileList}">
						<a href="/approval/approvalDownload?approvalFileNo=${a.approvalFileNo}" style="cursor:pointer;">${a.approvalFileOri}</a>
					</c:forEach><br><hr>
					
					<label class="form-label"><h4>결재 코멘트</h4></label><br>
					<!-- 결재자 코멘트 -->
					<label class="form-label">1차 결재자 [${approvalOne.approvalFirstName}]</label>
					<input type="text" class="form-control" value="${approvalOne.approvalFirstComment}" readonly="readonly"><br>
					<label class="form-label">2차 결재자 [${approvalOne.approvalSecondName}]</label>
					<input type="text" class="form-control" value="${approvalOne.approvalSecondComment}" readonly="readonly"><br>
					<label class="form-label">3차 결재자 [${approvalOne.approvalThirdName}]</label>
					<input type="text" class="form-control" value="${approvalOne.approvalThirdComment}" readonly="readonly"><br>
		
					<!-- 작성자만 지울수 있도록 수정 -->
					<c:if test="${approvalOne.memberId == memberId && approvalOne.approvalNowStatus eq '결재전'}">
						<form action="/group/approval/updateApprovalRecall" method="post">
							<input type="hidden" name="approvalNo" value="${approvalOne.approvalNo}">
							<button class="btn btn-primary" type="submit" onClick="return confirm('회수하시겠습니까?')">회수하기</button>
						</form>
					</c:if>
					<!-- 결재 진행 -->
					<c:if test="${(approvalOne.approvalFirstId == memberId && approvalOne.approvalFirstComment == null && approvalOne.approvalNowStatus != '결재완료')
								|| (approvalOne.approvalSecondId == memberId && approvalOne.approvalSecondComment == null && approvalOne.approvalFirstComment != null && approvalOne.approvalNowStatus != '결재완료')
								|| (approvalOne.approvalThirdId == memberId && approvalOne.approvalThirdComment == null && approvalOne.approvalSecondComment != null && approvalOne.approvalFirstComment != null && approvalOne.approvalNowStatus != '결재완료')}">
						<form action="/approval/updateApprovalComment" method="post">
							<!-- 확인이 필요한 값 -->
							<input type="hidden" name="approvalNo" value="${approvalOne.approvalNo}">
					 		<input type="hidden" name="approvalFirstComment" value="${approvalOne.approvalFirstComment}">
							<input type="hidden" name="approvalSecondComment" value="${approvalOne.approvalSecondComment}">
							<input type="hidden" name="approvalFirstId" value="${approvalOne.approvalFirstId}">
							<input type="hidden" name="approvalSecondId" value="${approvalOne.approvalSecondId}">
							<input type="hidden" name="approvalThirdId" value="${approvalOne.approvalThirdId}">
							<!-- 결재 코멘트 입력 -->
							<label class="form-label">결재 진행</label><br>
							<div class="input-group">
								<!-- 코멘트 -->
								<input class="form-control" type="text" name="approvalComment" required="required" placeholder="코멘트를 입력해주시기 바랍니다">
								<!-- 버튼으로 분기 -->
								<button class="btn btn-primary" type="submit" onClick="return confirm('결재하시겠습니까?')">결재하기</button>
								<button class="btn btn-primary" type="submit" name="approvalLastStatus" value="반려" onClick="return confirm('반려하시겠습니까?')">반려하기</button>
								<button class="btn btn-primary" type="submit" name="approvalLastStatus" value="취소" onClick="return confirm('취소하시겠습니까?')">취소하기</button>
							</div>
						</form>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!-- javaScirpt -->
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>