<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
    /* 모달 컨테이너 스타일 */
	.modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 모달 내용 스타일 */
    .modal_content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        border-radius: 5px;
    }

    /* 제목 스타일 */
    .modal_content h3 {
        margin-top: 0;
    }

    /* 폼 스타일 */
    .modal_content form {
        margin-top: 20px;
    }

    /* 테이블 스타일 */
    .modal_content table {
        width: 100%;
        border-collapse: collapse;
    }

    /* 테이블 셀 스타일 */
    .modal_content td {
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    /* 입력 필드 스타일 */
    .modal_content input[type="text"],
    .modal_content input[type="date"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    /* 메시지 스타일 */
    .modal_content .msg {
        color: red;
        font-size: 12px;
    }

    /* 버튼 스타일 */
    .modal_content button {
        margin-top: 10px;
        padding: 8px 15px;
        border: none;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        border-radius: 3px;
    }

    .modal_content button.close {
        background-color: #ccc;
    }

    .modal_content button:hover {
        background-color: #0056b3;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		// 대기중->수리중 모달창 오픈
		$('.underRepairModalOpen').click(function(){
			var repairNo = $(this).data("repairno");
	        var repairProductName = $(this).data("repairproductname");
	        var memberId = $(this).data("memberid");
	        $("#repairNoInput").val(repairNo); // 모달 내의 input 요소에 수리번호 설정
	        $("#repairProductNameInput").val(repairProductName); // 모달 내의 input 요소에 수리제품이름 설정
	        $("#memberIdInput").val(memberId); // 대여자 Id값(세션에서 받아옴)
			
			$('#underRepairModal').fadeIn();
		});
		
		// 장비 추가 버튼
		$('#updateUnderRepairBtn').click(function(){
			
			$('#updateUnderRepair').submit();
			$('#underRepairModal').fadeOut();
		});
			
		// 모달창 닫기
	    $('.close').click(function(){
			$('#underRepairModal').fadeOut();
		});
	});
</script>
</head>
<body>
	<!-- 대기중 리스트 -->
	<c:if test="${repairStatus eq '대기중'}">
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
						<a href ="#" class="underRepairModalOpen" data-repairNo="${r.repairNo}" data-memberId="${memberId}" data-repairProductName="${r.repairProductName}">수리시작</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 검색및 페이징 -->
		<div>
			<form
				action="${pageContext.request.contextPath}/repair/repairList" method="get">
				<input type="text" name="repairProductCategory">
				<input type="hidden" name="repairStatus" value="대기중">
				<button type="submit">검색</button>
			</form>
		</div>
		<c:if test="${currentPage > 1}">
			<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=대기중">이전</a>
		</c:if>
		<c:if test="${currentPage < lastPage}">
			<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=대기중">다음</a>
		</c:if>
	</c:if>
	<!-- 대기중 -> 수리중 모달 -->
	<div id="underRepairModal" class="modal">
		<div class="modal_content">
			<h3>장비 추가</h3>
			<form id="updateUnderRepair" action="${pageContext.request.contextPath}/repair/updateRepair" method="post">
				<input type="hidden" name="repairNo" id="repairNoInput" value="repairNoInput">
				<table>
					<tr>
						<td>제품명</td>
						<td>
							<input type="text" id="repairProductNameInput" value="repairProductNameInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리담당자</td>
						<td>
							<input type="text" name="memberId" id="memberIdInput" value="memberIdInput">
							<span id="equipmentInspectCycleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>수리시작일</td>
						<td>
							<input type="text" name="equipmentStatus" value="비대여" readonly="readonly">
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
	
	<!-- 수리중 리스트 -->
	<c:if test="${repairStatus eq '수리중'}">
	<h1>AS수리리스트</h1>
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
					<td>${r.memberId}</td>
					<td>${r.repairProductCategory}</td>
					<td>${r.repairProductName}</td>
					<td>${r.receivingDate}</td>
					<td>${r.repairDate}</td>
					<td>${r.repairStatus}</td>
					<td>${r.repairReceivingReason}</td>
					<td></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<!-- 수리완료 리스트 -->
	<c:if test="${repairStatus eq '수리완료'}">
	<h1>AS완료리스트</h1>
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
				<th>입고사유</th>
				<th>수리</th>
			</tr>
			<c:forEach var="r" items="${repairList}">
				<tr>
					<td>${r.repairNo}</td>
					<td>${r.memberId}</td>
					<td>${r.repairProductCategory}</td>
					<td>${r.repairProductName}</td>
					<td>${r.receivingDate}</td>
					<td>${r.repairDate}</td>
					<td>${r.repairReleaseDate}</td>
					<td></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>