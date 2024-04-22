<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>



 
 <jsp:include page="../layout/header.jsp">
   <jsp:param value="${post.postNo}번 블로그" name="title"/>
 </jsp:include>
 
 <style>
 
 .detail-page {
     align-items: center;
    background-color: var(--mono-000);
    display: flex;
    flex-direction: column;
    height: calc(100% - 150px);
    left: 0;
    margin: 150px auto 0;
    overflow-y: scroll;
    padding: 0 0 127px;
    scrollbar-width: none;
    top: 40px;
    width: 100%;
    
    }
 
  .project-detail-header{
    background-color: rgb(255,255,255);
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    
    top: 40px;
    width: 100%;
    z-index: 99;
  }
 
 .title-wraper{
    align-items: center;
    background-color: rgb(255,255,255);
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    justify-content: center;
    left: 0;
    margin: 50px 0;
    padding: 40px 0;
    position: fixed;
    top: 0;
    width: 100%;
 }
  .tag-wrapper{
    align-items: center;
    background-color: var(--mono-000);
    display: flex;
    justify-content: center;
    position: relative;
    width: 100%;
    z-index: 99;
  }
  
  .tag-round-degree-large {
    --tag-round-border-radius: 100px;
 }
  .tag-round-color-gray {
    --tag-round-border-color: var(--mono-080);
    --tag-round-bg-color: var(--mono-050);
    color: var(--mono-400);
 }
  .tag-round-size-small {
    --tag-round-height: 28px;
    --tag-round-font-size: 12px;
    --tag-round-gutter: 12px;
 }
  .tag-round {
    --tag-round-height: 28px;
    --tag-round-font-size: 12px;
    --tag-round-gutter: 12px;
    --tag-round-color: var(--mono-900);
    --tag-round-border-width: 1px;
    --tag-round-border-style: solid;
    --tag-round-border-color: var(--mono-900);
    --tag-round-border-radius: 100px;
    --tag-round-bg-color: var(--mono-000);
    align-items: center;
    background-color: var(--tag-round-bg-color);
    border-radius: var(--tag-round-border-radius);
    color: var(--tag-round-color);
    display: inline-flex;
    font-size: var(--tag-round-font-size);
    font-weight: 400;
    gap: 10px;
    height: var(--tag-round-height);
    justify-content: center;
    padding: 0 var(--tag-round-gutter);
    position: relative;
    white-space: nowrap;
}
  
  .title-inner-wrapper{
    align-items: center;
    display: flex;
    justify-content: center;
  }
  
  span.title-txt {
    display: block;
    font-size: 28px;
    font-weight: 700;
    height: 36px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: -moz-fit-content;
    width: fit-content;
 }
  
  .content-wrapper {
    border-bottom: 1px solid rgb(255,255,255);
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-bottom: 80px;
    position: relative;
    width: 60%;
 }

  .content-block-wrap, .content-wrapper-upper {
    display: flex;
    flex-direction: column;
    width: 100%;
 }
 
   article.content-article {
    flex: none;
    width: 100%;
 }
  
   .block {
    --block-gap: 100px;
    margin-left: auto;
    margin-right: auto;
    max-width: 1000px;
 }
 
  .content-figure  {
    margin: 0;
    position: relative;
 }
 
  .content-image-wrap {
    border-radius: 10px;
    
    position: relative;
 }
 
  .content-image-wrap img{
    display: block;
    height: auto;
    margin: 0 auto;
    max-width: 100%;
    pointer-events: none;
  }
  .content-image-wrap p{
    height: auto;
    width: auto;
  }
  
  .content-bottom-wrapper {
    align-items: center;
    display: flex;
    gap: 30px;
    justify-content: space-between;
    margin: 50px 0 0;
    width: 100%;
 }
  
  .tab-wrapper {
    align-items: center;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    width: 100%;
 }
 
  .hashtag-btn {
    cursor: pointer;
 }
 
  .hashtag-color-default {
    --hashtag-bg-color: rgb(240,240,240);
    --hashtag-color: rgb(0,0,0);
 }
 
  .hashtag-size-medium {
    --hashtag-height: 39px;
    --hashtag-font-size: 14px;
    --hashtag-gutter: 20px;
 }
  
  .hashtag {
    --hashtag-height: 32px;
    --hashtag-font-size: 12px;
    --hashtag-gutter: 16px;
    --hashtag-bg-color: rgb(240,240,240);
    --hashtag-color: rgb(0,0,0);
    background-color: var(--hashtag-bg-color);
    border-radius: 100px;
    color: var(--hashtag-color);
    display: inline-block;
    font-size: var(--hashtag-font-size);
    font-weight: 400;
    height: var(--hashtag-height);
    line-height: var(--hashtag-height);
    overflow: hidden;
    padding: 0 var(--hashtag-gutter);
    position: relative;
    text-overflow: ellipsis;
    white-space: nowrap;
 }
  
  .figure-data-wrapper {
    align-items: center;
    display: flex;
    gap: 12px;
    margin: 10px 0 auto;
 }
  
  .figure-data {
    align-items: center;
    display: flex;
    gap: 4px;
 }
 
  .navigation {
    position: fixed;
    top: 195px;
    left: 1800px;
    z-index: 10;
 }
  
  .profile-wrapper {
    align-items: center;
    display: flex;
    justify-content: space-between;
    padding: 0 20px 20px;
 }
  
  .profile-avatar-wrapper {
    align-items: center;
    display: flex;
    gap: 10px;
}
 
  .dropdown-outer {
    display: inline-flex;
    height: auto;
    position: relative;
    width: auto;
 }
  
  .dropdown-custom-trigger-block, .dropdown-trigger-block, .dropdown-trigger-wrapper {
    display: flex;
    height: auto;
    width: 100%;
 }
  
  .dropdown-trigger-block {
    cursor: pointer;
 }
  
  .avatar.owner {
    border: 1px solid rgb(0,255,0);
    border-radius: 100%;
    cursor: pointer;
 }
 
  .profile-image-wrap {
    display: flex;
    flex-direction: column;
    position: relative;
 }
 
  .avatar.owner .profile-image-wrapper {
    height: 48px;
    width: 48px;
 }
 
  .profile-image-medium {
    --profile-image-size: 40px;
 }
  
  .profile-image-wrapper {
    --profile-image-size: 30px;
    background-color: var(--mono-080);
    border-radius: 50%;
    display: inline-block;
    height: var(--profile-image-size);
    overflow: hidden;
    width: var(--profile-image-size);
 }
  
  .profile-image-wrapper img {
    border-radius: 50%;
    height: 100%;
    -o-object-fit: cover;
    object-fit: cover;
    pointer-events: none;
    transition: transform 125ms;
    width: 100%;
 }
  
  ul.menu-wrapper {
    align-items: center;
    display: flex;
    flex-direction: column;
    gap: 20px;
    justify-content: center;
    margin: 0;
    padding: 0;
 }
  
  .avatar-wrapper.hidden {
    display: none;
 }
  
  .avatar-wrapper {
    height: 50px;
    position: relative;
    width: 50px;
 }
  
  .avatar-wrapper .avatar.participant:first-child {
    border-radius: 100%;
    opacity: 1;
    z-index: 4;
 }
