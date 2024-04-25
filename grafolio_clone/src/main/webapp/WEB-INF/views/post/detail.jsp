<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>



 
 <jsp:include page="../layout/header.jsp">
   <jsp:param value="${post.postNo}번 블로그" name="title"/>
 </jsp:include>
  
  <link rel="stylesheet" href="${contextPath}/resources/css/detail.css?dt=${dt}">
   
 
 <div class=""></div>
 
 <div class="detail-page">
 
 <div class="project-detail-header">
    <div class="title-wraper">
     <div class="tag-wrapper">
       <div class="tag-round tag-round-size-small tag-round-color-gray tag-round-degree-large" id="ca-div">
          <c:choose>
    <c:when test="${post.category eq '0'}">
        전체
    </c:when>
    <c:when test="${post.category eq '1'}">
        일러스트
    </c:when>
    <c:when test="${post.category eq '2'}">
        사진
    </c:when>
    <c:when test="${post.category eq '3'}">
        디자인
    </c:when>
    <c:when test="${post.category eq '4'}">
        회화
    </c:when>
    <c:when test="${post.category eq '5'}">
        조소/공예
    </c:when>
    <c:when test="${post.category eq '6'}">
        사운드
    </c:when>
    <c:when test="${post.category eq '7'}">
        애니메이션
    </c:when>
    <c:when test="${post.category eq '8'}">
        캘리그라피
    </c:when>
    <c:otherwise>
        기타
    </c:otherwise>
