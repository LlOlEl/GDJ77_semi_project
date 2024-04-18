<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>

<!-- include custom css/js -->
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css?dt=${dt}">

  </div>

<footer  class="footer">
    <section  class="footer-main">
        <div  class="footer-brand">
          <a  href="${contextPath}" class="logo-wrapper">
            <img src="${contextPath}/resources/svg/footer_logo.svg" alt="Logo">
          </a>
            <div  class="footer-menus">
              <a href="https://github.com/DevC21/GDJ77_semi_project/">GitHub Link<i class="fa-brands fa-github"></i></a>
            </div>
        </div>
        <div  class="company-info">
            <div  class="company-inner-info upper">
              <span >GDJ 77 5조 Semi Project GrafolioClone</span>
              <span>팀장 최연승</span>
              <span ></span>
            </div>
            <span class="spacing">&nbsp;</span>
            <div  class="company-inner-info lower">
              <span>조원 : 오채원 장윤수 김규식 김현우</span>
            </div>
        </div>
    </section>
</footer>

</body>
</html>