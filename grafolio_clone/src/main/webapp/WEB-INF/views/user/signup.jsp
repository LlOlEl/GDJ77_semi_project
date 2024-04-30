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
<link rel="stylesheet" href="${contextPath}/resources/css/init.css?dt=${dt}">
<link rel="stylesheet" href="${contextPath}/resources/css/signup.css?dt=${dt}">

</head>

<body>

<div id="app">
  <div class="frame">
  <div class="layout">
  
    <div class="layout-contents">
      <div class="layout-logo">
        <img alt="signup-logo" src="../resources/svg/logo-grapolio.svg">
      </div>
      <div class="layout-page">
		  <form method="POST"
		        enctype="multipart/form-data"
		        action="${contextPath}/user/signup.do"
		        id="frm-signup">
		      <div class="text-massage">
		        <span>OGQ 계정으로 사용할</span>
		        <div>
		          <span class="highlight-text-message text-message">이메일</span>
		          <span>주소를 입력해주세요</span>  
	          </div>
		      </div>
			  <div id="section-email">
			    <div class="signup-frm-email">
			      <div class="signup-input">
			        <input type="text" id="inp-email" name="email" class="input-text" placeholder="example@example.com">
			      </div>
			      <button type="button" id="btn-code" class="btn-code">인증요청</button>
			    </div>
			    <div class="msg-email" id="msg-email"></div>
			    <div class="signup-frm-email">
			      <div class="signup-input">
			        <input type="text" id="inp-code" class="input-text" placeholder="인증코드입력" disabled>
			      </div>
			      <button type="button" id="btn-verify-code" class="btn-code" disabled>인증하기</button>
			    </div>
			    <div class="msg-emailCode" id="msg-emailCode"></div>
			    <div class="message-field">
			      <span>· 입력한 이메일 주소로 인증번호가 발송됩니다.</span>
			      <span>· 인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.</span>
			    </div>
			    <div class="signup-btn-wrap">
			      <button type="button" id="btn-confirmCode" class="signup-btn" disabled>다음</button>
			    </div>
			  </div>
			  
			  <div id="section-pw" style="display:none">
			    <div class="signup-frm-pw">
			      <label for="inp-pw" class="signup-label">비밀번호</label>
			      <div class="signup-input">
			        <input type="password" id="inp-pw" name="pw" class="input-text" placeholder="비밀번호를 입력해주세요. (8~20자리)">
			      </div>
			      <div class="msg-pw" id="msg-pw"></div>
			    </div>
			    <div class="signup-frm-pw">
			      <div class="signup-input">
			        <input type="password" id="inp-pw2" class="input-text" placeholder="확인을 위해 비밀번호를 재입력해주세요.">
			      </div>
			      <div class="msg-pw2" id="msg-pw2"></div>
			    </div>
			    <div class="signup-btn-wrap">
			      <button type="button" id="btn-confirmPw" class="signup-btn" disabled>다음</button>
			    </div>
			  </div>
			  
			  <div id="section-name" style="display:none">
			   <div class="signup-frm-name">
			     <label for="inp-name" class="signup-label">이름</label>
			     <div class="signup-input">
			       <input type="text" name="name" id="inp-name" class="input-text" placeholder="닉네임을 입력해주세요. (5~30자)">
			     </div>
			     <div class="msg-name" id="msg-name"></div>
			   </div>
			   <div class="signup-btn-wrap">
			     <button type="button" id="btn-confirmName" class="signup-btn" disabled>다음</button>
			   </div>
			  </div>
				
			  <div id="section-mobile" style="display:none">
			    <div class="signup-frm-mobile">
			      <label for="inp-mobile" class="signup-label">휴대전화번호</label>
			      <div class="signup-input">
			        <input type="text" name="mobile" id="inp-mobile" class="input-text">
			      </div>
			      <div class="msg-mobile" id="msg-mobile"></div>
			    </div>
			    <div class="signup-btn-wrap">
			      <button type="button" id="btn-confirmMobile" class="signup-btn" disabled>다음</button>
			    </div>
			  </div>
			  
			  <div id="section-options" style="display:none">
			     <span>크리에이터 프로필을 설정하고 다양한 서비스를 편리하게 이용해 보세요!</span>
			     <span>프로필 수정을 통해 언제든지 변경할 수 있어요.</span>  
			    <div class="signup-frm-profileImage">
			      <label for="inp-miniProfile" class="signup-label">프로필 이미지</label>
			      <div class="signup-input">
			        <input type="file" name="miniProfilePicturePath" id="inp-miniProfile" class="inp-miniProfile">
			      </div>
			      <div class="attach-mini-list" id="attach-mini-list"></div>
			    </div>
			    <div class="signup-frm-coverImage">
			      <label for="inp-mainProfile" class="signup-label">프로필 배경 이미지</label>
			      <div class="signup-input">
			        <input type="file" name="mainProfilePicturePath" id="inp-mainProfile" class="inp-mainProfile">
			      </div>
			      <div class="attach-main-list" id="attach-main-list"></div>
			    </div>
			    <div class="signup-frm-describe">
			      <label for="inp-descript" class="signup-label">한 줄 소개</label>
			      <div class="signup-input">
			        <input type="text" name="descript" id="inp-descript" class="input-text" placeholder="작가님을 한 마디로 표현해주세요. (100자 이내)">
			      </div>
			      <div class="msg-describe" id="msg-describe"></div>
			    </div>
			    <div class="signup-frm-category">
			      <label for="inp-category" class="signup-label">관심 카테고리</label>
			      <div class="signup-check">
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
			      <div class="signup-category-label"><p>3개 이하로 선택 가능합니다.</p></div>
			      <div class="msg-category" id="msg-category"></div>
			    </div>
			    <div class="signup-btn-wrap">
			      <button type="submit" id="btn-signup" class="signup-btn">가입 하기</button>
			    </div>
			  </div>
		  </form>
      </div>
    </div>
    
  </div>
  </div>
</div>


<script>
const LogoMain = () => {
  $('.layout-logo').find('img').on('click', () => {
    location.href = "${contextPath}/main.page";
  })
}

LogoMain();

</script>

<script src="${contextPath}/resources/js/signup.js?dt=${dt}"></script>

</body>
</html>
  
