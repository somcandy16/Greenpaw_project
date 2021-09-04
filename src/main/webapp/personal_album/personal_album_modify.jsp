<%@page import="model1.PersonalAlbumDAO"%>
<%@page import="model1.PersonalAlbumTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	int flag = 1; //비로그인 상태
	if (session.getAttribute("mail") != null) {
		flag = 0; //로그인 상태
	
		//System.out.println(flag);
	}

	String nickname = (String)session.getAttribute("nickname");
	String seq = request.getParameter("seq");
	String cpage = request.getParameter("cpage");
	String type = request.getParameter("type");
	String catSeq = "2"; //성장앨범 게시판
	
	PersonalAlbumTO to = new PersonalAlbumTO();
	to.setSeq(seq);
	to.setNickname(nickname);
	to.setCatSeq(catSeq);
	
	PersonalAlbumDAO dao = new PersonalAlbumDAO();
	to = dao.view(to);
	
	nickname = to.getNickname();
	seq = to.getSeq();
	String title = to.getTitle();
	String content = to.getContent();
	String thumbUrl = to.getThumbUrl();
	String familyMember = to.getFamilyMember();
	Boolean isPrivate = to.getIsPrivate();
	String wDate = to.getwDate();
	String mDate = to.getmDate();
	

%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>GreenPaw</title>

<!-- Toast Editor 2.0.0과 의존성 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor/2.0.0/toastui-editor.min.css" />

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- sweet alert -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<!-- css, font -->
<link rel="stylesheet" href="../css/reset.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="../css/menu.css" />
    <link rel="stylesheet" href="../css/personal_album_modify.css" />


    <%
    	//로그인되어있는지 확인	
    
		if(flag == 1){ //비로그인 시
			out.println("<script type='text/javascript'>");
			out.println("alert('잘못된 접근입니다. 로그인 후 이용가능합니다.');");
			out.println("location.href='../sign_in.jsp';");
			out.println("</script>");
		}else{ // 로그인시
			out.println("<script src='../js/menu_logeIn.js' defer></script>");
		}
	
	%>

</head>
<body>

	<!-- body 에 넣어줘야 함! -->
	<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!--  끝 -->
	
    <div class="main">
      <!-- nav bar include -->
 	 <%@ include file="../nav_bar.jsp" %>
 	       <div class="content_wrap">
        <div class="center_wrap">
          <div class="view_box_bg">
            <div class="content_outer">
              <div class="content_title">
                <div class="title_outer">
	                <ul class="type">
	                  <li class="type_select"><input type="radio" name="type" id="plant" checked value="plant" /><label for="plant">plant</label></li>
	                  <li class="type_select"><input type="radio" name="type" id="pet" value="pet" /><label for="pet">pet</label></li>
	                </ul>
                	<input class="title_input" id="title" type="text" value=<%=title %>></input>
              	</div>
                <ul class="other_info">
                	<li>Written by&nbsp;<%= nickname%></li>
                    <li>Created on&nbsp;<%= wDate%></li>
                    <li>Updated on&nbsp;<%= mDate%></li>
                </ul>
              </div>
              <div id="editor" class="viewer">
                <%=content %>
              </div>    
              <input type="hidden" id="seq" name="seq" value="<%=seq %>">        
              <p class="btn_out">
             <%
             	if(isPrivate == false){             			
		           		out.print("<span class='public'>✔ 커뮤니티에도 공개하신 글 입니다.</span>");
		           		out.print("<span class='is_private'>");
		           		out.print("<input type='checkbox' name='isPrivate' id='isPrivate' checked />");
		           		out.print("<label for='isPrivate'>커뮤니티에 공개하기</label></span>");
		           		out.print("<button class='btn_save' id='btn_save' onclick='clickSaveBtn()'>Save!</button>");
               	}else{
	           		out.print("<span class='is_private'>");
	           		out.print("<input type='checkbox' name='isPrivate' id='isPrivate' />");
	           		out.print("<label for='isPrivate'>커뮤니티에 공개하기</label></span>");
	           		out.print("<button class='btn_save' id='btn_save' onclick='clickSaveBtn()'>Save!</button>");
               	}
            %>
                
                	
                
                
              </p>
            </div>
          </div>
        <!-- 우측 메뉴바 -->
        <div class="album_right">
          <ul class="menu">
            <li class="menu_list">
              <a href="#" id="edit" onclick="history.back();">back</a>
            </li>
            <li class="menu_list">
              <a href="#" id="delete">delete</a>
            </li>
            <li class="list">
              <a href="#">list</a>
            </li>
            <li class="new">
              <a href="#">new</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </body>
  <!-- toast ui editor JS -->
  <!-- 꼭 editor 사용할 div 보다 아래에 넣어줘야 함 -->
  <script src="../js/modify_page.js" defer></script>
  
  	<!-- delete module -->
	<script type="text/javascript" src="../js/delete_modal.js"></script>

  

</html>
 	 