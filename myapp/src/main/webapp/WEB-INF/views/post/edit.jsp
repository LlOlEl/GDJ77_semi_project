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