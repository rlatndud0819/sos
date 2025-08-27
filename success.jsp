<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 성공</title>
    <style>
        body {
            font-family: '맑은 고딕', 'Malgun Gothic', sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            color: #333;
        }
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeIn 0.8s ease-in-out;
            max-width: 600px;
        }
        h1 {
            color: #4CAF50;
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            line-height: 1.6;
        }
        .info-box {
            background-color: #e8f5e9;
            border-left: 5px solid #4CAF50;
            margin: 25px 0;
            padding: 15px;
            border-radius: 8px;
            text-align: left;
        }
        .info-box h3 {
            margin-top: 0;
            color: #2e7d32;
        }
        .info-box p {
            margin: 8px 0;
        }
        .btn-home {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 25px;
            background-color: #4CAF50;
            color: #fff;
            text-decoration: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            font-weight: bold;
            margin-right: 10px;
        }
        .btn-home:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-secondary:hover {
            background-color: #1976D2;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 회원가입을 축하드립니다!</h1>
        <p>
            회원님의 정보가 성공적으로 등록되었습니다.<br>
            서비스 이용을 위해 로그인 페이지로 이동해주세요.
        </p>

        <div class="info-box">
            <h3>📋 회원가입 정보 확인</h3>
            <p><strong>이름:</strong> <c:out value="${memberVo.name}" /></p>
            <c:if test="${not empty memberVo.passportFirstName || not empty memberVo.passportLastName}">
                <p><strong>영문 이름:</strong> 
                   <c:out value="${memberVo.passportFirstName}" /> <c:out value="${memberVo.passportLastName}" />
                </p>
            </c:if>
            <p><strong>이메일:</strong> <c:out value="${memberVo.email}" /></p>
            <p><strong>전화번호:</strong> <c:out value="${memberVo.phone}" /></p>
            <c:if test="${not empty memberVo.birthdate}">
                <p><strong>생년월일:</strong> <c:out value="${memberVo.birthdate}" /></p>
            </c:if>
            <c:if test="${not empty memberVo.gender}">
                <p><strong>성별:</strong> <c:out value="${memberVo.gender}" /></p>
            </c:if>
        </div>

        <a href="${pageContext.request.contextPath}/" class="btn-home">🏠 메인 페이지로 돌아가기</a>
        <a href="${pageContext.request.contextPath}/memberWrite.do" class="btn-home btn-secondary">
            👥 추가 회원가입
        </a>
    </div>
</body>
</html>
