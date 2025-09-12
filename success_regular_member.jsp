<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>정회원 전환 완료</title>
  <style>
    /* 페이지 레이아웃: sticky footer + 중앙 정렬 */
    .page-container { min-height:100vh; display:flex; flex-direction:column; } /* 세로 플렉스 컨테이너 */ 
    .main-content   { flex:1; display:flex; justify-content:center; align-items:flex-start; padding:32px 16px; } /* 가로 중앙 */ 
    .main-inner     { width:100%; max-width:1080px; display:flex; justify-content:center; } /* 중앙 래퍼 */ 

    /* 카드 */
    .card{
      width:100%; max-width:440px; margin:0 auto;
      border:1px solid #e0e0e0; border-radius:8px; padding:50px 24px;
      box-shadow:0 4px 12px rgba(0,0,0,.06); text-align:center; line-height:1.6; background:#fff;
    }
    h1{font-size:1.5rem;font-weight:700;color:#333;margin-bottom:1.5rem;}
    p{font-size:1rem;color:#666;margin-bottom:1rem;}
    .btn{display:inline-block;margin-top:2rem;padding:12px 24px;background:#d32f2f;color:#fff;
      text-decoration:none;border-radius:4px;font-weight:700;transition:background .3s;}
    .btn:hover{background:#b71c1c;}
    .success-icon{font-size:4rem;color:#4CAF50;margin-bottom:1rem;}
    .member-info{background:#f5f6f9;padding:20px;border-radius:8px;margin:20px 0;}
    .member-info strong{color:#d32f2f;}
  </style>
</head>
<body>
<div class="page-container">
  <%@ include file="../layout/header.jsp" %>

  <main class="main-content">
    <div class="main-inner">
      <div class="card">
        <div class="success-icon">🎉</div>
        <h1>정회원 전환이 완료되었습니다!</h1>
        <div class="member-info">
          <p><strong><c:out value="${memberVo.korName}"/>님</strong>은 이제 <strong>정회원</strong>입니다.</p>
          <p>모든 정회원 혜택을 이용하실 수 있습니다.</p>
        </div>
        <p>축하드립니다! 정회원으로서 더욱 다양한 서비스를 경험해보세요.</p>
        <a href="${pageContext.request.contextPath}/main.do" class="btn">메인으로 이동</a>
      </div>
    </div>
  </main>

  <%@ include file="../layout/footer.jsp" %>
</div>
</body>
</html>
