<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="../layout/header.jsp">
  <jsp:param value="Modify" name="title"/>
</jsp:include>
 
<div class="m-3">   <!-- signup.jsp 와 이 부분 수정할지 확인하기 -->

  <form method="POST"
        action="${contextPath}/user/modify.do"
        id="frm-modify">
        
	  <div class="profile_picture">
	   <div class="main">
	     <c:if test="${profile.mainProFilePicutrePath == ''}">
	       <img src="${contextPath}/resources/img/default_cover.png">
	     </c:if>
	     <c:if test="${profile.mainProFilePicutrePath != ''}">
	       ${profile.mainProfilePicturePath}
	     </c:if>
	     <img class="main-edit-btn" src="${contextPath}/resources/img/btn-edit.png">
	   </div>
     <div class="mini">
       <img src="${contextPath}/resources/img/default_profile_image.png">
       <img class="mini-edit-btn" src="${contextPath}/resources/img/btn-edit.png">
     </div>
	  </div>

	  <div id="section-profile">
	    <div class="row">
		    <span>이메일</span>
		    <div>
		      <span>${sessionScope.user.email}</span>
		      <div><a href="${contextPath}/user/signout.do">로그아웃</a></div>
		    </div>
		  </div>
		  <div class="row">
		    <span>닉네임</span>
		    <div>
		      <input type="text" name="name" id="name" value="${profile.name}">
		    </div>
		  </div>
		  <div class="row">
		    <span>휴대전화번호</span>
		    <div>
		      <input type="text" name="mobile" id="mobile" value="${profile.mobile}">
		    </div>
		  </div>
		  <div class="row">
		    <span>비밀번호</span>
		    <div>
		      <div>
		        <input type="password" name="currPw" placeholder="현재 비밀번호를 입력해 주세요.">
		        <div id="msg-pw"></div>
		      </div>
		      <div>
		        <input type="password" id="inp-pw1" name="pw" placeholder="새 비밀번호를 입력해 주세요.(8~20자리)">
		        <div id="msg-pw1"></div>
		      </div>
		      <div>
		        <input type="password" id="inp-pw2" placeholder="확인을 위해 새 비밀번호를 재입력해 주세요.">
		        <div id="msg-pw2"></div>
		      </div>
		    </div>
		  </div>
		  <div class="row">
		    <span>한줄 소개</span>
		    <c:if test="${profile.descript == ''}">
		      <div><input type="text" id="descript" name="descript" placeholder="작가님을 한 마디로 표현해주세요. (100자 이내)"></div>
		    </c:if>
		    <c:if test="${profile.descript != ''}">
		      <div><input type="text" id="descript" name="descript" value="${profile.descript}"></div>
		    </c:if>
		  </div>
		  <div class="row">
		    <div>
		      <span>관심 카테고리</span>
		      <p>3개 이하로 선택 가능합니다.</p>
		    </div>
		    <div>
		      <input type="checkbox" name="profileCategory" value="일러스트">일러스트
		      <input type="checkbox" name="profileCategory" value="사진">사진
		      <input type="checkbox" name="profileCategory" value="디자인">디자인
		      <input type="checkbox" name="profileCategory" value="회화">회화
		      <input type="checkbox" name="profileCategory" value="조소/공예">조소/공예
		      <input type="checkbox" name="profileCategory" value="사운드">사운드
		      <input type="checkbox" name="profileCategory" value="애니메이션">애니메이션
		      <input type="checkbox" name="profileCategory" value="캘리그라피">캘리그라피
		      <input type="checkbox" name="profileCategory" value="기타">기타
		    </div>
		  </div>
	    <div>
	      <input type="hidden" name="userNo" value="${user.userNo}">
		    <button type="submit" id="btn-modify" class="btn btn-primary">저장하기</button>
		    <button type="button" id="btn-next" class="btn btn-secondary">취소하기</button>
	    </div>
	   
	  </div>
    
  </form>

</div>

<!--
   alert 창으로 안내
     <h3>환영합니다!</h3>
     <span>OGQ 계정 가입이 완료되었습니다.<br>크리에이터 프로필을 설정하고<br>다양한 서비스를 편리하게 이용해 보세요!</span>
     <span>프로필 수정을 통해 언제든지 변경할 수 있어요.</span>
-->

<script>
  
</script>
  
<%@ include file="../layout/footer.jsp" %>
