<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 페이지마다 다른 제목 -->
<title>
  <c:choose>
    <c:when test="${empty param.title}">Welcome</c:when>
    <c:otherwise>${param.title}</c:otherwise>
  </c:choose>
</title>

<!-- include moment js -->
<script src="${contextPath}/resources/moment/moment-with-locales.min.js"></script>

<!-- include libraries(jquery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- include summernote css/js -->
<link rel="stylesheet" href="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.css">
<script src="${contextPath}/resources/summernote-0.8.18-dist/summernote.min.js"></script>
<script src="${contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>

<!-- include custom css/js -->
<link rel="stylesheet" href="${contextPath}/resources/css/header.css?dt=${dt}">
<link rel="stylesheet" href="${contextPath}/resources/css/init.css?dt=${dt}">

</head>
<body>

  <div class="header-wrap">
  
    <div class="header-left" >
      <div class="logo">
          <div class="header-brand" >
            <a href="${contextPath}" class="logo-wrapper" >
              <img src="${contextPath}/resources/svg/header_logo.svg" alt="Logo">
            </a>
          </div>
      </div>
      <div class="header-menus">
        <div class="header-menu">
          <a href="${contextPath}/post/list.page">프로젝트</a>
        </div>
        <div class="hedaer-menu">
          <div class="profile" data-user-no="${sessionScope.user.userNo}">마이페이지</div>
        </div>
        <div class="hedaer-menu">
          <a href="${contextPath}/user/creators.page">크리에이터</a>
        </div>
      </div>
    </div>
    
    <div class="hedaer-right">
      <div class="user-wrap">
        <!-- Sign In 안 된 경우 -->
        <c:if test="${sessionScope.user == null}">  
          <a href="${contextPath}/user/signin.page"><i class="fa-solid fa-arrow-right-to-bracket"></i>Sign In</a>
          <a href="${contextPath}/user/signup.page"><i class="fa-solid fa-user-plus"></i>Sign Up</a>
        </c:if>
        <!-- Sign In 된 경우 -->
        <c:if test="${sessionScope.user != null}">
          <a href="${contextPath}/post/write.page">프로젝트 올리기</a>
          ${sessionScope.user.name}님 반갑습니다
          <a href="${contextPath}/user/signout.do"><i class="fa-solid fa-arrow-right-from-bracket"></i>Sign Out</a>
          <a href="${contextPath}/user/leave.do"><i class="fa-solid fa-user-minus"></i>회원탈퇴</a>
        </c:if>
      </div>
    </div>

    
  </div>

  <div class="main-wrap">
  
  
  <script>
  
  const fnGetProfile = () => {
  	$('.profile').on('click', (evt) => {
  		if(evt.target.dataset.userNo === '') {
	  		console.log(evt.target.dataset.userNo);
	  		location.href="${contextPath}/user/profile.do?userNo=" + 1;
  		} else {
  	  		console.log(evt.target.dataset.userNo);
  	  		location.href="${contextPath}/user/profile.do?userNo=" + evt.target.dataset.userNo;
  		}

  	})
  }
  
  
  fnGetProfile();
  
  
  </script>
  
  
  
  