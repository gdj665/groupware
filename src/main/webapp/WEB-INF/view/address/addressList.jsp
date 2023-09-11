<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>부서관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/address.css">
</head>

<body>
    <!--  사이드바 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
    <div class="body-wrapper">
      <!--  해더바 -->
      <jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
      <!-- 내용물 추가하는 곳 -->
      
      <br><br><br><br>
              <h1 class="text-center mt-4">주소록</h1>
				<div class="container">
					<div>
						<form action="${pageContext.request.contextPath}/group/address/addressList" method="get">
							<div class="input-group" style="width:25% !important;">
								<input type="text" class="form-control" style="width:30% !important;" name="searchName" placeholder="사원명으로 검색">
								<button class="btn btn-primary" type="submit">검색</button>
							</div>
						</form>
					</div>
					<br>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=${currentPage}" class="choso-button btn btn-primary">전체</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㄱ" class="choso-button btn btn-primary">ㄱ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㄴ" class="choso-button btn btn-primary">ㄴ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㄷ" class="choso-button btn btn-primary">ㄷ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㄹ" class="choso-button btn btn-primary">ㄹ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅁ" class="choso-button btn btn-primary">ㅁ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅂ" class="choso-button btn btn-primary">ㅂ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅅ" class="choso-button btn btn-primary">ㅅ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅇ" class="choso-button btn btn-primary">ㅇ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅈ" class="choso-button btn btn-primary">ㅈ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅊ" class="choso-button btn btn-primary">ㅊ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅋ" class="choso-button btn btn-primary">ㅋ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅌ" class="choso-button btn btn-primary">ㅌ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅍ" class="choso-button btn btn-primary">ㅍ</a>
					<a href="${pageContext.request.contextPath}/group/address/addressList?currentPage=1&colpol=ㅎ" class="choso-button btn btn-primary">ㅎ</a>
				    <br><br>
				<table  class="table table-hover">
					<thead class="table-active">
						<tr>
							<td>이름</td>
							<td>부서</td>
							<td>직위</td>
							<td>휴대폰</td>
							<td>이메일</td>
							<td>입사일</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="e" items="${getAddressList}">
							<tr>
								<td>${e.memberName}</td>
								<td>${e.departmentId}</td>
								<td>${e.memberLevel}</td>
								<td class="copy-phone">${e.memberPhone}</td>
								<td class="copy-email">${e.memberEmail}</td>
								<td>${e.memberHiredate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>
				
					<div>
						<ul class="pagination" style="justify-content: center;">
							<c:if test="${currentPage > 1}">
								<li class="page-item">
								    <a href="/group/address/addressList?currentPage=${currentPage-1}&colpol=${param.colpol}&searchName=${param.searchName}" class="page-link">이전</a>
								</li>
							</c:if>
							
							<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
								<li class="page-item">
							    	<c:if test="${i ==  currentPage}">
										<span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
									</c:if>
									<c:if test="${i !=  currentPage}">
										<a href="/group/address/addressList?currentPage=${i}&colpol=${param.colpol}&searchName=${param.searchName}" class="page-link">${i}</a>
									</c:if>
								</li>
							</c:forEach>
								
							<c:if test="${currentPage < lastPage}">
								<li class="page-item">
								    <a href="/group/address/addressList?currentPage=${currentPage+1}&colpol=${param.colpol}&searchName=${param.searchName}" class="page-link">다음</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
            </div>
	<script src="${pageContext.request.contextPath}/javascript/address.js"></script>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>