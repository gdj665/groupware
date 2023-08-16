<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.container {
  width: 45%;
  border: 2px solid #000;
  box-sizing: border-box;
  display: inline-block;
  margin: 10px;
  overflow: hidden;
}

.independent-container {
  background-color: lightgray;
}

.container-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
}

.content {
  padding: 10px;
}

/* Main list style */
.main-list {
  list-style-type: none;
  padding-left: 0;
}

/* Sub list style */
.sub-list {
  list-style-type: none;
  padding-left: 20px;
  margin-top: 10px;
}

/* Remove bullet points from list items */
.main-list li,
.sub-list li {
  list-style: none;
  margin: 0;
  padding: 0;
  position: relative;
}

/* Style for list item links */
.main-list a,
.sub-list a {
  text-decoration: none;
  color: #333;
  display: block;
  padding: 5px 0;
}

/* Hover effect for list item links */
.main-list a:hover,
.sub-list a:hover {
  background-color: #f0f0f0;
}

/* Disable text selection and cursor for li elements */
.main-list li,
.sub-list li {
  user-select: none;
  cursor: default;
}

/* Disable content editing */
.content[contenteditable="true"] {
  background-color: white;
  outline: none;
  border: none;
}

</style>
</head>
<body>
  <h1>부서관리</h1>
  <div>
    <a href="/department/addDepartment">부서추가</a>
  </div>
  <div class="container-wrapper">
    <div class="container">
      <div class="content">
        <ul class="main-list">
          <c:forEach var="d" items="${departmentList}">
            <c:if test="${d.departmentParentId eq 'test'}">
              <li>
                <a href="#">${d.departmentId}</a>
                <ul class="sub-list">
                  <c:forEach var="c" items="${departmentList}">
                    <c:if test="${d.departmentId eq c.departmentParentId}">
                      <li>
                        <a href="#">${c.departmentId}</a>
                      </li>
                    </c:if>
                  </c:forEach>
                </ul>
              </li>
            </c:if>
          </c:forEach>
        </ul>
      </div>
    </div>
    <div class="container independent-container">
      <!-- 컨테이너 2 내용 -->
    </div>
  </div>
  <script>
    function adjustContainerSize(element) {
      const container = element.parentElement;
      container.style.height = element.scrollHeight + 'px';
    }
  </script>
</body>
</html>
