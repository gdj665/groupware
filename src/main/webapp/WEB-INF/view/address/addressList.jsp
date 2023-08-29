<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hrm.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        /* Add some basic styling to the buttons */
        .choso-button {
            display: inline-block;
            padding: 8px 12px;
            margin-right: 8px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        /* Style the active button */
        .choso-button.active {
            background-color: #e74c3c;
        }
    </style>
</head>
<body>
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
	<script>
    const copyEmailCells = document.querySelectorAll('.copy-email');
    copyEmailCells.forEach(cell => {
        cell.style.cursor = 'pointer';
        cell.addEventListener('click', () => {
            const textToCopy = cell.textContent;
            const tempInput = document.createElement('textarea');
            tempInput.value = textToCopy;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);
            alert('이메일 주소가 복사되었습니다: ' + textToCopy);
        });
    });
    const copyEmailCells = document.querySelectorAll('.copy-phone');
    copyEmailCells.forEach(cell => {
        cell.style.cursor = 'pointer';
        cell.addEventListener('click', () => {
            const textToCopy = cell.textContent;
            const tempInput = document.createElement('textarea');
            tempInput.value = textToCopy;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);
            alert('전화번호가 복사되었습니다: ' + textToCopy);
        });
    });
</script>
</body>
</html>