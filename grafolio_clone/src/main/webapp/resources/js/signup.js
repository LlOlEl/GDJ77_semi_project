/**
 * 
 */
 
var emailCheck = false;
var passwordCheck = false;
var passwordConfirm = false
var nameCheck = false;
var mobileCheck = false;
var secEmail = document.getElementById('section-email');
var secPw = document.getElementById('section-pw');
var secName = document.getElementById('section-name');
var secMobile = document.getElementById('section-mobile');
var secOptions = document.getElementById('section-options');
var btnConfirmCode = document.getElementById('btn-confirmCode');
var btnVerifyCode = document.getElementById('btn-verify-code');
var btnConfirmPw = document.getElementById('btn-confirmPw');
var btnConfirmName = document.getElementById('btn-confirmName');
var btnConfirmMobile = document.getElementById('btn-confirmMobile');
var msg = document.querySelector('.text-massage');
var str = '';



const fnGetContextPath = ()=>{
  const host = location.host;  /* localhost:8080 */
  const url = location.href;   /* http://localhost:8080/mvc/getDate.do */
  const begin = url.indexOf(host) + host.length;
  const end = url.indexOf('/', begin + 1);
  return url.substring(begin, end);
}

const fnCheckEmail = ()=>{
  
  /*
    new Promise((resolve, reject) => {
      $.ajax({
        url: '이메일중복체크요청'
      })
      .done(resData => {
        if(resData.enableEmail){
          resolve();
        } else {
          reject();
        }
      })
    })
    .then(() => {
      $.ajax({
        url: '인증코드전송요청'
      })
      .done(resData => {
        if(resData.code === 인증코드입력값)
      })
    })
    .catch(() => {
      
    })
  */
  
  /*
    fetch('이메일중복체크요청', {})
    .then(response=>response.json())
    .then(resData=>{
      if(resData.enableEmail){
        fetch('인증코드전송요청', {})
        .then(response=>response.json())
        .then(resData=>{  // {"code": "123asb"}
          if(resData.code === 인증코드입력값)
        })
      }
    })
  */
  
  let inpEmail = document.getElementById('inp-email');
  let regEmail = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  if(!regEmail.test(inpEmail.value)){
    let msgEmail = document.getElementById('msg-email');
    msgEmail.innerHTML = '이메일 형식이 올바르지 않습니다.';
    msgEmail.style.color = 'red';
    msgEmail.style.fontSize = '13px';  
    emailCheck = false;
    return;
  }
  
  
  fetch(fnGetContextPath() + '/user/checkEmail.do', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'email': inpEmail.value
    })
  })
  .then(response => response.json())  // .then( (response) => { return response.json(); } )
  .then(resData => {
    if(resData.enableEmail){
      let msgEmail = document.getElementById('msg-email');
      msgEmail.innerHTML = '';
      
      fetch(fnGetContextPath() + '/user/sendCode.do', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          'email': inpEmail.value
        })
      })
      .then(response => response.json())
      .then(resData => {  // resData = {"code": "123qaz"}
        let msgEmail = document.getElementById('msg-email');
        msgEmail.innerHTML = '인증코드가 전송되었습니다.';
        msgEmail.style.color = 'black';
        msgEmail.style.fontSize = '13px';      
        
        let inpCode = document.getElementById('inp-code');
        let btnVerifyCode = document.getElementById('btn-verify-code');
        inpCode.disabled = false;
        btnVerifyCode.disabled = false;
        btnVerifyCode.addEventListener('click', (evt) => {
          if(resData.code === inpCode.value) {
            let msgEmailCode = document.getElementById('msg-emailCode');
            msgEmailCode.innerHTML = '인증되었습니다.';
            msgEmailCode.style.color = 'black';
            msgEmailCode.style.fontSize = '13px';
            emailCheck = true;
            
          } else {
            let msgEmailCode = document.getElementById('msg-emailCode');
            msgEmailCode.innerHTML = '인증되지 않았습니다.';
            msgEmailCode.style.color = 'red';
            msgEmailCode.style.color = '13px';
            emailCheck = false;
          }
        })
      })
    } else {
      let msgEmail = document.getElementById('msg-email');
      msgEmail.innerHTML = '이미 사용 중인 이메일입니다.';
      msgEmail.style.color = 'red';
      msgEmail.style.fontSize = '13px';
      
      // document.getElementById('msg-email').innerHTML = '이미 사용 중인 이메일입니다.';
      emailCheck = false;
      return;
    }
  })
}

