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
    width: 100%;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
  }
  
  .post{
    width: 24%;
    height: 300px;
    margin: 10px auto;
    cursor: pointer;

  }
  
  .post > post-bottom {
    display: flex;
    width: 100%;
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
 
  <h1 class="title">블로그 목록</h1>
  
  <a href="${contextPath}/post/write.page">블로그작성</a>
  
  <div id="post-list">
  
  </div>
  
  
 
  
  <script>
  
    // 전역 변수
    var page = 1;
    var totalPage = 0;
    
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
              if (thumbnailUrl) {
                  str += displayThumbnail(thumbnailUrl);
              }
              str += '<div class="post-bottom">';
  		        str += '<span>' + post.title + '</span>';
  		        str += '<span>' + post.user.email + '</span>';
  		        str += '<span>' + post.hit + '</span>';
  		        str += '<span>' + moment(post.createDt).format('YYYY.MM.DD.') + '</span>';
  		        str += '</div>';
  		        str += '</div>';
  		        $('#post-list').append(str);
  		      })
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

    // 추출한 이미지 URL로 썸네일을 화면에 표시
    function displayThumbnail(imageUrl) {
        var imgElement = document.createElement('img');
        imgElement.src = imageUrl;
        imgElement.alt = 'Thumbnail';
        imgElement.style.width = '100%'; // 썸네일 크기 설정
        return imgElement.outerHTML;
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
    	        fnGetPostList();
    	      }
    	    }, 500);
    	})
    }
  
    const fnPostDetail = () => {
    	
    	$(document).on('click', '.post', (evt) => {
    		
    		// <div class="post"> 중 클릭 이벤트가 발생한 <div> : 이벤트 대상 evt.target
    		// evt.target.dataset.postNo === $(evt.target).data('postNo')
    		// evt.target.dataset.userNo === $(evt.target).data('userNo')
    		
    		// 내가 작성한 블로그는 /detail.do 요청 (조회수 증가가 없음)
    		// 남이 작성한 블로그는 /updateHit.do 요청 (조회수 증가가 있음)
    		if('${sessionScope.user.userNo}' === evt.target.dataset.userNo) {
  			  location.href = '${contextPath}/post/detail.do?postNo=' + evt.target.dataset.postNo;
    		} else { 
  			  location.href = '${contextPath}/post/updateHit.do?postNo=' + evt.target.dataset.postNo;
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
    
    fnGetPostList();
    fnScrollHander();
    fnPostDetail();
    fnInsertCount();
    
  </script>
  
  
<%@ include file="../layout/footer.jsp" %>