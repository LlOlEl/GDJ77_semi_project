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
      <img class="default-cover-image" alt="default-image" src="../resources/img/default_cover.png">
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
        <span class="txt-card-count">0</span>
        <span>좋아요</span>
      </div>
      <div class="user-static">
        <span class="txt-card-count">0</span>
        <span>팔로잉</span>
      </div>
      <div class="user-static">
        <span class="txt-card-count">0</span>
        <span>팔로워</span>
      </div>
      <div class="user-static">
        <span class="txt-card-count">0</span>
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
   

<script>

// 팔로잉 여부
var checkFollow = false;
var modalCheckFollow = false;
// 팔로우 or 언팔로우
var check = false;
// 로그인 체크
var hasLogin = true;

var page = 1;
var UploadListPage = 1;

// 팔로잉 totalPage
var totalPage = 0;

const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}






// 프로필의 팔로우 버튼
$('#btn-follow').on('click', (evt) => {
  // 로그인 여부 체크
  fnCheckSignin();
  if(!hasLogin) {
    return;
  } else {
  // check값에 true 주기 - follow
    check = false;
    fnFollow();
  }
})

// 프로필의 언팔로우 버튼
$(document).on('click', '#btn-unfollow', function() {
  // check값에 true 주기 - follow
  check = true;
  fnFollow();
});

// 모달창의 팔로우 버튼
$(document).on('click', '.btn-modal-follow', function() {
  
	var buttonId = $(this).attr('id');
	
	// 로그인 여부 검사
	fnCheckSignin();
	if(!hasLogin) {
		return;
	} else {
		
		// 로그인 여부 통과되었으므로 fetch 진행
    fetch(fnGetContextPath() + '/user/follow.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'toUser': $(this).data('userNo')
      })
      })
      .then(response=> response.json())
      .then(resData=> {
        if(resData.insertFollowCount === 1) {
        	// 팔로우 성공 시, 버튼 스타일 바꿈.
        	$(this).text('팔로우');
        	$(this).css('background-color', 'black');
        	$(this).css('color', 'white');
        	$(this).attr('class', 'btn-modal-unfollow');
        }
      })
	}


});

// 모달창의 언팔로우 버튼
$(document).on('click', '.btn-modal-unfollow', function() {
	
  // 로그인 여부 통과되었으므로 fetch 진행
  fetch(fnGetContextPath() + '/user/unfollow.do', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'toUser': $(this).data('userNo')
    })
    })
    .then(response=> response.json())
    .then(resData=> {
      if(resData.deleteFollowCount === 1) {
        // 팔로우 성공 시, 버튼 스타일 바꿈.
        $(this).text('팔로잉');
        $(this).css('background-color', '');
        $(this).css('color', '');
        $(this).attr('class', 'btn-modal-follow');
      }
    })
});




// 모달창 - 팔로잉 리스트 가져오기

// 팔로잉 요소 가져옴
var userStatic = $('.txt-card-count').eq(1);
// 팔로워 요소 가져옴
var userStatic2 = $('.txt-card-count').eq(2);
 
// 팔로잉 클릭시 서버에서 해당 유저의 팔로잉 리스트 받아오기
userStatic.on('click', () => {
	
  console.log('팔로잉 리스트 가져와주세요.');
	
  // 모달창 띄우기
  $('.modal-outer').css('display', 'flex');
  fngetFollowingList();
  fnFollwingScrollHandler();
  // 로그인된 유저(session)와 팔로잉 유저 데이터의 userNo값 비교해서 팔로잉 
   
})

// 팔로워 클릭시 서버에서 해당 유저의 팔로워 리스트 받아오기
userStatic2.on('click', () => {

  console.log('팔로워 리스트 가져와주세요.');	
	
  // 모달창 띄우기
  $('.modal-outer').css('display', 'flex');
  fngetFollowerList();
  fnFollwerScrollHandler();
  // 로그인된 유저(session)와 팔로잉 유저 데이터의 userNo값 비교해서 팔로잉 
	
})

// 2. 모달창 나가기
$('.modal-overlay').on('click', () => {
  $('.modal-outer').css('display', 'none');
})


// 함수

