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
<link rel="stylesheet" href="${contextPath}/resources/css/creators.css?dt=${dt}">

  <h1 class="title">모든 크리에이터</h1>
  <p class="description">OGQ 그라폴리오에서 활동하는 모든 크리에이터를 만나보세요.</p>
  
  
  <div id="creator-list">
    
  </div>
  
  <script>
    // 전역 변수
    var page = 1;
    var totalPage = 0;
    
    const fnGetUserList = () => {
      // page에 해당하는 목록 요청 
        $.ajax({
          // 요청
          type: 'GET',
          url: '${contextPath}/user/getProfileList.do',
          data: 'page=' + page,
          // 응답
          dataType: 'json',
          success: (resData) => {  // resData = {"postList": [], "totalPage": 10}
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
              str += '      <div class="profile-image-wrapper profile-image-large profile-bordered">';
              str += '        <img src="${contextPath}/resources/img/default_profile_image.png" alt="avatar" draggable="false">';
              str += '      </div>';
              str += '    </div>'
              str += '  </div>'
              str += '</div>'
              
              // 프로필 div 몸통
              str += '<div class="creator-body">';
              str += '  <div class="creator-body-info">';
              str += '    <div class="creator-body-info-upper">';
              str += '      <div class="nickname-wrapper">';
              str += '        <span class="txt-card-nickname">';
              str += user.name;
              str += '</span>'
              str += '      </div>';
              str += '      <span class="txt-card-type">';
              str += user.profileCategory;
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
                // `data-user-no` 속성을 사용하여 해당 사용자의 div를 찾고 그 하위에서 n번째 .txt-card-count를 업데이트
                const n = 3; // n은 0부터 시작하여 해당 위치를 지정 (예: 0은 첫 번째, 1은 두 번째)
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
    
    
    // HTML 문자열에서 첫 번째 <img> 태그의 src 속성을 추출
    function extractFirstImage(htmlContent) {
        var div = document.createElement('div');
        div.innerHTML = htmlContent; // HTML 문자열을 DOM으로 변환
        var image = div.querySelector('img'); // 첫 번째 이미지 태그 선택
        return image ? image.src : null; // 이미지의 src 속성 반환
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
              fnGetUserList();
            }
          }, 500);
      })
    }

    const fnCheckSignin = () => {
      if('${sessionScope.user}' === '') {
        if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
          location.href = '${contextPath}/user/signin.page';
        }
      }
    }

    fnGetUserList();
    fnScrollHander();
  </script>
  
  
<%@ include file="../layout/footer.jsp" %>