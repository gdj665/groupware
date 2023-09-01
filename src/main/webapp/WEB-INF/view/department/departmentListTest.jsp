<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modernize Free</title>
  <link rel="shortcut icon" type="image/png" href="../assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="../assets/css/styles.min.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
</head>

<body>
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <!-- Sidebar Start -->
    <aside class="left-sidebar">
      <!-- Sidebar scroll-->
      <div>
        <div class="brand-logo d-flex align-items-center justify-content-between">
          <a href="./index.html" class="text-nowrap logo-img">
            <img src="../assets/images/logos/dark-logo.svg" width="180" alt="" />
          </a>
          <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
          </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
          <ul id="sidebarnav">
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">Home</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./index.html" aria-expanded="false">
                <span>
                  <i class="ti ti-layout-dashboard"></i>
                </span>
                <span class="hide-menu">Dashboard</span>
              </a>
            </li>
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">UI COMPONENTS</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-buttons.html" aria-expanded="false">
                <span>
                  <i class="ti ti-article"></i>
                </span>
                <span class="hide-menu">Buttons</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-alerts.html" aria-expanded="false">
                <span>
                  <i class="ti ti-alert-circle"></i>
                </span>
                <span class="hide-menu">Alerts</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-card.html" aria-expanded="false">
                <span>
                  <i class="ti ti-cards"></i>
                </span>
                <span class="hide-menu">Card</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-forms.html" aria-expanded="false">
                <span>
                  <i class="ti ti-file-description"></i>
                </span>
                <span class="hide-menu">Forms</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./ui-typography.html" aria-expanded="false">
                <span>
                  <i class="ti ti-typography"></i>
                </span>
                <span class="hide-menu">Typography</span>
              </a>
            </li>
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">AUTH</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./authentication-login.html" aria-expanded="false">
                <span>
                  <i class="ti ti-login"></i>
                </span>
                <span class="hide-menu">Login</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./authentication-register.html" aria-expanded="false">
                <span>
                  <i class="ti ti-user-plus"></i>
                </span>
                <span class="hide-menu">Register</span>
              </a>
            </li>
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">EXTRA</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./icon-tabler.html" aria-expanded="false">
                <span>
                  <i class="ti ti-mood-happy"></i>
                </span>
                <span class="hide-menu">Icons</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="./sample-page.html" aria-expanded="false">
                <span>
                  <i class="ti ti-aperture"></i>
                </span>
                <span class="hide-menu">Sample Page</span>
              </a>
            </li>
          </ul>
          <div class="unlimited-access hide-menu bg-light-primary position-relative mb-7 mt-5 rounded">
            <div class="d-flex">
              <div class="unlimited-access-title me-3">
                <h6 class="fw-semibold fs-4 mb-6 text-dark w-85">Upgrade to pro</h6>
                <a href="https://adminmart.com/product/modernize-bootstrap-5-admin-template/" target="_blank" class="btn btn-primary fs-2 fw-semibold lh-sm">Buy Pro</a>
              </div>
              <div class="unlimited-access-img">
                <img src="../assets/images/backgrounds/rocket.png" alt="" class="img-fluid">
              </div>
            </div>
          </div>
        </nav>
        <!-- End Sidebar navigation -->
      </div>
      <!-- End Sidebar scroll-->
    </aside>
    <!--  Sidebar End -->
    <!--  Main wrapper -->
    <div class="body-wrapper">
      <!--  Header Start -->
      <header class="app-header">
        <nav class="navbar navbar-expand-lg navbar-light">
          <ul class="navbar-nav">
            <li class="nav-item d-block d-xl-none">
              <a class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse" href="javascript:void(0)">
                <i class="ti ti-menu-2"></i>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link nav-icon-hover" href="javascript:void(0)">
                <i class="ti ti-bell-ringing"></i>
                <div class="notification bg-primary rounded-circle"></div>
              </a>
            </li>
          </ul>
          <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
              <a href="https://adminmart.com/product/modernize-free-bootstrap-admin-dashboard/" target="_blank" class="btn btn-primary">Download Free</a>
              <li class="nav-item dropdown">
                <a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown"
                  aria-expanded="false">
                  <img src="../assets/images/profile/user-1.jpg" alt="" width="35" height="35" class="rounded-circle">
                </a>
                <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
                  <div class="message-body">
                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                      <i class="ti ti-user fs-6"></i>
                      <p class="mb-0 fs-3">My Profile</p>
                    </a>
                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                      <i class="ti ti-mail fs-6"></i>
                      <p class="mb-0 fs-3">My Account</p>
                    </a>
                    <a href="javascript:void(0)" class="d-flex align-items-center gap-2 dropdown-item">
                      <i class="ti ti-list-check fs-6"></i>
                      <p class="mb-0 fs-3">My Task</p>
                    </a>
                    <a href="./authentication-login.html" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </nav>
      </header>
      <!--  Header End -->
      <div class="container-fluid">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
              <h1 class="text-center mt-4">부서관리</h1>
