<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="검색" name="title"/>
 </jsp:include>
 
<!-- include custom css/js -->
<link rel="stylesheet" href="${contextPath}/resources/css/creators.css?dt=${dt}">
<link rel="stylesheet" href="${contextPath}/resources/css/list.css?dt=${dt}">
<link rel="stylesheet" href="${contextPath}/resources/css/search.css?dt=${dt}">

    <div class="search-head">
        <div class="search-head-upper">
            <div class="dropdown-outer select category">
                <div class="dropdown-trigger-block">
                    <div class="dropdown-trigger-wrapper">
                        <div class="select-trigger select-size-medium select-color-gray select-bordered">
                            <span class="value value-size-medium">프로젝트</span>
                            <img class=".arrow-icon" src="${contextPath}/resources/svg/search_arrow_down_icon.svg">
                        </div>
                    </div>
                </div>
                <div class="dropdown-menu-block">
                  <div class="dropdown-menu-wrapper align-right">
                      <div class="dropdown-menu-inner" style="top: 0px;">
                          <div  class="menu-list menu-size-medium menu-type-filter no-scroll">
                              <div class="menu-item selected"><span style="color: #00B57F;"></span>프로젝트</div>
                              <div class="menu-item"><span style="color: #00B57F;"></span>크리에이터</div>
                          </div>
                      </div>
                  </div>
                </div>
            </div>
            <div class="input-outer input-bg-color-gray input-size-medium input-stretch input-search" type="text">
              <div class="input-wrapper">
                <c:if test="${q != null}">  
                  <input class="input input-delete" type="text" placeholder="검색어를 입력해주세요" value="${q}">
                </c:if>
                <c:if test="${q == null}">
                  <input class="input input-delete" type="text" placeholder="검색어를 입력해주세요">
                </c:if>
                <div class="input-icon">
                  <img class="icon icon-search" src="${contextPath}/resources/svg/search_icon.svg">
                  <img class="icon icon-delete default" src="${contextPath}/resources/svg/search_icon_delete.svg">
                </div>
              </div>
            </div>
        </div>
        <div class="search-head-lower">
            <span class="keyword input"></span>
        </div>
    </div>
  
  
  <div class="search-list">
    
  </div>
  
  <script>
    // 전역 변수
    var page = 1;
    var totalPage = 0;
    var selectedValue;
    var hasLogin = true;
    
    const fnSearch = () => {
        const bindSearchEvent = () => {
        	$(document).on('keydown', '.input-delete', (evt) => {
        	    if (evt.key === 'Enter') {
        	        performSearch($(evt.target).val());
        	        evt.preventDefault();
        	    }
        	});
        };

        // 최초 페이지 로드 시 실행할 검색 함수
        const initialSearch = () => {
            const initialQuery = '${q}';
            if (initialQuery) {
                performSearch(initialQuery);
            }
        };

        // 검색 실행 함수
        const performSearch = (query) => {
            $('.search-list').empty();
            page = 1;
            totalPage = 0;
            selectedValue = $('.value').text().trim();

            if (selectedValue === '프로젝트') {
                fnSearchPostList(query);
                fnPostScrollHander(query);
                fnPostDetail();
                fnPostLike();
            } else if (selectedValue === '크리에이터') {
                fnSearchUserList(query);
                fnUserScrollHander(query);
            }
        };
        
        // 이벤트 바인딩 및 초기 검색 실행
        bindSearchEvent();
        initialSearch();
    };
    
    const fnSearchPostList = (query) => {
      if (selectedValue === '프로젝트') {
      	$('.search-list').attr('id', 'post-list');
        $.ajax({
          // 요청
          type: 'GET',
          url: '${contextPath}/search/projects' ,
          data: {page: page, q: query},
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
    
    const fnPostScrollHander = (query) => {
        // 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청
        if(selectedValue === '프로젝트'){
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
                fnSearchPostList(query);
              }
            }, 500);
          })
        }
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
      
      const fnSearchUserList = (query) => {
          if (selectedValue === '크리에이터') {
    	    $('.search-list').attr('id', 'creator-list');
          // page에 해당하는 목록 요청 
            $.ajax({
              // 요청
              type: 'GET',
              url: '${contextPath}/search/creators',
              data: {page: page, q: query},
              // 응답
              dataType: 'json',
              success: (resData) => {  // resData = {"userList": [], "totalPage": 10}
                totalPage = resData.totalPage;
                $.each(resData.userList, (i, user) => {

                  let str = '<div class="creator-wrap" data-user-no="' + user.userNo + '">';
                  
                  // 프로필 div 머리부분
                  str += '<div class="creator-head">';
                  str += '  <div class="creator-head-image-wrap">';
                  str += '    <div class="creator-head-image" style="background-image: url(${contextPath}/resources/img/default_cover.png);"></div>';
                  str += '    <div class="creator-head-image" style="background-image: url(${contextPath}/resources/img/default_cover.png);"></div>';
                  str += '    <div class="creator-head-image" style="background-image: url(${contextPath}/resources/img/default_cover.png);"></div>';
                  str += '    <div class="creator-head-image" style="background-image: url(${contextPath}/resources/img/default_cover.png);"></div>';
                  str += '  </div>';
                  str += '  <div class="creator-avatar-wrap">';
                  str += '    <div class="profile-image-wrap card-avatar">';
                  str += '      <a href="${contextPath}/user/profile.do?userNo=' + user.userNo + '"">'
                  str += '        <div class="profile-image-wrapper profile-image-large profile-bordered">';
                  str += '          <img src="${contextPath}/resources/img/default_profile_image.png" alt="avatar" draggable="false">';
                  str += '        </div>';
                  str += '      </a>'
                  str += '    </div>'
                  str += '  </div>'
                  str += '</div>'
                  
                  // 프로필 div 몸통
                  str += '<div class="creator-body">';
                  str += '  <div class="creator-body-info">';
                  str += '    <div class="creator-body-info-upper">';
                  str += '      <div class="nickname-wrapper">';
                  str += '        <a href="${contextPath}/user/profile.do?userNo=' + user.userNo + '"">'
                  str += '          <span class="txt-card-nickname">';
                  str += user.name;
                  str += '</span>'
                  str += '</a>'
                  str += '      </div>';
                  str += '      <span class="txt-card-type">';
                  if(user.profileCategory){
                    str += user.profileCategory;
                  }
                  str += '</span>'
                  str += '    </div>';
                  str += '  </div>';
                  str += '</div>';
                  
                  // 프로필 div 다리
                  str += '<div class="creator-bottom">';
                  str += '  <div class="creator-bottom-info">';
                  str += '    <div class="creator-bottom-info-inner">';
                  str += '      <span class="txt-card-count">';
                  str += '0';
                  str += '</span>'
                  str += '      <span class="txt-card-name">';
                  str += '좋아요';
                  str += '</span>'
                  str += '    </div>';
                  str += '    <div class="creator-bottom-info-inner">';
                  str += '      <span class="txt-card-count">';
                  str += '0';
                  str += '</span>'
                  str += '      <span class="txt-card-name">';
                  str += '팔로잉';
                  str += '</span>'
                  str += '    </div>';
                  str += '    <div class="creator-bottom-info-inner">';
                  str += '      <span class="txt-card-count">';
                  str += '0';
                  str += '</span>'
                  str += '      <span class="txt-card-name">';
                  str += '팔로워';
                  str += '</span>'
                  str += '    </div>';
                  str += '    <div class="creator-bottom-info-inner">';
                  str += '      <span class="txt-card-count">';
                  str += '0';
                  str += '</span>'
                  str += '      <span class="txt-card-name">';
                  str += '조회수';
                  str += '</span>'
                  str += '    </div>';
                  str += '  </div>';
                  str += '  <div class="button-wrapper list">';
                  // 팔로잉, 팔로워 버튼 추가
                  if(user.isFollow === 1) {
                  str += '    <button class="btn-detail btn-unfollow" id="following_' + user.userNo + '" data-user-no="' + user.userNo + '">';
                  str += '      <div class="btn-text">팔로잉</div>';
                  str += '    </button>';
                } else {
                  str += '    <button class="btn-detail btn-follow" id="following_' + user.userNo + '" data-user-no="' + user.userNo + '">';
                  str += '      <div class="btn-text">팔로우하기</div>';
                  str += '    </button>';
                }
                  
                  str += '</div>';
                  str += '</div>';
                  
                  $('#creator-list').append(str);
                  
                  // 포스트 썸네일 받아오기
                  /* var thumbnailUrl = extractFirstImage(post.contents); */
                  
                  // 서버에서 userNo로 유저가 올린 게시물의 모든 Like 수를 받아와서
                  // creator-wrap의 data-user-no가 user.userNo인 n번째 .txt-card-count에 업데이트한다. 
                  fnGetLikeCountByUserNo(user.userNo)
                    .then(result => {
                      // `data-user-no` 속성을 사용하여 해당 사용자의 div를 찾고 그 하위에서 n번째 .txt-card-count를 업데이트
                      const n = 0; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
                      $('div[data-user-no="' + user.userNo + '"]').find('.txt-card-count').eq(n).text(result);
                    })
                    .catch(error => {
                      console.error('Error fetching like count for user number ' + user.userNo + ': ', error);
                    });
                  
                  fnGetHitCountByUserNo(user.userNo)
                  .then(result => {
                    // `data-user-no` 속성을 사용하여 해당 사용자의 div를 찾고 그 하위에서 n번째 creator-head-image를 업데이트
                     const n = 3;
                    $('div[data-user-no="' + user.userNo + '"]').find('.txt-card-count').eq(n).text(result);
                  })
                  .catch(error => {
                    console.error('Error fetching hit count for user number ' + user.userNo + ': ', error);
                  });
                  
                  // 팔로잉 & 팔로워 카운트 조회 - 오채원(24/04/21)
                  fnGetFollowCount(user.userNo)
                  .then(result => {
                    // `data-user-no` 속성을 사용하여 해당 사용자의 div를 찾고 그 하위에서 n번째 .txt-card-count를 업데이트
                    const n1 = 1;
                    const n2 = 2;
                    $('div[data-user-no="' + user.userNo + '"]').find('.txt-card-count').eq(n1).text(result.followingCount);
                    $('div[data-user-no="' + user.userNo + '"]').find('.txt-card-count').eq(n2).text(result.followerCount);
                  })
                  .catch(error => {
                    console.error('Error fetching following count for user number ' + user.userNo + ': ', error);
                  });   
                  
                  // 유저가 업로드한 최근 게시물 4개에서 썸네일을 받아와서 표시
                  fnGetUserUploadList(user.userNo)
                  .then(result => {
                    // 각 썸네일 URL을 div의 백그라운드 이미지로 설정
                    const $divs = $('div[data-user-no="' + user.userNo + '"]').find('.creator-head-image');
                    result.forEach((thumbnailUrl, index) => {
                      if (thumbnailUrl  && $divs.eq(index).length) {  // 해당 인덱스의 div가 존재하는 경우에만 처리
                        $divs.eq(index).css('background-image', 'url("' + thumbnailUrl + '")');
                      }
                    })
                  })
                  .catch(error => {
                    console.error('Error fetching UploadList for user number ' + user.userNo + ': ', error);
                  });
                  
              })
              /*   if('${sessionScope.user}' !== ''){
                 fnLikeCheck();
                } */
              },
              error: (jqXHR) => {
                alert(jqXHR.statusText + '(' + jqXHR.status + ')');
              }
            });
          }
        }
      
        const fnGetLikeCountByUserNo = (userNo) => {
          return fetch('${contextPath}/post/get-like-count-by-userNo?userNo=' + userNo, {
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
        
        const fnGetHitCountByUserNo = (userNo) => {
          return fetch('${contextPath}/post/get-hit-count-by-userNo?userNo=' + userNo, {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
            }
          })
          .then(response => response.json())
          .then(resData => {
            return resData.hitCount;
          })
          .catch(error => {
              console.log('Error likecount the post.'); // 에러 처리
          });
        }
        
        // 팔로잉, 팔로워 수 가져오기 - 오채원(24/04/21)
        const fnGetFollowCount = (userNo) => {
            return fetch('${contextPath}/user/getFollowCount.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    'userNo': userNo
                })
            })
            .then(response => response.json())
            .then(resData => {
                return resData;
            })
            .catch(error => {
                console.log('Error getting the follow count:', error); // 에러 처리
                throw error; // 에러를 다시 throw하여 상위로 전파
            });
        }
        
        // 프로필 유저가 업로드한 게시물 가져오기
        const fnGetUserUploadList = (userNo) => {
          return fetch('${contextPath}/post/getUserUploadList.do?userNo=' + userNo + '&page=1&display=4')
          .then(response=>response.json())
          .then(resData=> {
            const thumbnailUrls = []; // thumbnailUrl 배열 생성
            $.each(resData.userUploadList, (i, upload) => {
              var thumbnailUrl = extractFirstImage(upload.contents);
              thumbnailUrls.push(thumbnailUrl); // 배열에 thumbnailUrl 추가
            })
            return thumbnailUrls; // thumbnailUrl 배열 리턴
          })
        }
        
        // HTML 문자열에서 첫 번째 <img> 태그의 src 속성을 추출
        function extractFirstImage(htmlContent) {
            var div = document.createElement('div');
            div.innerHTML = htmlContent; // HTML 문자열을 DOM으로 변환
            var image = div.querySelector('img'); // 첫 번째 이미지 태그 선택
            return image ? image.src : null; // 이미지의 src 속성 반환
        }
        
        const fnUserScrollHander = (query) => {
          // 스크롤이 바닥에 닿으면 page 증가(최대 totalPage 까지) 후 새로운 목록 요청
          if(selectedValue === '크리에이터'){
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
                    fnSearchUserList(query);
                  }
                }, 500);
            })
          }
        }
        
        // 팔로우
        $(document).on('click', '.btn-follow', function() {
        
        // 자기 자신 검사
        if($('.loginId').data('userNo') === $(this).data('userNo')) {
          return;
        }
        
        // 로그인 여부 검사
        fnFollowCheckSignin();
        if(!hasLogin) {
          return;
        } else {
          
          // 로그인 여부 통과되었으므로 fetch 진행
          fetch('${contextPath}/user/follow.do', {
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
                $(this).css('background-color', '#425052');
                $(this).css('color', 'white');
                $(this).css('border-color', '#425052');
                $(this).attr('class', 'btn-detail btn-unfollow');
              }
            })
        }

      });
        
        
        // 언팔로우
        $(document).on('click', '.btn-unfollow', function() {
      
        // 자기 자신 검사
        if($('.loginId').data('userNo') === $(this).data('userNo')) {
          return;
        }
        
        // 로그인 여부 통과되었으므로 fetch 진행
        fetch('${contextPath}/user/unfollow.do', {
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
              $(this).text('팔로우하기');
              $(this).css('background-color', '#00b57f');
              $(this).css('color', 'white');
              $(this).css('border-color', '#00b57f');
              $(this).attr('class', 'btn-detail btn-follow');
            }
          })
      });
        
        const fnFollowCheckSignin = () => {
          if('${sessionScope.user}' === '') {
            if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
              location.href = '${contextPath}/user/signin.page';
            } else {
              hasLogin = false;
            }
          }
        }

      
      
      const fnCheckSignin = () => {
        if('${sessionScope.user}' === '') {
          if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
            location.href = '${contextPath}/user/signin.page';
          }
        }
      }
      
      $('.select-trigger').click(function() {
    	  $('.dropdown-menu-block').toggle();
    	});

    	$('.menu-item').click(function() {
    	    // 모든 메뉴 아이템에서 'selected' 클래스 제거
    	    $('.menu-item').removeClass('selected');
    	    // 클릭된 메뉴 아이템에만 'selected' 클래스 추가
    	    $(this).addClass('selected');

    	    // 선택된 메뉴 아이템의 텍스트를 .value 요소에 설정
    	    var text = $(this).text().trim();
    	    $('.value').text(text);

    	    // 드롭다운 메뉴 숨기기
    	    $('.dropdown-menu-block').css('display', 'none');
    	});
      
      fnSearch();
  </script>

<%@ include file="../layout/footer.jsp" %>