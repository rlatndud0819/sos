<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  .site-header{position:sticky;top:0;z-index:100;background:#fff;border-bottom:1px solid #eaecef}
  .header-wrap{max-width:1080px;margin:0 auto;height:72px;display:flex;align-items:center;justify-content:space-between;gap:16px;padding:0 16px}
  .brand{display:flex;align-items:center;gap:12px}
  .brand .logo{width:36px;height:36px;border-radius:50%;background:#f2f4f7;display:inline-block}
  .brand .name{display:flex;flex-direction:column;line-height:1}
  .brand .name strong{font-size:18px;color:#222}
  .brand .name small{font-size:11px;color:#6b7280}
  .actions{display:flex;align-items:center;gap:10px}
  .btn-outline{padding:8px 14px;border:1px solid #dadfe6;border-radius:18px;background:#fff;color:#333;font-weight:600;text-decoration:none}
  .btn-outline:hover{background:#f6f7f9}
  .icon-btn{width:36px;height:36px;border:1px solid #e2e5ea;border-radius:50%;display:flex;align-items:center;justify-content:center;background:#fff}
  .icon-btn:hover{background:#f6f7f9}
  .icon{width:18px;height:18px;fill:#4b5563}
  @media (max-width:768px){
    .header-wrap{height:64px}
    .brand .name strong{font-size:16px}
  }
</style>

<header class="site-header">
  <div class="header-wrap">
    <a href="${pageContext.request.contextPath}/main.do" class="brand" aria-label="홈으로">
      <span class="logo"></span>
      <span class="name">
        <strong>재태국한인회</strong>
        <small>The Korean Association in Thailand</small>
      </span>
    </a>

    <div class="actions">
      <!-- 로그인/로그아웃 -->
      <c:if test="${empty sessionScope.userEmail}">
        <a href="${pageContext.request.contextPath}/login.do" class="btn-outline">로그인</a>
      </c:if>
      <c:if test="${not empty sessionScope.userEmail}">
        <a href="${pageContext.request.contextPath}/logout.do" class="btn-outline">로그아웃</a>
      </c:if>

      <!-- 검색 -->
      <button type="button" class="icon-btn" aria-label="검색">
        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M15.5 14h-.79l-.28-.27a6.471 6.471 0 001.57-4.23C16 6.01 13.99 4 11.5 4S7 6.01 7 9.5 9.01 15 11.5 15c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l4.25 4.25c.41.41 1.09.41 1.5 0 .41-.41.41-1.09 0-1.5L15.5 14zm-4 0C9.01 14 7 11.99 7 9.5S9.01 5 11.5 5 16 7.01 16 9.5 13.99 14 11.5 14z"/>
        </svg>
      </button>

      <!-- 프로필 -->
      <button type="button" class="icon-btn" aria-label="마이페이지">
        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M12 12c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm0 2c-3.33 0-10 1.67-10 5v3h20v-3c0-3.33-6.67-5-10-5z"/>
        </svg>
      </button>

      <!-- 메뉴 -->
      <button type="button" class="icon-btn" aria-label="메뉴 열기">
        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
          <path d="M3 6h18v2H3V6zm0 5h18v2H3v-2zm0 5h18v2H3v-2z"/>
        </svg>
      </button>
    </div>
  </div>
</header>
