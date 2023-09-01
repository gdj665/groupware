<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 리스트</title>

<!-- Bootstrap -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/bootstrap/css/bootstrap.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/font-awesome/css/font-awesome.css">
<!-- Metis core stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
<!-- metisMenu stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/metismenu/metisMenu.css">
<!-- onoffcanvas stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/onoffcanvas/onoffcanvas.css">
<!-- animate.css stylesheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/lib/animate.css/animate.css">
<!--fa -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script>
	less = {
		env: "development",
		relativeUrls: false,
		rootpath: "/assets/"
	};
</script>
<script>
    function changeDepartment(departmentNo) {
        document.location.href = "/board/boardList?departmentNo=" + departmentNo;
    }
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-switcher.css">
<link rel="stylesheet/less" type="text/css" href="${pageContext.request.contextPath}/assets/less/theme.less">
<script src="https://cdnjs.cloudflare.com/ajax/libs/less.js/2.7.1/less.js"></script>


</head>

<body class="  ">
	<div class="bg-dark dk" id="wrap">
		<div id="top">
			<!-- .navbar -->
			<nav class="navbar navbar-inverse navbar-static-top">
				<div class="container-fluid">
					<div class="topnav">
						<!-- 상단 표시버튼 3개 -->
						<div class="btn-group">
							<a data-placement="bottom" data-original-title="E-mail" data-toggle="tooltip"
								class="btn btn-default btn-sm">
								<i class="fa fa-envelope"></i>
								<span class="label label-warning">5</span>
							</a>
							<a data-placement="bottom" data-original-title="Messages" href="#" data-toggle="tooltip"
								class="btn btn-default btn-sm">
								<i class="fa fa-comments"></i>
								<span class="label label-danger">4</span>
							</a>
							<a data-toggle="modal" data-original-title="Help" data-placement="bottom"
								class="btn btn-default btn-sm" href="#helpModal">
								<i class="fa fa-question"></i>
							</a>
						</div>
						<!-- logout버튼 -->
						<div class="btn-group">
							<a href="${pageContext.request.contextPath}/logout" data-toggle="tooltip" data-original-title="Logout"
								data-placement="bottom" class="btn btn-metis-1 btn-sm">
								<i class="fa fa-power-off"></i>
							</a>
						</div>
						<!-- 로그아웃 오른쪽 사이드바 보여주기와 알림창 표시 -->
						<div class="btn-group">
							<!-- 사이드 숨기고 보여주기 -->
							<a data-placement="bottom" data-original-title="Show / Hide Left" data-toggle="tooltip"
								class="btn btn-primary btn-sm toggle-left" id="menu-toggle">
								<i class="fa fa-bars"></i>
							</a>
							<!-- 화면 우측에 알림창 표시 -->
							<a href="#right" data-toggle="onoffcanvas" class="btn btn-default btn-sm"
								aria-expanded="false">
								<span class="fa fa-fw fa-comment"></span>
							</a>
						</div>
					</div><!-- /topnav -->

					<div class="collapse navbar-collapse navbar-ex1-collapse">
						<!-- nav -->
						<ul class="nav navbar-nav">
							<!-- Logo a href 링크 하면 좋을예정 -->
							<li><a href="${pageContext.request.contextPath}/home">홈으로</a></li>
							<!-- 사용시에 활성화 좌측상단 로그 우측에 메뉴 바 기능 -->
							<!-- 
							<li class="active"><a href="table.html">Tables</a></li>
							<li class='dropdown '>
								<a href="#" class="dropdown-toggle" data-toggle="dropdown">
									Form Elements <b class="caret"></b>
								</a>
								<ul class="dropdown-menu">
									<li><a href="form-general.html">General</a></li>
									<li><a href="form-validation.html">Validation</a></li>
									<li><a href="form-wysiwyg.html">WYSIWYG</a></li>
									<li><a href="form-wizard.html">Wizard &amp; File Upload</a></li>
								</ul>
							</li>
							-->
						</ul>
						<!-- /.nav -->
					</div>
				</div>
				<!-- /.container-fluid -->
			</nav>
			<!-- /.navbar 상단바 종료-->
			
		</div>
		<!-- /#top -->
		
		<div id="left">
			<div class="media user-media bg-dark dker">
				<!-- 좌측 사용자 표시 -->
				<div class="user-wrapper bg-dark">
					<a class="user-link" href="">
						<img class="media-object img-thumbnail user-img" alt="User Picture" src="assets/img/user.gif">
						<span class="label label-danger user-label">16</span>
					</a>
					<div class="media-body">
						<h5 class="media-heading">Archie</h5>
						<ul class="list-unstyled user-info">
							<li><a href="">Administrator</a></li>
							<li>Last Access : <br>
								<small><i class="fa fa-calendar"></i>&nbsp;16 Mar 16:32</small>
							</li>
						</ul>
					</div>
				</div><!-- ./user-wrapper bg-dart -->
			</div>
			<!-- #menu -->
			<ul id="menu" class="bg-blue dker">
				<li class="nav-header">Menu</li>
				<!-- 게시판으로 이동 -->
				<li class="">
					<a href="javascript:;">
						<i class="fa-sharp fa-regular fa-pen-to-square"></i>
						<span class="link-title">&nbsp; 게시판</span>
						<span class="fa arrow"></span>
					</a>
					<ul class="collapse">
						<li>
							<a href="${pageContext.request.contextPath}/board/boardList?departmentNo=-1">
							<i class="fa fa-angle-right"></i>&nbsp; 부서 게시판</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/board/boardList?departmentNo=0">
							<i class="fa fa-angle-right"></i>&nbsp; 회사 게시판</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/board/addBoard">
							<i class="fa fa-angle-right"></i>&nbsp; 게시글 작성</a>
						</li>
					</ul>
				</li>
				<!-- 결재로 이동 -->
				<li class="">
					<a href="javascript:;">
						<i class="fa fa-tasks"></i>
						<span class="link-title">&nbsp; 결재</span>
						<span class="fa arrow"></span>
					</a>
					<ul class="collapse">
						<li>
							<a href="${pageContext.request.contextPath}/approval/approvalList">
							<i class="fa fa-angle-right"></i>&nbsp; 결재 리스트</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/approval/addApproval">
							<i class="fa fa-angle-right"></i>&nbsp; 결재 추가</a>
						</li>
					</ul>
				</li>
				<!-- 단일 메뉴 -->
				<li>
					<a href="table.html">
						<i class="fa fa-table"></i>
						<span class="link-title">단일 메뉴</span>
					</a>
				</li>
				<!-- 사이드 바 레벨 -->
				<li>
					<a href="javascript:;">
						<i class="fa fa-code"></i>
						<span class="link-title">
							Unlimited Level Menu
						</span>
						<span class="fa arrow"></span>
					</a>
					<ul class="collapse">
						<li>
							<a href="javascript:;">Level 1 <span class="fa arrow"></span> </a>
							<ul class="collapse">
								<li> <a href="javascript:;">Level 2</a> </li>
								<li> <a href="javascript:;">Level 2</a> </li>
								<li>
									<a href="javascript:;">Level 2 <span class="fa arrow"></span> </a>
									<ul class="collapse">
										<li> <a href="javascript:;">Level 3</a> </li>
										<li> <a href="javascript:;">Level 3</a> </li>
										<li>
											<a href="javascript:;">Level 3 <span class="fa arrow"></span> </a>
											<ul class="collapse">
												<li> <a href="javascript:;">Level 4</a> </li>
												<li> <a href="javascript:;">Level 4</a> </li>
												<li>
													<a href="javascript:;">Level 4 <span class="fa arrow"></span> </a>
													<ul class="collapse">
														<li> <a href="javascript:;">Level 5</a> </li>
														<li> <a href="javascript:;">Level 5</a> </li>
														<li> <a href="javascript:;">Level 5</a> </li>
													</ul>
												</li>
											</ul>
										</li>
										<li> <a href="javascript:;">Level 4</a> </li>
									</ul>
								</li>
								<li> <a href="javascript:;">Level 2</a> </li>
							</ul>
						</li>
						<li> <a href="javascript:;">Level 1</a> </li>
						<li>
							<a href="javascript:;">Level 1 <span class="fa arrow"></span> </a>
							<ul class="collapse">
								<li> <a href="javascript:;">Level 2</a> </li>
								<li> <a href="javascript:;">Level 2</a> </li>
								<li> <a href="javascript:;">Level 2</a> </li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
			<!-- /#menu -->
		</div>
		<!-- /#left -->
		
		<!-- 테이블 시작-->
		<div id="content">
			<div class="outer">
				<div class="inner bg-light lter">
					<!--Begin Datatables-->
					<div class="row">
						<div class="col-lg-12">
							<div class="box">
								<header>
									<h1 style="margin-left:30px;">
										<c:choose>
											<c:when test="${param.departmentNo == -1}">
								                부서 게시판
								            </c:when>
								            <c:when test="${param.departmentNo == 0}">
								                회사 게시판
								            </c:when>
										</c:choose>
									</h1><br>
								</header>
								<div id="collapse4" class="body">
									<table class="table table-striped responsive-table">
										<thead>
											<tr>
												<th>번호</th>
												<th>제목</th>
												<th>내용</th>
												<th>작성자</th>
												<th>생성날짜</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="b" items="${boardList}">
												<tr onClick="location.href='/board/boardOne?boardNo=${b.boardNo}'" style="cursor:pointer;">
													<td>${b.boardNo}</td>
													<td>${b.boardTitle}</td>
													<td>${b.boardContent}</td>
													<td>${b.memberName}</td>
													<td>${b.createdate}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div>
										<form action="${pageContext.request.contextPath}/board/boardList" method="get">
											<input type="text" name="searchWord">
											<input type="hidden" name="departmentNo" value="${param.departmentNo}">
											<button type="submit">검색</button>
										</form>
									</div>
									<c:if test="${currentPage>1}">
										<a href="/board/boardList?currentPage=${currentPage-1}&departmentNo=${param.departmentNo}&searchWord=${param.searchWord}">이전</a>
									</c:if>
									<c:if test="${currentPage<lastPage}">
										<a href="/board/boardList?currentPage=${currentPage+1}&departmentNo=${param.departmentNo}&searchWord=${param.searchWord}">다음</a>
									</c:if>
								</div>
							</div>
						</div>
					</div><!--row -->
				</div><!-- /.inner -->
			</div><!-- /.outer -->
		</div><!-- /#content -->

		<!-- 우상단 메세지 눌럿을 때 알람창 출력 -->
		<div id="right" class="onoffcanvas is-right is-fixed bg-light" aria-expanded=false>
			<a class="onoffcanvas-toggler" href="#right" data-toggle=onoffcanvas aria-expanded=false></a>
			<br>
			<br>
			<div class="alert alert-danger">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong>Warning!</strong> Best check yo self, you're not looking too good.
			</div>
			<!-- .well well-small -->
			<div class="well well-small dark">
				<ul class="list-unstyled">
					<li>Visitor <span class="inlinesparkline pull-right">1,4,4,7,5,9,10</span></li>
					<li>Online Visitor <span class="dynamicsparkline pull-right">Loading..</span></li>
					<li>Popularity <span class="dynamicbar pull-right">Loading..</span></li>
					<li>New Users <span class="inlinebar pull-right">1,3,4,5,3,5</span></li>
				</ul>
			</div>
			<!-- /.well well-small -->
			<!-- .well well-small -->
			<div class="well well-small dark">
				<button class="btn btn-block">Default</button>
				<button class="btn btn-primary btn-block">Primary</button>
				<button class="btn btn-info btn-block">Info</button>
				<button class="btn btn-success btn-block">Success</button>
				<button class="btn btn-danger btn-block">Danger</button>
				<button class="btn btn-warning btn-block">Warning</button>
				<button class="btn btn-inverse btn-block">Inverse</button>
				<button class="btn btn-metis-1 btn-block">btn-metis-1</button>
				<button class="btn btn-metis-2 btn-block">btn-metis-2</button>
				<button class="btn btn-metis-3 btn-block">btn-metis-3</button>
				<button class="btn btn-metis-4 btn-block">btn-metis-4</button>
				<button class="btn btn-metis-5 btn-block">btn-metis-5</button>
				<button class="btn btn-metis-6 btn-block">btn-metis-6</button>
			</div>
			<!-- /.well well-small -->
			<!-- .well well-small -->
			<div class="well well-small dark">
				<span>Default</span><span class="pull-right"><small>20%</small></span>

				<div class="progress xs">
					<div class="progress-bar progress-bar-info" style="width: 20%"></div>
				</div>
				<span>Success</span><span class="pull-right"><small>40%</small></span>

				<div class="progress xs">
					<div class="progress-bar progress-bar-success" style="width: 40%"></div>
				</div>
				<span>warning</span><span class="pull-right"><small>60%</small></span>

				<div class="progress xs">
					<div class="progress-bar progress-bar-warning" style="width: 60%"></div>
				</div>
				<span>Danger</span><span class="pull-right"><small>80%</small></span>

				<div class="progress xs">
					<div class="progress-bar progress-bar-danger" style="width: 80%"></div>
				</div>
			</div>
		</div>
		<!-- /#right -->
	</div>
	<!-- /#wrap -->
	
	
	<footer class="Footer bg-dark dker">
		<p>2023 &copy; 구슬</p>
	</footer>
	<!-- /#footer -->
	
	<!-- #helpModal -->
	<div id="helpModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<div class="modal-body">
					<p>
						Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut
						labore
						et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
						ut
						aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
						cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
						culpa qui officia deserunt mollit anim id est laborum.
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- /#helpModal -->
	
	
<!--jQuery -->
<script src="${pageContext.request.contextPath}/assets/lib/jquery/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/js/jquery.dataTables.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/js/dataTables.bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.26.6/js/jquery.tablesorter.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
<!--Bootstrap -->
<script src="${pageContext.request.contextPath}/assets/lib/bootstrap/js/bootstrap.js"></script>
<!-- MetisMenu -->
<script src="${pageContext.request.contextPath}/assets/lib/metismenu/metisMenu.js"></script>
<!-- onoffcanvas -->
<script src="${pageContext.request.contextPath}/assets/lib/onoffcanvas/onoffcanvas.js"></script>
<!-- Screenfull -->
<script src="${pageContext.request.contextPath}/assets/lib/screenfull/screenfull.js"></script>
<!-- Metis core scripts -->
<script src="${pageContext.request.contextPath}/assets/js/core.js"></script>
<!-- Metis demo scripts -->
<script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
<script>
	$(function () {
		Metis.MetisTable();
		Metis.metisSortable();
	});
</script>
<!-- 화면 우측에서 나와서 사이드 바 색변경 가능 -->
<script src="${pageContext.request.contextPath}/assets/js/style-switcher.js"></script>
</body>
</html>