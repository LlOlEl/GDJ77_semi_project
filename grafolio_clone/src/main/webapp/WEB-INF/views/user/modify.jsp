<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
 <jsp:include page="../layout/header.jsp">
   <jsp:param value="Sign In" name="title"/>
 </jsp:include>
 
<div class="m-3">

  <form method="POST"
        action="${contextPath}/user/signup.do"
        id="frm-profile">

  <div id="section-profile">
   <div class="row mb-4">
     <h3>환영합니다!</h3>
     <span>OGQ 계정 가입이 완료되었습니다.<br>크리에이터 프로필을 설정하고<br>다양한 서비스를 편리하게 이용해 보세요!</span>
   </div>
   <div class="row mb-2"></div>
   <div class="row mb-8">
     <span>프로필 수정을 통해 언제든지 변경할 수 있어요.</span>
     <div class="row-mb-4">
       <img >
     </div>
     <div class="row mb-4">
       <div class="col-sm-4"></div>
       <div class="col-sm-2">
         <img src="${contextPath}/resources/img/profile.png">
         <div>
           <i class="fa-solid fa-pen-to-square"><input type="file" name="profile" id="profile"></i>
         </div>
       </div>
     <div class="col-sm-4"></div>
     </div>
     
   </div>
   <button type="submit" id="btn-profile" class="btn btn-primary">시작하기</button>
  </div>
    
  </form>
     <label for="inp-profile" class="col-sm-3 col-form-label">프로필</label>

</div>

<script src="${contextPath}/resources/js/signup.js?dt=${dt}"></script>
  
<%@ include file="../layout/footer.jsp" %>
