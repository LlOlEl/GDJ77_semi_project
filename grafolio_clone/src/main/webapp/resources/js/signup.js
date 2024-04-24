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
var msg = document.querySelector('span');




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
    alert('이메일 형식이 올바르지 않습니다.');
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
      document.getElementById('msg-email').innerHTML = '';
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
        alert(inpEmail.value + '로 인증코드를 전송했습니다.');
        let inpCode = document.getElementById('inp-code');
        let btnVerifyCode = document.getElementById('btn-verify-code');
        inpCode.disabled = false;
        btnVerifyCode.disabled = false;
        btnVerifyCode.addEventListener('click', (evt) => {
          if(resData.code === inpCode.value) {
            alert('인증되었습니다.');
            emailCheck = true;
            
          } else {
            alert('인증되지 않았습니다.');
            emailCheck = false;
          }
        })
      })
    } else {
      document.getElementById('msg-email').innerHTML = '이미 사용 중인 이메일입니다.';
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
  } else {
    msgPw.innerHTML = '비밀번호 4 ~ 12자, 영문/숫자/특수문자 중 2개 이상 포함 ';
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
      msgPw2.innerHTML = '비밀번호 입력을 확인하세요';
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
    msgMobile.innerHTML = '휴대전화를 확인하세요.'
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
document.getElementById('inp-pw2').addEventListener('blur', fnConfirmPassword); 
document.getElementById('inp-name').addEventListener('blur', fnCheckName);
document.getElementById('inp-mobile').addEventListener('blur', fnCheckMobile);
document.getElementById('inp-miniProfile').addEventListener('blur', fnAttachMini);
document.getElementById('inp-mainProfile').addEventListener('blur', fnAttachMain);


btnVerifyCode.addEventListener('click', () => {
	btnConfirmCode.removeAttribute('disabled');
})

btnConfirmCode.addEventListener('click', () => {
    secEmail.style.display = 'none';
    secPw.style.display = '';
    msg.textContent = 'OGQ 계정으로 사용할 비밀번호를 등록해주세요';
})
btnConfirmPw.addEventListener('click', () => {
    secPw.style.display = 'none';
    secName.style.display = '';
    msg.textContent = 'OGQ 계정 닉네임을 입력해 주세요.';
})
btnConfirmName.addEventListener('click', () => {
    secName.style.display = 'none';
    secMobile.style.display = '';
    msg.textContent = '회원정보 확인 및 계정찾기를 위해 휴대폰 본인인증을 해주세요.';
})
btnConfirmMobile.addEventListener('click', () => {
    secMobile.style.display = 'none';
    secOptions.style.display = '';
})


fnSignup();