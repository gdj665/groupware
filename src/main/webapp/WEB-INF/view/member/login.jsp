<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login</title>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/logos/favicon.png" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/styles.min.css" />
</head>

<body>
  <!--  Body Wrapper -->
  <div class="page-wrapper" id="main-wrapper" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full"
    data-sidebar-position="fixed" data-header-position="fixed">
    <div
      class="position-relative overflow-hidden radial-gradient min-vh-100 d-flex align-items-center justify-content-center">
      <div class="d-flex align-items-center justify-content-center w-100">
        <div class="row justify-content-center w-100">
          <div class="col-md-8 col-lg-6 col-xxl-3">
            <div class="card mb-0">
              <div class="card-body">
                <a class="text-nowrap logo-img text-center d-block py-3 w-100">
                  <img src="${pageContext.request.contextPath}/assets/images/logos/dark-logo.svg" width="180" alt="">
                </a>
                <form action="${pageContext.request.contextPath}/group/login" method="post" id="loginForm">
                  <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="memberId" aria-describedby="emailHelp" name="memberId" value="${saveLoginId}">
                  </div>
                  <div class="mb-4">
                    <label for="exampleInputPassword1" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="memberPw" name="memberPw">
                  </div>
                  <div class="d-flex align-items-center justify-content-between mb-4">
                    <div class="form-check">
                      <input class="form-check-input primary" type="checkbox" name="saveId" ${saveId}>
                      <label class="form-check-label text-dark" for="flexCheckChecked">
                        아이디 저장
                      </label>
                    </div>
                  </div>
                  <button type="button" id="loginBtn" class="btn btn-primary w-100 py-8 fs-4 mb-4 rounded-2">Sign In</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/javascript/login.js"></script>
</body>

</html>