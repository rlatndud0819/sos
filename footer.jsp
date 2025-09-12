<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
  .site-footer{background:#f3f5f7;border-top:1px solid #e6e9ec}
  .footer-wrap{max-width:1080px;margin:0 auto;padding:28px 16px;display:flex;gap:24px;justify-content:space-between;align-items:flex-start}
  .footer-left{flex:1;min-width:0}
  .info-row{display:grid;grid-template-columns:auto 1fr;row-gap:8px;column-gap:12px;margin:0 0 14px 0}
  .info-row dt{font-weight:700;color:#222}
  .info-row dd{margin:0;color:#333}
  .address{color:#667085;line-height:1.7;margin:10px 0 14px 0}
  .copy{color:#8a8f98;font-size:.875rem;margin:12px 0 0 0;border-top:1px solid #e1e4e8;padding-top:12px}
  .footer-right{display:flex;align-items:center;gap:12px}
  .sns{width:42px;height:42px;border-radius:50%;display:flex;align-items:center;justify-content:center;border:1px solid #e1e4e8;background:#fff}
  .sns:hover{background:#f6f7f9}
  .sns .icon{width:20px;height:20px}
  .sns.kakao{background:#fee500;border-color:#fee500}
  .sns.kakao img{width:22px;height:22px;display:block}
  @media (max-width:768px){
    .footer-wrap{flex-direction:column;align-items:flex-start}
  }
</style>

<footer class="site-footer">
  <div class="footer-wrap">
    <div class="footer-left">
      <dl class="info-row">
        <dt>Phone</dt><dd>+66-2-1004749</dd>
        <dt>Email</dt><dd>thaihanin@gmail.com</dd>
        <dt>Tax ID</dt><dd>0993000179251</dd>
      </dl>

      <p class="address">
        사단법인 재태국한인회 (The Korean Association in Thailand)<br/>
        23/16 Sorachai Building 12 FL., 23 Soi Sukhumvit 63, Klong Tan Nuea, Wattana, Bangkok 10110, Thailand
      </p>

      <p class="copy">© 2025 The Korean Association in Thailand (재태국한인회) All rights reserved.</p>
    </div>

    <div class="footer-right">
      <!-- Facebook -->
      <a href="#" class="sns fb" aria-label="Facebook">
        <svg class="icon" viewBox="0 0 24 24" aria-hidden="true">
          <path fill="#1877F2" d="M22 12.06C22 6.48 17.52 2 11.94 2 6.36 2 1.88 6.48 1.88 12.06c0 4.9 3.58 8.97 8.26 9.86v-6.98H7.9v-2.88h2.24V9.54c0-2.22 1.32-3.45 3.34-3.45.97 0 1.98.17 1.98.17v2.17h-1.12c-1.1 0-1.45.69-1.45 1.4v1.68h2.47l-.39 2.88h-2.08v6.98c4.68-.89 8.26-4.96 8.26-9.86z"/>
        </svg>
      </a>

      <!-- KakaoTalk (프로젝트 정적 리소스 사용) -->
      <a href="#" class="sns kakao" aria-label="KakaoTalk">
        <img src="${pageContext.request.contextPath}/static/img/kakao_round.svg" alt="KakaoTalk">
      </a>
    </div>
  </div>
</footer>
