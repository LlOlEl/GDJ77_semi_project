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

// 페이지
var FollowingPage = 1;
var FollowerPage = 1;
var UploadListPage = 1;
var LikeListPage = 1;

// 팔로잉 totalPage
var FollowingTotalPage = 0;

// 팔로워 totalPage
var FollowerTotalPage = 0;

// 업로드 totalPage
var UploadListTotalPage = 0;

// 좋아요 totalPage
var LikeListTotalPage = 0;


const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}










// 프로필의 팔로우 버튼

$(document).on('click', '#btn-follow', function() {
  // 로그인 여부 체크
  fnCheckSignin();
  if(!hasLogin) {
    return;
  } else {
  // check값에 true 주기 - follow
    check = false;
    fnFollow(check);
  }
})

// 프로필의 언팔로우 버튼
$(document).on('click', '#btn-unfollow', function() {
  // check값에 true 주기 - follow
  check = true;
  fnFollow(check);
});

// 모달창의 팔로우 버튼
$(document).on('click', '.btn-modal-follow', function() {
  
  var buttonId = $(this).attr('id');
  
  // 자기 자신 검사
  if($('.content').data('userNo') === $(this).data('userNo')) {
	  return;
  }
  
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
          $(this).text('팔로잉');
          $(this).css('background-color', 'white');
          $(this).css('color', '#00b57f');
          $(this).css('border-color', '#00b57f');
          $(this).attr('class', 'btn-detail btn-modal-unfollow');
        }
      })
  }


});

// 모달창의 언팔로우 버튼
$(document).on('click', '.btn-modal-unfollow', function() {
  
  // 자기 자신 검사
  if($('.content').data('userNo') === $(this).data('userNo')) {
	  return;
  }
	
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
        // 언팔로우 성공 시, 버튼 스타일 바꿈.
        $(this).text('팔로우');
        $(this).css('background-color', '#00b57f');
        $(this).css('color', 'white');
        $(this).css('border-color', '#00b57f');
        $(this).attr('class', 'btn-detail btn-modal-follow');
      }
    })
});




// 모달창 - 팔로잉 리스트 가져오기

// 팔로잉 요소 가져옴
var userStatic = $('.user-statistic').eq(1);
// 팔로워 요소 가져옴
var userStatic2 = $('.user-statistic').eq(2);
 
// 팔로잉 클릭시 서버에서 해당 유저의 팔로잉 리스트 받아오기
userStatic.on('click', () => {
  
  // 모달창 띄우기
  $('.modal-outer').css('display', 'flex');
  
  // 모달창 및 전역변수 초기화
  
  FollowingPage = 1;
  FollowingTotalPage = 0;
  
  
  fngetFollowingList();
  fnFollwingScrollHandler();
  // 로그인된 유저(session)와 팔로잉 유저 데이터의 userNo값 비교해서 팔로잉 
   
})

// 팔로워 클릭시 서버에서 해당 유저의 팔로워 리스트 받아오기
userStatic2.on('click', () => {
  
  console.log('팔로워 클릭');
  // 모달창 띄우기
  $('.modal-outer').css('display', 'flex');
  
  // 모달창 및 전역변수 초기화
  
  FollowerPage = 1;
  FollowerTotalPage = 0;
  
  fngetFollowerList();
  fnFollwerScrollHandler();
  // 로그인된 유저(session)와 팔로잉 유저 데이터의 userNo값 비교해서 팔로잉 
  
})

// 2. 모달창 나가기
$('.modal-overlay').on('click', () => {
  $('.modal-outer').css('display', 'none');
  $(".list.chow-scrollbar").empty();
})

$('.btn-confirm').on('click', () => {
	$('.modal-outer').css('display', 'none');
	$(".list.chow-scrollbar").empty();
})

// 3. 모달창 - 닉네임 클릭 시 해당 유저 프로필 이동
$(document).on('click', '.nickname', function(event) {
    location.href = fnGetContextPath() + '/user/profile.do?userNo=' + $(this).data('userNo');
});

