<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1>수리완료 상세</h1>
	<div class="row">
		<div class="col-lg-6">
			<table>
					<tr>
						<td>수리번호</td>
						<td>${completedOne.repairNo}</td>
					</tr>
					<tr>
						<td>담당자</td>
						<td>${completedOne.memberId}</td>
					</tr>
					<tr>
						<td>제품분류</td>
						<td>${completedOne.repairProductCategory}</td>
					</tr>
					<tr>
						<td>제품명</td>
						<td>${completedOne.repairProductName }</td>
					</tr>
					<tr>
						<td>입고날짜</td>
						<td>${completedOne.receivingDate }</td>
					</tr>
					<tr>
						<td>수리날짜</td>
						<td>${completedOne.repairDate }</td>
					</tr>
					<tr>
						<td>출고날짜</td>
						<td>${completedOne.repairReleaseDate }</td>
					</tr>
					<tr>
						<td>수리금액</td>
						<td>${completedOne.repairPrice }</td>
					</tr>
					<tr>
						<td>상태</td>
						<td>${completedOne.repairStatus }</td>
					</tr>
					<tr>
						<td>입고사유</td>
						<td>${completedOne.repairReceivingReason }</td>
					</tr>
					<tr>
						<td>수리내용</td>
						<td>${completedOne.repairContent }</td>
					</tr>
			</table>
		</div>
		<div class="col-lg-6">
			<h3>사용자재</h3>
			<table>
					<tr>
						<th>소비번호</th>
						<th>자재명</th>
						<th>수량</th>
						<th>가격(개)</th>
						<th>총가격</th>
					</tr>
					<c:forEach var="cf" items="${completedOneFixturesList}">
						<tr>
							<td>${cf.repairPartsNo}</td>
							<td>${cf.partsName}</td>
							<td>${cf.repairPartsCnt}</td>
							<td>${cf.partsPrice}</td>
							<td>${cf.partsPrice * cf.repairPartsCnt}</td>
						</tr>
					</c:forEach>
			</table>
		</div>			
	</div>
</body>
</html>