</c:choose>
          </div>
        </div>
       <div class="title-inner-wrapper">
        <span class="title-txt">${post.title}</span>
       </div>
         
    </div>
 
 </div>
  
  
  
  
  
    <div>
      
    </div>
    
    
    
    <div class="content-wrapper" style="backround-color:rgb(255,255,255)">
      <div class="content-wrapper-upper">
        <article class="content-article">
          <div class="block">
            <div class="content">
              <div class="content-figure">
                <div class="content-image-wrap">
                  ${post.contents}
                </div>
              </div>
            </div>
          </div>
        </article>
        
        <div class="content-bottom-wrapper">
          <div class="tab-wrapper">
            
          </div>
          <div class="figure-data-wrapper">
            <div class="figure-data">
              <i class="fa-regular fa-heart" width="10px;"></i>
              
            </div>
            <div class="figure-data">
              <i class="fa-regular fa-eye" width="10px"></i>
            </div>
            <div class="figure-data">
              <i class="fa-regular fa-comment" width="10px"></i>            
            </div>
          </div>
        </div>
      </div>
    
    
     <div class="navigation">
    <div class="profile-wrapper" width="24" height="24"> 
      <div class="profile-avatar-wrapper">
        <div class="dropdwon-outer">
          <div class="dropdwon-trigger-block">
            <div class="dropdwon-trigger-wrapper">
              <div class="profile-image-wrap avatar owner" id="profile-move" data-user-no="${post.user.userNo}">
                <div class="profile-image-wrapper profile-image-medium">
                  <c:if test="${user.miniProfilePicturePath != null}">
                     ${user.miniProfilePicturePath}
                    </c:if>
                    <c:if test="${user.miniProfilePicturePath == null}">
                     <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png"  width="40">
                    </c:if>
                  
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
     </div>
      <ul class="menu-wrapper">
        <!-- <div class="avatar-wrapper-hidden">
          <div class="profile-image-wrap avatar participant">
            <div class="profile-image-wrapper profile-image-medium">
              
            </div>
          </div>
        </div> -->
        <div class="icon-wrapper">          
           <button type="button" class="like-button" id="post"  data-post-no="${post.postNo}">
           <i class="fa-regular fa-heart" id="icon-heart"  width="24" height="24"></i></button>                  
      </div>
      <div class="icon-wrapper">
         <!-- 폰트 어썸 아이콘 사용 -->
         <i class="fas fa-thin fa-share-nodes" id="share-icon" style="cursor: pointer;"></i>
         
         <!-- 모달 -->
         <div id="myModal" class="modal">
           <div class="modal-content">
             &nbsp;링크가 복사되었습니다.
         </div>
          
        
      </div>  
      
      </ul>  
    <!-- class="navigation" -->
  </div>
        
    
    
    </div>
    
  
    
    <c:if test="${sessionScope.user.userNo == post.user.userNo}">
      <form id="frm-btn" method="POST">  
        <input type="hidden" name="postNo" value="${post.postNo}">
        <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
        <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
      </form>
    </c:if>
 
  
 
  
  
  
  
  
  
  
  <div class="comment-section">
 
  
   <div id="comment-list">
     <div class="comment-item">
     </div>   
   </div>
  <div id="paging"></div>
  
  </div>
  
  <form id="frm-comment" class="form">
  <div class="input-wrapper">
   <div  class="profile-image-wrap">
   <div class="profile-image-wrapper profile-image-medium">
    <c:if test="${sessionScope.user.userNo != null}">
           ${sessionScope.user.miniProfilePicturePath}
          </c:if>
    </div>      
   </div>
   <div class="input-outer input-stretch">
    <div data-v-ec5e8f9c class="input-wrapper">
      <div class="input-inner-wrap">
        <input type="text" id="contents" name="contents" placeholder="댓글을 입력해주세요"></input>
        <button id="btn-comment-register" type="button" disabled class="btn btn-size-small btn-color-black button write-button">
        <div data-v-2862dfae class="btn-text">
          등록하기
        </div>
      </button> 
      </div>
   </div>
    </div>
   </div>
      
      <input type="hidden" name="postNo" value="${post.postNo}">
      <c:if test="${not empty sessionScope.user}">
        <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
      </c:if>
  </form>
  
  <div class="info-wrapper">
    <div>
      <div class="tooltip-title">
       <div class="title-wrapper">
        <span id="comment-bottom" class="tooltip-wrapper">© All Rights Reserved</span>
       </div> 
      </div>    
     </div>   
  </div>
 
  
  <div class="project-section">
    <div class="head">
      <div class="head-left" id="profile-list-move">
        <div class="profile-image-wrap avatar" id="avatar">
          <div  class="profile-image-wrapper profile-image-medium" >
           <c:if test="${user.miniProfilePicturePath != null}">
                     ${user.miniProfilePicturePath}
          </c:if>
           <c:if test="${user.miniProfilePicturePath == null}">
                     <img class="default-profile-image" alt="default-profile-image" src="../resources/img/default_profile_image.png"  width="40">
          </c:if>
          </div>
        </div>
        
      </div>
      <div class="head-right">
        <div class="figure-wrapper">
          
        </div>
        <button data-v-2862dfae data-v-e3383a90  class="btn btn-size-small btn-color-primary btn-rounded follow-button" id="btn-follow">
          <div data-v-09a3cce7 class="btn-text">
            팔로우 하기
          </div>
        </button>
      </div>
    </div>
     <ul data-v-e3383a90 class="list">
      <button data-v-57eb2394 data-v-e3383a90 class="btn-text btn-disabled"  id="left-move" disabled style="cursor:not-allowed;">
        <svg class="arrow-icon left" width="24" height="24" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512" ><path d="M9.4 233.4c-12.5 12.5-12.5 32.8 0 45.3l192 192c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3L77.3 256 246.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0l-192 192z"/>
        </svg>
      </button>
      <section data-v-e3383a90 class="carousel carousel__wrapper" dir="ltr" aria-label="Gallery" tabindex="0">
        <div class="carousel__viewport">
          <ol class="carousel__track" style="transform: translateX(0px); transition: all 0ms ease 0s; width: 100%;" id="each-start">
            
          </ol>
        </div>
        <div class="carousel__liveregion carousel__sr-only" aria-live="polite" aria-atomic="true">Item 1 of 10</div>
      </section>
      
      <button data-v-57eb2394 data-v-e3383a90 class="btn-text" id="right-move" >
        <svg class="arrow-icon right" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 512"><path d="M310.6 233.4c12.5 12.5 12.5 32.8 0 45.3l-192 192c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3L242.7 256 73.4 86.6c-12.5-12.5-12.5-32.8 0-45.3s32.8-12.5 45.3 0l192 192z"/>
        </svg>
      </button>
    </ul>
  </div>
  
  <div data-v-42056357 width="24" height="24" class="arrow-wrapper">
    <i data-v-42056357 width="24" height="24" class="fa-solid fa-chevron-up" id="scrollToTopBtn"></i>
    <i data-v-42056357 width="24" height="24" class="fa-solid fa-chevron-down" id="scrollToBottomBtn"></i>
  </div>
  

 
  
  