// 4. 업로드한 프로젝트 버튼 클릭 시
$('.list-item').eq(0).on('click', () => {
  $('.list-item').eq(0).css('color', '#00b57f');
  $('.list-item').eq(1).css('color', 'black');
	$('.list-body').empty();
	fnGetUserUploadList();
});

// 5. 좋아요 프로젝트 버튼 클릭 시
$('.list-item').eq(1).on('click', () => {
	$('.list-item').eq(0).css('color', 'black');
	$('.list-item').eq(1).css('color', '#00b57f');
	$('.list-body').empty();
	fnGetUserLikeList();
})

// 6. 업로드 및 좋아요한 프로젝트 - 상세보기
$(document).on('click', '.card', function(event) {
	location.href = fnGetContextPath() + '/post/detail.do?postNo=' + $(this).data('postNo');
});




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
      'page': FollowingPage
    })
   })
   .then(response=> response.json())
   .then(resData=> { // resData - {"followingList": [...], "totalPage":3}
   
    $('.modal-title').text('팔로잉');  
      
    // totalPage 갱신
    FollowingTotalPage = resData.totalPage;
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
          str += '      <div class="profile-modal-image-wrapper profile-modal-image-medium">';
        if(following.miniProfilePicturePath !== null) {
        	str += following.miniProfilePicturePath;
        } else {
          str += '        <img alt="avatar-image" src="../resources/img/default_profile_image.png" draggable="false" width=40px>';
        } 
          str += '      </div>';
          str += '    </div>';
          str += '    <span class="nickname" data-user-no="' + following.userNo + '">' + following.name + '</span>';
          str += '  </div>';
          str += '  <div class="button-wrapper list">';
      
          if(following.isFollow === 1) {
            str += '    <button class="btn-detail btn-modal-unfollow" id="following_' + following.userNo + '" data-user-no="' + following.userNo + '">';
            str += '      <div class="btn-text">팔로잉</div>';
            str += '    </button>';
          } else {
            str += '    <button class="btn-detail btn-modal-follow" id="following_' + following.userNo + '" data-user-no="' + following.userNo + '">';
            str += '      <div class="btn-text">팔로우</div>';
            str += '    </button>';
          }
            str += '  </div>';
            str += '</div>';
           $(".list.chow-scrollbar").append(str);
          
          // 그 다음 버튼 디자인을 변경해준다.
          if(resData.hasFollow != 0) {
            // 언팔로우로 변경..(팔로우)
            var buttonId = 'following_' + following.userNo;
            var buttonElement = $('#' + buttonId);
            
            buttonElement.text('팔로잉');
            buttonElement.css('background-color', 'white');
            buttonElement.css('color', '#00b57f');
            buttonElement.css('border-color', '#00b57f');
            buttonElement.attr('class', 'btn-detail btn-modal-unfollow');
          
          } else {
            // 팔로우로 변경..(팔로잉)
              var buttonId = 'following_' + following.userNo
              var buttonElement = $('#' + buttonId);
            
              buttonElement.text('팔로우');
              buttonElement.css('background-color', '#00b57f');
              buttonElement.css('color', 'white');
              buttonElement.css('border-color', '#00b57f');
              buttonElement.attr('class', 'btn-detail btn-modal-follow');
          }

        })
     })
 }) 
 
}

