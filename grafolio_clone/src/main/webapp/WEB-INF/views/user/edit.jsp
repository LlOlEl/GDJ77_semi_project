<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<jsp:include page="../layout/header.jsp">
  <jsp:param value="edit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${contextPath}/resources/css/edit.css?dt=${dt}">

<div class="content">
  <div class="settings-wrapper">

    <nav class="settings-navbar">
    
    </nav>

    <div class="settings-content">
      <span class="title">기본정보 수정</span>
		  <form method="POST"
		        enctype="multipart/form-data"
		        action="${contextPath}/user/modify.do"
		        id="frm-edit"
		        onsubmit="return fnSubmitForm()">
		        
			  <div class="profile_picture">
			   <div class="main">
			     <div id="mainPreview">
				     <c:if test="${profile.mainProfilePicturePath == null}">
				       <img src="${contextPath}/resources/img/default_cover.png">
				     </c:if>
				     <c:if test="${profile.mainProfilePicturePath != null}">
				       ${profile.mainProfilePicturePath}
				     </c:if>
			     </div>
			     <div>
			       <input type="file" name="miniProfilePicturePath" id="hasMainProfile">
				     <input type="file" name="mainProfilePicturePath" id="real-upload-mainProfile" onchange="fnUploadMainProfile()">
				     <img class="main-upload-btn" id="upload-mainProfile" src="${contextPath}/resources/img/btn-edit.png">
			     </div>
			   </div>
			   <div class="mypage-profile">
			     <div class="mini">
			       <div id="miniPreview">
					     <c:if test="${profile.miniProfilePicturePath == null}">
					       <img src="${contextPath}/resources/img/default_profile_image.png">
					     </c:if>
					     <c:if test="${profile.miniProfilePicturePath != null}">
					       ${profile.miniProfilePicturePath}
					     </c:if>
			       </div>
				     <div>
				       <input type="file" name="miniProfilePicturePath" id="hasMiniProfile">
					     <input type="file" name="miniProfilePicturePath" id="real-upload-miniProfile" onchange="fnUploadMiniProfile()">
			         <img class="mini-upload-btn" id="upload-miniProfile" src="${contextPath}/resources/img/btn-edit.png">
				     </div>
			     </div>
		     </div>
		     
			  </div>
		
			  <div class="content-section">
			    <div class="title-wrapper">
				    <span class="title-txt">이메일</span>
				  </div>
			    <div class="input-wrapper">
			      <span>${sessionScope.user.email}</span>
			      <div><a href="${contextPath}/user/signout.do">로그아웃</a></div>
			    </div>
				</div>
				<div class="content-section">
				  <div class="title-wrapper">
				    <span class="title-txt">닉네임</span>
				  </div>
			    <div class="input-wrapper">
			      <input type="text" name="name" id="name" value="${profile.name}">
			    </div>
				</div>
				<div class="content-section">
				  <div class="title-wrapper">
				    <span>휴대전화번호</span>
				  </div>
			    <div class="input-wrapper">
			      <input type="text" name="mobile" id="mobile" value="${profile.mobile}">
			    </div>
				</div>
				<div class="content-section">
				  <div class="title-wrapper">
				    <span>비밀번호</span>
				  </div>
			    <div>
			      <div>
			        <input type="password" name="currPw" id="inp-currPw" placeholder="현재 비밀번호를 입력해 주세요.">
			        <div id="msg-pw"></div>
			      </div>
			      <div><button type="button" id="checkPw">확인</button></div>
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
				  <div class="content-section">
				    <div class="title-wrapper">
				      <span class="title-txt">한줄 소개</span>
				    </div>
				    <div class="input-wrapper">
					    <c:if test="${profile.descript == null}">
					      <input type="text" id="descript" name="descript" placeholder="작가님을 한 마디로 표현해주세요. (100자 이내)">
					    </c:if>
					    <c:if test="${profile.descript != null}">
					      <input type="text" id="descript" name="descript" value="${profile.descript}">
					    </c:if>
				    </div>
				  </div>
				  <div class="content-section">
				    <div class="title-wrapper">
				      <span class="title-txt">관심 카테고리</span>
				      <p class="description">3개 이하로 선택 가능합니다.</p>
				    </div>
				    <div>
				      <input type="checkbox" name="profileCategory" class="cb" value="일러스트">
				      <label class="cb-label" for="category_일러스트">일러스트</label>
				      
				      <input type="checkbox" name="profileCategory" class="cb" id="category_사진" value="사진">사진
				      <input type="checkbox" name="profileCategory" class="cb" id="category_디자인" value="디자인">디자인
				      <input type="checkbox" name="profileCategory" class="cb" id="category_회화" value="회화">회화
				      <input type="checkbox" name="profileCategory" class="cb" id="category_조소/공예" value="조소/공예">조소/공예
				      <input type="checkbox" name="profileCategory" class="cb" id="category_사운드" value="사운드">사운드
				      <input type="checkbox" name="profileCategory" class="cb" id="category_애니메이션" value="애니메이션">애니메이션
				      <input type="checkbox" name="profileCategory" class="cb" id="category_캘리그라피" value="캘리그라피">캘리그라피
				      <input type="checkbox" name="profileCategory" class="cb" id="category_기타" value="기타">기타
				    </div>
				  </div>
			    <div>
			      <input type="hidden" name="userNo" value="${user.userNo}">
				    <button type="submit" id="btn-modify" class="btn btn-primary">저장하기</button>
				    <button type="button" id="btn-back" class="btn btn-secondary">취소하기</button>
			    </div>
			   
			  
		    
		  </form>
    </div>


  </div>
