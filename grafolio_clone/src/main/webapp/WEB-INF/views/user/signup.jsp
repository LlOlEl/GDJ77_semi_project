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

  <img alt="signup-logo" src="../resources/img/logo-grapolio.svg">
  <form method="POST"
        action="${contextPath}/user/signup.do"
        id="frm-signup">
  
  <div id="section-email">
    <div class="row mb-3">
      <span>OGQ 계정으로 사용할 이메일 주소를 입력해주세요</span>
      <div class="col-sm-6"><input type="text" id="inp-email" name="email" class="form-control" placeholder="example@example.com"></div>
      <div class="col-sm-3"><button type="button" id="btn-code" class="btn btn-primary">인증코드받기</button></div>
      <div class="col-sm-3"id="msg-email"></div>
    </div>
    <div class="row mb-3">
      <div class="col-sm-6"><input type="text" id="inp-code" class="form-control" placeholder="인증코드입력" disabled></div>
      <div class="col-sm-3"><button type="button" id="btn-verify-code" class="btn btn-primary" disabled>인증하기</button></div>
    </div>
    <button type="button" id="btn-confirmCode" disabled>다음</button>
  </div>
  
  <div id="section-pw" style="display:none">
    <div class="row mb-3">
      <label for="inp-pw" class="col-sm-3 col-form-label">비밀번호</label>
      <div class="col-sm-6"><input type="password" id="inp-pw" name="pw" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-pw"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-pw2" class="col-sm-3 col-form-label">비밀번호 확인</label>
      <div class="col-sm-6"><input type="password" id="inp-pw2" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-pw2"></div>
    </div>
    <button type="button" id="btn-confirmPw" disabled>다음</button>
  </div>
  
  <div id="section-name" style="display:none">
   <div class="row mb-3">
     <label for="inp-name" class="col-sm-3 col-form-label">이름</label>
     <div class="col-sm-9"><input type="text" name="name" id="inp-name" class="form-control"></div>
     <div class="col-sm-3"></div>
     <div class="col-sm-9" id="msg-name"></div>
   </div>
   <button type="button" id="btn-confirmName" disabled>다음</button>
  </div>
	
  <div id="section-mobile" style="display:none">
    <div class="row mb-3">
      <label for="inp-mobile" class="col-sm-3 col-form-label">휴대전화번호</label>
      <div class="col-sm-9"><input type="text" name="mobile" id="inp-mobile" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-mobile"></div>
    </div>
    <button type="button" id="btn-confirmMobile" disabled>다음</button>
  </div>
  
  <div id="section-options" style="display:none">
     <span>크리에이터 프로필을 설정하고 다양한 서비스를 편리하게 이용해 보세요!</span>
     <span>프로필 수정을 통해 언제든지 변경할 수 있어요.</span>  
    <div class="row mb-3">
      <label for="inp-miniProfile" class="col-sm-3 col-form-label">프로필 이미지</label>
      <div class="col-sm-9"><input type="file" name="miniProFilePicutrePath" id="inp-miniProfile" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-mainProfile" class="col-sm-3 col-form-label">프로필 배경 이미지</label>
      <div class="col-sm-9"><input type="file" name="mainProFilePicutrePath" id="inp-mainProfile" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-descript" class="col-sm-3 col-form-label">한 줄 소개</label>
      <div class="col-sm-9"><input type="text" name="descript" id="inp-descript" placeholder="작가님을 한 마디로 표현해주세요. (100자 이내)" class="form-control"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-9" id="msg-"></div>
    </div>
    <div class="row mb-3">
      <label for="inp-" class="col-sm-3 col-form-label">관심 카테고리</label>
      <div class="col-sm-9">
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
      <div class="col-sm-3"><p>3개 이하로 선택 가능합니다.</p></div>
      <div class="col-sm-9" id="msg-"></div>
    </div>
    <button type="submit" id="btn-signup" class="btn btn-primary">가입하기</button>
  </div>
    
  </form>

</div>

<script src="${contextPath}/resources/js/signup.js?dt=${dt}"></script>
  
<%@ include file="../layout/footer.jsp" %>
