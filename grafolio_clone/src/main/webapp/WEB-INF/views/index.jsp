<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

 <jsp:include page="./layout/header.jsp">
   <jsp:param value="main" name="title"/>
 </jsp:include>
 
  <h1 class="title">Welcome to grafolioclone</h1>
  
  <!-- profile.jsp로 이동 -->
  
  <script>

  // 헤더 프로필 이미지 경로 변경
  const profileImage = () => {
    $('.default-profile-image').attr('src', './resources/img/default_profile_image.png');
  }  
  
  profileImage();
  
  </script>
  
  
 
<%@ include file="./layout/footer.jsp" %>