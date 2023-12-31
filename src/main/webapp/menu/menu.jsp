<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Modernize Free</title>

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
          <a href="${pageContext.request.contextPath}/group/home" class="text-nowrap logo-img">
            <img src="${pageContext.request.contextPath}/assets/images/logos/logo.png" width="180" alt="" />
          </a>
          <div class="close-btn d-xl-none d-block sidebartoggler cursor-pointer" id="sidebarCollapse">
            <i class="ti ti-x fs-8"></i>
          </div>
        </div>
        <!-- Sidebar navigation-->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar="">
          <ul id="sidebarnav">
          <!-- 메인 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">Home</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/home" aria-expanded="false">
                <span>
                  <i class="ti ti-home"></i>
                </span>
                <span class="hide-menu">메인화면</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/member/workResister" aria-expanded="false">
                <span>
                  <i class="ti ti-stretching"></i>
                </span>
                <span class="hide-menu">근태</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/member/workCheck" aria-expanded="false">
                <span>
                  <i class="ti ti-report"></i>
                </span>
                <span class="hide-menu">근태관리</span>
              </a>
            </li>
            <!-- 공지 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">공지</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/board/boardList?departmentNo=0" aria-expanded="false">
                <span>
                  <i class="ti ti-speakerphone"></i>
                </span>
                <span class="hide-menu">공지사항</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/board/boardList?departmentNo=-1" aria-expanded="false">
                <span>
                  <i class="ti ti-news"></i>
                </span>
                <span class="hide-menu">부서게시판</span>
              </a>
            </li>
           
            <!-- 일정 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">일정관리</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/schedule/scheduleList" aria-expanded="false">
                <span>
                  <i class="ti ti-calendar"></i>
                </span>
                <span class="hide-menu">일정</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomList" aria-expanded="false">
                <span>
                  <i class="ti ti-category"></i>
                </span>
                <span class="hide-menu">회의실 목록</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationList" aria-expanded="false">
                <span>
                  <i class="ti ti-clock-edit"></i>
                </span>
                <span class="hide-menu">회의실 예약</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/meetingroom/meetingroomReservationHistory" aria-expanded="false">
                <span>
                  <i class="ti ti-clipboard-list"></i>
                </span>
                <span class="hide-menu">회의실 예약내역</span>
              </a>
            </li>
            
            <!-- 결재 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">결재</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/approval/approvalList" aria-expanded="false">
                <span>
                  <i class="ti ti-file-check"></i>
                </span>
                <span class="hide-menu">결재관리</span>
              </a>
            </li>
           
            <!-- 장비 자재 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">장비 및 자재</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/equipment/equipmentList" aria-expanded="false">
                <span>
                  <i class="ti ti-axe"></i>
                </span>
                <span class="hide-menu">장비 목록</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/fixtures/fixturesList" aria-expanded="false">
                <span>
                  <i class="ti ti-ballpen"></i>
                </span>
                <span class="hide-menu">자재 목록</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/eqHistory/eqHistoryList" aria-expanded="false">
                <span>
                  <i class="ti ti-checkup-list"></i>
                </span>
                <span class="hide-menu">개인 장비사용내역</span>
              </a>
            </li>
            <!-- as -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">AS</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/repair/addRepairForm" aria-expanded="false">
                <span>
                  <i class="ti ti-pencil-plus"></i>
                </span>
                <span class="hide-menu">AS추가</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/repair/repairList?repairStatus=대기중" aria-expanded="false">
                <span>
                  <i class="ti ti-loader"></i>
                </span>
                <span class="hide-menu">대기</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/repair/repairList?repairStatus=수리중" aria-expanded="false">
                <span>
                  <i class="ti ti-hammer"></i>
                </span>
                <span class="hide-menu">수리중</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/repair/repairList?repairStatus=수리완료" aria-expanded="false">
                <span>
                  <i class="ti ti-checklist"></i>
                </span>
                <span class="hide-menu">완료</span>
              </a>
            </li>
            <!-- 부서 및 인사 -->
            <li class="nav-small-cap">
              <i class="ti ti-dots nav-small-cap-icon fs-4"></i>
              <span class="hide-menu">부서 및 인사관리</span>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/department/departmentList" aria-expanded="false">
                <span>
                  <i class="ti ti-friends"></i>
                </span>
                <span class="hide-menu">부서관리</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/hrm/hrmList" aria-expanded="false">
                <span>
                  <i class="ti ti-accessible"></i>
                </span>
                <span class="hide-menu">인사관리</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a class="sidebar-link" href="${pageContext.request.contextPath}/group/address/addressList" aria-expanded="false">
                <span>
                  <i class="ti ti-address-book"></i> 
                </span>
                <span class="hide-menu">주소록</span>
              </a>
            </li>
          </ul>
          <br>
          <br>
          <br>
          
        </nav>
        <!-- End Sidebar navigation -->
      </div>
      <!-- End Sidebar scroll-->
    </aside>
    <!--  Sidebar End -->
    <!--  Main wrapper -->
</body>
<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>

</html>