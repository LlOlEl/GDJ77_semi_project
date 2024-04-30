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
<div class="content profile" data-user-no="${sessionScope.user.userNo}">
  <div class="page">
    <div class="page-content">
       <div class="profile-page">
         <div class="profil-wrap">
           <div class="profile-top" id="profile-top" >
           
             <div class="profile-cover-wrap">
               <div class="profile-cover-image">
                  <c:if test="${profile.mainProfilePicturePath != null}">
                   ${profile.mainProfilePicturePath}
                  </c:if>
                  <c:if test="${profile.mainProfilePicturePath == null}">
                   <img class="default-cover-image" alt="default-image" src="../resources/img/default_cover.png">
                  </c:if>
               </div>
             </div>
             
             <div class="user-wrap">
              
              <div class="user-head">
                <div class="user-avatar">
                 <div class="profile-image-wrap">
                  <div class="profile-image-wrapper profile-image-xlarge profile-bordered">
                    <c:if test="${profile.miniProfilePicturePath != null}">
                     ${profile.miniProfilePicturePath}
                    </c:if>
                    <c:if test="${profile.miniProfilePicturePath == null}">
                     <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png"  width="75">
                    </c:if>
                  </div>
                 </div>
                </div>
              </div>
              
              <div class="user-body" data-user-no="${profile.userNo}">
                <span class="user-nickname">${profile.name}</span>
              <div class="user-category">${profile.profileCategory}</div> <!-- 유저가 선택한 태그(사진, 일러스트 등) -->
              <div class="user-description">${profile.descript}</div> <!-- 유저 프로필 설명 -->
              <div class="user-buttons">
                <c:if test="${sessionScope.user.userNo != profile.userNo}">
                <div class="change-btn">
                  <button type="button" class="profile-btn" id="btn-follow" data-user-no="${profile.userNo}">팔로우하기</button>
                </div>
                </c:if>
                <c:if test="${sessionScope.user.userNo == profile.userNo}">
                  <button type="button" class="profile-btn" id="btn-modify" data-user-no="${profile.userNo}">기본정보수정</button>
                  <input type="hidden" class="modify" data-modify-result="${modifyResult}">
                </c:if>
              </div>
              
              
              <div class="user-statistic-wrap">
                <div class="user-statistic">
                  <span class="txt-card-count">0</span>
                  <span class="txt-card-name">좋아요</span>
                </div>
                <div class="user-statistic">
                  <span class="txt-card-count">0</span>
                  <span class="txt-card-name">팔로잉</span>
                </div>
                <div class="user-statistic">
                  <span class="txt-card-count">0</span>
                  <span class="txt-card-name">팔로워</span>
                </div>
                <div class="user-statistic">
                  <span class="txt-card-count">0</span>
                  <span class="txt-card-name">조회수</span>
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
         
           <div class="profile-bottom">
             <div class="list no-head">
               <div class="list-head"></div>
               <ul class="list-body">
               </ul>
             </div>
           </div>
         </div> 
       </div>
    </div>
  </div>
</div>
   
 <!-- 팔로잉, 팔로워 리스트 모달창 -->
 <div class="modal-outer user-list-modal">
   <div class="modal-overlay"></div>
   <div class="modal medium">
     
     <!-- model 창 head 부분 -->
     <div class="modal-head action">
       <!-- 팔로잉 유저 수 -->
       <h1 class="modal-title">팔로잉</h1>
       <div class="user-list-modal-head">
         <span class="count">총 <span class="count-detail"></span>명</span>
       </div>
     </div>
     
     <!-- modal 창 body 부분 -->
     <div class="modal-body">
       <div class="user-list-modal">
         <ul class="list chow-scrollbar"></ul>
         <div class="button-wrapper confirm">
           <button class="btn-confirm">
             <div class="btn-text">확인</div>
           </button>
         </div>
       </div>
     </div>
   </div>
 </div>
 
<script src="${contextPath}/resources/js/profile.js?dt=${dt}"></script>

<script>

</script>
 
<%@ include file="../layout/footer.jsp" %>