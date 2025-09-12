<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        /* 레이아웃: 페이지 전체를 세로 플렉스 → sticky footer 대비 */
        .page-container { min-height: 100vh; display: flex; flex-direction: column; }
        .main-content { flex: 1; display: flex; justify-content: center; align-items: flex-start; }
        /* 가운데 정렬용 내부 래퍼: 최대 폭 제한 + 가로 중앙 */
        .main-inner { width: 100%; max-width: 1080px; padding: 16px; display: flex; justify-content: center; }
        /* 카드: 반응형 중앙 배치 */
        .card { width: 100%; max-width: 440px; margin: 16px auto; border:1px solid #e0e0e0; border-radius:8px; padding:24px; box-shadow:0 4px 12px rgba(0,0,0,.06); }

        .profile{display:flex;align-items:center;gap:16px;margin-bottom:28px;}
        .avatar{width:56px;height:56px;border-radius:50%;
                background:#e5e5e5 url("${pageContext.request.contextPath}/static/img/profile_default.svg") center/60% no-repeat;}
        .info h1{font-size:1.25rem;color:#222;font-weight:700;line-height:1.2;}
        .info small{display:block;margin-top:4px;font-size:.875rem;color:#d32f2f;font-weight:700;}
        .table{width:100%;border-top:1px solid #ebeef1;border-bottom:1px solid #ebeef1;}
        .row{display:flex;justify-content:space-between;align-items:center;height:54px;padding:0 12px;border-bottom:1px dashed #ebeef1;}
        .row:last-child{border-bottom:none;}
        .row label{color:#999;font-size:.875rem;}
        .row span{color:#333;font-size:.875rem;font-weight:700;letter-spacing:.03em;}
        .qr-section {margin-top: 24px;padding-top: 24px;border-top: 1px solid #ebeef1;text-align: center;}
        .button-section {margin-top: 24px;padding: 0 12px;text-align: center;}
        .simple-btn {display: block;width: 100%;padding: 10px;border: 1px solid #d32f2f;border-radius: 4px;background-color: #f8f9fa;color: #d32f2f;font-size: 0.875rem;font-weight: 600;cursor: pointer;transition: background-color 0.2s ease;text-decoration: none;}
        .simple-btn:hover {background-color: #eef0f3;}
        .status-btn {display: block;width: 100%;padding: 10px;border: 1px solid;border-radius: 4px;font-size: 0.875rem;font-weight: 600;cursor: default;text-decoration: none;}
        .status-pending {background-color: #fff3cd;color: #856404;border-color: #ffeaa7;}
        .status-approved {background-color: #d4edda;color: #155724;border-color: #c3e6cb;}
    </style>
</head>
<body>
<div class="page-container">
    <%@ include file="../layout/header.jsp" %>

    <main class="main-content">
        <div class="main-inner">
            <div class="card">
                <div class="profile">
                    <div class="avatar"></div>
                    <div class="info">
                        <h1><c:out value="${memberVo.korName}"/> 님</h1>
                        <p><c:out value="${memberVo.engName}"/> <c:out value="${memberVo.engLastName}"/></p>
                        <small><c:out value="${memberVo.grade}"/></small>
                    </div>
                </div>

                <div class="table">
                    <div class="row">
                        <label>Name</label>
                        <span><c:out value="${memberVo.engName}"/> <c:out value="${memberVo.engLastName}"/></span>
                    </div>
                </div>

                <div class="qr-section">
                    <img src="https://placehold.co/200x200" alt="회원 QR 코드" style="margin-top: 16px;">
                </div>

                <c:if test="${memberVo.grade eq '일반회원'}">
                    <div class="button-section">
                        <a href="${pageContext.request.contextPath}/regular_member.do" class="simple-btn">정회원 전환하기</a>
                    </div>
                </c:if>
                <c:if test="${memberVo.grade eq '신청중'}">
                    <div class="button-section">
                        <span class="status-btn status-pending">승인 대기중</span>
                    </div>
                </c:if>
                <c:if test="${memberVo.grade eq '정회원'}">
                    <div class="button-section">
                        <span class="status-btn status-approved">정회원 승인완료</span>
                    </div>
                </c:if>
            </div>
        </div>
    </main>

    <%@ include file="../layout/footer.jsp" %>
</div>
</body>
</html>
