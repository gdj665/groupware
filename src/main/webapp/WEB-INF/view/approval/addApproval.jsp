<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 문서 작성</title>

<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- bootStrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addApproval.css">

</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<div class="card">
					<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">결재 문서 작성</div>
					<form action="/group/approval/addApproval" method="post" enctype="multipart/form-data" id="uploadForm">
						
						<!-- 결재 문서 선택 -->
						<label class="form-label">기안서 종류</label>
							<select name="approvalForm" id="approvalForm" required="required">
								<option value="">===선택해주세요===</option>
								<option value="기안서">기안서</option>
								<option value="지출결의서">지출결의서</option>
								<option value="휴가계획서">휴가계획서</option>
							</select><br><br>
						
						<!-- 제목 기입 -->
						<label for="approvalTitle" class="form-label">제목</label>
						<input type="text" id="approvalTitle" name="approvalTitle" required="required" class="form-control" style="background-color:#FFFFFF;"><br>
						<!-- 작성자 명 세션에서 받아와서 출력 -->
						<label class="form-label">작성자</label>
						<input type="text" value="<c:out value="${sessionScope.loginMember}" />" readonly><br><br>
						<!-- 내용 출력 -->
						<label for="approvalContent" class="form-label">내용</label>
						<textarea id="approvalContent" name="approvalContent" rows="20" cols="50" required="required" class="form-control" style="background-color:#FFFFFF; border: 1px solid #cccccc;"></textarea><br>
						
						<!-- 첨부파일 추가 -->
						<input type="file" name="multipartFile" id="fileInput" multiple><br><br>
						<!-- 선택한 첨부파일들 이름 출력 -->
						<label class="form-label">선택된 파일</label>
						<div style="background-color:#FFFFFF; border: 1px solid #cccccc; padding:5px;" id="selectedFiles"></div><br>
						
						<!-- 모달창 열기 버튼 / 결재자 선택 -->
						<button id="open" type="button" class="btn btn-primary">결재자 선택</button><br><br>
						<!-- 결재자 출력 -->
						<label class="form-label">1차 결재자</label>
						<input type="hidden" value="" name="approvalFirstId" class="memberIdInputFirst">
						<input type="text" value="" class="memberNameInputFirst" readonly>
						
						<label class="form-label">2차 결재자</label>
						<input type="hidden" value="" name="approvalSecondId" class="memberIdInputSecond">
						<input type="text" value="" class="memberNameInputSecond" readonly>
						
						<label class="form-label">3차 결재자</label>
						<input type="hidden" value="" name="approvalThirdId" class="memberIdInputThird">
						<input type="text" value="" class="memberNameInputThird" readonly><br><br>
						<!-- 결재 폼 보내기 -->
						<button type="submit" form="uploadForm" class="btn btn-primary">결재 진행</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- modal창 화면 -->
	<div class="modal">
		<div class="modal_content">
			<div class="row">
				<!-- 결재자 선택창 좌측 -->
				<div class="col-lg-4">
					<h3>결재자 선택</h3>
					<ul class="main-list">
						<li>
							<a href="#" class="toggle-link">회사</a>
							<ul class="sub-list">
								<c:forEach var="d" items="${departmentList}">
									<c:if test="${d.departmentParentId eq '회사'}">
										<li>
											<a href="#" class="toggle-link">${d.departmentId}</a>
											<ul class="sub-list">
												<c:forEach var="a" items="${memberList}">
													<c:if test="${d.departmentNo eq a.departmentNo}">
														<li>
															<label><input type="checkbox" value="${a.memberId}" class="member-checkbox">&nbsp;${a.memberName}</label>
														</li>
													</c:if>
												</c:forEach>
												<c:forEach var="c" items="${departmentList}">
													<c:if test="${d.departmentId eq c.departmentParentId}">
														<li>
															<a href="#" class="toggle-link">${c.departmentId}</a>
															<ul class="sub-list">
																<c:forEach var="t" items="${memberList}">
																	<c:if test="${c.departmentNo eq t.departmentNo}">
																		<li>
																			<label><input type="checkbox"value="${t.memberId}" class="member-checkbox">&nbsp;${t.memberName}</label>
																		</li>
																	</c:if>
																</c:forEach>
															</ul>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</li>
									</c:if>
								</c:forEach>
							</ul><!-- /sub-list -->
						</li>
					</ul><!-- main-list -->
				</div>
				
				<div class="col-lg-2">
				</div>

				<!-- 세 번째 컨테이너 내용 -->
				<div class="col-lg-6">
					<h3>선택된 결재자</h3>
					<form>
						<table>
							<tr>
								<td rowspan="2"><button type="button" id="rightArrowButtonFirst">&rarr;</button></td>
								<td>첫 번째 결재자</td>
							</tr>
							<tr>
								<!-- <td><button id="rightArrowButtonFirst">&rarr;</button></td> -->
								<td>
									<input type="hidden" value="" name="memberId" class="memberIdInputFirst">
									<input type="text" value="" name="memberName" class="memberNameInputFirst" readonly>
								</td>
							</tr>
							<tr>
								<td rowspan="2"><button type="button" id="rightArrowButtonSecond">&rarr;</button></td>
								<td>두 번째 결재자</td>
							</tr>
							<tr>
								<!-- <td rowspan="2"><button id="rightArrowButtonSecond">&rarr;</button></td> -->
								<td>
									<input type="hidden" value="" name="memberId" class="memberIdInputSecond">
									<input type="text" value="" name="memberName" class="memberNameInputSecond" readonly>
								</td>
							</tr>
							<tr>
								<td rowspan="2"><button type="button" id="rightArrowButtonThird">&rarr;</button></td>
								<td>세 번째 결재자</td>
							</tr>
							<tr>
								<!-- <td rowspan="2"><button id="rightArrowButtonThird">&rarr;</button></td> -->
								<td>
									<input type="hidden" value="" name="memberId" class="memberIdInputThird">
									<input type="text" value="" name="memberName" class="memberNameInputThird" readonly>
								</td>
							</tr>
						</table>
						<button id="close" type="button">선택완료</button>
						<button type="reset">초기화</button>
					</form>
				</div><!-- 모달창 결재자 선택 3번째 -->
			</div><!-- row -->
		</div><!-- modal_content -->
	</div><!-- modal -->
	<script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 개인 js -->
	<script src="${pageContext.request.contextPath}/javascript/addApproval.js"></script>
</body>
</html>