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
  
  <div class="profile-test" data-user-no="2">유저프로필 테스트</div>
  
  <script>
    
    const fnGetProfile = () => {
    	$('.profile-test').on('click', (evt) => {
    		console.log(evt.target.dataset.userNo);
    		location.href="${contextPath}/user/profile.do?userNo=" + evt.target.dataset.userNo;
    	})
    }
    fnGetProfile();
    
  </script>
  
  
  <!-- profile.jsp로 이동 -->
  
  
  
<%@ include file="./layout/footer.jsp" %>