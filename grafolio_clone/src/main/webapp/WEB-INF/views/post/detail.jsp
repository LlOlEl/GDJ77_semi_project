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
 
  #detail-page {
     align-items: center;
    background-color: var(--mono-000);
    display: flex;
    flex-direction: column;
    height: calc(100% - 150px);
    left: 0;
    margin: 150px auto 0;
    overflow-y: scroll;
    padding: 0 0 127px;
    position: absolute;
    scrollbar-width: none;
    top: 40px;
    width: 100%;
    }

  #title-wraper {
    align-items: center;
    background-color: var(--mono-000);
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    justify-content: center;
    left: 0;
    margin: 40px 0;
    padding: 40px 0;
    position: fixed;
    top: 0;
    width: 100%;
  }

  .blind {
    display: none;
  }
  
  .title-inner-wrapper{
    align-items: center;
    display: flex;
    justify-content: center;
  }
  
  .title-txt {
    display: block;
    font-size: 24px;
    font-weight: 700;
    height: 32px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: -moz-fit-content;
    width: fit-content
  }
 
 
  .comment-top {
    color: gray;
    font-size: 14px;
    height: 100%;
  }
  
  
  
  #btn-comment-register{
    height: 100%;
    weigth: 100%;
    padding: var(--input-gutter);
  }
  
  .con {
  display: flex;
  justify-content: center; /* 수평 가운데 정렬 */
  align-items: center; /* 수직 가운데 정렬 */
  width: 90%; /* 브라우저 너비의 90%로 설정 */
  padding-bottom: 30px; /* 하단 여백 */
  margin: 0 auto; /* 가운데 정렬을 위해 좌우 마진 자동 설정 */
  margin-rigth: 20px;
}

.con span:nth-of-type(1) {
  width: 20%; /* 내용의 너비를 브라우저 너비의 20%로 설정 */
   
}

#contents {
  
}

.con img {
  max-width: 600px; /* 이미지의 최대 너비를 부모 요소인 .con의 너비에 맞게 설정 */
  max-height: 600px; /* 이미지의 최대 높이를 부모 요소인 .con의 높이에 맞게 설정 */
  
}
  
  .content-bottom-wrapper {
    cursor: pointer;
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
    flex-wrap:wrap;
    gap: 20px;
    width: 100%;
    column-gap: 20px;
    
}
 .hashtag {
 background-color: gray;
 display: inline-block;
 border-radius: 100px;
 padding: 20px;
 font-size:12px;
 }
 
 .like{
  font-size:12px;
  cursor: auto;
 }
 
  #btn-comment-register {
  background-color: gray;
  
  }
  
  .comments-all{
    display: none;
  }
  
  #modalOpenButton, #modalCloseButton {
  cursor: pointer;
}

#modalContainer {
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
}

#modalContent {
  position: absolute;
  background-color: #ffffff;
  width: 300px;
  height: 150px;
  padding: 15px;
}

