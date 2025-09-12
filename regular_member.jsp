<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>여권등록</title>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Malgun Gothic','맑은 고딕',sans-serif;text-decoration:none;}
    .page-container{min-height:100vh;display:flex;flex-direction:column;}
    .main-content{flex:1;display:flex;justify-content:center;align-items:flex-start;padding:40px 16px;background:#fff;}
    .main-inner{width:100%;max-width:1080px;display:flex;justify-content:center;}
    .tabs{width:440px;display:flex;border-bottom:1px solid #d32f2f;font-size:.85rem;margin:0 auto 12px;}
    .tabs a{flex:1;text-align:center;padding:6px 0;color:#666;}
    .tabs a.active{color:#d32f2f;font-weight:700;border-bottom:3px solid #d32f2f;}
    .profile{display:flex;align-items:center;gap:16px;margin-bottom:28px;}
    .avatar{width:56px;height:56px;border-radius:50%;background:#d32f2f url('${pageContext.request.contextPath}/static/img/profile_default.svg') center/60% no-repeat;}
    .info h1{font-size:1.25rem;color:#222;font-weight:700;line-height:1.2;}
    .info .en-name{margin-top:4px;font-size:.95rem;color:#444;font-weight:400;letter-spacing:.02em;}
    .info small{display:block;margin-top:4px;font-size:.875rem;font-weight:700;}
    .table{background-color:#d32f2f;height:1px;margin:0 0 20px;}
    .apply-box{width:440px;margin:0 auto;}
    .input{width:100%;margin:0 0 14px;padding:10px;border:1px solid #ccc;border-radius:3px;font-size:.85rem;}
    .passport{margin-bottom:20px;}
    .passport-title{font-size:.9rem;color:#333;font-weight:700;margin-bottom:8px;}
    .field{margin:0 0 18px;}
    .field-head{display:flex;justify-content:space-between;align-items:center;margin:0 0 8px;}
    .field-title{font-size:.9rem;color:#333;font-weight:700;}
    .file-name{font-size:.78rem;color:#888;}
    .visually-hidden{position:absolute!important;width:1px;height:1px;margin:-1px;border:0;padding:0;white-space:nowrap;clip-path:inset(50%);clip:rect(0 0 0 0);overflow:hidden;}
    .upload{height:38px;display:flex;align-items:center;justify-content:center;border:1px solid #ccc;color:#666;font-size:.85rem;margin-bottom:14px;cursor:pointer;background:#fafafa;border-radius:3px;}
    .upload:hover{background:#f0f0f0;}
    .btn{width:100%;height:42px;background:#d32f2f;color:#fff;font-size:.95rem;font-weight:700;border:none;border-radius:3px;cursor:pointer;}
    .btn:hover{background:#F44336;}
    .preview{position:relative;display:flex;align-items:center;justify-content:center;width:100%;margin:-6px 0 14px;border:1px dashed #e5e5e5;border-radius:3px;padding:8px;}
    .preview img{max-width:100%;max-height:220px;object-fit:contain;display:none;}
    .preview .preview-clear{position:absolute;top:6px;right:6px;width:24px;height:24px;border:none;border-radius:50%;background:rgba(0,0,0,.55);color:#fff;font-size:16px;line-height:24px;font-weight:700;cursor:pointer;display:none;}
    .error-msg{background:#ffebee;color:#d32f2f;padding:10px;border-radius:4px;margin-bottom:20px;font-size:.875rem;border:1px solid #ffcdd2;}
  </style>
</head>
<body>
<div class="page-container">
  <%@ include file="../layout/header.jsp" %>

  <main class="main-content">
    <div class="main-inner">
      <div style="width:100%;max-width:440px;">
        <div class="tabs">
          <a href="#" class="active">멤버</a>
          <a href="#">정회원</a>
        </div>

        <c:if test="${not empty error}">
          <div class="error-msg"><c:out value="${error}"/></div>
        </c:if>

        <c:set var="gradeColor" value="#20B2AA"/>
        <c:if test="${memberVo.grade eq '일반회원'}"><c:set var="gradeColor" value="#d32f2f"/></c:if>

        <div class="profile">
          <div class="avatar"></div>
          <div class="info">
            <h1><c:out value="${memberVo.korName}"/> 님</h1>
            <div class="en-name"><c:out value="${memberVo.engName}"/> <c:out value="${memberVo.engLastName}"/></div>
            <small style="color:${gradeColor};"><c:out value="${memberVo.grade}"/></small>
          </div>
        </div>

        <div class="table"></div>

        <form class="apply-box" action="${pageContext.request.contextPath}/member/upgrade.do" method="post" enctype="multipart/form-data">
          <div class="passport">
            <div class="passport-title">여권 번호</div>
            <input type="text" name="passportNo" placeholder="Passport No." class="input" maxlength="20" required>
          </div>

          <div class="field">
            <div class="field-head">
              <span class="field-title">여권 이미지등록 <span style="color:#d32f2f;">*</span></span>
              <span class="file-name" id="passport-name">선택된 파일 없음</span>
            </div>
            <input type="file" id="passportImg" name="passportImg" accept="image/*" class="visually-hidden" required>
            <label class="upload" for="passportImg">이미지 업로드</label>
            <div class="preview">
              <img id="preview-passport" alt="여권 이미지 미리보기">
              <button type="button" id="clear-passport" class="preview-clear" aria-label="여권 이미지 삭제">×</button>
            </div>
          </div>

          <div class="field">
            <div class="field-head">
              <span class="field-title">비자 이미지 등록</span>
              <span class="file-name" id="visa-name">선택된 파일 없음</span>
            </div>
            <input type="file" id="visaImg" name="visaImg" accept="image/*" class="visually-hidden">
            <label class="upload" for="visaImg">이미지 업로드</label>
            <div class="preview">
              <img id="preview-visa" alt="비자 이미지 미리보기">
              <button type="button" id="clear-visa" class="preview-clear" aria-label="비자 이미지 삭제">×</button>
            </div>
          </div>

          <div class="field">
            <div class="field-head">
              <span class="field-title">회원납부 이미지 등록</span>
              <span class="file-name" id="fee-name">선택된 파일 없음</span>
            </div>
            <input type="file" id="feeImg" name="feeImg" accept="image/*" class="visually-hidden">
            <label class="upload" for="feeImg">이미지 업로드</label>
            <div class="preview">
              <img id="preview-fee" alt="회원납부 이미지 미리보기">
              <button type="button" id="clear-fee" class="preview-clear" aria-label="회원납부 이미지 삭제">×</button>
            </div>
          </div>

          <button type="submit" class="btn">정회원 신청하기</button>
        </form>
      </div>
    </div>
  </main>

  <%@ include file="../layout/footer.jsp" %>
</div>

<script>
  function bindUpload(inputId, nameId, imgId, clearId){
    const input = document.getElementById(inputId);
    const nameSpan = document.getElementById(nameId);
    const img = document.getElementById(imgId);
    const clearBtn = document.getElementById(clearId);
    if(!input || !nameSpan || !img || !clearBtn) return;

    function reset(){
      if (img.src && img.src.startsWith('blob:')) URL.revokeObjectURL(img.src);
      input.value = '';
      nameSpan.textContent = '선택된 파일 없음';
      img.removeAttribute('src');
      img.style.display = 'none';
      clearBtn.style.display = 'none';
    }

    input.addEventListener('change', (e) => {
      const file = e.target.files && e.target.files;
      if(!file){ reset(); return; }
      if (file.size > 5 * 1024 * 1024) { alert('파일 크기는 5MB 이하여야 합니다.'); reset(); return; }
      nameSpan.textContent = file.name;
      const url = URL.createObjectURL(file);
      img.onload = () => { URL.revokeObjectURL(url); };
      img.onerror = () => { URL.revokeObjectURL(url); alert('이미지 파일만 선택해주세요.'); reset(); };
      img.src = url; img.style.display = 'block'; clearBtn.style.display = 'inline-block';
    });

    clearBtn.addEventListener('click', reset);
  }
  document.addEventListener('DOMContentLoaded', function(){
    bindUpload('passportImg','passport-name','preview-passport','clear-passport');
    bindUpload('visaImg','visa-name','preview-visa','clear-visa');
    bindUpload('feeImg','fee-name','preview-fee','clear-fee');
  });
</script>
</body>
</html>
