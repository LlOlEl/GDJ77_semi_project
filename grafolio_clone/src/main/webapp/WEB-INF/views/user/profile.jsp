<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

 <jsp:include page="../layout/header.jsp">
   <jsp:param value="Profile" name="title"/>
 </jsp:include>
 
 <link rel="stylesheet" href="${contextPath}/resources/css/profile.css?dt=${dt}">
 
 <!-- 유저 프로필 및 배경사진 -->
 <div class="profile-top" id="profile-top">
 
   <div class="profile-cover-wrap">
   	 <div class="profile-cover-image">
   	 	<img class="default-cover-image" alt="default-mage" src="../resources/img/default_cover.png">
   	 </div>
   </div>
   
   <div class="user-wrap">
   	
   	<div class="user-head">
      <div class="user-avatar">
       <div class="profile-image">
       	 <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png">
       </div>
      </div>
   	</div>
   	
   	<div class="user-body">
   	  <span class="user-nickname">${profile.name}</span>
   	<div class="user-category">${profile.profileCategory}</div> <!-- 유저가 선택한 태그(사진, 일러스트 등) -->
   	<div class="user-description">${profile.descript}</div> <!-- 유저 프로필 설명 -->
    <div>
    <c:if test="${sessionScope.user.userNo != profile.userNo}">
      <button type="button" id="btn-follow" data-follow-no="${profile.userNo}">팔로우하기</button>
    </c:if>
    <c:if test="${sessionScope.user.userNo == profile.userNo}">
      <button type="button" id="btn-modify" data-follow-no="${profile.userNo}">기본정보수정</button>
    </c:if>
    
    </div>
   	
   	<div class="user-statistic-wrap">
   	  <div class="user-static">
   	  	<span class="txt-card-count">1</span>
   	  	<span>좋아요</span>
   	  </div>
   	  <div class="user-static">
   	  	<span class="txt-card-count">1</span>
   	  	<span>팔로잉</span>
   	  </div>
   	  <div class="user-static">
   	  	<span class="txt-card-count">1</span>
   	  	<span>팔로워</span>
   	  </div>
   	  <div class="user-static">
   	  	<span class="txt-card-count">1</span>
   	  	<span>조회수</span>
   	  </div>
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

const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}

/* 팔로잉 */
const fnFollwing = () => {
	$('#btn-follow').on('click', (evt) => {
		
		console.log('클릭');
		
		// 팔로우를 신청받은 user의 userNo 전송
		fetch(fnGetContextPath() + '/user/follow.do', {
			method: 'POST',
			headers: {
			  'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				'toUser': evt.target.dataset.followNo
			})
		})
		.then(response=> response.json())
		.then(resData=> {
		  console.log(resData);
		})
	})
}

fnFollwing();
</script>
 
 
 
 
 
 
<%@ include file="../layout/footer.jsp" %>