// 팔로워 리스트 가져오기
const fngetFollowerList = () => {
	
	console.log('팔로워 리스트 가져옴');
	
    // 팔로잉 & 팔로워 유저 데이터 가져오기
    fetch(fnGetContextPath() + '/user/getFollowerList.do', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'profileUserNo': $('.user-body').data('userNo'),
        'page': FollowerPage
      })
     })
     .then(response=> response.json())
     .then(resData=> { // resData - {"followerList": [...], "totalPage":3}
     
        $('.modal-title').text('팔로워');  
        // totalPage 갱신
        FollowerTotalPage = resData.totalPage;
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
            if(follower.miniProfilePicturePath !== null) {
                str += follower.miniProfilePicturePath;
              } else {
                str += '        <img alt="avatar-image" src="../resources/img/default_profile_image.png" draggable="false" width=40px>';
              }     
            str += '        <img alt="avatar-image" src="../resources/img/default_profile_image.png" draggable="false" width=40px>';
            str += '      </div>';
            str += '    </div>';
            str += '    <span class="nickname" data-user-no="' + follower.userNo + '">' + follower.name + '</span>';
            str += '  </div>';
            str += '  <div class="button-wrapper list">';
          
            if(follower.isFollow === 1) {
              str += '    <button class="btn-detail btn-modal-unfollow" id="following_' + follower.userNo + '" data-user-no="' + follower.userNo + '">';
              str += '      <div class="btn-text">팔로우</div>';
              str += '    </button>';
            } else {
              str += '    <button class="btn-detail btn-modal-follow" id="following_' + follower.userNo + '" data-user-no="' + follower.userNo + '">';
              str += '      <div class="btn-text">팔로잉</div>';
              str += '    </button>';
            }
              str += '  </div>';
              str += '</div>';
              $(".list.chow-scrollbar").append(str);
              
            // 그 다음 버튼 디자인을 변경해준다.
            if(resData.hasFollow != 0) {
              // 언팔로우로 변경..(팔로우)
              var buttonId = 'following_' + follower.userNo;
              var buttonElement = $('#' + buttonId);
              buttonElement.text('팔로잉');
              buttonElement.css('background-color', 'white');
              buttonElement.css('color', '#00b57f');
              buttonElement.css('border-color', '#00b57f');
              buttonElement.attr('class', 'btn-modal-unfollow');
              
            } else {
              // 팔로우로 변경..(팔로잉)
              var buttonId = 'following_' + follower.userNo;
              var buttonElement = $('#' + buttonId);
              buttonElement.text('팔로우');
              buttonElement.css('background-color', '#00b57f');
              buttonElement.css('color', 'white');
              buttonElement.attr('class', 'btn-modal-follow');
          }
        })
       })
   }) 
   
}


