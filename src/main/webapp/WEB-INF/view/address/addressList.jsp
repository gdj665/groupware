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
      <div class="container-fluid">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <h1 class="text-center mt-4">주소록</h1>
				<div class="container">
					<form
						action="${pageContext.request.contextPath}/address/addressList"
						method="get">
						<input type="text" name="searchName">
						<button type="submit" class="choso-button">검색</button>
					</form>
					<br>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=${currentPage}" class="choso-button">전체</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㄱ" class="choso-button">ㄱ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㄴ" class="choso-button">ㄴ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㄷ" class="choso-button">ㄷ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㄹ" class="choso-button">ㄹ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅁ" class="choso-button">ㅁ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅂ" class="choso-button">ㅂ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅅ" class="choso-button">ㅅ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅇ" class="choso-button">ㅇ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅈ" class="choso-button">ㅈ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅊ" class="choso-button">ㅊ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅋ" class="choso-button">ㅋ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅌ" class="choso-button">ㅌ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅍ" class="choso-button">ㅍ</a>
					<a href="${pageContext.request.contextPath}/address/addressList?currentPage=1&colpol=ㅎ" class="choso-button">ㅎ</a>
				    <br><br>
				<table>
					<thead>
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
				<c:if test="${currentPage > 1}">
					<a
						href="${pageContext.request.contextPath}/address/addressList?currentPage=${currentPage-1}&colpol=${param.colpol}&searchName=${param.searchName}" class="choso-button">이전</a>
				</c:if>
					<span class="choso-button">${currentPage}</span>
				<c:if test="${currentPage < lastPage}">
					<a
						href="${pageContext.request.contextPath}/address/addressList?currentPage=${currentPage+1}&colpol=${param.colpol}&searchName=${param.searchName}" class="choso-button">다음</a>
				</c:if>
				</div>
            </div>
          </div>
        </div>
      </div>
    </div>
	<script src="${pageContext.request.contextPath}/javascript/address.js"></script>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>