</div>

<!--
   alert 창으로 안내
     <h3>환영합니다!</h3>
     <span>OGQ 계정 가입이 완료되었습니다.<br>크리에이터 프로필을 설정하고<br>다양한 서비스를 편리하게 이용해 보세요!</span>
     <span>프로필 수정을 통해 언제든지 변경할 수 있어요.</span>
-->

<script>
var realUploadMainProfile = document.getElementById('real-upload-mainProfile');  // 실제로 이미지 첨부되는 input 부분
var uploadMainProfile = document.getElementById('upload-mainProfile');           // 이미지 첨부를 위한 img로 만들어진 버튼
var realUploadMiniProfile = document.getElementById('real-upload-miniProfile');
var uploadMiniProfile = document.getElementById('upload-miniProfile');

var passwordCheck = false;
var passwordConfirm = false;
var inpPw1 = document.getElementById('inp-pw1');
var inpPw2 = document.getElementById('inp-pw2');

// 배경 이미지 업로드
const fnUploadMainProfile = () => {
  const mainPreview = document.getElementById('mainPreview');
  
  const mainProfile = realUploadMainProfile.files[0];   // 첨부한 파일 가져오기
  const reader = new FileReader();
  reader.onloadend = () => {
	  const img = document.createElement('img');     // <img> 만들기
	  img.src = reader.result;
	  // img.style.maxWidth = '200px';
	  mainPreview.innerHTML = '';                    // 수정화면에서 보여졌던 이미지 초기화
	  mainPreview.appendChild(img);                  // <img> 만들기
  };
  reader.readAsDataURL(mainProfile);
}

// 프로필 이미지 업로드
const fnUploadMiniProfile = () => {
	const miniPreview = document.getElementById('miniPreview');
	
	const miniProfile = realUploadMiniProfile.files[0];
	const reader = new FileReader();
	reader.onloadend = () => {
		const img = document.createElement('img');
		img.src = reader.result;
		miniPreview.innerHTML = '';
		miniPreview.appendChild(img);
	};
	reader.readAsDataURL(miniProfile);
}

