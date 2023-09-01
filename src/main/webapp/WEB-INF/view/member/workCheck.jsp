<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<script>
	$(document).ready(function(){	
		
		const x = [];
		const y1 = [];
		const y2 = [];
		const y3 = [];
		
		
		// 동기호출로 x,y값을 셋팅
		$.ajax({
			async : false, // true(비동기:기본값), false(동기)
			url : '/member/restWorkCheckList',
			data : {targetMonth : $("#targetMonth").val(),
					targetYear : $("#targetYear").val()}, 
			type : 'get',
			success : function(model) {
				
				model.forEach(function(item, index){
					let member = item.memberId + '(' + item.memberName + ')' 
					// chart모델 생성
					x.push(member);
					y1.push(item.workBeginLate);
					y2.push(item.workEndFast);
					y3.push(item.useAnnual);
					
				});

			}
		});

		new Chart("target2", {
		  type: "bar",
		  data: {
		    labels: x, // 사원 번호
		    datasets: [
		    {
		    	label: '지각', // 작은 분류
		    	backgroundColor: 'rgb(255, 99, 132)', // 바 색상
                data: y1 // 들어갈 데이터
		    },
		    {
		    	label: '조퇴',
		    	backgroundColor: 'rgb(99, 99, 132)',
                data: y2
		    },
		    {
		    	label: '연차',
		    	backgroundColor: 'rgb(132, 99, 132)',
                data: y3
		    },
		    ]
		  },
		  options : {
			  scales : {
				  yAxes : [
					  {tics : {
						  beginAtZero : true
					  }}
				  ]
			  }
		  
		  }
		});
	});
</script>
</head>
<body>
	<c:set var="im" value="${workInfoMap}"></c:set>
	<c:set var="cm" value="${workCheckMap}"></c:set>
	<h1>근태 체크</h1>
	<table>
		<tr>
			<th>미출근</th>
			<th>출근</th>
			<th>퇴근</th>
			<th>연차</th>
		</tr>
		<tr>
		<!-- 미출근 -->
			<td>
				<c:forEach var="wil" items="${im.workCheckInfoList}">
					<c:if test="${empty wil.workBegin && empty wil.workAnnual}">
						${wil.memberId}(${wil.memberName})<br>
					</c:if>
				</c:forEach>
			</td>
		<!-- 출근 -->
			<td>
				<c:forEach var="wil" items="${im.workCheckInfoList}">
					<c:if test="${not empty wil.workBegin && empty wil.workEnd}">
						${wil.memberId}(${wil.memberName})<br>
					</c:if>
				</c:forEach>
			</td>
		<!-- 퇴근 -->
			<td>
				<c:forEach var="wil" items="${im.workCheckInfoList}">
					<c:if test="${not empty wil.workEnd}">
						${wil.memberId}(${wil.memberName})<br>
					</c:if>
				</c:forEach>
			</td>
		<!-- 연차 -->
			<td>
				<c:forEach var="wil" items="${im.workCheckInfoList}">
					<c:if test="${wil.workAnnual eq 'Y'}">
						${wil.memberId}(${wil.memberName})<br>
					</c:if>
				</c:forEach>
			</td>
		</tr>
	</table>
	<input type="hidden" value="${tagetYear}" id="targetYear">
	<input type="hidden" value="${targetMonth}" id="targetMonth">
	<canvas id="target2" style="width:100%;max-width:700px"></canvas><br>
</body>
</html>