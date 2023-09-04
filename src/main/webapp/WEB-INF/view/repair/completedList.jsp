<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 수리완료 리스트 -->
	<h1>AS완료리스트</h1>
	<div style="text-align: right;">
		<button id="excelBtn">엑셀 다운</button>
	</div>
	<table>
		<tr>
			<th>번호</th>
			<th>수리담당자</th>
			<th>제품분류</th>
			<th>제품명</th>
			<th>입고날짜</th>
			<th>수리날짜</th>
			<th>출고날짜</th>
			<th>수리상태</th>
		</tr>
		<c:forEach var="r" items="${repairList}">
			<tr>
				<td>
					<a href="#" class="modal_open" data-repairNo="${r.repairNo}">${r.repairNo}</a>
				</td>
				<td>${r.memberId}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairDate}</td>
				<td>${r.repairReleaseDate}</td>
				<td>${r.repairStatus}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색및 페이징 -->
	<div>
		<form action="${pageContext.request.contextPath}/group/repair/repairList" method="get">
			<div class="input-group" style="width:25% !important;">
				<input type="text" name="repairProductCategory">
				<input type="hidden" name="repairStatus" value="수리완료">
				<button class="btn btn-primary" type="submit">검색</button>
			</div>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리완료">이전</a>
	</c:if>
	
	<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
		<c:if test="${i ==  currentPage}">
			<span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
		</c:if>
		<c:if test="${i !=  currentPage}">
			<a href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${i}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리완료" class="page-link">${i}</a>
		</c:if>
	</c:forEach>
	
	<c:if test="${currentPage < lastPage}">
		<a href="${pageContext.request.contextPath}/group/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리완료">다음</a>
	</c:if>
	
	<!-- modal 상세보기 -->
	<div class="modal">
		<div class="modal_content">
			<h1>수리완료 상세</h1>
			<div class="row">
				<div class="col-lg-6">
					<table>
							<tr>
								<td>수리번호</td>
								<td>
									<span id="repairNoId"></span>
								</td>
							</tr>
							<tr>
								<td>담당자</td>
								<td>
									<span id="memberIdId"></span>
								</td>
							</tr>
							<tr>
								<td>제품분류</td>
								<td>
									<span id="repairProductCategoryId"></span>
								</td>
							</tr>
							<tr>
								<td>제품명</td>
								<td>
									<span id="repairProductNameId"></span>
								</td>
							</tr>
							<tr>
								<td>입고날짜</td>
								<td>
									<span id="receivingDateId"></span>
								</td>
							</tr>
							<tr>
								<td>수리날짜</td>
								<td>
									<span id="repairDateId"></span>
								</td>
							</tr>
							<tr>
								<td>출고날짜</td>
								<td>
									<span id="repairReleaseDateId"></span>
								</td>
							</tr>
							<tr>
								<td>수리금액</td>
								<td>
									<span id="repairPriceId"></span>
								</td>
							</tr>
							<tr>
								<td>상태</td>
								<td>
									<span id="repairStatusId"></span>
								</td>
							</tr>
							<tr>
								<td>입고사유</td>
								<td>
									<span id="repairReceivingReasonId"></span>
								</td>
							</tr>
							<tr>
								<td>수리내용</td>
								<td>
									<span id="repairContentId"></span>
								</td>
							</tr>
					</table>
				</div>
				<div class="col-lg-6">
					<h3>사용자재</h3>
					<table id="fixturesListId">
					
					</table>
				</div>
				<button class="close" type="button">닫기</button>			
			</div>
		</div>
	</div>
<script src="${pageContext.request.contextPath}/javascript/completedList.js"></script>
</body>
</html>