// 팔로우 - 프로필
const fnFollow = (check) => {
	
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
          check = true;
          // 테스트
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
        check = false;
        // 테스트
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
    $('#btn-follow').css('background-color', '#425052');
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

// 무한 스크롤 - 팔로잉
const fnFollwingScrollHandler = () => {
  var timerId;
  $('.chow-scrollbar').on('scroll', (evt) => {
    if(timerId) {  
      clearTimeout(timerId);
    }
    timerId = setTimeout(() => {
    let scrollTop = window.scrollY;  // $(window).scrollTop();
    let windowHeight = window.innerHeight;  // $(window).height();
    let modalHeight = 290;
      if((modalHeight - scrollTop - windowHeight) < 50) {  
        if(FollowingPage > FollowingTotalPage) {
          return;
        }
        FollowingPage++;
        fngetFollowingList();
      }
    }, 500);
  })
}

// 무한 스크롤 - 팔로워
const fnFollwerScrollHandler = () => {
  console.log('무한스크롤 - 팔로워 리스트');
	
  var timerId;
  $('.chow-scrollbar').on('scroll', (evt) => {
    if(timerId) {  
      clearTimeout(timerId);
    }
    timerId = setTimeout(() => {
    let scrollTop = window.scrollY;  // $(window).scrollTop();
    let windowHeight = window.innerHeight;  // $(window).height();
    let modalHeight = 290;
    
    
      if((modalHeight - scrollTop - windowHeight) < 50) {  
        if(FollowerPage > FollowerTotalPage) {
          return;
        }
        FollowerPage++;
        console.log('FollowerPage', FollowerPage);
        console.log('FollowerTotalPage', FollowerTotalPage);
        fngetFollowerList();
      }
    }, 500);
  })
}

// 프로필 유저가 업로드한 게시물 가져오기
const fnGetUserUploadList = () => {
  fetch(fnGetContextPath() + '/post/getUserUploadList.do?userNo=' + $('.user-body').data('userNo') + '&page=' + UploadListPage)
  .then(response=>response.json())
  .then(resData=> {
    UploadListTotalPage = resData.totalPage;
    $.each(resData.userUploadList, (i, upload) => {
      var thumbnailUrl = extractFirstImage(upload.contents);
      let str = '<div class="card-wrap card" data-post-no="' +upload.postNo+ '">';
      // str += displayThumbnail(thumbnailUrl);
      str += '  <div class="card-image" style="background-image: url(' + thumbnailUrl + ');">';
      str += '    <div class="card-item-wrap">';
      str += '      <div class="card-options has-inner-option">';
      str += '    <div class="card-options-header" data-post-no="' + upload.postNo+ '">';
      str += '      <div class="like-button"><i class="fa-regular fa-heart" style="color: #ffffff;"></i></div>';
      str += '    </div>';
      str += '    <div class="card-options-body">';
      str += '      <div class="options-title-wrap">';
      str += '        <span class="option-title">' + upload.title + '</span>';
      str += '        <span class="option-title">' + moment(upload.createDt).format('YYYY.MM.DD.') + '</span>';
      str += '      </div>';
      str += '    <div class="options-bottom-wrap">';
      str += '      <div class="card-bottom-wrap">';
      str += '        <div class="card-bottom-profile">';
      str += '          <div clas="profile-image-wrap">';
      str += '            <div class="profile-image-wrapper profile-image-xsmall">';
    if(upload.user.miniProfilePicturePath !== null) {
      str += upload.user.miniProfilePicturePath;
    } else {
      str += '        <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png">';
    }  
      str += '            </div>';
      str += '            <span class="profile-name" style="color: white;">' + upload.user.name + '</span>';
      str += '          </div>';
      str += '        </div>';
      str += '        <div class="card-bottom-options">';
      str += '          <div class="card-bottom-option like-button">';
      str += '            <i class="fa-regular fa-heart" style="color: #ffffff;"></i>';
      str += '            <span id="like-count-' + upload.postNo + '" class="bottom-option-name">3</span>';
      str += '          </div>';
      str += '          <div class="card-bottom-option">';
      str += '            <i class="fa-regular fa-eye" style="color: #ffffff;"></i>';
      str += '            <span class="bottom-option-name">' + upload.hit + '</span>';     
      str += '          </div>';
      str += '       </div>';
      str += '    </div>';
      str += '  </div>';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      $('.list-body').append(str);
      
        // 서버에서 likecount 를 받아와서 업데이트
        fnGetLikeCountByPostNo(upload.postNo)
          .then(result => {
            // id="like-count-' + post.postNo 내용을 바꿔줌
            $('#like-count-' + upload.postNo).html(result); 
          })
          .catch(error => {
            console.error(error);
            $('#like-count-' + upload.postNo).html('Error');
          });     
    })
    if('${sessionScope.user}' !== '') {
      fnLikeCheck();
    }
  })
}

// 업로드 게시글 페이지 용 무한 스크롤
const fnUploadListScrollHandler = () => {

    var timerId; 
    $(window).on('scroll', (evt) => {
      if(timerId) { 

        clearTimeout(timerId); 
      }

      timerId = setTimeout(() => {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();
        
        if( (scrollTop + windowHeight + 30) >= documentHeight ) {  
          if(UploadListPage > UploadListTotalPage) {
            return;
          }
            UploadListPage++;
            fnGetUserUploadList();
        }
      }, 500);
  })
}

//프로필 유저가 좋아요한 게시물 가져오기
const fnGetUserLikeList = () => {
  fetch(fnGetContextPath() + '/post/getUserLikeList.do?userNo=' + $('.user-body').data('userNo') + '&page=' + LikeListPage)
  .then(response=>response.json())
  .then(resData=> {
    LikeListTotalPage = resData.totalPage;
    $.each(resData.userLikeList, (i, like) => {
      var thumbnailUrl = extractFirstImage(like.contents);
      let str = '<div class="card-wrap card" data-post-no="' +like.postNo+ '">';
      // str += displayThumbnail(thumbnailUrl);
      str += '  <div class="card-image" style="background-image: url(' + thumbnailUrl + ');">';
      str += '    <div class="card-item-wrap">';
      str += '      <div class="card-options has-inner-option">';
      str += '    <div class="card-options-header" data-post-no="' +like.postNo+ '">';
      str += '      <div class="like-button"><i class="fa-regular fa-heart" style="color: #ffffff;"></i></div>';
      str += '    </div>';
      str += '    <div class="card-options-body">';
      str += '      <div class="options-title-wrap">';
      str += '        <span class="option-title">' + like.title + '</span>';
      str += '        <span class="option-title">' + moment(like.createDt).format('YYYY.MM.DD.') + '</span>';
      str += '      </div>';
      str += '    <div class="options-bottom-wrap">';
      str += '      <div class="card-bottom-wrap">';
      str += '        <div class="card-bottom-profile">';
      str += '          <div clas="profile-image-wrap">';
      str += '            <div class="profile-image-wrapper profile-image-xsmall">';
    if(like.user.miniProfilePicturePath !== null) {
      str += like.user.miniProfilePicturePath;
    } else {
      str += '        <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png">';
    }  
      str += '            </div>';
      str += '            <span class="profile-name" style="color: white;">' + like.user.name + '</span>';
      str += '          </div>';
      str += '        </div>';
      str += '        <div class="card-bottom-options">';
      str += '          <div class="card-bottom-option">';
      str += '            <i class="fa-regular fa-heart" style="color: #ffffff;"></i>';
      str += '            <span id="like-count-' + like.postNo + '" class="bottom-option-name">3</span>';
      str += '          </div>';
      str += '          <div class="card-bottom-option">';
      str += '            <i class="fa-regular fa-eye" style="color: #ffffff;"></i>';
      str += '            <span class="bottom-option-name">' + like.hit + '</span>';     
      str += '          </div>';
      str += '       </div>';
      str += '    </div>';
      str += '  </div>';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      str += '</div>';
      $('.list-body').append(str);
      
        // 서버에서 likecount 를 받아와서 업데이트
        fnGetLikeCountByPostNo(like.postNo)
          .then(result => {
            // id="like-count-' + post.postNo 내용을 바꿔줌
            $('#like-count-' + like.postNo).html(result); 
          })
          .catch(error => {
            console.error(error);
            $('#like-count-' + like.postNo).html('Error');
          });     
    })
    if('${sessionScope.user}' !== '') {
      fnLikeCheck();
    }
  })
}
	
//좋아요 게시글 페이지 용 무한 스크롤
const fnLikeListScrollHandler = () => {

    var timerId; 
    $(window).on('scroll', (evt) => {
      if(timerId) { 

        clearTimeout(timerId); 
      }

      timerId = setTimeout(() => {
        let scrollTop = $(window).scrollTop();
        let windowHeight = $(window).height();
        let documentHeight = $(document).height();
        
        if( (scrollTop + windowHeight + 30) >= documentHeight ) {  
          if(LikeListPage > LikeListTotalPage) {
            return;
          }
            LikeListPage++;
            fnGetUserLikeList();
        }
      }, 500);
  })
}


// 첫번째 이미지 요소 추출하기
const extractFirstImage = (htmlContent) => {
  var div = document.createElement('div');
  div.innerHTML = htmlContent; // HTML 문자열을 DOM으로 변환
  var image = div.querySelector('img'); // 첫 번째 이미지 태그 선택
  return image ? image.src : null; // 이미지의 src 속성 반환	
}


function displayThumbnail(imageUrl) {
  var thumbnail = document.createElement('div'); // div 요소 생성
  thumbnail.className = "card-image"; // class 이름 설정
  thumbnail.style.backgroundImage = 'url("' + imageUrl + '")'; // 배경 이미지 설정
  thumbnail.alt = 'Thumbnail'; // 대체 텍스트 설정

  return thumbnail.outerHTML; // 생성된 HTML 문자열 반환
}

// postNo당 좋아요 수 가져오기
const fnGetLikeCountByPostNo = (postNo) => {
  return fetch('${contextPath}/post/get-like-count-by-postno?postNo=' + postNo, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    }
  })
  .then(response => response.json())
  .then(resData => {
    return resData.likeCount;
  })
  .catch(error => {
      console.log('Error likecount the post.'); // 에러 처리
  });
}