const fnCheckPassword = () => {
  // 비밀번호 4 ~ 12자, 영문/숫자/특수문자 중 2개 이상 포함
  let inpPw = document.getElementById('inp-pw');
  let msgPw = document.getElementById('msg-pw');
  // 영문 포함되어 있으면 true (JavaScript 에서 true는 숫자 1과 같다.))
  let validCount = /[A-Za-z]/.test(inpPw.value)    // 영문 포함되어 있으면 true
                 + /[0-9]/.test(inpPw.value)       // 숫자 포함되어 있으면 true
                 + /[A-Za-z0-9]/.test(inpPw.test); // 영문/숫자가 아니면 true
  let regPw = /^[A-Za-z0-9-_]{2,}@[A-Za-z0-9]+(\.[A-Za-z]{2,6}){1,2}$/;
  let passwordLength = inpPw.value.length;
  passwordCheck = passwordLength >= 4
               && passwordLength <= 12
               && validCount >= 2
  
  if(passwordCheck){
    msgPw.innerHTML = '사용 가능한 비밀번호입니다.';
    msgPw.style.color = '#475993';
    msgPw.style.fontSize = '13px';
  } else {
    msgPw.innerHTML = '비밀번호 4 ~ 12자, 영문/숫자/특수문자 중 2개 이상 포함 ';
    msgPw.style.color = 'red';
    msgPw.style.fontSize = '13px';
  }
}

const fnConfirmPassword = () => {
    let inpPw = document.getElementById('inp-pw');
    let inpPw2 = document.getElementById('inp-pw2');
    passwordConfirm = (inpPw.value != '') && (inpPw.value === inpPw2.value);
    let msgPw2 = document.getElementById('msg-pw2');
    if(passwordConfirm) {
      msgPw2.innerHTML = ''; 
      btnConfirmPw.removeAttribute('disabled');
    } else {
      msgPw2.innerHTML = '비밀번호 입력을 확인하세요.';
      msgPw2.style.color = 'red';
	  msgPw2.style.fontSize = '13px';
      
      btnConfirmPw.setAttribute('disabled', true);
    }
}

const fnCheckName = () => {
  let inpName = document.getElementById('inp-name');
  let name = inpName.value
  let totalByte = 0;
  for(let i = 0; i < name.length; i++){
    if(name.charCodeAt(i) > 127) { // 코드값이 127 초과 이면 한 글자 당 2바이트 처리한다.
      totalByte += 2;
    } else {
      totalByte++;
    }
  }
  nameCheck = (totalByte <= 60);
  let msgName = document.getElementById('msg-name');
  if(!nameCheck){
    msgName.innerHTML = '이름은 30글자를 초과할 수 없습니다.'
    msgName.style.color = 'red';
    msgName.style.fontSize = '13px';
    btnConfirmName.setAttribute('disabled', 'true');
  } else {
    btnConfirmName.removeAttribute('disabled');
    msgName.innerHTML = ''
  }
}

const fnCheckMobile = () => {
  let inpMobile = document.getElementById('inp-mobile');
  let mobile = inpMobile.value;
  mobile = mobile.replaceAll(/[^0-9]/g, '');
  mobileCheck = /^010[0-9]{8}$/.test(mobile);
  let msgMobile = document.getElementById('msg-mobile');
  if(!mobileCheck){
    btnConfirmMobile.setAttribute('disabled', 'true');
    msgMobile.innerHTML = '휴대전화를 확인하세요.'
    msgMobile.style.color = 'red';
    msgMobile.style.fontSize = '13px';
  } else {
    btnConfirmMobile.removeAttribute('disabled');
    msgMobile.innerHTML = ''
  }
}