// 모달창 - 팔로잉 리스트 가져오기
const fngetFollowingList = () => {
	
  // 팔로잉 & 팔로워 유저 데이터 가져오기
  fetch(fnGetContextPath() + '/user/getFollowingList.do', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'profileUserNo': $('.user-body').data('userNo'),
      'page': page
    })
   })
   .then(response=> response.json())
   .then(resData=> { // resData - {"followingList": [...], "totalPage":3}
     
    // totalPage 갱신
    totalPage = resData.totalPage;
    // 팔로잉 수
    $('.count-detail').text(resData.followingCount);
    
    // 리스트 띄우기      
    $.each(resData.followingList, (i, following) => {
    	
  	  fetch(fnGetContextPath() + '/user/checkFollow.do', {
  		    method: 'POST',
  		    headers: {
  		      'Content-Type': 'application/json'
  		    },
  		    body: JSON.stringify({
  		      'toUser': following.userNo
  		    })
  		  })
  		  .then(response=> response.json())
  		  .then(resData=> {
  			// 요소를 만든다.
		    let str = '<div class="user-item">';
	        str += '  <div class="profile-wrapper">';
	        str += '    <div class="profile-image-wrap">';
	        str += '      <div class="profile-image-wrapper profile-image-medium">';
	        str += '        <img alt="avatar-image" src="../resources/img/default_profile_image.png" draggable="false" width=40px>';
	        str += '      </div>';
	        str += '    </div>';
	        str += '    <span class="nickname" data-user-no="' + following.userNo + '">' + following.name + '</span>';
	        str += '  </div>';
	        str += '  <div class="button-wrapper list">';
	    
	        if(following.isFollow === 1) {
	          str += '    <button class="btn-modal-unfollow" id="following_' + following.userNo + '" data-user-no="' + following.userNo + '">';
	          str += '      <div class="btn-text">팔로우</div>';
	          str += '    </button>';
	        } else {
	          str += '    <button class="btn-modal-follow" id="following_' + following.userNo + '" data-user-no="' + following.userNo + '">';
	          str += '      <div class="btn-text">팔로잉</div>';
	          str += '    </button>';
	        }
	          str += '  </div>'
	          str += '</div>';
	         $(".list.chow-scrollbar").append(str);
  			  
  			  // 그 다음 버튼 디자인을 변경해준다.
  		    if(resData.hasFollow != 0) {
  		    	// 언팔로우로 변경..(팔로우)
  		      var buttonId = 'following_' + following.userNo
  		      var buttonElement = $('#' + buttonId);
  		      buttonElement.text('팔로우');
  		      buttonElement.css('background-color', 'black');
  		      buttonElement.css('color', 'white');
  		      buttonElement.attr('class', 'btn-modal-unfollow');
  		    
  		    } else {
  		      // 팔로우로 변경..(팔로잉)
              var buttonId = 'following_' + following.userNo
              var buttonElement = $('#' + buttonId);
              buttonElement.text('팔로잉');
              buttonElement.css('background-color', '');
              buttonElement.attr('class', 'btn-modal-follow');
  		    }
  		  })
     })
 }) 
 
}

// 팔로워 리스트 가져오기
const fngetFollowerList = () => {
	  $(".list.chow-scrollbar").empty();
	  // 팔로잉 & 팔로워 유저 데이터 가져오기
	  fetch(fnGetContextPath() + '/user/getFollowerList.do', {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/json'
	    },
	    body: JSON.stringify({
	      'profileUserNo': $('.user-body').data('userNo'),
	      'page': page
	    })
	   })
	   .then(response=> response.json())
	   .then(resData=> { // resData - {"followerList": [...], "totalPage":3}
	      // totalPage 갱신
	      totalPage = resData.totalPage;
	      // 팔로잉 수
	      $('.count-detail').text(resData.followerCount);
	    
	      // 리스트 띄우기      
	      $.each(resData.followerList, (i, follower) => {
		  	  fetch(fnGetContextPath() + '/user/checkFollow.do', {
		  	    method: 'POST',
		  		  headers: {
		  		    'Content-Type': 'application/json'
		  		  },
		  		  body: JSON.stringify({
		  		    'toUser': follower.userNo
		  		  })
		  		})
		  		.then(response=> response.json())
		  		.then(resData=> {
		  	      // 요소를 만든다.
				  let str = '<div class="user-item">';
			      str += '  <div class="profile-wrapper">';
			      str += '    <div class="profile-image-wrap">';
			      str += '      <div class="profile-image-wrapper profile-image-medium">';
			      str += '        <img alt="avatar-image" src="../resources/img/default_profile_image.png" draggable="false" width=40px>';
			      str += '      </div>';
			      str += '    </div>';
			      str += '    <span class="nickname" data-user-no="' + follower.userNo + '">' + follower.name + '</span>';
			      str += '  </div>';
			      str += '  <div class="button-wrapper list">';
			    
			      if(follower.isFollow === 1) {
			        str += '    <button class="btn-modal-unfollow" id="following_' + follower.userNo + '" data-user-no="' + follower.userNo + '">';
			        str += '      <div class="btn-text">팔로우</div>';
			        str += '    </button>';
			      } else {
			        str += '    <button class="btn-modal-follow" id="following_' + follower.userNo + '" data-user-no="' + follower.userNo + '">';
			        str += '      <div class="btn-text">팔로잉</div>';
			        str += '    </button>';
			      }
			        str += '  </div>'
			        str += '</div>';
			        $(".list.chow-scrollbar").append(str);
		  			  
		  		  // 그 다음 버튼 디자인을 변경해준다.
		  		  if(resData.hasFollow != 0) {
		  		    // 언팔로우로 변경..(팔로우)
		  		    var buttonId = 'following_' + follower.userNo
		  		    var buttonElement = $('#' + buttonId);
		  		    buttonElement.text('팔로우');
		  		    buttonElement.css('background-color', 'black');
		  		    buttonElement.css('color', 'white');
		  		    buttonElement.attr('class', 'btn-modal-unfollow');
		  		    
		  		  } else {
		  		    // 팔로우로 변경..(팔로잉)
		            var buttonId = 'following_' + follower.userNo
		            var buttonElement = $('#' + buttonId);
		            buttonElement.text('팔로잉');
		            buttonElement.css('background-color', '');
		            buttonElement.attr('class', 'btn-modal-follow');
		  		}
		    })
	     })
	 }) 
	 
}


