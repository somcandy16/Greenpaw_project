<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//System.out.println(request.getContextPath());
%>
     <!-- ------------------nav start---------------- -->
      <div class="nav_wrap">
        <div class="title">
          <p>
            <a href="<%=request.getContextPath() %>/main.jsp" id="greenpaw">Green<br />Paw</a>
          </p>
        </div>
        <div><a href="<%=request.getContextPath() %>/sign_in.jsp"" id="login_status"></a></div>
        <ul class="nav_menu">
          <li class="depth1">
            <a href="#">My Page</a>
            <ul class="depth2">
              <li><a href="#">회원정보 관리</a></li>
            </ul>
          </li>
          <li class="depth1">
            <a href="#">With Me</a>
            <ul class="depth2">
              <li><a href="#">일정 관리</a></li>
              <li><a href="<%=request.getContextPath() %>/personal_album/personal_album_list.jsp?">성장 앨범</a></li>
            </ul>
          </li>
          <li class="depth1">
            <a href="#">Community</a>
            <ul class="depth2">
              <li><a href="<%=request.getContextPath() %>/community_main.jsp?">커뮤니티</a></li>
            </ul>
          </li>
          <li class="depth1">
            <a href="#">Lost Animals</a>
            <ul class="depth2">
              <li>
                <a href="#">유기동물<br />찾기/입양</a>
              </li>
            </ul>
          </li>
          <li class="depth1">
            <a href="#">About Us</a>
            <ul class="depth2">
              <li><a href="#">프로젝트 소개</a></li>
            </ul>
          </li>
        </ul>
      </div>
      <!-- ------------------nav end---------------- -->