const fnAttachMini = () => {
  document.getElementById('inp-miniProfile').addEventListener('change', (evt) => {
    const limitPerSize = 1024 * 1024 * 10;
    const file = evt.target.files;
    const attachList = document.getElementById('attach-mini-list');
    attachList.innerHTML = '';
    if(files[i].size > limitPerSize){
      alert('첨부 파일의 최대 크기는 10MB입니다.');
      evt.target.value = '';
      attachList.innerHTML = '';
      return;
    }
    attachList.innerHTML += '<div>' + files[i].name + '</div>';
  })
}

const fnAttachMain = () => {
  document.getElementById('inp-mainProfile').addEventListener('change', (evt) => {
    const limitPerSize = 1024 * 1024 * 10;
    const file = evt.target.files;
    const attachList = document.getElementById('attach-main-list');
    attachList.innerHTML = '';
    if(files[i].size > limitPerSize){
      alert('첨부 파일의 최대 크기는 10MB입니다.');
      evt.target.value = '';
      attachList.innerHTML = '';
      return;
    }
    attachList.innerHTML += '<div>' + files[i].name + '</div>';
  })
}


const fnSignup = () => {
  document.getElementById('frm-signup').addEventListener('submit', (evt) => {
    fnCheckAgree();
    if(!emailCheck) {
      alert('이메일을 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!passwordCheck || !passwordConfirm) {
      alert('비밀번호를 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!nameCheck) {
      alert('이름을 확인하세요.');
      evt.preventDefault();
      return;
    } else if(!mobileCheck) {
      alert('휴대전화를 확인하세요.');
      evt.preventDefault();
      return;
    } 
  });
}

document.getElementById('btn-code').addEventListener('click', fnCheckEmail);
document.getElementById('inp-pw').addEventListener('keyup', fnCheckPassword);
document.getElementById('inp-pw2').addEventListener('keyup', fnConfirmPassword); 
document.getElementById('inp-name').addEventListener('keyup', fnCheckName);
document.getElementById('inp-mobile').addEventListener('blur', fnCheckMobile);
document.getElementById('inp-miniProfile').addEventListener('blur', fnAttachMini);
document.getElementById('inp-mainProfile').addEventListener('blur', fnAttachMain);


btnVerifyCode.addEventListener('click', () => {
	btnConfirmCode.removeAttribute('disabled');
})

btnConfirmCode.addEventListener('click', () => {
    secEmail.style.display = 'none';
    secPw.style.display = '';
    str = '<span>OGQ 계정으로 사용할</span><div>';
    str += '<span class="highlight-text-message text-message">비밀번호</span>';
    str += '<span>를 등록해주세요</span>';
    str += '</div>';
    msg.innerHTML = str;
	            
})
btnConfirmPw.addEventListener('click', () => {
    secPw.style.display = 'none';
    secName.style.display = '';
    str = '<span>OGQ 계정</span><div>';
    str += '<span class="highlight-text-message text-message">닉네임</span>';
    str += '<span>을 입력해주세요</span>';
    str += '</div>';
    msg.innerHTML = str;
})
btnConfirmName.addEventListener('click', () => {
    secName.style.display = 'none';
    secMobile.style.display = '';
    str = '<span>회원정보 확인 및 계정 찾기를 위해</span><div>';
    str += '<span class="highlight-text-message text-message">휴대폰 번호</span>';
    str += '<span>를 입력해주세요</span>';
    str += '</div>';
    msg.innerHTML = str;    
})
btnConfirmMobile.addEventListener('click', () => {
    secMobile.style.display = 'none';
    secOptions.style.display = '';
    str = '<span class="highlight-text-message text-message">환영합니다!</span>';
    msg.innerHTML = str;    
})


fnSignup();