#modalContainer.hidden {
  display: none;
}


 .navigation {
   position: fixed;
    top: 195px;
    right: 0;
    padding: 10px 20px;
    z-index:10px
 }
 

 
 .menu-wrapper {
  align-items: center;
    display: flex;
    flex-direction: column;
    gap: 20px;
    justify-content: center;
    margin: 0;
    padding: 10px;
 }
 
 .profile-wrapper {
   align-items: center;
    display: flex;
    justify-content: space-between;
    padding: 0 20px 20px 40px;
}
 
 
 .icon-wrapper {
    
    border: 1px solid var(--mono-050);
    border-radius: 100%;
    box-shadow: 0 4px 15px #dedede4d;
    height: 50px;
    position: relative;
    width: 50px;
    
    
 }
 
 .fa-icon {
 cursor: pointer;
    left: 50%;
    position: absolute;
    top: 50%;
    transform: translate(-50%, -50%);
 }
 #share-icon {
 cursor: pointer;
    left: 50%;
    position: absolute;
    top: 50%;
    transform: translate(-50%, -50%);
 }
 #icon-third {
 cursor: pointer;
    left: 50%;
    position: absolute;
    top: 50%;
    transform: translate(-50%, -50%);
 }
 
 
 #comment-bottom{
  display: flex;
  left: 1300px;
  font-size:12px;
  cursor:pointer;
 }
 
 .inputwrapper {
  display: flex;
  align-items: center; /* 수직 가운데 정렬 */
  gap: 10px; /* 이미지와 입력 창 사이의 간격 조절 */
 }
 .img-ogq {
  
  border-radius: 50%;
  
 }
 
 .comment-selection {
 display: flex;
    flex-direction: column;
    gap: 40px;
    position: relative;
    width: 60%;
    margin: auto;
 }
  
 </style>
 <div class="detail-page">
 
 <div>
 
 </div>
  
  
  <a href="${contextPath}/post/list.page">블로그 리스트</a>
  
  <div class="post-detail">
    <div class="title-wrapper">
      <div class="title-inner-wrapper">
      <span class="title-txt">${post.title}</span>
      </div>
    </div>
    <div>
      <span>작성자</span>
      <span>${post.user.email}</span>
    </div>
    
    
    
    
    
    <div class="con">
      
      <span>${post.contents}</span>
    </div>
    <c:if test="${sessionScope.user.userNo == post.user.userNo}">
      <form id="frm-btn" method="POST">  
        <input type="hidden" name="postNo" value="${post.postNo}">
        <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
        <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
      </form>
    </c:if>
  </div>
  
  <hr>
  
  
  <div class="content-bottom-wrapper">
    <div class="tab-wrapper">   
        <div class="hashtag">사진</div>
        <div class="hashtag">인사동</div>
        <div class="hashtag">골목</div>
        <div class="hashtag">서울</div>
        <div class="hashtag">거리</div>
    </div>
    <div class="like">
      <div><i class="fa-regular fa-heart" width="10px;"></i>${like.likeNo}</div>
    </div>
    <div><i class="fa-regular fa-eye" width="10px"></i>${post.hit}</div>
    <div><i class="fa-regular fa-comment" width="10px"></i>${comment.commentNo}</div>
  </div>
  
  
  
  <hr>
  <div class="comment-selection">
  <div class="inputwrapper">
   <img class="img-ogq" src="https://preview.files.api.ogq.me/v1/profile/LARGE/NEW-PROFILE/default_profile.png" width="20px" height="20px">
  <form id="frm-comment">
    <input type="text" id="contents" name="contents" placeholder="댓글을 입력해주세요"></input>
    <input type="hidden" name="postNo" value="${post.postNo}">
    <c:if test="${not empty sessionScope.user}">
      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
    </c:if>
    <button id="btn-comment-register" type="button" disabled>등록하기</button>
  </form>
  
   </div>
  <div>
    <button id="comment-bottom">© All Rights Reserved</button>
  </div>
  </div>
  <hr>
  
  <div id="comment-list"></div>
  <div id="paging"></div>
  
  <hr>
  
  <div class="navigation"  >
    <div class="profile-wrapper" width="24" height="24"> 
      <i class="fa-regular fa-user"></i>
    </div>
    
    <div class="menu-wrapper">
      <div class="icon-wrapper">
       <div class="fa-icon">
         <c:if test="${sessionScope.user.userNo == post.user.userNo}">
         <i class="fa-regular fa-heart" id="icon-heart" ></i>
         </c:if>       
       </div>
      </div>
      <div class="icon-wrapper" >
        <c:if test="${sessionScope.user.userNo == post.user.userNo}">
          <button id="modalOpenButton"><i class="fas fa-thin fa-share-nodes" id="share-icon"></i></button> 
        </c:if> 
      </div>
      <div class="icon-wrapper">
        <i class="fa-regular fa-bookmark" id="icon-third"></i>
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
  
 
 
 
  
//아이콘의 초기 색상을 추적합니다.

  // 아이콘을 클릭할 때마다 색상을 변경하고 토글합니다.
  document.getElementById('icon-heart').addEventListener('click', (evt) => {
  let iconColor = '#ff'; // 이전 색상을 기본 색상으로 설정
    // 현재 색상이 이전 색상과 같은지 확인하여 토글합니다.
    if (evt.target.style.color === iconColor) {
      // 이전 색상과 같으면 초기 색상으로 변경합니다.
      evt.target.style.color = '#ff';
    } else {
      // 이전 색상과 다르면 새로운 색상을 설정합니다.
      evt.target.style.color = '#e33861';
    }
    // 현재 색상을 업데이트합니다.
    iconColor = evt.target.style.color;
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
	  //modal.classList.remove('hidden');
	    
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
			  btnChange.style.backgroundColor = 'green';
			  btnChange.disabled = false;
		  } else {
			  btnChange.disabled = true;
			  btnChange.style.backgroundColor = 'gray';
		  }
	  })
  }
  
    const fnCheckSignin = () => {
      if('${sessionScope.user}' === '') {
        if(confirm('Sign In 이 필요한 기능입니다. Sign In 할까요?')) {
          location.href = '${contextPath}/user/signin.page';
        }
      }
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
          let commentList = $('#comment-list');
          let paging = $('#paging');
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
              str += '<div>';

            } else {
              str += '<div class="comments-all" style="padding-left: 32px;">';
            }
            // 댓글 내용 표시
            console.log(comment.state);
            if(comment.state === 1){
              str += '<span class="comment-top">';
              str += comment.user.email;
              str += '<br>'
              str += '(' + moment(comment.createDt).format('YYYY.MM.DD.') + ')';
              str += '</span>';
              str += '<div>' + comment.contents + '</div>';
              
              str += '<button type="button" class="btn btn-success btn-reply">답글</button>';
              // 답글 버튼
                
              if(comment.depth === 0) {
                	
              }
              /* 답글 입력 화면 */
              str += '<div class="blind">';
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
                str += '<button type="button" id="btn-comment-show">답글보기</button>';
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
        let write = $(evt.target).next();
        if(write.hasClass('blind')) {
          $('.write').addClass('blind'); // 모든 답글 작성 화면 닫은 뒤
          write.removeClass('blind');    // 답글 작성 화면 열기
        } else {
          write.addClass('blind');
        }
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
  </script>
  
<%@ include file="../layout/footer.jsp" %>