// 팔로우 - 프로필
const fnFollow = () => {
  
  if(!check) {
    // check값 true이므로 follow
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
          checkFollow = true;
          fnChangeBtn();
        }
      })
      
  } else {
    
    // check 값 false이므로 unfollow
    fetch(fnGetContextPath() + '/user/unfollow.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'toUser': $('.user-body').data('userNo')
      })
    })
    .then(response=>response.json())
    .then(resData=>{
      if(resData.deleteFollowCount === 1) {
        checkFollow = false;
        fnChangeBtn();
      }
    })
  }
}

// 버튼 변경 - 프로필
const fnChangeBtn = () => {
  if(checkFollow) {
    $('#btn-follow').off('click');
    $('#btn-follow').text('팔로잉');
    $('#btn-follow').css('background-color', 'black');
    $('#btn-follow').css('color', 'white');
    $('#btn-follow').attr('id', 'btn-unfollow');

  } else{
    $('#btn-unfollow').off('click');
    $('#btn-unfollow').text('팔로우하기');
    $('#btn-unfollow').css('background-color', '');
    $('#btn-unfollow').attr('id', 'btn-follow');

  }
}

// 팔로잉 여부 조회 - 프로필
const fnCheckFollow = () => {
  
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
    if(resData.hasFollow != 0) {
      check=true;
      checkFollow = true;
      fnChangeBtn();
    } else {
      check=false;
      checkFollow = false;
      fnChangeBtn();
    }
  })
}


// 팔로잉 수 가져오기
const fnGetFollowCount = () => {
  
  fetch(fnGetContextPath() + '/user/getFollowCount.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'userNo': $('.user-body').data('userNo')
      })
    })
    .then(response=> response.json())
    .then(resData=> {
      var following = $('.txt-card-count:eq(1)');
      var follower = $('.txt-card-count:eq(2)');
      following.text(resData.followingCount);
      follower.text(resData.followerCount);
    })
}

// 로그인 체크
const fnCheckSignin = () => {
  if('${sessionScope.user}' === '') {
    if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
      location.href = '${contextPath}/user/signin.page';
    } else {
      hasLogin = false;
    }
  }
}


//조회수 가져오기
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
  })
}

// 무한 스크롤 - 팔로잉
const fnFollwingScrollHandler = () => {
  var timerId;
  $('.modal').on('scroll', (evt) => {
    if(timerId) {  
      clearTimeout(timerId);
    }
    timerId = setTimeout(() => {
    let scrollTop = window.scrollY;  // $(window).scrollTop();
    let windowHeight = window.innerHeight;  // $(window).height();
    let modalHeight = 290;
      if((modalHeight - scrollTop - windowHeight) < 50) {  
        if(page > totalPage) {
          return;
        }
        page++;
        fngetFollowingList();
      }
    }, 500);
  })
}

// 무한 스크롤 - 팔로워
const fnFollwerScrollHandler = () => {
  var timerId;
  $('.modal').on('scroll', (evt) => {
    if(timerId) {  
      clearTimeout(timerId);
    }
    timerId = setTimeout(() => {
    let scrollTop = window.scrollY;  // $(window).scrollTop();
    let windowHeight = window.innerHeight;  // $(window).height();
    let modalHeight = 290;
      if((modalHeight - scrollTop - windowHeight) < 50) {  
        if(page > totalPage) {
          return;
        }
        page++;
        fngetFollowerList();
      }
    }, 500);
  })
}

// 프로필 유저가 업로드한 게시물 가져오기
const fnGetUserUploadList = () => {
  console.log('fnGetUserUploadList 실행');
	
  fetch(fnGetContextPath() + '/post/getUserUploadList.do?userNo=' + $('.user-body').data('userNo') + '&page=' + UploadListPage)
  .then(response=>response.json())
  .then(resData=> {
	
  
  
  })
  
	
	
}



// 함수 호출
fnCheckFollow();
fnChangeBtn();
fnGetFollowCount();
fnGetUserUploadList();

 
</script>
 
 
<%@ include file="../layout/footer.jsp" %>