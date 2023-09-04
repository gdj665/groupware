<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
</head>
<body>
	<h1>AS대기리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>제품분류</th>
			<th>제품명</th>
			<th>입고날짜</th>
			<th>수리상태</th>
			<th>입고사유</th>
			<th>수리</th>
		</tr>
		<c:forEach var="r" items="${repairList}">
			<tr>
				<td>${r.repairNo}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairStatus}</td>
				<td>${r.repairReceivingReason}</td>
				<td>
					<a href ="#" class="underRepairModalOpen" data-underRepairNo="${r.repairNo}" data-underMemberId="${memberId}" data-underRepairProductName="${r.repairProductName}">수리시작</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색및 페이징 -->
	<div>
		<form action="${pageContext.request.contextPath}/repair/repairList" method="get">
			<div class="input-group" style="width:25% !important;">
				<input type="text" name="repairProductCategory">
				<input type="hidden" name="repairStatus" value="대기중">
				<button class="btn btn-primary" type="submit">검색</button>
			</div>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=대기중">이전</a>
	</c:if>
	
	<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
		<c:if test="${i ==  currentPage}">
			<span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
		</c:if>
		<c:if test="${i !=  currentPage}">
			<a href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${i}&repairProductCategory=${param.repairProductCategory}&repairStatus=대기중" class="page-link">${i}</a>
		</c:if>
	</c:forEach>
	
	<c:if test="${currentPage < lastPage}">
		<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=대기중">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>	
	
	<!-- 대기중 -> 수리중 업데이트 모달 -->
	<div id="underRepairModal" class="modal">
		<div class="modal_content">
			<h3>수리시작</h3>
			<form id="updateUnderRepair" action="${pageContext.request.contextPath}/repair/updateRepair" method="post">
				<input type="hidden" name="repairNo" id="underRepairNoInput" value="underRepairNoInput">
				<table>
					<tr>
						<td>제품명</td>
						<td>
							<input type="text" id="underRepairProductNameInput" value="underRepairProductNameInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리담당자</td>
						<td>
							<input type="text" name="memberId" id="underMemberIdInput" value="underMemberIdInput" required="required" readonly="readonly">
							<span id="equipmentInspectCycleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>수리시작일</td>
						<td>
							<input type="text" id="underRepairReleaseDate" value="underRepairReleaseDate" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리상태</td>
						<td>
							<input type="text" name="repairStatus" value="수리중" readonly="readonly">대기중 -> 수리중
						</td>
					</tr>
				</table>
			</form>
			<button id="updateUnderRepairBtn" type="button">추가</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
<script src="${pageContext.request.contextPath}/javascript/watingRepairList.js"></script>
</body>
</html>