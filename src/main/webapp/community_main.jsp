<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int flag = 1; //비로그인 상태
if (session.getAttribute("mail") != null) {
	flag = 0; //로그인 상태

	//System.out.println(flag);
}

//세션 확인
/*
	System.out.println("세션 메일: "+session.getAttribute("mail"));
	System.out.println("세션 닉네임: "+session.getAttribute("nickname"));
	System.out.println("세션 권한: "+session.getAttribute("authType"));
	System.out.println("세션 저장 카카오이메일:"+session.getAttribute("kakao_email"));
	System.out.println("세션 저장 카카오이메일:"+session.getAttribute("kakao_nickname"));
*/
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>GreenPaw</title>
<!-- toast ui editor -->
<!-- Toast Editor 2.0.0과 의존성 -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.css" /> -->
<!-- <link rel="stylesheet" href="https://uicdn.toast.com/editor/2.0.0/toastui-editor.min.css" /> -->

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- toastr -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" /> -->

<link rel="stylesheet" href="./css/reset.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet" />
<!-- <link rel="stylesheet" href="./css/main.css" /> -->
<link rel="stylesheet" href="./css/menu.css" />
<link rel="stylesheet" href="./css/community_main.css" />
<%
if (flag == 1) { //비로그인 시
	out.println("<script src='./js/menu_logOut.js' defer></script>");
} else { // 로그인시
	out.println("<script src='./js/main_logIn.js' defer></script>");
	out.println("<script src='./js/menu_logeIn.js' defer></script>");
}
%>

</head>
<body>
	<!-- body 에 넣어줘야 함! -->
	<!-- <script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.min.js"></script> -->
	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script> -->
	<!--  끝 -->

    <div class="main">
      <!-- nav bar include -->
 	 <%@ include file="./nav_bar.jsp" %>
      <div class="content_wrap">
        <div class="center_wrap">
          <div class="main_box_bg">
            <div class="content_outer">
              <div class="main_body">
				<ul class="banner -aim-partners">
					<li class="slides" id="carousel1"><a>배너 1</a></li>
					<li class="slides" id="carousel2"><a>배너 2</a></li>
					<li class="slides" id="carousel3"><a>배너 3</a></li>
					<li class="slides" id="carousel4"><a>배너 4</a></li>
				</ul>
				<ul class="category">
					<li id="category1" ><a href="normal_board1.jsp?category=1">일반 게시판</a></li>
					<li id="category2"><a href="Thumbnail_board.jsp?categorySeq=5">썸네일 게시판</a></li>
					<li id="category3"><a href="#">카테고리 3</a></li>
					<li id="category4"><a href="#">카테고리 4</a></li>
					<li id="category5"><a href="#">카테고리 5</a></li>
					<li id="category6"><a href="#">카테고리 6</a></li>
					<li id="category7"><a href="#">카테고리 7</a></li>
					<li id="category8"><a href="#">카테고리 8</a></li>
				</ul>
				<ul class="album">
					<li id="album">앨범</li>
				</ul>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </div>
  </body>
</html>
