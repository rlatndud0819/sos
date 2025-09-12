<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 성공</title>
    <style>
        * { margin:0; padding:0; list-style:none; text-decoration:none; font-family:'Malgun Gothic','맑은 고딕',sans-serif; box-sizing:border-box; }

        /* 페이지 레이아웃: sticky footer + 중앙 정렬 */
        .page-container { min-height:100vh; display:flex; flex-direction:column; } /* 세로 플렉스 컨테이너 */
        .main-content   { flex:1; display:flex; justify-content:center; align-items:flex-start; padding:24px 16px; } /* 가로 중앙 */
        .main-inner     { width:100%; max-width:1080px; display:flex; justify-content:center; } /* 중앙 래퍼 */

        /* 카드 컨테이너 */
        .container {
            width:100%; max-width:380px; background:#fff; border:1px solid #e0e0e0;
            box-shadow:0 2px 8px rgba(0,0,0,.1); border-radius:12px; overflow:hidden;
            animation:fadeIn .8s ease-in-out;
        }
        .header { background:#fff; padding:18px; text-align:center; }
        h1 { color:#333; font-size:1.4em; font-weight:bold; margin-bottom:0; }

        .tab-menu { display:flex; justify-content:space-around; border-bottom:2px solid #e9ecef; background:#fff; }
        .tab-menu a { color:#6c757d; padding:12px 0; flex-grow:1; text-align:center; font-weight:bold; transition:all .3s ease; }
        .tab-menu a.active { color:rgb(250,0,0); border-bottom:2px solid rgb(250,0,0); }

        .content { padding:25px 20px; background:#fff; }
        .member-info { margin-bottom:20px; padding:20px; border-radius:8px; background:#fff; }
        .member-name { font-size:1.3em; font-weight:bold; color:#333; margin-bottom:8px; }
        .birthdate { font-size:.7em; color:#666; font-weight:normal; }
        .member-code { color:#666; font-size:.9em; margin-bottom:15px; font-weight:500; }
        .member-details { line-height:1.6; color:#555; margin-bottom:15px; font-size:.9em; }
        .member-details div { margin-bottom:3px; }
        .member-type { color:#333; font-weight:bold; margin-top:15px; font-size:1em; }
        .success-message { color:#000; padding:15px; text-align:center; font-size:1em; font-weight:bold; margin-bottom:12px; }
        .info-text { text-align:center; color:#000; font-size:.8em; line-height:1.4; }

        .submit-button {
            width:100%; max-width:380px; padding:15px; background:rgb(250,0,0); color:#fff;
            font-size:1.1em; font-weight:bold; border:none; border-radius:8px; cursor:pointer; transition:background-color .3s ease; margin-top:10px;
        }
        .submit-button:hover { background:#1976D2; }

        @media (max-width:480px){
            .container { margin:10px; border-radius:8px; max-width:350px; }
            .content { padding:20px 15px; }
            .member-info { padding:15px; }
            .submit-button { max-width:350px; }
        }
        @keyframes fadeIn { from { opacity:0; transform:translateY(-20px);} to { opacity:1; transform:translateY(0);} }
    </style>
</head>
<body>
<div class="page-container">
    <%@ include file="../layout/header.jsp" %>

    <main class="main-content">
        <div class="main-inner">
            <div class="container">
                <div class="header">
                    <h1>회원가입</h1>
                </div>

                <!-- .do 매핑 사용 -->
                <div class="tab-menu">
                    <a href="${pageContext.request.contextPath}/signup.do" class="active">일반회원</a>
                    <a href="${pageContext.request.contextPath}/regular_member.do">정회원</a>
                    <a href="${pageContext.request.contextPath}/corporate.do">법인회원</a>
                </div>

                <div class="content">
                    <div class="member-info">
                        <div class="member-name">
                            <c:out value="${memberVo.name}"/>님
                            <span class="birthdate"><c:out value="${memberVo.birthdate}"/></span>
                        </div>

                        <div class="member-code"></div>

                        <div class="member-details">
                            <div>
                                <c:out value="${memberVo.passportFirstName}"/>
                                <c:out value="${memberVo.passportLastName}"/>
                                <span class="gender"><c:out value="${memberVo.gender}"/></span>
                            </div>
                            <div><c:out value="${memberVo.email}"/></div>
                            <div><c:out value="${memberVo.phone}"/></div>
                        </div>

                        <div class="member-type">일반회원</div>
                    </div>

                    <div class="success-message">회원가입이 완료 되었습니다.</div>
                    <div class="info-text">정회원이 되시면 더 많은 혜택을 받으실 수 있습니다.</div>

                    <button type="button" class="submit-button" onclick="goLogin()">로그인</button>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="../layout/footer.jsp" %>
</div>

<script>
  function goLogin(){
    window.location.href='${pageContext.request.contextPath}/login.do';
  }
</script>
</body>
</html>