</div>  


  <script>
  
  console.log('${sessionScope.user.miniProfilePicturePath}');
  
  // 팔로잉 여부
  var checkFollow = false;
  var hasLogin = true;
  //팔로우 or 언팔로우
  var check = false;
  
  
  // 게시물 4개씩 이동
  let firstValue= 4;
  let currentIndex = 0; // 현재 보여지고 있는 슬라이드의 인덱스
  leftMoveBtn = document.getElementById('left-move');
  rightMoveBtn = document.getElementById('right-move');

//왼쪽 이동 버튼 클릭 시
  document.getElementById('left-move').addEventListener('click', function() {
      moveSlides(-4); // 왼쪽으로 이동
  });

  //오른쪽 이동 버튼 클릭 시
  document.getElementById('right-move').addEventListener('click', function() {
      moveSlides(4); // 오른쪽으로 이동
      $('#left-move').css('display', 'block');
  });

  function moveSlides(n) {
      const slides = document.getElementsByClassName('carousel__slide');
      const totalSlides = slides.length;

      // 새로운 인덱스 계산
      let newIndex = currentIndex + n;

      // 게시물이 4개 이하인 경우 버튼을 숨김
      if (totalSlides <= 4) {
          leftMoveBtn.style.display = 'none';
          rightMoveBtn.style.display = 'none';
      } else {
          leftMoveBtn.style.display = 'block';
          rightMoveBtn.style.display = 'block';
      }

      // 새로운 인덱스가 음수일 경우 현재 인덱스로 유지하고 버튼을 비활성화
      if (newIndex < 0) {
          leftMoveBtn.disabled = true;
          leftMoveBtn.style.cursor = 'not-allowed';
          return;
      } else {
          leftMoveBtn.disabled = false;
          leftMoveBtn.style.cursor = 'pointer'; // 다시 활성화될 때 커서 스타일을 변경
      }

      // 모든 슬라이드를 숨김
      for (let i = 0; i < totalSlides; i++) {
          slides[i].style.display = 'none';
      }

      // 새로운 인덱스부터 보여줄 슬라이드 수 계산
      let slidesToShow = Math.min(4, totalSlides - newIndex); // 남은 슬라이드 수와 4 중 작은 값을 사용

      // 새로운 인덱스부터 보여줄 슬라이드를 순환하여 표시
      for (let i = 0; i < slidesToShow; i++) {
          slides[newIndex + i].style.display = 'block';
      }

      // 현재 인덱스 업데이트
      currentIndex = newIndex;

      // 남은 인덱스가 4개보다 적으면 오른쪽 버튼 비활성화
      if (slidesToShow < 4) {
          rightMoveBtn.disabled = true;
          rightMoveBtn.style.cursor = 'not-allowed';
      } else {
          rightMoveBtn.disabled = false;
          rightMoveBtn.style.cursor = 'pointer'; // 다시 활성화될 때 커서 스타일을 변경
      }
  }

  
  
  
