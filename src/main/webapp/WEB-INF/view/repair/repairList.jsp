<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>
<body>
	<!-- 수리중 리스트 -->
	<h1>AS수리중리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>수리담당자</th>
			<th>제품분류</th>
			<th>제품명</th>
			<th>입고날짜</th>
			<th>수리날짜</th>
			<th>수리상태</th>
			<th>입고사유</th>
			<th>수리</th>
		</tr>
		<c:forEach var="r" items="${repairList}">
			<tr>
				<td>${r.repairNo}</td>
				<td style="font-weight: bold; color: orange;">${r.memberName}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairDate}</td>
				<td>${r.repairStatus}</td>
				<td>${r.repairReceivingReason}</td>
				<!-- 수리 완료는 수리담당자 본인만 할 수 있게 세션아이디값으로 보이게설정 -->
				<c:if test="${r.memberId eq memberId}">
					<td><a href="#" class="comRepairModalOpen"
						data-comRepairNo="${r.repairNo}" data-comMemberId="${memberId}"
						data-comRepairProductName="${r.repairProductName}"
						data-comRepairReceivingReason="${r.repairReceivingReason}">수리END</a>
					</td>
				</c:if>
				<c:if test="${r.memberId ne memberId}">
					<td></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색및 페이징 -->
	<div>
		<form action="${pageContext.request.contextPath}/repair/repairList"
			method="get">
			<div class="input-group" style="width:25% !important;">
				<input type="text" name="repairProductCategory"> <input
					type="hidden" name="repairStatus" value="수리중">
				<button class="btn btn-primary" type="submit">검색</button>
			</div>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a
			href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">이전</a>
	</c:if>
	
	<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
		<c:if test="${i ==  currentPage}">
			<span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
		</c:if>
		<c:if test="${i !=  currentPage}">
			<a href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${i}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중" class="page-link">${i}</a>
		</c:if>
	</c:forEach>
	
	<c:if test="${currentPage < lastPage}">
		<a
			href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>	
	
	<!-- 수리중 -> 수리완료 업데이트 모달 -->
	<div id="completedRepairModal" class="modal">
		<div class="modal_content">
			<form id="updateCompletedRepair"
				action="${pageContext.request.contextPath}/repair/updateRepair"
				method="post">
				<div class="row">
					<div class="col-lg-12">
						<h3>수리완료</h3>
						<input type="hidden" name="repairNo" id="comRepairNoInput"
							value="comRepairNoInput" required="required">
						<table class="modalTable">
							<tr>
								<td>제품명</td>
								<td><input type="text" id="comRepairProductNameInput"
									value="comRepairProductNameInput" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리담당자</td>
								<td><input type="text" id="comMemberIdInput"
									value="comMemberIdInput" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리완료일</td>
								<td><input type="text" id="comRepairReleaseDate"
									value="comRepairReleaseDate" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리비</td>
								<td><input id="totalPriceId" type="number" name="repairPrice" value="20000" required="required" readonly="readonly">원 
								<span id="totalPriceIdMsg" class="msg"></span>
							</tr>
							<tr>
								<td>수리현황</td>
								<td><input type="text" name="repairStatus" value="수리완료"
									readonly="readonly"> 수리중 -> 수리완료</td>
							</tr>
							<tr>
								<td>입고사유</td>
								<td><textarea id="repairReceivingReasonId"
										value="repairReceivingReasonId" rows="5" cols="50"
										readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td>수리내용</td>
								<td><textarea id="repairContentId" rows="5" cols="50"
										name="repairContent" required="required"></textarea>
								<span id="repairContentIdMsg" class="msg"></span>		
							</tr>
						</table>
					</div>
				</div>
				<!--  row 2 -->
				<div class="row">
					<div class="col-lg-5">
						<!-- 조회 클릭시 자재목록 출력 -->
						<div class="parts-list">
						<h4>자재 목록</h4>
							<table class="modalTable">
								<tr>
									<td>
										<ul id="availablePartsList">
											<!-- 조회 결과 자재 목록이 여기에 추가됨 -->
										</ul>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="col-lg-2">
						<div class="arrow-buttons">
							<!-- 이동시킬버튼 -->
							<button id="leftArrowButton" type="button">&larr;</button>
							<button id="rightArrowButton" type="button">&rarr;</button>
						</div>
					</div>
					<div class="col-lg-5">
						<div class="parts-list">
						<h4>선택한 자재</h4>
							<table class="modalTable">
								<tr>
									<td>
										<!-- 옮겨진 자재들 -->
										<ul id="selectedPartsList">
							                <!-- 조회 결과 자재 목록이 여기에 추가됨 -->
							            </ul>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<button id="updateCompletedRepairBtn" type="button">수정</button>
				<button class="close" type="button">닫기</button>
			</form>
		</div>
		<!-- modal content -->
	</div>
	<!-- modal -->
<script src="${pageContext.request.contextPath}/javascript/repairList.js"></script>
</body>
</html>