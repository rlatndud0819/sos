<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <style>
    * { margin:0; padding:0; list-style:none; text-decoration:none; font-family:'Malgun Gothic','맑은 고딕',sans-serif; box-sizing:border-box; }
    .page-container{min-height:100vh;display:flex;flex-direction:column;background:#f7f9fc;}
    .main-content{flex:1;display:flex;justify-content:center;align-items:flex-start;padding:24px 16px;}
    .main-inner{width:100%;max-width:1080px;display:flex;justify-content:center;}
    .container { width:100%; max-width:400px; padding:30px; background:#ffffff; border:1px solid #e0e0e0; box-shadow:0 4px 8px rgba(0,0,0,0.05); border-radius:8px; }
    h2 { text-align:center; margin-bottom:20px; color:#333; font-size:1.8em; font-weight:bold; }
    .info-message { background:#f8f9fa; color:#6c757d; padding:15px; margin-bottom:20px; border-radius:4px; text-align:center; font-size:0.9em; }
    .form-group { margin-bottom:20px; }
    label { display:block; margin-bottom:8px; font-size:0.9em; color:#555; font-weight:bold; }
    .input-field { width:100%; padding:15px; border:1px solid #ced4da; border-radius:4px; font-size:1em; transition:all .3s ease; background:#f8f9fa; }
    .input-field:focus { outline:none; border-color:#20B2AA; box-shadow:0 0 5px rgba(32,178,170,.25); background:#fff; }
    .input-field::placeholder { color:#adb5bd; }
    .login-button { width:100%; padding:15px; background:#e74c3c; color:#fff; font-size:1.2em; font-weight:bold; border:none; border-radius:4px; cursor:pointer; margin-bottom:15px; transition:background-color .3s ease; }
    .login-button:hover { background:#c0392b; }
    .signup-button { width:100%; padding:15px; background:#fff; color:#333; font-size:1.1em; font-weight:bold; border:2px solid #dee2e6; border-radius:4px; cursor:pointer; transition:all .3s ease; }
    .signup-button:hover { background:#f8f9fa; border-color:#adb5bd; }
    @media (max-width:480px) { .container { margin:10px; padding:20px; } h2 { font-size:1.6em; } }
    .error-message { color:#e74c3c; font-size:.9em; margin-top:10px; text-align:center; display:none; }
    .server-error { color:#e74c3c; font-size:.95em; margin:12px 0 6px; text-align:center; }
  </style>
</head>
<body>
<div class="page-container">
  <%@ include file="../layout/header.jsp" %>

  <main class="main-content">
    <div class="main-inner">
      <div class="container">
        <h2>로그인</h2>
        <div class="info-message">회원가입 시 등록한 Email로 로그인합니다.</div>
        <c:if test="${not empty loginError}"><div class="server-error">${loginError}</div></c:if>

        <form action="${pageContext.request.contextPath}/login.do" method="post" onsubmit="return validateLogin()">
          <div class="form-group">
            <label for="email">ID(Email)</label>
            <input type="email" id="email" name="email" class="input-field" placeholder="Email 입력" value="${emailValue}" required>
          </div>
          <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" class="input-field" placeholder="비밀번호 입력" required>
          </div>
          <div class="error-message" id="errorMessage">이메일 또는 비밀번호가 올바르지 않습니다.</div>
          <button type="submit" class="login-button">로그인</button>
        </form>

        <button type="button" class="signup-button" onclick="location.href='${pageContext.request.contextPath}/signup.do'">회원가입</button>
      </div>
    </div>
  </main>

  <%@ include file="../layout/footer.jsp" %>
</div>

<script>
  function validateLogin() {
    const email = document.getElementById('email');
    const password = document.getElementById('password');
    if (!email.value.trim()) { showError('이메일을 입력해주세요.'); email.focus(); return false; }
    if (!password.value.trim()) { showError('비밀번호를 입력해주세요.'); password.focus(); return false; }
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email.value)) { showError('올바른 이메일 형식을 입력해주세요.'); email.focus(); return false; }
    hideError(); return true;
  }
  function showError(message){ const e=document.getElementById('errorMessage'); e.textContent=message; e.style.display='block'; }
  function hideError(){ document.getElementById('errorMessage').style.display='none'; }
  document.getElementById('email').addEventListener('focus', hideError);
  document.getElementById('password').addEventListener('focus', hideError);
  document.addEventListener('keypress', function(event){
    if (event.key === 'Enter') { event.preventDefault(); document.querySelector('.login-button').click(); }
  });
</script>
</body>
</html>
