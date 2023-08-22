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
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 40%;
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
        width: 50%;
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
		
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
// ---------------------------------------------------------------- 대기중 -> 수리중 수정 시작 ----------------------------------------------------------
		// 대기중 -> 수리중 모달창 오픈
		$('.underRepairModalOpen').click(function(){
			var underRepairNo = $(this).data("underrepairno");
	        var underRepairProductName = $(this).data("underrepairproductname");
	        var underMemberId = $(this).data("undermemberid");
	        $("#underRepairNoInput").val(underRepairNo); // 모달 내의 input 요소에 수리번호 설정
	        $("#underRepairProductNameInput").val(underRepairProductName); // 모달 내의 input 요소에 수리제품이름 설정
	        $("#underMemberIdInput").val(underMemberId); // 대여자 Id값(세션에서 받아옴)
	        $("#underRepairReleaseDate").val(preDate); // 현재날짜
			$('#underRepairModal').fadeIn();
		});
		
		// 대기중 -> 수리중 수정 버튼
		$('#updateUnderRepairBtn').click(function(){
			
			$('#updateUnderRepair').submit();
			$('#underRepairModal').fadeOut();
		});
// ---------------------------------------------------------------- 대기중 -> 수리중 수정 끝 ----------------------------------------------------------

// ---------------------------------------------------------------- 수리중 -> 수리완료 수정 시작 ----------------------------------------------------------
		// 수리중 -> 수리완료 모달창 오픈
		$('.comRepairModalOpen').click(function(){
			var comRepairNo = $(this).data("comrepairno");
	        var comRepairProductName = $(this).data("comrepairproductname");
	        var comMemberId = $(this).data("commemberid");
	        var comRepairReceivingReason = $(this).data("comrepairreceivingreason");
	        $("#comRepairNoInput").val(comRepairNo); // 모달 내의 input 요소에 수리번호 설정
	        $("#comRepairProductNameInput").val(comRepairProductName); // 모달 내의 input 요소에 수리제품이름 설정
	        $("#comMemberIdInput").val(comMemberId); // 대여자 Id값(세션에서 받아옴)
	        $("#repairReceivingReasonId").val(comRepairReceivingReason); // 입고사유
	        $("#comRepairReleaseDate").val(preDate); // 현재날짜
			
			$('#completedRepairModal').fadeIn();
		});
		
		// 수리중 -> 수리완료 수정 버튼
		$('#updateCompletedRepairBtn').click(function(){
			
			$('#updateCompletedRepair').submit();
			$('#completedRepairModal').fadeOut();
		});
// ---------------------------------------------------------------- 수리중 -> 수리완료 수정 끝 ----------------------------------------------------------		

		// 모달창 닫기 (공통)
	    $('.close').click(function(){
			$('#underRepairModal').fadeOut();
			$('#completedRepairModal').fadeOut();
		});

		// ajax 비동기로 자재 개수 가져오기
	    $('#partsNameId').on('change', function() {
            const selectedPartsName = $(this).val();
		    $.ajax({
		    	async: false,
		    	url: '/parts/getPartsCntList?partsName='+selectedPartsName,
		    	type: 'get',
		    	success: function(data) {
		    		const partsCntSelect = data.partsCnt;
		    		
		    		// 여기서부터 다시하기 
	    	});
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
						<a href ="#" class="underRepairModalOpen" data-underRepairNo="${r.repairNo}" data-underMemberId="${memberId}" data-underRepairProductName="${r.repairProductName}">수리시작</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 검색및 페이징 -->
		<div>
			<form action="${pageContext.request.contextPath}/repair/repairList" method="get">
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
	<!-- 대기중 -> 수리중 업데이트 모달 -->
	<div id="underRepairModal" class="modal">
		<div class="modal_content">
			<h3>수리중 수정</h3>
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
							<input type="text" name="memberId" id="underMemberIdInput" value="underMemberIdInput">
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
					<td>
						<a href ="#" class="comRepairModalOpen" data-comRepairNo="${r.repairNo}" data-comMemberId="${memberId}" data-comRepairProductName="${r.repairProductName}" data-comRepairReceivingReason="${r.repairReceivingReason}">수리완료</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 검색및 페이징 -->
		<div>
			<form action="${pageContext.request.contextPath}/repair/repairList" method="get">
				<input type="text" name="repairProductCategory">
				<input type="hidden" name="repairStatus" value="수리중">
				<button type="submit">검색</button>
			</form>
		</div>
		<c:if test="${currentPage > 1}">
			<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">이전</a>
		</c:if>
		<c:if test="${currentPage < lastPage}">
			<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">다음</a>
		</c:if>
	</c:if>
	
	<!-- 수리중 -> 수리완료 업데이트 모달 -->
	<div id="completedRepairModal" class="modal">
		<div class="modal_content">
			<h3>수리완료 수정</h3>
			<form id="updateCompletedRepair" action="${pageContext.request.contextPath}/repair/updateRepair" method="post">
				<input type="hidden" name="repairNo" id="comRepairNoInput" value="comRepairNoInput">
				<table>
					<tr>
						<td>제품명</td>
						<td>
							<input type="text" id="comRepairProductNameInput" value="comRepairProductNameInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리담당자</td>
						<td>
							<input type="text"  id="comMemberIdInput" value="comMemberIdInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리완료일</td>
						<td>
							<input type="text" id="comRepairReleaseDate" value="comRepairReleaseDate" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>수리비</td>
						<td>
							<input id="repairPriceId" type="number" name="repairPrice">원
							<span id="repairPriceIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>수리현황</td>
						<td>
							<input type="text" name="repairStatus" value="수리완료" readonly="readonly"> 수리중 -> 수리완료
						</td>
					</tr>
					<tr>
						<td>입고사유</td>
						<td>
							<textarea id="repairReceivingReasonId" value="repairReceivingReasonId" rows="5" cols="50" readonly="readonly"></textarea>
						</td>
					</tr>
					<tr>
						<td>수리내용</td>
						<td>
							<textarea id="repairContentId" rows="5" cols="50" name="repairContent"></textarea>
							<span id="repairContentIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>사용 자재</td>
					    <td>
					        <select id="partsNameId">
					            <c:forEach var="p" items="${partsList}">
					                <option value="${p.partsName}">
					                    ${p.partsName}
					                </option>
					            </c:forEach>
					        </select>
					        <select>
					            <option id="partsCntId"></option>
					        </select>
					    </td>
					</tr>
				</table>
			</form>
			<button id="updateCompletedRepairBtn" type="button">수정</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
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
					<td>${r.repairStatus}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>