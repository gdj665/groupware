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

<script>
	$(document).ready(function() {
		$('#uploadForm').submit(function() {
			const firstApprovalName = $('.memberNameInputFirst').val();
	        const secondApprovalName = $('.memberNameInputSecond').val();
	        const thirdApprovalName = $('.memberNameInputThird').val();
	        if (!firstApprovalName) {
	            alert("첫 번째 결재자를 선택해주세요.");
	            return false; // 폼 제출 방지
	        }

	        // 두 번째 결재자 입력 확인
	        if (secondApprovalName && !firstApprovalName && !thirdApprovalName) {
	            alert("두 번째 결재자를 선택하려면 첫 번째 결재자를 먼저 선택해야 합니다.");
	            return false; // 폼 제출 방지
	        }

	        // 세 번째 결재자 입력 확인
	        if (thirdApprovalName && (!secondApprovalName || !firstApprovalName)) {
	            alert("세 번째 결재자를 선택하려면 첫 번째와 두 번째 결재자를 먼저 선택해야 합니다.");
	            return false; // 폼 제출 방지
	        }
	        // 결재자 중복확인
	        if (!firstApprovalName
	        		&& (thirdApprovalName === secondApprovalName) 
	        		|| (secondApprovalName === firstApprovalName)
	        		|| (thirdApprovalName === firstApprovalName)) {
	            alert("결재자가 중복되었습니다. 수정바랍니다");
	            return false; // 폼 제출 방지
	        }
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

		selectElement.addEventListener("change", function() {
			if (selectElement.value === "") {
				selectElement.setAttribute("required", "required");
			} else {
				selectElement.removeAttribute("required");
			}
		});

		// 모달창 이벤트 -------------------------------------
		$('#open').click(function() {
			$('.modal').fadeIn();
		});
		$('#close').click(function() {
			$('.modal').fadeOut();
		});
		$('.modal').click(function() {
			$('.modal').fadeOut();
		});
		$('.modal_content').click(function(event) {
			event.stopPropagation(); // 이벤트 전파 중단
		});

		// ul li 숨기고 보이는 기능  ------------------------------------
		$('.toggle-link').click(function(e) {
			e.preventDefault();

			// 클릭한 요소의 하위 ul 요소를 활성화/비활성화합니다.
			$(this).next('ul').toggleClass('active');

			// 아이콘 방향을 변경합니다.
			$(this).toggleClass('active');
		});
		
		// 체크박스 관련 기능
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
				const memberIdInputFirst = $('.memberIdInputFirst');
				const memberNameInputFirst = $('.memberNameInputFirst');
				const memberId = $(selectedCheckbox).val();
				const memberName = $(selectedCheckbox).parent().text().trim();
				memberIdInputFirst.val(memberId);
				memberNameInputFirst.val(memberName);
			}
		});
		// 오른쪽 화살표 버튼 동작 구현
		$('#rightArrowButtonSecond').click(function() {
			if (selectedCheckbox !== null) {
				const memberIdInputSecond = $('.memberIdInputSecond');
				const memberNameInputSecond = $('.memberNameInputSecond');
				const memberId = $(selectedCheckbox).val();
				const memberName = $(selectedCheckbox).parent().text().trim();
				memberIdInputSecond.val(memberId);
				memberNameInputSecond.val(memberName);
			}
		});
		// 오른쪽 화살표 버튼 동작 구현
		$('#rightArrowButtonThird').click(function() {
			if (selectedCheckbox !== null) {
				const memberIdInputThird = $('.memberIdInputThird');
				const memberNameInputThird = $('.memberNameInputThird');
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
					<select name="approvalForm" id="approvalForm" required="required">
						<option value="">===선택해주세요===</option>
						<option value="1기안서">기안서</option>
						<option value="2지출결의서">지출결의서</option>
						<option value="3휴가계획서">휴가계획서</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="approvalTitle"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><c:out value="${sessionScope.loginMember}" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="approvalContent" rows="3" cols="50"></textarea></td>
			</tr>
			<tr>
				<th>1차 결재자</th>
				<td>
					<input type="hidden" value="" name="approvalFirstId" class="memberIdInputFirst">
					<input type="text" value="" class="memberNameInputFirst" readonly>
				</td>
			</tr>
			<tr>
				<th>2차 결재자</th>
				<td>
					<input type="hidden" value="" name="approvalSecondId" class="memberIdInputSecond">
					<input type="text" value="" class="memberNameInputSecond" readonly>
				</td>
			</tr>
			<tr>
				<th>3차 결재자</th>
				<td>
					<input type="hidden" value="" name="approvalThirdId" class="memberIdInputThird">
					<input type="text" value="" class="memberNameInputThird" readonly>
				</td>
			</tr>
			<tr>
				<td><input type="file" name="multipartFile" id="fileInput" multiple></td>
			</tr>
			<!-- 선택한 첨부파일들 이름 출력 -->
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
				<!-- 결재자 선택창 좌측 -->
				<div class="col-lg-5">
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

				<!-- 화살표 출력 -->
				<div class="col-lg-2 d-flex align-items-center">
					<div class="arrow-buttons">
						<button id="rightArrowButtonFirst">&rarr;</button>
						<button id="rightArrowButtonSecond">&rarr;</button>
						<button id="rightArrowButtonThird">&rarr;</button>
					</div>
				</div>

				<!-- 세 번째 컨테이너 내용 -->
				<div class="col-lg-5">
					<h3>선택된 결재자</h3>
					<table>
						<tr>
							<td>첫 번째 결재자</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" value="" name="memberId" class="memberIdInputFirst">
								<input type="text" value="" name="memberName" class="memberNameInputFirst" readonly>
							</td>
						</tr>
						<tr>
							<td>두 번째 결재자</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" value="" name="memberId" class="memberIdInputSecond">
								<input type="text" value="" name="memberName" class="memberNameInputSecond" readonly>
							</td>
						</tr>
						<tr>
							<td>세 번째 결재자</td>
						</tr>
						<tr>
							<td>
								<input type="hidden" value="" name="memberId" class="memberIdInputThird">
								<input type="text" value="" name="memberName" class="memberNameInputThird" readonly>
							</td>
						</tr>
					</table>
					<button id="close" type="button">선택완료</button>
				</div><!-- 모달창 결재자 선택 3번째 -->
			</div><!-- row -->
		</div><!-- modal_content -->
	</div><!-- modal -->
</body>
</html>