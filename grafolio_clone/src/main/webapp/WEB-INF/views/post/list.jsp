<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

 <jsp:include page="../layout/header.jsp">
   <jsp:param value="블로그 리스트" name="title"/>
 </jsp:include>
 
<!-- include custom css/js -->
<link rel="stylesheet" href="${contextPath}/resources/css/list.css?dt=${dt}">
 
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
              str += '<div class="post-bottom-profile">';
              str += '<span>' + post.user.email + '</span>';
              str += '</div>';
              str += '<div class="post-bottom-options">';
              str += '<div class="post-bottom-option">';
              str += '<i class="fa-regular fa-heart"></i>';
              str += '<span id="like-count-' + post.postNo + '"></span>';
              str += '</div>';
              str += '<div class="post-bottom-option">';
              str += '<i class="fa-regular fa-eye"></i>';
              str += '<span>' + post.hit + '</span>';
              str += '</div>';
              str += '</div>';
              str += '</div>';
              str += '</div>';
              $('#post-list').append(str);
              
              // 서버에서 likecount 를 받아와서 업데이트
              fnGetLikeCountByPostNo(post.postNo)
                .then(result => {
                  // id="like-count-' + post.postNo 내용을 바꿔줌
                  $('#like-count-' + post.postNo).html(result); 
                })
                .catch(error => {
                  console.error(error);
                  $('#like-count-' + post.postNo).html('Error');
                });
            })
            if('${sessionScope.user}' !== ''){
             fnLikeCheck();
            }
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
                str += '<div class="post-bottom-profile">';
                str += '<span>' + post.user.email + '</span>';
                str += '</div>';
                str += '<div class="post-bottom-options">';
                str += '<div class="post-bottom-option">';
                str += '<i class="fa-regular fa-heart"></i>';
                str += '<span id="like-count-' + post.postNo + '"></span>';
                str += '</div>';
                str += '<div class="post-bottom-option">';
                str += '<i class="fa-regular fa-eye"></i>';
                str += '<span>' + post.hit + '</span>';
                str += '</div>';
                str += '</div>';
                str += '</div>';
                str += '</div>';
                $('#post-list').append(str);
                
                // Fetch and update like count asynchronously
                fnGetLikeCountByPostNo(post.postNo)
                  .then(result => {
                    $('#like-count-' + post.postNo).html(result); // Update the like count placeholder with actual data
                  })
                  .catch(error => {
                    console.error(error);
                    $('#like-count-' + post.postNo).html('Error'); // Display error in the like count placeholder
                  });
              })
              if('${sessionScope.user}' !== ''){
                fnLikeCheck();
              }
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
        likeButton.innerHTML = '<i class="fa-regular fa-heart" style="color: #ffffff;"></i>';
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
          if('${sessionScope.user.userNo}' == userNo) {
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
    
    
    const fnCheckSignin = () => {
      if('${sessionScope.user}' === '') {
        if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
          location.href = '${contextPath}/user/signin.page';
        }
      }
    }
    
    fnGetPostList();
    fnScrollHander();
    fnPostDetail();
    fnInsertCount();
    fnCategorySelect();
    fnPostLike();
  </script>
  
  
<%@ include file="../layout/footer.jsp" %>