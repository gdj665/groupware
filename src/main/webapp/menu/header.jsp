<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />

</head>
<body>
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
						<!-- <div class="notification bg-primary rounded-circle"></div> -->
					</a>
				</li>
			</ul>
			<div class="navbar-collapse justify-content-end px-0" id="navbarNav">
				<ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
					<li class="nav-item dropdown">
						<a class="nav-link nav-icon-hover" href="javascript:void(0)" id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
							<img src="${pageContext.request.contextPath}/assets/images/profile/user.jpeg" alt="" width="35" height="35" class="rounded-circle">
						</a>
						<div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up" aria-labelledby="drop2">
							<div class="message-body">
								<!-- 마이페이지 -->
								<a href="${pageContext.request.contextPath}/group/member/mypage?memberId=${memberId}" class="d-flex align-items-center gap-2 dropdown-item" >
									<i class="ti ti-user fs-6"></i>My Page
								</a> 
								<a href="${pageContext.request.contextPath}/group/address/addressList" class="d-flex align-items-center gap-2 dropdown-item">
									<i class="ti ti-mail fs-6"></i>My Account
								</a>
								<!-- 로그아웃 -->
								<a href="${pageContext.request.contextPath}/group/logout" class="btn btn-outline-primary mx-3 mt-2 d-block">Logout</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</nav>
	</header>
	<!--  Header End -->
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>	
</html>