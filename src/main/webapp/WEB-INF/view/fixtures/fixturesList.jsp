<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 목록</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
	        	<div class="card">
					<!-- 자재추가는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
					<h5 class="card-title fw-semibold mb-4">자재 목록</h5>
					<span style="text-align: right;">
						<c:if test="${memberLevel > 1}">
							<button class="btn btn-primary" id="open">자재 추가</button>
							<button class="btn btn-success" id="excelBtn">엑셀 다운</button>
						</c:if>
					</span>
					<br>
					<table>
						<tr>
							<th>자재번호</th>
							<th>분류명</th>
							<th>부품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>상세내용</th>
							<c:if test="${memberLevel > 1}">
								<th>비활성</th>
							</c:if>
						</tr>
						<c:forEach var="f" items="${fixturesList}">
							<tr>
								<td>${f.partsNo}</td>
								<td>${f.partsCategory}</td>
								<td>${f.partsName}</td>
								<td>${f.partsCnt}</td>
								<td>${f.partsPrice}원</td>
								<td>${f.partsContent}</td>
								<c:if test="${memberLevel > 1}">
									<td>
										<a href="/group/fixtures/updatePartsAlive?partsNo=${f.partsNo}" onClick="return confirm('${f.partsName} 비활성화 하시겠습니까?')">비활성</a>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</table>
					<br>
					<div>
						<form action="${pageContext.request.contextPath}/group/fixtures/fixturesList" method="get">
							<div class="input-group" style="width:25% !important;">
								<input type="text" class="form-control" name="partsName" placeholder="부품명으로 검색">
								<button class="btn btn-primary" type="submit">검색</button>
							</div>
						</form>
					</div>
					<ul class="pagination" style="justify-content: center;">
					    <c:if test="${currentPage > 1}">
					        <li class="page-item">
					            <a href="${pageContext.request.contextPath}/group/fixtures/fixturesList?currentPage=${currentPage-1}&partsName=${param.partsName}" class="page-link">이전</a>
					        </li>
					    </c:if>
					    
					    <c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
					        <li class="page-item">
					            <c:if test="${i ==  currentPage}">
					                <span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
					            </c:if>
					            <c:if test="${i !=  currentPage}">
					                <a href="${pageContext.request.contextPath}/group/fixtures/fixturesList?currentPage=${i}&partsName=${param.partsName}" class="page-link">${i}</a>
					            </c:if>
					        </li>
					    </c:forEach>
					    
					    <c:if test="${currentPage < lastPage}">
					        <li class="page-item">
					            <a href="${pageContext.request.contextPath}/group/fixtures/fixturesList?currentPage=${currentPage+1}&partsName=${param.partsName}" class="page-link">다음</a>
					        </li>
					    </c:if>
					</ul>
	        	</div>
	    	</div>
		</div>
	</div>
	
	
	<div class="modal">
		<div class="modal_content">
			<h3>자재 추가</h3>
			<form id="addPartsForm" action="${pageContext.request.contextPath}/group/fixtures/addParts" method="post">
				<table>
					<tr>
						<td>자재 분류</td>
						<td>
							<select name ="partsCategoryNo" id="partsCategoryId">
								<option value="">= 선택하기 =</option>
								<c:forEach var="fm" items="${partsCategoryList}">
									<option value="${fm.partsCategoryNo}">
										${fm.partsCategory}
									</option>
								</c:forEach>
							</select>
							<span id="partsCategoryIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>자재 이름</td>
						<td>
							<input id="partsNameId" type="text" name="partsName">
							<span id="partsNameIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>총개수</td>
						<td>
							<input id="partsCntId" type="text" name="partsCnt">
							<span id="partsCntIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>가격</td>
						<td>
							<input id="partsPriceId" type="text" name="partsPrice">
							<span id="partsPriceIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>설명</td>
						<td>
							<textarea id="partsContentId" rows="5" cols="50" name="partsContent"></textarea>
							<span id="partsContentIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="partsAddBtn" type="button">추가</button>
			<button id="close" type="button">닫기</button>
		</div>
	</div>
<!-- js코드 url호출 -->
<script src="${pageContext.request.contextPath}/javascript/fixturesList.js"></script>
</body>
</html>