<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>AS추가</h1>
	<form action="${pageContext.request.contextPath}/repair/addRepair" method="post">
		<table>
			<tr>
				<td>제품분류</td>
				<td>
					<select id="repairProductCategoryId" name="repairProductCategory" required="required">
						<option>=선택하기=</option>
						<option value="노트북">노트북</option>
						<option value="데스크탑">데스크탑</option>
						<option value="스마트폰">스마트폰</option>
					</select>
					<span id="repairProductCategoryIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>
					<input id="repairProductNameId" type="text" name="repairProductName" required="required">
					<span id="repairProductNameIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>입고날짜</td>
				<td>
					<input id="receivingDateId" type="date" name="receivingDate" required="required">
					<span id="receivingDateIdMsg" class="msg"></span>
				</td>
			</tr>
			<tr>
				<td>수리상태</td>
				<td>
					<input type="text" value="대기중" readonly="readonly" required="required">
				</td>
			</tr>
			<tr>
				<td>입고사유</td>
				<td>
					<textarea id="repair_receiving_reasonId" rows="5" cols="30" name="repairReceivingReason" required="required"></textarea>
					<span id="repair_receiving_reasonIdMsg" class="msg"></span>
				</td>
			</tr>
		</table>
		<button type="submit">AS접수</button>
	</form>
</body>
</html>