// 좋아요 수 확인
const fnLikeCheck = () => {
    const posts = document.querySelectorAll('.card');
    // 모든 게시물에 대해 'Liked' 상태를 확인
    posts.forEach(post => {
      let postNo = post.dataset.postNo;
      // 서버에서 'liked' 상태 정보를 가져오는 fetch 요청
      fetch('${contextPath}/post/check-like-status?postNo=' + postNo +'&userNo=${sessionScope.user.userNo}', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        }
      })
      .then(response => response.json())
      .then(resData => {
        if (resData.likeCount === 1) {
          post.querySelector('.like-button').classList.add('liked');
          post.querySelector('.like-button').innerHTML = '<i class="fa-solid fa-heart" style="color: #e33861;"></i>';
        }
      })
      .catch(error => {
          console.log('Error likeChecking the post.'); // 에러 처리
      });
    })
  };
  
// 좋아요, 조회수 가져오기
const fnGetLikeCountByUserNo = () => {
  return fetch('${contextPath}/post/get-like-count-by-userNo?userNo=' + $('.user-body').data('userNo'), {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    }
  })
  .then(response => response.json())
  .then(resData => {
    var likeCount = $('.txt-card-count:eq(0)');
    likeCount.text(resData.likeCount);
  })
  .catch(error => {
      console.log('Error likecount the post.'); // 에러 처리
  });
}

