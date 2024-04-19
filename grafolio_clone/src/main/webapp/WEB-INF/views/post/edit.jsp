<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<jsp:include page="../layout/header.jsp">
   <jsp:param value="포스트 수정화면" name="title"/>
 </jsp:include>

 <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">

<h1 class="title">포스트 편집화면</h1>

<form id="frm-post-modify"
      method="POST"
      action="${contextPath}/post/modify.do">

  <div>
    <span>작성자</span>
    <span>${sessionScope.user.email}</span>
  </div>

  <div>
    <span>작성일자</span>
    <span>${post.createDt}</span>
  </div>
  
  <div>
    <span>최종수정일</span>
    <span>${post.modifyDt}</span>
  </div>
  
  <div>
    <label for="title">제목</label>
    <input type="text" name="title" id="title" value="${post.title}">
  </div>
  
  <div>
    <textarea id="contents" name="contents">${post.contents}</textarea>
  </div>
  
    <!-- 1 일러스트 2 사진 3 디자인 4 회화 5 조소/공예 6 사운드 7 애니메이션 8 캘리그라피 9 기타 --> 
    <div class="row mb-3">
      <label class="col-sm-3 form-label">카테고리</label>
      <div class="col-sm-3">
        <input type="radio" name="category" value="1" id="rdo-illust" class="form-check-input" checked>
        <label class="form-check-label" for="rdo-illust">일러스트</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="2" id="rdo-pic" class="form-check-input">
        <label class="form-check-label" for="rdo-pic">사진</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="3" id="rdo-design" class="form-check-input">
        <label class="form-check-label" for="rdo-design">디자인</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="4" id="rdo-painting" class="form-check-input">
        <label class="form-check-label" for="rdo-painting">회화</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="5" id="rdo-sculpture-craft" class="form-check-input">
        <label class="form-check-label" for="rdo-sculpture-craft">조소/공예</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="6" id="rdo-sound" class="form-check-input">
        <label class="form-check-label" for="rdo-sound">사운드</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="7" id="rdo-animation" class="form-check-input">
        <label class="form-check-label" for="rdo-animation">애니메이션</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="8" id="rdo-calligraphy" class="form-check-input">
        <label class="form-check-label" for="rdo-calligraphy">캘리그라피</label>
      </div>
      <div class="col-sm-3">
        <input type="radio" name="category" value="9" id="rdo-etc" class="form-check-input">
        <label class="form-check-label" for="rdo-etc">기타</label>
      </div>
    </div>
    
  <div>
    <input type="hidden" name="postNo" value="${post.postNo}">
    <button class="btn btn-success" type="submit">수정완료</button>
    <a href="${contextPath}/post/list.page"><button class="btn btn-warning" type="button">작성취소</button></a>
  </div>
      
</form>

<script>

const fnSummernoteEditor = () => {
  $('#contents').summernote({
      width: 1024,
      height: 768,
      lang: 'ko-KR',
      callbacks: {
       onImageUpload: (images)=>{
         // 비동기 방식을 이용한 이미지 업로드
         for(let i = 0; i < images.length; i++){
           let formData = new FormData();
           formData.append('image', images[i]);
           fetch('${contextPath}/post/summernote/imageUpload.do', {
                   method: 'POST',
                   body: formData
           })
           .then(response=>response.json())
           .then(resData=>{
             $('#contents').summernote('insertImage', '${contextPath}' + resData.src);
           });
         }
       }
     }
  });
} 

fnSummernoteEditor();

</script>

<%@ include file="../layout/footer.jsp" %>