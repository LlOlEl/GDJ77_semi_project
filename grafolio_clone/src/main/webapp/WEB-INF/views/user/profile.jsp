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
   	
   	<div class="user-body" data-user-no="${profile.userNo}">
   	  <span class="user-nickname">${profile.name}</span>
   	<div class="user-category">${profile.profileCategory}</div> <!-- 유저가 선택한 태그(사진, 일러스트 등) -->
   	<div class="user-description">${profile.descript}</div> <!-- 유저 프로필 설명 -->
    <div class="button-wrap">
      <c:if test="${sessionScope.user.userNo != profile.userNo}">
      <div class="change-btn">
        <button type="button" id="btn-follow" data-user-no="${profile.userNo}">팔로우하기</button>
      </div>
      </c:if>
      <c:if test="${sessionScope.user.userNo == profile.userNo}">
        <button type="button" id="btn-modify" data-user-no="${profile.userNo}">기본정보수정</button>
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

// 팔로잉 여부
var checkFollow = false;

const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}

// 버튼 변경
const fnChangeBtn = () => {
  console.log("changeBtn");
  if(checkFollow) {
	$('#btn-follow').off('click');
    $('#btn-follow').text('팔로잉');
    $('#btn-follow').css('background-color', 'black');
    $('#btn-follow').attr('id', 'btn-unfollow');
    fnUnfollow();
  } else{
	$('#btn-unfollow').off('click');
    $('#btn-follow').text('팔로우하기');
    $('#btn-follow').css('background-color', '');
    $('#btn-follow').attr('id', 'btn-follow');
    fnFollwing();
  }
}

// 팔로우
const fnFollwing = () => {
	
  $('#btn-follow').on('click', (evt) => {
    // 로그인 여부 검사
    fnCheckSignin();

    // 팔로우를 신청받은 user의 userNo 전송
    fetch(fnGetContextPath() + '/user/follow.do', {
	  method: 'POST',
	  headers: {
        'Content-Type': 'application/json'
	  },
	  body: JSON.stringify({
	    'toUser': $('#btn-follow').data('userNo')
	  })
    })
    .then(response=> response.json())
    .then(resData=> {
      if(resData.insertFollowCount === 1) {
        fnCheckFollow();
      }
    })
  })
}

// 언팔로우
const fnUnfollow = () => {
  
  
  
  $('.change-btn').children().on('click', (evt) => {
    
    fetch(fnGetContextPath() + '/user/unfollow.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'toUser': $('#btn-unfollow').data('userNo')
      })
    })
    .then(response=>response.json())
    .then(resData=>{
      if(resData.deleteFollowCount === 1) {
        fnCheckFollow();
      }
    })
	  
  })
}

// 팔로우 조회
const fnCheckFollow = () => {
	
	console.log("fnCheckFollow");
	
	fetch(fnGetContextPath() + '/user/checkFollow.do', {
		method: 'POST',
		headers: {
		  'Content-Type': 'application/json'
		},
		body: JSON.stringify({
		  'toUser': $('.user-body').data('userNo')
		})
	})
	.then(response=> response.json())
	.then(resData=> {
		console.log(resData.hasFollow);
		if(resData.hasFollow != 0) {
			checkFollow = true;
			fnChangeBtn();
			console.log("checkFollow값", checkFollow);
		} else {
			checkFollow = false;
			fnChangeBtn();
			console.log("checkFollow값", checkFollow);
		}
	})
}

// 조회수 가져오기
const fnGetHitCount = () => {
  fetch(fnGetContextPath() + '/user/getHitCount.do', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'userNo': $('#btn-follow').dataset.userNo
    })
  })
  .then(response=>response.json())
  .then(resData=> {
    console.log(resData);
  })
}

// 로그인 체크
const fnCheckSignin = () => {
  if('${sessionScope.user}' === '') {
    if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
      location.href = '${contextPath}/user/signin.page';
    }
  }
}

// 함수 호출
fnCheckFollow();
fnChangeBtn();
fnFollwing();
fnUnfollow();

 
 
</script>
 
 
<%@ include file="../layout/footer.jsp" %>