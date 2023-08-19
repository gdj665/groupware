<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서관리</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style>
/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

/* 컨테이너 레이아웃 스타일 */
.container-wrapper {
    display: flex;
    justify-content: center; /* 가운데 정렬을 위해 수정 */
    align-items: flex-start;
    padding: 20px; /* 패딩을 좁혀줍니다 */
    max-width: 1200px; /* 최대 가로 길이 설정 */
    margin: 0 auto; /* 가운데 정렬을 위해 추가 */
}

.container {
    width: calc(33.33% - 20px);
    margin: 0 10px; /* 컨테이너 사이의 간격을 늘림 */
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}



/* 첫 번째, 두 번째, 세 번째 컨테이너 공통 스타일 */
.container:nth-child(1),
.container:nth-child(2),
.container:nth-child(3) {
    height: 350px; /* 세로 고정값 */
    overflow-y: scroll; /* 내용이 넘칠 경우 스크롤 생성 */
}

/* 두 번째 컨테이너 스타일 */
.container:nth-child(2) {
    width: calc(16.66% - 20px); /* 가로 길이 절반으로 줄임 */
    margin: 0 10px; /* 컨테이너 사이의 간격을 늘림 */
    background-color: transparent; /* 배경색 제거 */
    border: none; /* 테두리 제거 */
    box-shadow: none; /* 그림자 효과 제거 */
    overflow-y: hidden; /* 스크롤 제거 */
}
/* 화살표 버튼 스타일 */
.arrow-buttons {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
}

.arrow-buttons button {
    border: none;
    background-color: transparent;
    font-size: 24px;
    cursor: pointer;
    color: #007bff;
    transition: color 0.2s;
}

.arrow-buttons button:hover {
    color: #0056b3;
}

/* 메인 리스트 스타일 */
ul.main-list {
    list-style: none;
    padding: 0;
    margin: 20px;
}

.toggle-link {
    display: block;
    padding: 10px 0;
    text-decoration: none;
    color: #333;
    transition: color 0.2s;
}

.toggle-link:hover {
    color: #007bff;
}

/* 하위 리스트 스타일 */
ul.sub-list {
    list-style: none;
    margin-left: 20px;
    padding-left: 0;
    display: none;
}

ul.sub-list.active {
    display: block;
}

/* 폼 스타일 */
form {
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f5f5f5;
    margin: 20px;
}

select, input[type="text"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #fff;
    font-size: 14px;
    margin-bottom: 10px;
}

button[type="submit"] {
    padding: 10px 20px;
    background-color: #007bff;
    border: none;
    border-radius: 4px;
    color: #fff;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.2s;
}

button[type="submit"]:hover {
    background-color: #0056b3;
}
/* 체크박스 스타일 */
.member-checkbox {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    width: 18px;
    height: 18px;
    border: 2px solid #ccc;
    border-radius: 4px;
    margin-right: 10px;
    vertical-align: middle;
    cursor: pointer;
    transition: border-color 0.2s;
}

.member-checkbox:checked {
    border-color: #007bff;
    background-color: #007bff;
}

/* 체크박스 컨테이너 스타일 */
.member-checkbox-container {
    display: flex;
    align-items: center;
    margin-bottom: 8px;
}

.member-name {
    font-size: 14px;
    color: #333;
}
/* ... (이전 스타일 코드) ... */

/* toggle-link 스타일 변경 */
.toggle-link {
    display: block;
    padding: 10px 0;
    text-decoration: none;
    color: #333;
    transition: color 0.2s;
    position: relative; /* 아이콘 위치 설정을 위해 추가 */
}

/* 아이콘 스타일 설정 */
.toggle-link::before {
    content: ">";
    position: absolute;
    right: 0;
    transition: transform 0.3s;
}

.toggle-link.active::before {
    transform: rotate(90deg);
}
/* toggle-link 스타일 변경 */
.toggle-link {
    display: block;
    padding: 10px 0;
    text-decoration: none;
    color: #333;
    transition: color 0.2s;
    position: relative; /* 아이콘 위치 설정을 위해 추가 */
}

/* 아이콘 스타일 설정 */
.toggle-link::before {
    content: ">";
    position: absolute;
    right: 0;
    transition: transform 0.3s;
}

.toggle-link.active::before {
    transform: rotate(90deg);
}

