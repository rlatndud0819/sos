<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>정회원 신청 대기</title>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Malgun Gothic','맑은 고딕',sans-serif;text-decoration:none;}
    .page-container{min-height:100vh;display:flex;flex-direction:column;background:#f1f5f9;}
    .main-content{flex:1;display:flex;justify-content:center;align-items:flex-start;padding:24px 16px;}
    .main-inner{width:100%;max-width:1080px;display:flex;justify-content:center;}
    .container{width:100%;max-width:480px;border-radius:12px;padding:40px;background:#fff;box-shadow:0 10px 30px rgba(0,0,0,.08);text-align:center;animation:fadeIn .8s ease-in-out;}
    @keyframes fadeIn{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
    h1{font-size:1.8rem;color:#222;font-weight:700;margin-bottom:30px;}
    .spinner{width:50px;height:50px;border:4px solid #f3f3f3;border-top:4px solid #d32f2f;border-radius:50%;margin:0 auto 20px;animation:spin 1s linear infinite;}
    @keyframes spin{0%{transform:rotate(0deg);}100%{transform:rotate(360deg);}}
    .waiting-text{font-size:1rem;color:#555;line-height:1.7;margin-bottom:30px;}
    .check-button{display:inline-block;width:100%;padding:16px 20px;font-size:1.1rem;font-weight:700;border:none;border-radius:50px;background:#d32f2f;color:#fff;cursor:pointer;transition:background-color .3s,box-shadow .3s;box-shadow:0 4px 10px rgba(211,47,47,.2);margin-top:10px;}
    .check-button:hover{background:#b71c1c;box-shadow:0 8px 15px rgba(211,47,47,.3);}
    .footer-text{margin-top:40px;color:#aaa;font-size:.85rem;line-height:1.6;}
  </style>
</head>
<body>
<div class="page-container">
  <%@ include file="../layout/header.jsp" %>

  <main class="main-content">
    <div class="main-inner">
      <div class="container">
        <h1>정회원 승인 대기 중입니다</h1>
        <div class="spinner"></div>
        <p class="waiting-text">관리자가 제출하신 정회원 신청을 검토하고 있습니다.<br>승인이 완료되면 자동으로 안내해드리겠습니다.</p>
        <form action="${pageContext.request.contextPath}/checkApprovalStatus.do" method="post">
          <button type="submit" class="check-button">승인 상태 확인하기</button>
        </form>
        <div class="footer-text">
          <p>※ 승인 처리에는 시간이 소요될 수 있습니다.<br>궁금한 사항이 있으시면 관리자에게 문의해주세요.</p>
        </div>
      </div>
    </div>
  </main>

  <%@ include file="../layout/footer.jsp" %>
</div>
</body>
</html>