<div class="text-center mt-3">
<!-- "부서추가" 버튼 -->
<button id="addDepartmentLink" class="btn btn-primary">부서추가</button>
<!-- "부서삭제" 버튼 -->
<button id="deleteDepartmentLink" class="btn btn-primary">부서삭제</button>

</div>
<div class="container-wrapper">
    <div class="container">
  		<h5>이동할 사원 선택</h5>
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
        <h5>이동할 부서 선택</h5>
        <form id="updateForm" action="/department/updateDepartment" method="post">
            <table>
                <tr>
                    <td>부서</td>
                    <td>
                        <select name="bigDepartment" id="bigDepartment">
                            <option value="">===   부서 선택   ===</option>
                            <option value="100">인사 부</option>
                            <option value="200">서비스 부</option>
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
<!-- 부서 추가 모달창 html -->

<div class="modal">
	<div class="modal_content">
		<h3>부서 추가</h3>
		<form id="addDepartmentForm" action="${pageContext.request.contextPath}/department/addDepartment" method="post">
			<table>
				<tr>
					<td>부서목록</td>
					<td>
						<select name="departmentParentNo" id="addDepartmentId">
                            <option value="">===   부서 선택   ===</option>
                            <option value="100">인사 부</option>
                            <option value="200">서비스 부</option>
                        </select>
                        <span id="addDepartmentParentMsg" class="msg"></span>
					</td>
				</tr>
				<tr>
					<td>추가할 부서 이름</td>
					<td>
						<input id="addDepartmentId" type="text" name="departmentId">
						<span id="addDepartmentIdMsg" class="msg"></span>
					</td>
				</tr>
			</table>
		</form>
			<button id="addDepartmentBtn" type="button">추가</button>
			<button id="close" type="button">닫기</button>
	</div>
</div>
<!-- 부서 삭제 모달창 html -->
<div class="modal2">
	<div class="modal_content2">
		<h3>부서 삭제</h3>
		<h6>부서 삭제를 하시려면 부서인원을 모두 이동 후 삭제가능합니다.</h6>
		<form id="deleteDepartmentForm" action="${pageContext.request.contextPath}/department/deleteDepartment" method="post">
			<table>
				<tr>
					<td>삭제 가능 부서 목록</td>
				</tr>
				<c:forEach var="od" items="${getDeleteOnDepartmentList}">
				<tr>
					<td><input type="checkbox" value="${od.departmentNo}" name="departmentNo">&nbsp;&nbsp;&nbsp; ${od.departmentNo}</td>
					<td>${od.departmentId}</td>
				</tr>
				</c:forEach>
			</table>	
		</form>
		<button id="deleteDepartmentBtn" type="button">삭제</button>
		<button id="close2" type="button">닫기</button>
	</div>
</div>
<script src="${pageContext.request.contextPath}/javascript/department.js"></script>
              
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="../assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/js/sidebarmenu.js"></script>
  <script src="../assets/js/app.min.js"></script>
  <script src="../assets/libs/simplebar/dist/simplebar.js"></script>
</body>

</html>