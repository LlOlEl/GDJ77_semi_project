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
    
    fnGetPostList();
    fnScrollHander();
    fnPostDetail();
    fnInsertCount();
    fnCategorySelect();
    
  </script>
  
  
<%@ include file="../layout/footer.jsp" %>