.avatar-wrapper .avatar.participant {
    cursor: pointer;
    position: absolute;
 }
.profile-image-wrap {
    display: flex;
    flex-direction: column;
    position: relative;
 }
  
  .profile-image-medium {
    --profile-image-size: 40px;
 }
.profile-image-wrapper {
    --profile-image-size: 30px;
    background-color: var(--mono-080);
    border-radius: 50%;
    display: inline-block;
    height: var(--profile-image-size);
    overflow: hidden;
    width: var(--profile-image-size);
 }
  
  .icon-wrapper {
    background-color: rgb(255,255,255);
    border: 1px solid rgb(255,255,255);
    border-radius: 100%;
    box-shadow: 0 4px 15px #dedede4d;
    height: 50px;
    position: relative;
    width: 50px;
 }
  
  .icon-wrapper i {
    cursor: pointer;
    left: 50%;
    position: absolute;
    top: 50%;
    transform: translate(-50%, -50%);
 }
  
  .comment-section {
    gap: 44px;
    width: 70%;
}
  
  #comment-list {
    display: flex;
    flex-direction: column;
    list-style: none;
    margin: 0;
    padding: 40px 0 0;
}
  
  .comment-list {
    display: flex;
    flex-direction: column;
    list-style: none;
    margin: 0;
    padding: 40px 0 0;
 }

 
  .comment-item {
    align-items: flex-start;
    display: flex;
    flex-direction:column;
    gap: 10px;
    grid-template-columns: 40px 1fr;
    padding: 20px;
    position: relative;
 }
  
  .profile-image-wrap {
    display: flex;
    flex-direction: column;
    position: relative;
 } 
 
  .comment-data-wrapper {
    display: flex;
    flex-direction: column;
    gap: 10px;
    position: relative;
 }
 
  .profile-image-wrap-avatar{
    display:flex;
    flex-direction: column;
  }
  
  .profile-image-medium {
    --profile-image-size: 40px;
 }
 
 
 
 .comments-all{
   display:flex;
   flex-direction: column;
   
 }
 
 
 .btn-bottom-reply{
  display:flex;
  flex-direction: column;
 }
 
   form.form {
    align-items: center;
    border-top: 1px solid rgb(255,255,255);
    display: grid;
    gap: 5px;
    padding: 40px 20px 20px;
    margin-left: -850px;
    margin-top: 50px;
 }
 
  .input-wrapper {
    grid-gap: 10px;
    align-items: center;
    display: grid;
    grid-template-columns: 40px 1fr;
    justify-content: space-between;
    width: 100%;
 }
 
  .profile-image-wrap[data-v-d7f7ea8d] {
    display: flex;
    flex-direction: column;
    position: relative;
 }
  
  
  .input-outer.input-stretch {
    --input-width: 100%;
 }
 
  .input-wrapper[data-v-ec5e8f9c] {
    align-items: center;
    background-color: var(--input-bg-color);
    border-color: var(--input-border-color);
    border-radius: 4px;
    
    border-width: var(--input-border-width);
    display: flex;
    height: var(--input-height);
    position: relative;
 }
 
  .input-inner-wrap {
    align-items: center;
    display: flex;
    height: 100%;
    width: 100%;
    gap: 20px;
 }
 
  input.input {
    --input-color: rgb(0,0,0);
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-color: rgb(255,255,255);
    border-radius: 4px;
    border-width: 0;
    color: rgb(0,0,0);
    font-size: var(--input-font-size);
    font-weight: 400;
    height: 100%;
    line-height: normal;
    min-width: 0;
    outline: none;
    padding: var(--input-gutter);
      
    border-style: solid;
 }
 
 .button.write-button {
    height: 40px;
    width: 90px;
    
 }
 
   
 
  .btn-text {
    display: block;
    position: relative;
    transition: transform .3s;
    white-space: nowrap;
 }
 
  .info-wrapper {
    display: flex;
    gap: 15px;
    margin: 0px 0 120px auto;
 }
 
  .tooltip-title {
    align-items: center;
    cursor: pointer;
    display: flex;
 }
 
  .title-wrapper {
    align-items: center;
    display: flex;
    gap: 5px;
 }
 
  .project-section {
    background-color: var(--mono-900);
    border-radius: 10px;
    padding: 50px;
    width: 60%;
 }
 
  .head {
    align-items: center;
    display: flex;
    gap: 20px;
    justify-content: space-between;
    width: 100%;
 }
 
  .head-left {
    align-items: center;
    display: flex;
    gap: 10px;
 }
 
  .avatar[data-v-e3383a90] {
    border: 1px solid rgb(0,245,0);
    border-radius: 100%;
    cursor: pointer;
 }
 
  .profile-image-wrap[data-v-d7f7ea8d] {
    display: flex;
    flex-direction: column;
    position: relative;
 }
 
  .profile-image-medium[data-v-d7f7ea8d] {
    --profile-image-size: 40px;
 }
 
 .profile-image-wrapper[data-v-d7f7ea8d] {
    --profile-image-size: 30px;
    background-color: var(--mono-080);
    border-radius: 50%;
    display: inline-block;
    height: var(--profile-image-size);
    overflow: hidden;
    width: var(--profile-image-size);
}
 
  .figure-wrapper, .head-right {
    align-items: center;
    display: flex;
 }
 
 span.nickname {
    color: var(--mono-000);
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 150px;
 }
 
  .head-right {
    gap: 30px;
    justify-content: flex-end;
    width: 100%;
 }
 
  
 
  
 </style>
 
 <div class=""></div>
 
 <div class="detail-page">
 
 <div class="project-detail-header">
    <div class="title-wraper">
     <div class="tag-wrapper">
       <div class="tag-round tag-round-size-small tag-round-color-gray tag-round-degree-large" id="ca-div">
          <span>${post.category}</span>
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
            <div class="hashtag hashtag-size-medium hastag-color-default hastag btn">#사진</div>
            <div class="hashtag hashtag-size-medium hastag-color-default hastag btn">#인사동</div>
            <div class="hashtag hashtag-size-medium hastag-color-default hastag btn">#골목</div>
            <div class="hashtag hashtag-size-medium hastag-color-default hastag btn">#서울</div>
            <div class="hashtag hashtag-size-medium hastag-color-default hastag btn">#거리</div>
          </div>
          <div class="figure-data-wrapper">
            <div class="figure-data">
              <i class="fa-regular fa-heart" width="10px;"></i>
              
            </div>
            <div class="figure-data">
              <i class="fa-regular fa-eye" width="10px"></i>${post.hit}
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
              <div class="profile-image-wrap avatar owner">
                <div class="profile-image-wrapper profile-image-medium">
                  <img src="  https://preview.files.api.ogq.me/v1/profile/LARGE/PROFILE/7d7503a5/5f2ed5a3057d7/5f2ed5a3057d7.jpg
                  " alt="avatar">
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
        
          <button id="modalOpenButton"><i class="fas fa-thin fa-share-nodes" id="share-icon"></i></button> 
        
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
   <div data-v-d7f7ea8d class="profile-image-wrap">
    <img class="img-ogq" src="https://preview.files.api.ogq.me/v1/profile/LARGE/NEW-PROFILE/default_profile.png" width="40px" height="40px">
   </div>
   <div class="input-outer input-stretch">
    <div data-v-ec5e8f9c class="input-wrapper">
      <div class="input-inner-wrap">
        <input type="text" id="contents" name="contents" placeholder="댓글을 입력해주세요"></input>
        <button id="btn-comment-register" type="button" disabled class="btn btn-size-small btn-color-black button write-button">
        <div class="btn-text">
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
      <div class="head-left">
        <div data-v-d7f7ea8d data-v-e3383a90 class="profile-image-wrap avatar">
          <div data-v-d7f7ea8d class="profile-image-wrapper profile-image-medium">
            <i class="fa-regular fa-user"></i>
          </div>
        </div>
        <span class="nickname">${user.name}</span>
      </div>
    </div>
  </div>
  
  
  <div id="modalContainer" class="hidden">
    <div id="modalContent">
      <p>링크가 복사되었습니다.</p>
      <button id="modalCloseButton">닫기</button>
      <button type="button" class="copy-btn" onclick="copyUrl()">링크복사</button>
    </div>
  </div>
 
  
  
