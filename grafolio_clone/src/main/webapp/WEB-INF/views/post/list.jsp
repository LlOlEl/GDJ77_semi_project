<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

 <jsp:include page="../layout/header.jsp">
   <jsp:param value="블로그 리스트" name="title"/>
 </jsp:include>
 
 <style>
 
  #post-list{

    -moz-column-gap: 30px;
    column-gap: 30px;
    display: grid;
    grid-template-columns: repeat(4,1fr);
    margin: 0;
    padding: 0;
    row-gap: 40px;
    width: 100%
  }
  
  .post-image {
    position: relative;
    width: 100%;
    height: 300px;
    background-position: 50%;
    background-size: cover;
    border-radius: 4px; /* 통일된 모서리 반경을 사용합니다 */
    cursor: pointer;
    overflow: hidden;
  }
  
  .post-image::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(128, 128, 128, 0); /* 초기에는 완전 투명 */
  }
  
  
  .post{
    height: -moz-fit-content;
    height: fit-content;
    min-width: 0;
    position: relative;
    width: 100%;
  }
  
  .post-title, .post-date, .like-button {
      position: absolute;
      color: white;
      padding: 5px;
      visibility: hidden; /* 기본적으로 숨김 */
  }

  .post-title {
      left: 10px;
      bottom: 10px;
  }

  .post-date {
      right: 10px;
      bottom: 10px;
  }

  .like-button {
      right: 10px;
      top: 10px;

      font-size: 25px;
      color: #ffffff;
      background-color: rgba(0, 0, 0, 0.0);
      border: none;
  }
  
  .post-image:hover::before {
    background-color: rgba(128, 128, 128, 0.5); /* 마우스 호버 시 회색 오버레이 적용 */
  }
  
  .post-image:hover .post-title,
  .post-image:hover .post-date,
  .post-image:hover .like-button {
      visibility: visible; /* 호버 시 보이도록 */
  }

  
  .post > .post-bottom {
    display: flex;
    width: 100%;
    hegiht: 30px;
  }
  
  .post span {
    color: tomato;
  }
  
  .post span:nth-of-type(1){
    width: 150px;

  }
  
  .post span:nth-of-type(2){
    width: 250px;
  }
  
  .post span:nth-of-type(3){
    width: 50px;
  }
  
  .post span:nth-of-type(4){
    width: 150px;
  }
 
 </style>
 
 <style>
   :root {
      --mono-000: #fff;
      --mono-010: #fcfdfd;
      --mono-030: #f9fbfb;
      --mono-050: #f4f6f6;
      --mono-080: #eef1f1;
      --mono-100: #d8dfdf;
      --mono-200: #a7b6b9;
      --mono-300: #89989c;
      --mono-400: #7d8d92;
      --mono-500: #76888f;
      --mono-600: #6c7e84;
      --mono-700: #57676b;
      --mono-800: #425052;
      --mono-900: #262d2e;
      --mono-990: #040606;
      --primary-010: #fbfdfc;
      --primary-030: #eef7f4;
      --primary-050: #dff4ea;
      --primary-080: #cbecdf;
      --primary-100: #b5e5d7;
      --primary-200: #9bdfcc;
      --primary-300: #7fdec1;
      --primary-400: #58dab1;
      --primary-500: #32d29d;
      --primary-600: #00c389;
      --primary-700: #00b57f;
      --primary-800: #00996e;
      --primary-900: #007a58;
      --primary-990: #006147;
      --secondary-010: #fbfbfe;
      --secondary-030: #f8f6fe;
      --secondary-050: #ebe8fc;
      --secondary-080: #e0dafb;
      --secondary-100: #d2c8f9;
      --secondary-200: #bfb0f2;
      --secondary-300: #a793ec;
      --secondary-400: #947be5;
      --secondary-500: #7e5ae2;
      --secondary-600: #703fe4;
      --secondary-700: #5b1dcd;
      --secondary-800: #4917a6;
      --secondary-900: #37117e;
      --secondary-990: #290d5e;
      --blue-100: #a4d9ff;
      --blue-200: #75c2fa;
      --blue-300: #1490eb;
      --red-100: #ffd0d3;
      --red-200: #e33861;
      --red-300: #e21235;
      --green: #00ff85;
      --orange: #ff550d;
      --purple: #7f00ff;
      --color-sns-naver: #03c75a;
      --color-sns-facebook: #3d5a98;
      --color-sns-afreeca: #0545b1;
      --shadow-card: 0px 4px 15px hsla(0,0%,87%,.3)
  }
 
 
   .categories-wrap {
    display: flex;
    justify-content: center
  }
  
  .categories{
    -ms-overflow-style: none;
    display: inline-flex;
    gap: 10px;
    justify-content: flex-start;
    margin: 30px auto 49px;
    overflow-x: auto;
    scrollbar-width: none
  }

  .categories::-webkit-scrollbar {
      display: none
  }
  
  @media screen and (max-width: 768px) {
      .categories{
          margin:30px auto 20px
      }
  }
  
  .category.selected{
      background-color: var(--primary-050);
      color: var(--primary-600);
      font-weight: 500
  }
  
  .category-round {
      --category-round-height: 28px;
      --category-round-font-size: 12px;
      --category-round-gutter: 12px;
      --category-round-color: var(--mono-900);
      --category-round-border-width: 1px;
      --category-round-border-style: solid;
      --category-round-border-color: var(--mono-900);
      --category-round-border-radius: 100px;
      --category-round-bg-color: var(--mono-000);
      align-items: center;
      background-color: var(--category-round-bg-color);
      border-radius: var(--category-round-border-radius);
      color: var(--category-round-color);
      display: inline-flex;
      font-size: var(--category-round-font-size);
      font-weight: 400;
      gap: 10px;
      height: var(--category-round-height);
      justify-content: center;
      padding: 0 var(--category-round-gutter);
      position: relative;
      white-space: nowrap
  }
  
  .category-round.category-round-bordered {
      border-color: var(--category-round-border-color);
      border-style: var(--category-round-border-style);
      border-width: var(--category-round-border-width)
  }
  
  .category-round.category-round-pointed {
      cursor: pointer
  }
  
  .category-round-size-small {
      --category-round-height: 28px;
      --category-round-font-size: 12px;
      --category-round-gutter: 12px
  }
  
  .category-round-size-medium {
      --category-round-height: 34px;
      --category-round-font-size: 14px;
      --category-round-gutter: 16px
  }
  
  .category-round-color-primary {
      --category-round-color: var(--mono-900);
      --category-round-border-color: var(--mono-900);
      --category-round-bg-color: var(--mono-000)
  }
  
  .category-round-color-gray {
      --category-round-border-color: var(--mono-080);
      --category-round-bg-color: var(--mono-050);
      color: var(--mono-400)
  }
  
  .category-round-color-black {
      --category-round-bg-color: var(--mono-900);
      color: var(--mono-000)
  }
  
  .category-round-color-purple {
      --category-round-border-color: var(--primary-600);
      --category-round-bg-color: var(--primary-050);
      color: var(--primary-600)
  }
  
  .category-round-degree-large {
      --category-round-border-radius: 100px
  }
  
  .category-round-degree-small {
      --category-round-border-radius: 5px
  }
 
 </style>
 
  <h1 class="title">블로그 목록</h1>
  
  <div class="categories-wrap" >
    <div class="categories"><!--[-->
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category selected"
            data-category=0><!--[-->전체<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=1><!--[-->일러스트<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=2><!--[-->사진<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=3><!--[-->디자인<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=4><!--[-->회화<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=5><!--[-->조소/공예<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=6><!--[-->사운드<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=7><!--[-->애니메이션<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=8><!--[-->캘리그라피<!--]--><!----></div>
        <div class="category-round category-round-size-medium category-round-color-gray category-round-degree-large category-round-pointed category"
            data-category=9><!--[-->기타<!--]--><!----></div>
    </div>
  </div>
  
  <a href="${contextPath}/post/write.page">블로그작성</a>
  
  <div id="post-list">
  
  </div>
  
  
 
  
  <script>
  
    // 전역 변수
    var page = 1;
    var totalPage = 0;
    var category = 0;
    
    const fnGetPostList = () => {
    	// page에 해당하는 목록 요청	
    	  $.ajax({
  		    // 요청
  		    type: 'GET',
  		    url: '${contextPath}/post/getPostList.do',
  		    data: 'page=' + page,
  		    // 응답
  		    dataType: 'json',
  		    success: (resData) => {  // resData = {"postList": [], "totalPage": 10}
  		      totalPage = resData.totalPage;
  		      $.each(resData.postList, (i, post) => {
              var thumbnailUrl = extractFirstImage(post.contents);
              let str = '<div class="post" data-user-no="' + post.user.userNo + '"data-post-no="' + post.postNo + '">';
              str += displayThumbnail(thumbnailUrl, post.title, moment(post.createDt).format('YYYY.MM.DD.'));
              str += '<div class="post-bottom">';
              str += '<span>' + post.user.email + '</span>';
              str += '<span>' + post.hit + '</span>';
              str += '</div>';
              str += '</div>';
              $('#post-list').append(str);
  		      })
  		      fnLikeCheck();
  		    },
  		    error: (jqXHR) => {
  		      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
  		    }
  		  });

    }
    
    const fnGetPostListByCategory = () => {
        // page에 해당하는 목록 요청 
          $.ajax({
            // 요청
            type: 'GET',
            url: '${contextPath}/post/getPostList.do',
            data: {page: page, category: category},
            // 응답
            dataType: 'json',
            success: (resData) => {  // resData = {"postList": [], "totalPage": 10}
              totalPage = resData.totalPage;
              $.each(resData.postList, (i, post) => {
                var thumbnailUrl = extractFirstImage(post.contents);
                let str = '<div class="post" data-user-no="' + post.user.userNo + '"data-post-no="' + post.postNo + '">';
                str += displayThumbnail(thumbnailUrl, post.title, moment(post.createDt).format('YYYY.MM.DD.'));
                str += '<div class="post-bottom">';
                str += '<span>' + post.user.email + '</span>';
                str += '<span>' + post.hit + '</span>';
                str += '</div>';
                str += '</div>';
                $('#post-list').append(str);
              })
              fnLikeCheck();
            },
            error: (jqXHR) => {
              alert(jqXHR.statusText + '(' + jqXHR.status + ')');
            }
          });

      }
    
    
    // HTML 문자열에서 첫 번째 <img> 태그의 src 속성을 추출
    function extractFirstImage(htmlContent) {
        var div = document.createElement('div');
        div.innerHTML = htmlContent; // HTML 문자열을 DOM으로 변환
        var image = div.querySelector('img'); // 첫 번째 이미지 태그 선택
        return image ? image.src : null; // 이미지의 src 속성 반환
    }

    function displayThumbnail(imageUrl, postTitle, postDate) {
        var thumbnail = document.createElement('div'); // div 요소 생성
        thumbnail.className = "post-image"; // class 이름 설정
        thumbnail.style.backgroundImage = 'url("' + imageUrl + '")'; // 배경 이미지 설정
        thumbnail.alt = 'Thumbnail'; // 대체 텍스트 설정
        
        // 타이틀 추가
        var info = document.createElement('div');
        info.className = "post-title";
        info.textContent = postTitle;
        thumbnail.appendChild(info);

        // 작성 일자 추가
        var dateElement = document.createElement('div');
        dateElement.className = "post-date";
        dateElement.textContent = postDate;
        thumbnail.appendChild(dateElement);

        // 좋아요 버튼 추가
        var likeButton = document.createElement('button');
        likeButton.className = "like-button";
        likeButton.innerHTML = '<i class="fa-regular fa-heart" style="color: #ffffff;"></i>'; // 이모지나 커스텀 아이콘 사용 가능
        thumbnail.appendChild(likeButton);

        return thumbnail.outerHTML; // 생성된 HTML 문자열 반환
    }
    
    
    const fnScrollHander = () => {
    	// 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청

    	  // 타이머 id (동작한 타이머의 동작 취소를 위한 변수)
    	  var timerId;  // undefined, boolean 의 의미로는 false
    	  $(window).on('scroll', (evt) => {
    	    if(timerId) {  // timerId 가 undefined 이면 false, 아니면 true 
    	                   // timerId 가 undefined 이면 setTimeout() 함수가 동작한 적 없음
    	      clearTimeout(timerId);  // setTimeout() 함수 동작을 취소함 -> 목록을 가져오지 않는다.
    	    }
    	    // 500밀리초(0.5초) 후에 () => {}가 동작하는 setTimeout 함수
    	    timerId = setTimeout(() => {
    	      let scrollTop = $(window).scrollTop();
    	      let windowHeight = $(window).height();
    	      let documentHeight = $(document).height();
    	      if( (scrollTop + windowHeight + 50) >= documentHeight ) {  // 스크롤과 바닥 사이 길이가 50px 이하인 경우 
    	        if(page > totalPage) {
    	          return;
    	        }
    	        page++;
    	        if(category === 0){
    	          fnGetPostList();
    	        } else {
    	        	fnGetPostListByCategory();
    	        }
    	      }
    	    }, 500);
    	})
    }
  
    const fnPostDetail = () => {
    	
  	  $(document).on('click', '.post', (evt) => {
	        // 클릭된 요소로부터 가장 가까운 '.post' 클래스 요소를 찾음
	        const $post = $(evt.target).closest('.post');

	        // .post 요소에서 데이터셋을 읽음
	        const postNo = $post.data('postNo');
	        const userNo = $post.data('userNo');

	        // 현재 세션의 userNo와 비교
	        if('${sessionScope.user.userNo}' === userNo) {
	            location.href = '${contextPath}/post/detail.do?postNo=' + postNo;
	        } else { 
	            location.href = '${contextPath}/post/updateHit.do?postNo=' + postNo;
	        }
	    })
    }
    
  
    const fnInsertCount = () => {
  	  let insertCount = '${insertCount}';
  	  if(insertCount !== ''){
  		  if(insertCount === '1') {
  			  alert('블로그가 등록되었습니다.');
  		  } else {
  			  alert('블로그 등록이 실패했습니다.');;
  		  }
  	  }
    }
    
    const fnCategorySelect = () => {
        // 모든 태그 요소를 찾음
        const categories = document.querySelectorAll('.category');

        // 각 태그에 클릭 이벤트 리스너를 추가
        categories.forEach(categoryElement  => {
        	categoryElement.addEventListener('click', function() {
                // 선택된 태그에서 'selected' 클래스를 토글
                this.classList.add('selected');
                // category 설정
                window.category = this.getAttribute('data-category');
                // page 1로 리셋
                page = 1;
                // 선택된 태그를 제외하고 다른 모든 태그에서 'selected' 클래스를 제거
                categories.forEach(t => {
                    if (t !== this) {
                        t.classList.remove('selected');
                    }
                })
                $('#post-list').empty();
                if(window.category === 0){
                    fnGetPostList();
                  } else {
                    fnGetPostListByCategory();
                }
            })
        })
    }
    
    const fnPostLike = () => {
      // 좋아요 버튼에 클릭 이벤트 리스너 추가
      $(document).on('click', '.like-button', (evt) => {
    	    evt.stopPropagation(); // 이벤트 버블링을 중단
          var postNo = evt.target.closest('.post').dataset.postNo; // 게시물 번호 추출
          var likeButton = evt.target.closest('.like-button'); // 좋아요 버튼 참조
          
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
                      'userNo': ${sessionScope.user.userNo}
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
                      'userNo': ${sessionScope.user.userNo}
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
    
   const fnLikeCheck = () => {
	    const posts = document.querySelectorAll('.post');
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

	  // Like 버튼 클릭 이벤트 핸들러
/*     const fnLikeCheck = () => {
  	  document.querySelectorAll('.like-button').forEach(button => {
  	    button.addEventListener('click', function() {
  	      const post = this.closest('.post');
  	      const postNo = post.dataset.postNo;
  	      const isLiked = this.classList.contains('liked');

  	      // 서버에 'Like' 상태 변경 요청
  	      fetch('/toggle-like', {
  	        method: 'POST',
  	        headers: {
  	          'Content-Type': 'application/json',
  	        },
  	          body: JSON.stringify({ 
  	              'postNo': parseInt(postNo, 10)
  	             ,'userNo': ${sessionScope.user.userNo}
  	          })
  	        })
  	      .then(response => response.json())
  	      .then(data => {
  	        if (data.success) {
  	          this.classList.toggle('liked');
  	        }
  	      })
  	      .catch(error => console.error('Error:', error));
  	    });
  	  });
  	}; */
  	

    fnGetPostList();
    fnScrollHander();
    fnPostDetail();
    fnInsertCount();
    fnCategorySelect();
    fnPostLike();
/*     document.addEventListener('DOMContentLoaded', () => {
        fnLikeCheck();
    }); */

  </script>
  
  
<%@ include file="../layout/footer.jsp" %>