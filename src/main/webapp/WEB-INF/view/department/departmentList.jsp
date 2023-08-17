<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<style>
/* 스타일 내용은 그대로 유지합니다. */

/* 추가한 스타일 */
.container-wrapper {
    display: flex;
    align-items: center; /* 수직 가운데 정렬 */
}

.container {
    flex: 1;
    margin-right: 10px;
    border: 1px solid #ccc; /* 태두리 선 추가 */
    display: flex;
    justify-content: center; /* 수평 가운데 정렬 */
    align-items: center; /* 수직 가운데 정렬 */
}

.container:nth-child(2) {
    flex: 0.1; /* 두 번째 컨테이너 크기 10%로 조정 */
    border: none; /* 두 번째 컨테이너의 태두리 제거 */
    display: flex;
    justify-content: center;
    align-items: center;
}

.arrow-buttons {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%;
    align-items: center; /* 수직 가운데 정렬 */
}

.arrow-buttons button {
    border: none;
    background-color: transparent;
    cursor: pointer;
}

.arrow-buttons button:hover {
    color: blue;
}

/* 추가한 스타일 */
ul.sub-list {
    display: none; /* 최초에 숨김 */
}

ul.sub-list.active {
    display: block; /* 활성화시 표시 */
}
</style>
</head>
<script>
    $(document).ready(function(){
        // 부서 선택시 팀 리스트 출력
        $('#bigDepartment').change(function(){
            if ($('#bigDepartment').val() == '') {
                $('#littleDepartment').empty();
                $('#littleDepartment').append('<option value="">==팀 선택==</option>');
            } else {
                $.ajax({
                    url: '/rest/departmentList',
                    type: 'get',
                    success: function(model) {
                        $('#littleDepartment').empty();
                        $('#littleDepartment').append('<option value="">==팀 선택==</option>');
                        model.forEach(function(item, index) {
                            $('#littleDepartment').append('<option value="' + item.departmentId + '">' + item.departmentId + '</option>');
                        });
                    }
                });
            }
        });

        // ul li 숨기고 보이는 기능
        $('.toggle-link').click(function(e) {
            e.preventDefault();
            $(this).siblings('.sub-list').toggleClass('active');
        });

        // ul 숨기고 보이는 기능
        $('ul.main-list').addClass('active'); // 최초에 보이도록 설정

        $('a.toggle-link').click(function(e) {
            e.preventDefault();
            $(this).parent('li').children('ul.sub-list').toggleClass('active');
        });
    });
</script>
<body>
    <h1>부서관리</h1>
    <div>
        <a href="/department/addDepartment">부서추가</a>
    </div>
    <div class="container-wrapper">
        <div class="container">
            <div>
                <ul class="main-list">
                    <li>
                        <!-- 최상위 회사 --> <a href="#" class="toggle-link">회사</a>
                        <ul class="sub-list">
                            <c:forEach var="d" items="${departmentList}">
                                <c:if test="${d.departmentParentId eq 'test'}">
                                    <li><a href="#" class="toggle-link">${d.departmentId}</a>
                                        <ul class="sub-list">
                                            <c:forEach var="a" items="${memberList}">
                                                <c:if test="${d.departmentNo eq a.departmentNo}">
                                                    <li><label> <input type="checkbox"
                                                            class="member-checkbox">${a.memberName}
                                                    </label></li>
                                                </c:if>
                                            </c:forEach>
                                            <c:forEach var="c" items="${departmentList}">
                                                <c:if test="${d.departmentId eq c.departmentParentId}">
                                                    <li><a href="#" class="toggle-link">${c.departmentId}</a>
                                                        <ul class="sub-list">
                                                            <c:forEach var="t" items="${memberList}">
                                                                <c:if test="${c.departmentNo eq t.departmentNo}">
                                                                    <li><label> <input type="checkbox"
                                                                            class="member-checkbox">${t.memberName}
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
            <table>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="bigDepartment" id="bigDepartment">
                            <option value="">==부서 선택==</option>
                            <option value="인사부">인사 부</option>
                            <option value="서비스부">서비스 부</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>팀</td>
                    <td>
                        <select name="littleDepartment" id="littleDepartment">
                            <option value="">== 선택==</option>
                        </select>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script>
        // 새로운 스크립트 추가
        const toggleLinks = document.querySelectorAll(".toggle-link");

        toggleLinks.forEach(link => {
            link.addEventListener("click", function(event) {
                event.preventDefault();
                const subList = this.nextElementSibling;
                subList.classList.toggle("active");
            });
        });

        const leftArrowButton = document.getElementById("leftArrowButton");
        const rightArrowButton = document.getElementById("rightArrowButton");

        leftArrowButton.addEventListener("click", function() {
            // 왼쪽 화살표 버튼 동작 구현
        });

        rightArrowButton.addEventListener("click", function() {
            // 오른쪽 화살표 버튼 동작 구현
        });
    </script>
</body>
</html>