const fnGetHitCountByUserNo = () => {
  return fetch('${contextPath}/post/get-hit-count-by-userNo?userNo=' + $('.user-body').data('userNo'), {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    }
  })
  .then(response => response.json())
  .then(resData => {
	  console.log(resData.hitCount);
    var hitCount = $('.txt-card-count:eq(3)');
    hitCount.text(resData.hitCount);
  })
  .catch(error => {
      console.log('Error hitcount the post.'); // 에러 처리
  });
}


// 업로드, 좋아요 게시글 좋아요 기능
const fnPostLike = () => {
  // 좋아요 버튼에 클릭 이벤트 리스너 추가
  $(document).on('click', '.like-button', (evt) => {
      evt.stopPropagation(); // 이벤트 버블링을 중단
      var postNo = evt.target.closest('.card-options-header').dataset.postNo; // 게시물 번호 추출
      var userNo = '${sessionScope.user.userNo}';
      var likeButton = evt.target.closest('.like-button'); // 좋아요 버튼 참조
      if('${sessionScope.user}' === ''){
        fnCheckSignin();
        return;
      }
      // 좋아요 버튼에 'liked' 클래스가 있는지 확인
      if (likeButton.classList.contains('liked')) {
          // 좋아요 취소 요청
          fetch('${contextPath}/post/deletelikepost.do', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/json'
              },
              body: JSON.stringify({ 
                  'postNo': parseInt(postNo, 10),
                  'userNo': parseInt(userNo, 10)
              })
          })
          .then(response => response.json())
          .then(resData => {
              alert('Like removed!'); // 성공 처리
              likeButton.classList.remove('liked');
              likeButton.innerHTML = '<i class="fa-regular fa-heart" style="color: #ffffff;"></i>'; // 빈 하트 아이콘으로 변경
          })
          .catch(error => {
              alert('Error removing like.'); // 에러 처리
          });
      } else {
          // 좋아요 설정 요청
          fetch('${contextPath}/post/likepost.do', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/json'
              },
              body: JSON.stringify({ 
                  'postNo': parseInt(postNo, 10),
                  'userNo': parseInt(userNo, 10)
              })
          })
          .then(response => response.json())
          .then(resData => {
              alert('Liked!'); // 성공 처리
              likeButton.classList.add('liked');
              likeButton.innerHTML = '<i class="fa-solid fa-heart" style="color: #e33861;"></i>';
          })
          .catch(error => {
              alert('Error liking the post.'); // 에러 처리
          });
      }
      return false; // 페이지 리로드 방지
  });
};



  



// 함수 호출
fnCheckFollow();
fnChangeBtn();
fnGetFollowCount();
fnGetLikeCountByUserNo();
fnGetHitCountByUserNo();
fnUploadListScrollHandler();
fnGetUserUploadList();
fnPostLike();

 
</script>
 
 
<%@ include file="../layout/footer.jsp" %>