</style>
</head>
<script>
$(document).ready(function () {
    // 부서 선택시 팀 리스트 출력
    $('#bigDepartment').change(function () {
        if ($('#bigDepartment').val() == '') {
            $('#littleDepartment').empty();
            $('#littleDepartment').append('<option value="">==팀 선택==</option>');
        } else {
            $.ajax({
                url: '/rest/departmentList',
                type: 'get',
                data: {
                    departmentId: $('#bigDepartment').val() // 선택한 부서의 값 전달
                },
                success: function (data) {
                    $('#littleDepartment').empty();
                    $('#littleDepartment').append('<option value="">==팀 선택==</option>');
                    // 받아온 팀 리스트를 옵션으로 추가
                    data.teamDepartmentList.forEach(function (item, index) {
                        $('#littleDepartment').append('<option value="' + item.departmentNo + '">' + item.departmentId + '</option>');
                    });
                }
            });
        }
    });

 // ul li 숨기고 보이는 기능
    $('.toggle-link').click(function (e) {
        e.preventDefault();

        // 클릭한 요소의 하위 ul 요소를 활성화/비활성화합니다.
        $(this).next('ul').toggleClass('active');

        // 아이콘 방향을 변경합니다.
        $(this).toggleClass('active');
    });

   
    
    // 왼쪽 화살표 버튼 동작 구현
    $('#leftArrowButton').click(function() {
        $('#memberIdInput').val("");
        $('#memberNameInput').val(""); // 수정된 부분
    });

    let selectedCheckbox = null; // 선택된 체크박스를 추적하는 변수

 // 체크박스 클릭 이벤트
    $('.member-checkbox').click(function() {
        // 다른 체크박스 선택 해제
        $('.member-checkbox').not(this).prop('checked', false);

        // 클릭한 체크박스 선택
        $(this).prop('checked', true);
        
        selectedCheckbox = this; // 선택된 체크박스 저장
    });

    // 오른쪽 화살표 버튼 동작 구현
    $('#rightArrowButton').click(function() {
        if (selectedCheckbox !== null) {
            const memberIdInput = $('#memberIdInput');
            const memberNameInput = $('#memberNameInput');
            const memberName = $(selectedCheckbox).parent().text().trim();
            const memberId = $(selectedCheckbox).val();
            memberIdInput.val(memberId);
            memberNameInput.val(memberName);
        }
    });
});
</script>
<body>
<h1 class="text-center mt-4">부서관리</h1>
<div class="text-center mt-3">
<!-- "부서추가" 버튼 -->
<a href="#" id="addDepartmentLink" class="btn btn-primary">부서추가</a>

</div>
<div class="container-wrapper">
    <div class="container">
        <div>
            <ul class="main-list">
                <li>
                    <!-- 최상위 회사 --> <a href="#" class="toggle-link">회사</a>
                    <ul class="sub-list">
                        <c:forEach var="d" items="${departmentList}">
                            <c:if test="${d.departmentParentId eq '회사'}">
                                <li><a href="#" class="toggle-link">${d.departmentId}</a>
                                    <ul class="sub-list">
                                        <c:forEach var="a" items="${memberList}">
                                            <c:if test="${d.departmentNo eq a.departmentNo}">
                                                <li><label> <input type="checkbox" value="${a.memberId}" class="member-checkbox">&nbsp;${a.memberName}
                                                </label></li>
                                            </c:if>
                                        </c:forEach>
                                        <c:forEach var="c" items="${departmentList}">
                                            <c:if test="${d.departmentId eq c.departmentParentId}">
                                                <li><a href="#" class="toggle-link">${c.departmentId}</a>
                                                    <ul class="sub-list">
                                                        <c:forEach var="t" items="${memberList}">
                                                            <c:if test="${c.departmentNo eq t.departmentNo}">
                                                                <li><label> <input type="checkbox" value="${t.memberId}" class="member-checkbox">&nbsp;${t.memberName}
                                                                </label></li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul></li>
                                            </c:if>
                                        </c:forEach>
                                    </ul></li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <div class="container">
        <div class="arrow-buttons">
            <button id="leftArrowButton">&larr;</button>
            <button id="rightArrowButton">&rarr;</button>
        </div>
    </div>
    <div class="container">
        <!-- 세 번째 컨테이너 내용 -->
        <form id="updateForm" action="/department/updateDepartment" method="post">
            <table>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="bigDepartment" id="bigDepartment">
                            <option value="">===   부서 선택   ===</option>
                            <option value="998">인사 부</option>
                            <option value="997">서비스 부</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>팀</td>
                    <td>
                        <select name="littleDepartment" id="littleDepartment">
                            <option value="">=== 선택 ===</option>
                            <!-- 서버에서 받아온 팀 리스트를 반복하여 옵션 생성 -->
                            <c:forEach var="team" items="${teamDepartmentList}">
                                <option value="${team.departmentNo}">${team.departmentId}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>직원 아이디</td>
                    <td>
                        <input type="text" value="" name="memberId" id="memberIdInput">
                    </td>
                </tr>
                <tr>
                    <td>직원 이름</td>
                    <td>
                        <input type="text" value="" name="memberName" id="memberNameInput" readonly>
                    </td>
                </tr>
            </table>
            <button type="submit">업데이트</button>
        </form>
    </div>
</div>

<!-- ... (이후 코드) ... -->

</body>
</html>