const fnCheckPassword = () => {
  // 비밀번호 4 ~ 12자, 영문/숫자/특수문자 중 2개 이상 포함
  let msgPw1 = document.getElementById('msg-pw1');
  // 영문 포함되어 있으면 true
  let validCount = /[A-Za-z]/.test(inpPw1.value)    // 영문 포함되어 있으면 true
                 + /[0-9]/.test(inpPw1.value)       // 숫자 포함되어 있으면 true
                 + /[A-Za-z0-9]/.test(inpPw1.test); // 영문/숫자가 아니면 true
  let regPw = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  let passwordLength = inpPw1.value.length;
  passwordCheck = passwordLength >= 4
               && passwordLength <= 12
               && validCount >= 2;
  
  if(passwordCheck){
    msgPw1.innerHTML = '사용 가능한 비밀번호입니다.';
    msgPw1.style.color = '#475993';
    msgPw1.style.fontSize = '13px';
  } else {
    msgPw1.innerHTML = '비밀번호 4 ~ 12자, 영문/숫자/특수문자 중 2개 이상 포함 ';
    msgPw1.style.color = 'red';
    msgPw1.style.fontSize = '13px';
  }
}

const fnConfirmPassword = () => {
  passwordConfirm = (inpPw1.value != '') && (inpPw1.value === inpPw2.value);
  let msgPw2 = document.getElementById('msg-pw2');
  if(passwordConfirm) {
    msgPw2.innerHTML = ''; 
    btnConfirmPw.removeAttribute('disabled');
  } else {
    msgPw2.innerHTML = '비밀번호 입력을 확인하세요.';
    msgPw2.style.color = 'red';
    msgPw2.style.fontSize = '13px';
    
    btnConfirmPw.setAttribute('disabled', true);
  }
}

const fnEditUser = () => {
	let inpCurrPw = document.getElementById('inp-currPw');
	
  document.getElementById('frm-edit').addEventListener('submit', (evt) => {
    if(!emailCheck) {
      alert('이메일을 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!passwordCheck || !passwordConfirm) {
      alert('비밀번호를 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!nameCheck) {
      alert('이름을 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!mobileCheck) {
      alert('휴대전화를 확인하세요.');
      evt.preventDefault();
      return;
    }
    
    fetch('${contextPath}/user/pwCheck.do', {
    	method: 'POST',
    	headers: {
    		'Content-Type': 'application/json'
    	},
    	body: JSON.stringify({
    		'currPw': inpCurrPw.value
    	})
    })
    .then(response => response.json())
    .then(resData => {
    	if(resData === 0) {
    		alert('현재 패스워드와 입력한 패스워드가 일치하지 않습니다.');
    		evt.preventDefault();
    		inpCurrPw.focus();
    	}
    })
    
  });
}

// 첨부한 메인 프로필, 미니 프로필이 없을 경우 기존 DB에 저장된 이미지가 저장되도록 하는 함수
const fnSubmitForm = () => {
	if(realUploadMainProfile.value === null || realUploadMainProfile.trim() === "") {
		const originalMainProfilePath = "${profile.mainProfilePicturePath}";
		document.getElementById('hasMainProfile').value = originalMainProfilePath;
	}
	if(realUploadMiniProfile.value === null || realUploadMiniProfile.trim() === "") {
		const originalMiniProfilePath = "${profile.miniProfilePicturePath}";
		document.getElementById('hasMiniProfile').value = originalMiniProfilePath;
	}
	return true;
}

uploadMainProfile.addEventListener('click', () => realUploadMainProfile.click());  // img로 만들어진 버튼을 눌렀을 때 실제 첨부 input이 실행되는 이벤트 
uploadMiniProfile.addEventListener('click', () => realUploadMiniProfile.click());

inpPw1.addEventListener('keyup', fnCheckPassword);
inpPw2.addEventListener('keyup', fnConfirmPassword);

fnEditUser();



const getCategoryList = () => {
	var selectedCategories = "${profile.profileCategory}";
	let arr = selectedCategories.split(", ");
 	arr.forEach((category)=>{
 		var checkbox = document.getElementById('category_' + category);
 		if(checkbox) {
 			checkbox.checked = true;
 		}
 	})
 }
getCategoryList();






</script>

  
<%@ include file="../layout/footer.jsp" %>
