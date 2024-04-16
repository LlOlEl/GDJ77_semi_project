<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

 <jsp:include page="../layout/header.jsp">
   <jsp:param value="Profile" name="title"/>
 </jsp:include>
 
 
 <!-- 유저 프로필 및 배경사진 -->
 <div class="profile-top" id="profile-top" data-user-no="${sessionScope.user.userNo}">
 
   <div class="profile-cover-wrap">
   	 <div class="profile-cover">
   	 	<!-- 배경 이미지 넣기-->
   	 </div>
   </div>
   
   <div class="user-wrap">
   	
   	<div class="user-head">
      <div class="user-avatar">
       <div class="profile-image-wrap">
       	<!-- 프로필 이미지 넣기-->
       </div>
      </div>
   	</div>
   	
   	<div class="user-body">
   	  <span class="user-nickname">${profileList.name}</span>
   	</div>
   	<div class="user-type"></div> <!-- 유저가 선택한 태그(사진, 일러스트 등) -->
   	<div class="user-description">${profileList.describe}</div> <!-- 유저 프로필 설명 -->
    <div>
  	 <button type="button" id="btn-follow">팔로우하기</button>
    </div>
   	
   	<div class="user-statistic">
   	  <div>
   	  	<span></span>
   	  	<span>좋아요</span>
   	  </div>
   	  <div>
   	  	<span></span>
   	  	<span>팔로잉</span>
   	  </div>
   	  <div>
   	  	<span></span>
   	  	<span>팔로워</span>
   	  </div>
   	  <div>
   	  	<span></span>
   	  	<span>조회수</span>
   	  </div>
   	</div>
   </div>
 </div>
 
 <!-- 메뉴 선택 -->
 <ul class="tab-list">
   <li class="list-item"><a>업로드한 프로젝트</a></li>
   <li class="list-item"><a>좋아요</a></li>
 </ul>
 
 <!-- 업로드한 프로젝트 및 좋아요 -->
   <div id="post-list"></div>
   
<script>

// 유저 번호
  

</script>
 
 
 
 
 
 
<%@ include file="../layout/footer.jsp" %>