//Function to scroll to the top of the page
  function scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }

  // Event listener for the scroll to top button
  document.getElementById('scrollToTopBtn').addEventListener('click', scrollToTop);

  // Show or hide the scroll to top button based on scroll position
  window.addEventListener('scroll', function() {
    var scrollToTopBtn = document.getElementById('scrollToTopBtn');
    if (window.scrollY > 100) {
      scrollToTopBtn.style.display = 'block';
    } else {
      scrollToTopBtn.style.display = 'block';
    }
  });
  
  
  function scrollToBottom() {
    window.scrollTo({
      top: document.documentElement.scrollHeight,
      behavior: 'smooth'
    });
  }

  // Event listener for the scroll to bottom button
  document.getElementById('scrollToBottomBtn').addEventListener('click', scrollToBottom);

  // Show or hide the scroll to bottom button based on scroll position
  window.addEventListener('scroll', function() {
    var scrollToBottomBtn = document.getElementById('scrollToBottomBtn');
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 100) {
      scrollToBottomBtn.style.display = 'block';
    } else {
      scrollToBottomBtn.style.display = 'block';
    }
  });
  
  var loadPage = 1
  
  const fnGetUploadList = () => { 
      let userNo = document.getElementById('profile-move').dataset.userNo;
      fetch('${contextPath}/post/getUserUploadList.do?userNo=' + userNo + '&page=' + loadPage, {
        method: 'GET'
      })
      .then(response => response.json())
      .then(resData => {
        console.log(resData.userUploadList);
        let str2 = '<span  class="nickname">'+resData.userUploadList[0].user.name+'</span>';
        $('.head-left').append(str2);
        $.each(resData.userUploadList, (i, uploadList) => {
          
          var thumbnailUrl = extractFirstImage(uploadList.contents);
          let str ='<li  class="carousel__slide carousel__slide--visible carousel__slide--active" style="width:25%">';
            str +=  '<div  class="card-wrap card" id="cardbtn" data-post-no="' + uploadList.postNo + '">';
            str +=  '<div  class="card-image" style="background-image: url('+ thumbnailUrl +');">';
            str +=  '<div  class="card-item-wrap">';
            str +=  '<div  class="card-options has-inner-option">';
            str +=  '<div  class="card-options-header card-header-detail">';
            str += '<i  width="24" height="24 class="fa-regular fa-heart"></i>';
            str += '</div>';
            str += '<div  class="card-options-body card-body-detail">';
            str += '<div  class="options-title-wrap">';
            str += '<span  class="option-title">'+uploadList.title+'</span>';
            str += '<span  class="option-title"></span>';
            str += '</div>';
            str += '<div  class="options-bottom-wrap">';
            str += '<div  class="card-bottom-wrap">';
            str += '<div  class="card-bottom-options">';
            str += '<div  class="card-bottom-option white">';
            str += '<i  class="fa-regular fa-heart" style="color: #fff;"></i>';
            str += '<span  class="bottom-option-name" id="like-count-'+uploadList.postNo+'"></span>';
            str += '</div>';
            str += '<div  class="card-bottom-option white">';
            str += '<i  class="fa-regular fa-eye" style="color: #fff;"></i>';
            str += '<span class="bottom-option-name">'+uploadList.hit+'</span>';
            str += '</div>';
            str += ' </div>';
            str += '</div>';
            str += '</div>';
            str += '</div>';
            str += '</div>';
            str += '</div>';
            str += '</div>';
            str += '</div>';
            str += '</li>';
            $('#each-start').append(str); 
           
            fnGetLikeCountByPostNo(uploadList.postNo)
              .then(result => {
                $('#like-count-' + uploadList.postNo).html(result); // Update the like count placeholder with actual data
              })
             .catch(error => {
               console.error(error);
               $('#like-count-' + uploadList.postNo).html('Error'); // Display error in the like count placeholder
             });
            if('${sessionScope.user}' !== ''){
            	getLikeStatus();
               }
          fnPostMove();
        }) 
        
      })
       .catch(error => {
              console.error('데이터를 불러오는 중 오류가 발생했습니다:', error);
          });
      
      
    } 
 
  
  
  function extractFirstImage(htmlContent) {
        var div = document.createElement('div');
        div.innerHTML = htmlContent; // HTML 문자열을 DOM으로 변환
        var image = div.querySelector('img'); // 첫 번째 이미지 태그 선택
        return image ? image.src : null; // 이미지의 src 속성 반환
    }
  
  // 게시물로 이동
  const fnPostMove = ()=>{
	  document.querySelectorAll('.card-wrap').forEach(card => {
		    let postNo = card.dataset.postNo;
		    card.addEventListener('click', (evt) => {
		        location.href= '${contextPath}/post/detail.do?postNo=' + postNo;
		    });
		});
    }
  
  
  // 프로필로이동
  const profileMove = ()=>{
    let userNo = document.getElementById('profile-move').dataset.userNo;
    let profile = document.getElementById('profile-move');
    profile.addEventListener('click', (evt)=>{
      location.href= '${contextPath}/user/profile.do?userNo=' + userNo;
      
    })
    
    }
  
  // 리스트에서 프로필로 이동
  const profilListeMove = ()=>{
    let userNo = document.getElementById('profile-move').dataset.userNo;
    let profile = document.getElementById('profile-list-move');
    profile.addEventListener('click', (evt)=>{
      location.href= '${contextPath}/user/profile.do?userNo=' + userNo;
      
    })
    
    }
  
   // 조회수
  const fnGetHitCountByPostNo = () => {
	  let btnLike = document.getElementById('post');
    let postNo = btnLike.dataset.postNo;
    fetch('${contextPath}/post/get-hit-count-by-postno?postNo=' + postNo,{
    	method: 'GET',
    })
    .then(response => response.json())
    .then(resData => {
    	 let str = '<div>';
        str += '<span>' + resData.hitCount + '</span>'; // resData는 댓글 수를 나타냅니다.
        str += '</div>';
        
        const n = 1; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
        $('.figure-data-wrapper').find('.figure-data').eq(n).append(str);
    })
      .catch(error => {
    	  alert('Error getting hit count: ' + error); // 에러 처리
      })
  }
  
  const fnGetCommentCountByPostNo = () => {
      // 댓글 받아오기
      let btnLike = document.getElementById('post');
      let postNo = btnLike.dataset.postNo;
      fetch('${contextPath}/post/get-comment-count-by-postno?postNo=' + postNo , {
          method: 'GET',
      }) 
      .then(response => response.json())
      .then(resData => {
          let str = '<div>';
          str += '<span>' + resData.commentCount + '</span>'; // resData는 댓글 수를 나타냅니다.
          str += '</div>';
          
          const n = 2; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
          $('.figure-data-wrapper').find('.figure-data').eq(n).append(str);
      })
      .catch(error => {
          alert('Error getting comment count: ' + error); // 에러 처리
      });
  } 
  
  
  
  // 팔로우 하기
