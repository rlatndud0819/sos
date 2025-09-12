<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <style>
    * { margin:0; padding:0; list-style:none; text-decoration:none; font-family:'Malgun Gothic','맑은 고딕',sans-serif; box-sizing:border-box; }

    /* 공통 레이아웃: sticky footer + 중앙 정렬 */
    .page-container { min-height:100vh; display:flex; flex-direction:column; }
    .main-content   { flex:1; display:flex; justify-content:center; align-items:flex-start; padding:24px 16px; }
    .main-inner     { width:100%; max-width:1080px; display:flex; justify-content:center; }

    /* 폼 카드 */
    .container { width:100%; max-width:400px; padding:30px; background-color:#ffffff; border:1px solid #e0e0e0; box-shadow:0 4px 8px rgba(0,0,0,0.05); border-radius:8px; }

    h2 { text-align:center; margin-bottom:10px; color:#333; font-size:1.8em; }
    .subtitle { text-align:center; margin-bottom:30px; color:#666; font-size:0.9em; }
    .form-group { margin-bottom:20px; }
    label { display:block; margin-bottom:8px; font-size:0.9em; color:#555; font-weight:bold; }
    .required { color:#e74c3c; }
    .input-field { width:100%; padding:12px; border:1px solid #ced4da; border-radius:4px; font-size:1em; transition:all 0.3s ease; }
    .input-field:focus { outline:none; border-color:#20B2AA; box-shadow:0 0 5px rgba(32,178,170,0.25); }
    .input-field.error { border-color:#e74c3c; box-shadow:0 0 5px rgba(231,76,60,0.25); }
    .input-field.success { border-color:#27ae60; box-shadow:0 0 5px rgba(39,174,96,0.25); }
    .error-message, .success-message { font-size:0.8em; margin-top:5px; display:none; }
    .error-message { color:#e74c3c; }
    .success-message { color:#27ae60; }
    .password-guide { color:#999; font-size:0.75em; margin-top:5px; line-height:1.4; }
    .inline-fields { display:flex; gap:10px; }
    .inline-fields .field-group { flex-grow:1; }
    .gender-radio { display:flex; gap:20px; }
    .submit-button { width:100%; padding:15px; background-color:#e74c3c; color:#fff; font-size:1.2em; font-weight:bold; border:none; border-radius:4px; cursor:pointer; margin-top:30px; transition:background-color 0.3s ease; }
    .submit-button:hover { background-color:#c0392b; }
  </style>
</head>
<body>
<div class="page-container">
  <%@ include file="../layout/header.jsp" %>

  <main class="main-content">
    <div class="main-inner">
      <div class="container">
        <h2>회원가입</h2>
        <p class="subtitle">회원가입에 필요한 정보를 입력해주세요.</p>

        <form action="${pageContext.request.contextPath}/join.do" method="post" onsubmit="return validateForm()">
          <div class="form-group">
            <label for="email">이메일<span class="required">(필수)</span></label>
            <input type="email" id="email" name="email" class="input-field"
                   placeholder="이메일" value="${prefill_email}" required>
            <div id="emailDupMsg" style="display:none; margin-top:6px; color:#e74c3c; font-size:0.85em;">
              이미 회원가입을 한 이메일 입니다!
            </div>
            <c:if test="${not empty dupEmailMsg}">
              <script>
                window.addEventListener('DOMContentLoaded', function(){
                  const msg = document.getElementById('emailDupMsg');
                  if (msg) { msg.style.display = 'block'; }
                  const emailEl = document.getElementById('email');
                  if (emailEl) { emailEl.classList.add('error'); }
                });
              </script>
            </c:if>
          </div>

          <div class="form-group">
            <label for="password">비밀번호<span class="required">(필수)</span></label>
            <input type="password" id="password" name="Password" class="input-field" placeholder="비밀번호 입력" required oninput="validatePassword()">
            <div class="error-message" id="passwordError">비밀번호는 8자 이상이어야 합니다.</div>
          </div>

          <div class="form-group">
            <label for="confirmPassword">비밀번호 확인<span class="required">(필수)</span></label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="input-field" placeholder="비밀번호 재입력" required oninput="validatePasswordMatch()">
            <div class="error-message" id="confirmPasswordError">비밀번호가 일치하지 않습니다.</div>
            <div class="success-message" id="confirmPasswordSuccess">비밀번호가 일치합니다.</div>
            <div class="password-guide">영문 대소문자, 숫자, 특수문자를 사용하여 8글자 이상 입력</div>
          </div>

          <div class="form-group">
            <label for="name">한글 이름 입력<span class="required">(필수)</span></label>
            <input type="text" id="name" name="name" class="input-field" placeholder="이름(한글)" value="${prefill_name}" required>
          </div>

          <div class="form-group">
            <label>이름과 성을<span class="required">(필수)</span></label>
            <div class="inline-fields">
              <div class="field-group">
                <input type="text" id="passportFirstName" name="passportFirstName" class="input-field" placeholder="이름(영문)" value="${prefill_firstName}" required>
              </div>
              <div class="field-group">
                <input type="text" id="passportLastName" name="passportLastName" class="input-field" placeholder="성(영문)" value="${prefill_lastName}" required>
              </div>
            </div>
          </div>

          <div class="form-group">
            <label for="birthdate">생년월일<span class="required">(필수)</span></label>
            <input type="text" id="birthdate" name="birthdate" class="input-field"
                   placeholder="YYYY.MM.DD" value="${prefill_birthdate}" required
                   pattern="^[0-9]{4}\.[0-9]{2}\.[0-9]{2}$"
                   title="YYYY.MM.DD 형식으로 입력" oninput="autoFormatDate(this)">
          </div>

          <div class="form-group">
            <label for="phone">휴대폰번호<span class="required">(필수)</span></label>
            <input type="tel" id="phone" name="phone" class="input-field"
                   placeholder="010-1234-5678" value="${prefill_phone}" required
                   pattern="^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$"
                   title="010-1234-5678 형식으로 입력" oninput="autoHyphen(this)">
          </div>

          <div class="form-group">
            <label>성별<span class="required">(필수)</span></label>
            <div class="gender-radio">
              <label><input type="radio" name="gender" value="남" ${prefill_gender == '남' ? 'checked' : ''}> 남</label>
              <label><input type="radio" name="gender" value="여" ${prefill_gender == '여' ? 'checked' : ''}> 여</label>
            </div>
          </div>

          <button type="submit" class="submit-button" id="submitBtn">가입</button>
        </form>
      </div>
    </div>
  </main>

  <%@ include file="../layout/footer.jsp" %>
</div>

<script>
  document.getElementById('email').addEventListener('blur', checkEmailDuplicate);
  async function checkEmailDuplicate() {
    const emailEl = document.getElementById('email');
    const msgEl   = document.getElementById('emailDupMsg');
    const email   = (emailEl.value || '').trim().toLowerCase();
    if (!email) { hideEmailMsg(); return; }
    try {
      const url = '${pageContext.request.contextPath}/api/email-exists.do?email=' + encodeURIComponent(email);
      const res = await fetch(url, { cache: 'no-store' });
      const text = (await res.text()).trim();
      if (text === 'true') { showEmailMsg(); } else { hideEmailMsg(); }
    } catch (e) { hideEmailMsg(); }
    function showEmailMsg(){ msgEl.style.display = 'block'; emailEl.classList.add('error'); }
    function hideEmailMsg(){ msgEl.style.display = 'none';  emailEl.classList.remove('error'); }
  }

  function validatePassword() {
    const password = document.getElementById('password');
    const passwordError = document.getElementById('passwordError');
    if (password.value.length < 8 && password.value.length > 0) {
      password.classList.add('error'); password.classList.remove('success'); passwordError.style.display = 'block';
    } else if (password.value.length >= 8) {
      password.classList.remove('error'); password.classList.add('success'); passwordError.style.display = 'none';
    } else {
      password.classList.remove('error', 'success'); passwordError.style.display = 'none';
    }
    validatePasswordMatch();
  }

  function validatePasswordMatch() {
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const confirmError = document.getElementById('confirmPasswordError');
    const confirmSuccess = document.getElementById('confirmPasswordSuccess');
    if (confirmPassword.value.length === 0) {
      confirmPassword.classList.remove('error', 'success');
      confirmError.style.display = 'none';
      confirmSuccess.style.display = 'none';
      return;
    }
    if (password.value !== confirmPassword.value) {
      confirmPassword.classList.add('error');
      confirmPassword.classList.remove('success');
      confirmError.style.display = 'block';
      confirmSuccess.style.display = 'none';
    } else if (password.value.length > 0) {
      confirmPassword.classList.remove('error');
      confirmPassword.classList.add('success');
      confirmError.style.display = 'none';
      confirmSuccess.style.display = 'block';
    }
  }

  function autoHyphen(obj) {
    let value = obj.value.replace(/[^0-9]/g, '');
    let result = '';
    if (value.length > 3) {
      result += value.substring(0, 3) + '-';
      if (value.length > 7) { result += value.substring(3, 7) + '-' + value.substring(7); }
      else { result += value.substring(3); }
    } else { result = value; }
    obj.value = result;
  }

  // 최소 검증용 날짜 포매터: 전각 점 치환 + 숫자만 유지 + 자동 점 삽입
  function autoFormatDate(obj) {
    let value = obj.value.replace(/\uFF0E/g, '.'); // 전각 점 → 일반 점
    value = value.replace(/[^0-9]/g, '');
    let result = '';
    if (value.length > 4) {
      result += value.substring(0, 4) + '.';
      if (value.length > 6) { result += value.substring(4, 6) + '.' + value.substring(6, 8); }
      else { result += value.substring(4); }
    } else { result = value; }
    obj.value = result;
  }

  // 제출 전 최소 검증 + 중복 이메일 최종 확인
  async function validateForm() {
    const emailEl = document.getElementById('email');
    const passEl  = document.getElementById('password');
    const pass2El = document.getElementById('confirmPassword');
    const email   = (emailEl.value || '').trim().toLowerCase();
    if (!email) { emailEl.focus(); return false; }
    if ((passEl.value || '').length < 8) { passEl.focus(); return false; }
    if (passEl.value !== pass2El.value) { pass2El.focus(); return false; }
    try {
      const url = '${pageContext.request.contextPath}/api/email-exists.do?email=' + encodeURIComponent(email);
      const res = await fetch(url, { cache: 'no-store' });
      const text = (await res.text()).trim();
      if (text === 'true') {
        const msgEl = document.getElementById('emailDupMsg');
        msgEl.style.display = 'block';
        emailEl.classList.add('error');
        emailEl.focus();
        return false;
      }
    } catch (e) { /* 서버측 최종 검증에 맡김 */ }
    return true;
  }
</script>
</body>
</html>