</div>  


  <script>
  
  
  
  
  
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
  
  
    const fnGetLikeCountByPostNo = () => {
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
          console.log(str);
          $('.figure-data').append(str);   
          
          
        })
        .catch(error => {
            console.log('Error likecount the post.'); // 에러 처리
        });
      }

  
   
  
  //navigation
  window.addEventListener('resize', function() {
      var navigation = document.querySelector('.navigation');
      var windowWidth = window.innerWidth;
      var leftPosition = windowWidth - 100;
      
      navigation.style.left = leftPosition + 'px';
      
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
 
 
  

  
  
 
  const modalOpenButton = document.getElementById('modalOpenButton');
  const modalCloseButton = document.getElementById('modalCloseButton');
  const modal = document.getElementById('modalContainer');

  
  modalOpenButton.addEventListener('click', () => {
    modal.classList.remove('hidden');
    

    // 임시 textarea 요소를 생성하여 텍스트를 복사
    var textarea = document.createElement("textarea");
    textarea.value = textToCopy;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand("copy");
    document.body.removeChild(textarea);

    // 복사 완료 메시지 표시
    alert("주소가 복사되었습니다: " + textToCopy);
  });
    
   

  
  
  modalCloseButton.addEventListener('click', () => {
    modal.classList.add('hidden');
  });
  
  // commentBottom
  document.getElementById('comment-bottom').onclick = (evt)=>{
    alert('저작권자의 허가 없이 무단복제 및 도용, 2차 가공 및 공유 금지');
    modal.classList.remove('hidden');
      
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
        btnChange.style.backgroundColor = 'rgb(130,130,130)';
        btnChange.disabled = false;
      } else {
        btnChange.disabled = true;
        btnChange.style.backgroundColor = 'rgba(0,240,0,0.5)';
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
              str += '<i class="fa-regular fa-user"></i>'
            } else {
              str += '<div class="comments-all" style="padding-left: 32px; display:none">';
            }
            // 댓글 내용 표시
            console.log(comment.state);
            if(comment.state === 1){
              str += '<div class="comment-top">';
              str += comment.user.email;
              str += '<br>'
              str += '(' + moment(comment.createDt).format('YYYY.MM.DD.') + ')';
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
    fnGetLikeCountByPostNo();
  </script>
  
<%@ include file="../layout/footer.jsp" %>