const fnFollow = () => {
    if (!checkFollow) {
        // 팔로우 요청
        fetch('${contextPath}/user/follow.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                'toUser': $('#profile-move').data('userNo')
            })
        })
        .then(response => response.json())
        .then(resData => {
            if (resData.insertFollowCount === 1) {
                checkFollow = true;
                let btnFollow = document.getElementById('btn-follow');
                btnFollow.textContent = '팔로잉';
            }
        })
    } else {
        // 언팔로우 요청
        fetch('${contextPath}/user/unfollow.do', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                'toUser': $('#profile-move').data('userNo')
            })
        })
        .then(response => response.json())
        .then(resData => {
            if (resData.deleteFollowCount === 1) {
                checkFollow = false;
                let btnFollow = document.getElementById('btn-follow');
                btnFollow.textContent = '팔로우 하기';
            }
        })
    }
}

// 팔로우 버튼 클릭 이벤트 처리
let btnFollow = document.getElementById('btn-follow');
btnFollow.addEventListener('click', (evt) => {
    fnCheckSignin();
    if (!hasLogin) {
        return;
    } else {
        // 로그인 상태일 때만 팔로우 기능 수행
        fnFollow();
    }
});

// 팔로잉 여부 조회 및 버튼 텍스트 변경
const fnCheckFollow = () => {
    fetch('${contextPath}/user/checkFollow.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            'toUser': $('#profile-move').data('userNo')
        })
    })
    .then(response => response.json())
    .then(resData => {
        let btnFollow = document.getElementById('btn-follow');
        if (resData.hasFollow !== 0) {
            checkFollow = true;
            btnFollow.textContent = '팔로잉';
        } else {
            checkFollow = false;
            btnFollow.textContent = '팔로우 하기';
        }
    })
}
  
  // 전체 좋아요
  const fnGetLikeCountByUserNo = () => {
	    
	    let userNo = document.getElementById('profile-move').dataset.userNo;
	     fetch('${contextPath}/post/get-like-count-by-userNo?userNo=' + $('#profile-move').data('userNo'), {
	      method: 'GET',
	      headers: {
	        'Content-Type': 'application/json',
	      }
	    })
	    .then(response => response.json())
	    .then(resData => {
	      let str = '<span>좋아요 '+resData.likeCount+'</span>';
	      $('.figure-wrapper').append(str);
	      
	    })
	    .catch(error => {
	        console.log('Error likecount the post.'); // 에러 처리
	    });
	  }
  
  // 전체 팔로워 수
  const fnGetFollowCount = () => {
	  
	  fetch(  '${contextPath}/user/getFollowCount.do?', {
	      method: 'POST',
	      headers: {
	        'Content-Type': 'application/json'
	      },
	      body: JSON.stringify({
	        'userNo': $('#profile-move').data('userNo')
	      })
	    })
	    .then(response=> response.json())
	    .then(resData=> {
	    	let str = '<span>팔로워 '+resData.followerCount+'</span>';
	      $('.figure-wrapper').append(str);
	    })
	}
  
  // 전체 조회 수
  const fnGetHitCountByUserNo = () => {
	  let userNo = document.getElementById('profile-move').dataset.userNo;
	   fetch('${contextPath}/post/get-hit-count-by-userNo?userNo=' + $('#profile-move').data('userNo'), {
	    method: 'GET',
	    headers: {
	      'Content-Type': 'application/json',
	    }
	  })
	  .then(response => response.json())
	  .then(resData => {
	    
		  let str = '<span>조회수 '+resData.hitCount+'</span>';
	     $('.figure-wrapper').append(str);
	  })
	  .catch(error => {
	      console.log('Error hitcount the post.'); // 에러 처리
	  });
	}
  
  
  
  const fnCheckSignin = () => {
   
      if('${sessionScope.user}' === '') {
        if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
          location.href = '${contextPath}/user/signin.page';
        }
      }
    }
  
  const fnPostLike = () => {
      // 좋아요 버튼에 클릭 이벤트 리스너 추가
      $(document).on('click', '.like-button', (evt) => {
          evt.stopPropagation(); // 이벤트 버블링을 중단
          var postNo = evt.target.closest('.like-button').dataset.postNo; // 게시물 번호 추출
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
                  likeButton.innerHTML = '<i class="fa-regular fa-heart" style="color: #000000;"></i>'; // 빈 하트 아이콘으로 변경
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




const getLikeStatus = () => {
      var postNo = $('.like-button').data('postNo');
      var userNo = '${sessionScope.user.userNo}';
      fetch('${contextPath}/post/check-like-status?postNo=' + postNo + '&userNo=' + userNo)
          .then(response => response.json())
          .then(resData => {
              if (resData.likeCount > 0) {
                  $('.like-button').addClass('liked');
                  $('.like-button').html('<i class="fa-solid fa-heart" style="color: #e33861;"></i>');
              } else {
                  $('.like-button').removeClass('liked');
                  $('.like-button').html('<i class="fa-regular fa-heart" style="color: #000000;"></i>');
              }
          })
          .catch(error => {
              console.log('Error getting like status:', error);
          });
  };
  
  
     const fnGetLikeCountByPostNo2 = () => {
         let btnLike = document.getElementById('post');
         let postNo = btnLike.dataset.postNo;
         fetch('${contextPath}/post/get-like-count-by-postno?postNo=' + postNo, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            
          }
        })
        .then(response => response.json())
        .then(resData => {
            
          let str ='<div>'
          str += '<span>' + resData.likeCount+ '</span>';
          str += '</div>';
          
         
          
            const n = 0; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
            $('.figure-data-wrapper').find('.figure-data').eq(n).append(str);
          
        })
        .catch(error => {
            console.log('Error likecount the post.'); // 에러 처리
        });
      }
 
  
   
  
  //navigation
  window.addEventListener('resize', function() {
      var navigation = document.querySelector('.navigation');
      var windowWidth = window.innerWidth;
      var leftPosition = windowWidth * 0.8;
      
      navigation.style.left = leftPosition + 'px';
      
  });
  
  window.addEventListener('resize', function() {
      var navigation = document.querySelector('form.form');
      var windowWidth = window.innerWidth;
      var scrollbarWidth = window.innerWidth - document.documentElement.clientWidth; // 스크롤바의 너비 계산
      var rightPosition = (windowWidth - scrollbarWidth) * 0.8; // 스크롤바를 고려하여 오른쪽 위치 계산
      
      navigation.style.right = rightPosition + 'px';
  });
  
  
  // header 상단고정 후 움직임
  window.addEventListener('scroll', function() {
      var header = document.querySelector('.project-detail-header');
      var headerJsp = document.querySelector('.header-wrap');

      if (header && headerJsp) {
          var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
          var headerHeight = header.offsetHeight;

          if (scrollTop > headerHeight) {
              header.style.position = 'fixed';
              header.style.top = '0';
              headerJsp.style.position = 'fixed';
              headerJsp.style.top = '0';
              headerJsp.style.backgroundColor = 'rgb(255,255,255)';
              headerJsp.style.zIndex = '1000';
          } else {
              header.style.position = 'static';
              headerJsp.style.position = 'static';
          }
      }
  });
 
  
  // commentBottom
  document.getElementById('comment-bottom').onclick = (evt)=>{
    alert('저작권자의 허가 없이 무단복제 및 도용, 2차 가공 및 공유 금지');
    
      
    }
  
  
  let nowUrl = window.location.href;

  function copyUrl(){ 
    //nowUrl 변수에 담긴 주소를
      navigator.clipboard.writeText(nowUrl).then(res=>{
      alert("주소가 복사되었습니다!");
    })
  }
   
  
  const fnKeyup = ()=> {
    let btnChange = document.getElementById('btn-comment-register');
    document.getElementById('contents').addEventListener('input', (evt)=>{
      if( evt.target.value !== ''){
        btnChange.style.backgroundColor = 'rgba(0,240,0,0.5)';
        btnChange.style.color = 'rgba(0,240,0,0.5)';
        btnChange.disabled = false;
      } else {
        btnChange.disabled = true;
        btnChange.style.backgroundColor = 'rgb(130,130,130)';
      }
    })
  }
  
    
    
    const fnRegisterComment = () => {
      $('#btn-comment-register').on('click', (evt) => {
        if('${sessionScope.user}' === ''){
          fnCheckSignin();  
        }
        else{
          $.ajax({
            // 요청
            type: 'POST',
            url: '${contextPath}/post/registerComment.do',
            // <form> 내부의 모든 입력을 파라미터 형식으로 보낼 때 사용
            // 입력 요소들은 name 속성을 가지고 있어야 함
            data: $('#frm-comment').serialize(),
            // 응답
            dataType: 'json',
            success: (resData) => { // resData => {"insertCount": 1}
              if(resData.insertCount === 1){
                alert('댓글이 등록되었습니다.');
                $('#contents').val('');
                // 댓글 목록 보여주는 함수
                fnCommentList();
              } else {
                alert('댓글 등록이 실패했습니다');
              }
            },
            error: (jqXHR) => {
              alert(jqXHR.statusText + '(' + jqXHR.status + ')');
            }
          })
        }
      })
    }
    
    // 전역 변수
    
    
    
    
    var page = 1;
    
    const fnCommentList = () => {
      $.ajax({
        type: 'GET',
        url: '${contextPath}/post/comment/list.do',
        data: 'postNo=${post.postNo}&page=' + page,
        dataType: 'json',
        success: (resData) => { // resData = {"commentList": [], "paging": "< 1 2 3 4 5 >"}
          let commentList = $('.comment-item');
          let paging = $('#paging');
          let profileWrap = $('.profile-image-wrap-avatar')
          commentList.empty();
          paging.empty();
          if(resData.commentList.length === 0){
            commentList.append('<div>댓글이 없습니다.</div>');
            paging.empty();
            return;
          }
          $.each(resData.commentList, (i, comment) => {
            let str = '';
            // 댓글 들여쓰기 (댓글 여는 <div>)
            if(comment.depth === 0) {
              
              str += '<div class="comment-start" style="">';
              
            } else {
              str += '<div class="comments-all" style="padding-left: 32px; display:none">';
            }
            // 댓글 내용 표시
            console.log(comment.state);
            if(comment.state === 1){
              str += '<div class="comment-top">';
              str += '<div class="profile-image-wrapper profile-image-medium">'
              str += comment.user.miniProfilePicturePath
              str += '</div>'
              str += comment.user.name;
              str += '<br>'
              str += '<span style="padding-left: 15px;">(' + moment(comment.createDt).format('YYYY.MM.DD.') + ')</span>';
              str += '</div>';
              str += '<div>' + comment.contents + '</div>';
              
              // 답글 버튼
              str += '<div clas="btn-bottom-reply">'
              str += '<button type="button" class="btn-reply" >답글</button>';
              str += '<button type="button" id="btn-comment-show" >답글보기</button>';
              str += '</div>'
              if(comment.depth === 0) {
                  
              }
              /* 답글 입력 화면 */
              str += '<div class="blind" style="display:none;">';
              str += '  <form class="frm-reply">';
              str += '    <input type="hidden" name="groupNo" value="' + comment.groupNo + '">';
              str += '    <input type="hidden" name="postNo" value="${post.postNo}">';
              str += '    <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">';
              str += '    <textarea name="contents" placeholder="답글 입력"></textarea>';
              str += '    <button type="button" class="btn btn-warning btn-register-reply">작성완료</button>';
              str += '  </form>';
              str += '</div>';
              /*                */
              // 삭제 버튼 (내가 작성한 댓글에만 삭제 버튼이 생성됨)
              if(Number('${sessionScope.user.userNo}') === comment.user.userNo) {
                str += '<button type="button" class="btn btn-danger btn-remove" data-comment-no="' + comment.commentNo + '">삭제</button>'
                
              }
            } else {
              str += '<span>삭제된 댓글입니다.</span>'
            }
            // 댓글 닫는 <div>
            str += '</div>';
            
            // 목록에 댓글 추가
            commentList.append(str);
          })
          // 페이징 표시
          paging.append(resData.paging);
          
          
            $('#btn-comment-show').on('click', ()=> {
              // 현재 클릭한 답글 보기 버튼에 해당하는 댓글의 답글 목록을 토글
             $('.comments-all').toggle();
            });  
            
          
        },
        error: (jqXHR) => {
          alert(jqXHR.statusText + '(' + jqXHR.status + ')');
        }
      })
    }
    
    
    const fnBtnReply = () => {
      $(document).on('click', '.btn-reply', (evt) => {
        // Sign In 체크
        fnCheckSignin();
        // 답글 작성 화면 조작하기

        $('.blind').toggle();
         
        
      })
    }
    
    const fnBtnRemove = () => {
      $(document).on('click', '.btn-remove', (evt) => {
         if(confirm('댓글을 삭제할까요?')) {
           location.href = '${contextPath}/post/removeComment.do?commentNo=' + evt.target.dataset.commentNo + '&postNo=${post.postNo}';
         }
       })
     }
    
    const fnPaging = (p) => {
      page = p;
      fnCommentList();
    }
    
    const fnRegisterReply = () => {
      $(document).on('click', '.btn-register-reply', (evt) => {
        if('${sessionScope.user}' === ''){
          fnCheckSignin();
        }
        else{
          $.ajax({
            // 요청
            type: 'POST',
            url: '${contextPath}/post/registerReply.do',
            data: $(evt.target).closest('.frm-reply').serialize(),
            // 응답
            dataType: 'json',
            success: (resData) => { // resData => {"insertCount": 1}
              if(resData.insertCount === 1){
                alert('댓글이 등록되었습니다.');
                $('#contents').val('');
                $(evt.target).prev().val('');
                // 댓글 목록 보여주는 함수
                fnCommentList();
              } else {
                alert('댓글 등록이 실패했습니다');
              }
            },
            error: (jqXHR) => {
              alert(jqXHR.statusText + '(' + jqXHR.status + ')');
            }
          })
        }
      })
    }
    
    // 전역 객체
    var frmBtn = $('#frm-btn');
    const fnEditPost = () => {
      $('#btn-edit').on('click', (evt) => {
        frmBtn.attr('action', '${contextPath}/post/edit.do');
        frmBtn.submit();
      })
    }
    
    const fnRemovePost = () => {
      $('#btn-remove').on('click', (evt) => {
        if(confirm('블로그를 삭제하면 모든 댓글이 함께 삭제됩니다. 삭제할까요?')){
          frmBtn.attr('action', '${contextPath}/post/remove.do');
          frmBtn.submit();
        }
      })
    }
    
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
    

    
    document.addEventListener("DOMContentLoaded", function() {
        var shareIcon = document.getElementById("share-icon");
        var modal = document.getElementById("myModal");

        shareIcon.addEventListener("click", function() {
          // 링크 복사
          var dummy = document.createElement("textarea");
          document.body.appendChild(dummy);
          dummy.value = window.location.href;
          dummy.select();
          document.execCommand("copy");
          document.body.removeChild(dummy);

          // 모달 표시 및 3초 후에 fade out
          modal.style.display = "flex"; // display 변경
          modal.style.alignItems = "flex-end"; // display 변경
          setTimeout(function() {
            modal.style.opacity = 0; // 투명도 조정
            setTimeout(function() {
              modal.style.display = "none"; // 모달 숨김
              modal.style.opacity = 1; // 초기 투명도로 리셋
            }, 500); // 투명도가 0이 되는 시간과 동일한 시간을 설정 (트랜지션 지속시간)
          }, 3000);
        });
      });
   
    fnKeyup();
    fnBtnRemove();
    $('#contents').on('click', fnCheckSignin);
    fnRegisterComment();
    fnCommentList();
    fnBtnReply();
    fnRegisterReply();
    fnEditPost();
    fnRemovePost();
    fnPostLike();
    getLikeStatus();
    fnGetLikeCountByPostNo2();
    fnGetCommentCountByPostNo();
    fnGetHitCountByPostNo();
    fnGetUploadList();
    profileMove();
    profilListeMove();
    fnGetLikeCountByUserNo();
    fnGetFollowCount();
    fnGetHitCountByUserNo();
    fnCheckFollow();
    
  </script>
  
<%@ include file="../layout/footer.jsp" %>