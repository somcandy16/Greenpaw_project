<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model1.BoardListTO" %>
<%@ page import="model1.BoardTO" %>
<%@ page import="model1.ThumbDAO" %>
<%@ page import="java.util.ArrayList" %>

<%
   	int flag = 1; //비로그인 상태
   	if(session.getAttribute("mail") != null){
  		flag = 0; //로그인 상태
   	}
%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>GreenPaw</title>
    <link rel="stylesheet" href="./css/reset.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="./css/thumbnail_board.css" />
    <link rel="stylesheet" href="./css/menu.css" />
    <!-- 아이콘-->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
  	<!-- jquery cdn -->
    <script
      src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
      crossorigin="anonymous"></script>
    <!-- jquery-ui cdn -->
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <%
    	//로그인되어있는지 확인	
    
		/* if(flag == 1){ //비로그인 시
			out.println("<script src='./js/menu_logOut.js' defer></script>");
		}else{ // 로그인시
			out.println("<script type='text/javascript'>");
			out.println("alert('잘못된 접근입니다. 이미 로그인 하셨습니다.');");
			out.println("location.href='main.jsp';");
			out.println("</script>");
		} */
		if(flag == 1){ //비로그인 시
			out.println("<script src='./js/menu_logOut.js' defer></script>");
		}else{ // 로그인시
			out.println("<script src='./js/main_logIn.js' defer></script>");
			out.println("<script src='./js/menu_logeIn.js' defer></script>");
		}
	
	
	%>
	
	<%
	/* search 기능 */
	
	
	int cpage = 1;
	if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
		cpage = Integer.parseInt(request.getParameter("cpage"));
	}
	
	BoardListTO listTO = new BoardListTO();
	listTO.setCpage( cpage );
	
	ThumbDAO dao = new ThumbDAO();
	listTO = dao.boardList(listTO);
	
	int recordPerPage = listTO.getRecordPerPage();
	
	int totalRecord = listTO.getTotalRecord();
	int totalPage = listTO.getTotalPage();
	
	int blockPerPage = listTO.getBlockPerPage();
	int startBlock = listTO.getStartBlock();
	int endBlock = listTO.getEndBlock();
	
	ArrayList<BoardTO> boardLists = listTO.getBoardLists();
	
	StringBuilder sbHtml = new StringBuilder();
	for( int i=0 ; i<recordPerPage ; i++ ) {
		String seq = "";
		String categorySeq = "";
		String subTitle = "";
		String saleStatus = "";
		String title = "";
		String familyMemberType = "";
		String content = "";
		String thumbUrl = "";
		String nickname = "";
		String lickCount = "";
		String hit = "";
		String createdAt = "";

		
		if( i < boardLists.size() ) {
			BoardTO to = boardLists.get(i);
			seq = to.getSeq();
			categorySeq = to.getCategorySeq();
			/* subTitle = to.getSubTitle();{
				if (subTitle == null )
			} */
			saleStatus = to.getSaleStatus();
			title = to.getTitle();
			familyMemberType = to.getFamilyMemberType();
			content = to.getContent();
			thumbUrl = to.getThumbUrl() == null ? "./images/noimage.jpg" : to.getThumbUrl();
			nickname = to.getNickname();
			lickCount = to.getLikeCount();
			hit = to.getHit();
			createdAt = to.getCategorySeq();

			
		}
		
		if( i<5 ) {
			sbHtml.append( "<li class='item'>" );
			sbHtml.append("			<div class='family-type'>");
			sbHtml.append("				<span>"+familyMemberType+"</span>");
			sbHtml.append("			</div>");
			sbHtml.append("			<div class='thumb'><a href='Thumbnail_board_view.jsp?cpage=" + cpage + "&seq=" + seq + "'>");
			if( thumbUrl.isBlank()  ) {
				sbHtml.append( "						<div class='no-image'></div>" );
			} else {
				sbHtml.append( "						<img src='" + thumbUrl + "'>" );
			}
			sbHtml.append("			</a></div>");
			sbHtml.append("			<div class='list-title'>");
			sbHtml.append("				<div class='list-sub_title'>" + subTitle + "</div>");
			sbHtml.append("				<span class='list-title-title'><a href='Thumbnail_board_view.jsp?cpage=" + cpage + "&seq=" + seq + "'>" + title + "</a></span>");
			sbHtml.append("				<span class='list-title-content'><a href='Thumbnail_board_view.jsp?cpage=" + cpage + "&seq=" + seq + "'>" + content + "</a></span>");
			sbHtml.append("			 </div>");
			sbHtml.append("			<div class='list-info'>");
			sbHtml.append("				<span class='meta-item view-count' >");
			if( thumbUrl.isBlank() ){
				sbHtml.append("					<span class='stats-count'></span>");
			}else{
				sbHtml.append("					<span class='stats-count'>조회수" + hit + "</span>");
			}
			sbHtml.append("				</span>");
			sbHtml.append("				<span class='meta-item like-count' >");
			if( thumbUrl.isBlank() ){
				sbHtml.append("					<span class='stats-count'></span>");
			}else{
				sbHtml.append("					<span class='stats-count'>좋아요" + lickCount + "</span>");
			}
			sbHtml.append("				</span>");
			sbHtml.append("				<span class='meta-item comment-count' >");
			if(thumbUrl.isBlank()){
				sbHtml.append("					<span class='stats-count'></span>");
			}else{
				sbHtml.append("					<span class='stats-count'>댓글 0</span>");
			}
			sbHtml.append("				</span>");
			sbHtml.append("			</div>");
			sbHtml.append("			 <div class='list-writer'>");
			sbHtml.append("				<div class='writer-info'>");
			sbHtml.append("					<a>" + nickname + "</a>");
			sbHtml.append("					<span>" + createdAt + "</span>");
			sbHtml.append("				</div>");
			sbHtml.append("			 </div>");
			sbHtml.append("		</li>");
		}
		
	}
	 String categorySeq = String.valueOf(5);
	/* int categorySeq = 1; */
	%>
	
    <!-- 카카오 cdn 추가 -->
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <!-- ajax 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  </head>
  <body>
  	<!-- 카카오 연결 스크립트 추가-->
	<script src="./js/kakao_connect.js"></script>
    <div class="main">
    	<%@ include file="./nav_bar.jsp" %>
        <!-- <div class="nav_wrap">
            <div class="title">
              <p>
                <a href="" id="greenpaw">Green<br />Paw</a>
              </p>
            </div>
            <div><a href="#" id="login_status">Log in</a></div>
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
                  <li><a href="#">성장 앨범</a></li>
                </ul>
              </li>
              <li class="depth1">
                <a href="#">Community</a>
                <ul class="depth2">
                  <li><a href="#">커뮤니티</a></li>
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
          </div> -->
          <!-- ------------------nav end---------------- -->
    <div class="main-menu">
    <!-- ------------------nav start---------------- -->
    
    </div>
    <div class="main-body">
        <!--배너-->
        <div class="main-body-banner">
            <div class="banner"></div>
        </div>
        <div class="main-body-searchform">
            <form action="#" method="get" class="searchform">
                 <select class="search_key">
                    <option>전체</option>
                    <option>제목</option>
                    <option>내용</option>
                </select>
                <input type="text" id="search-input" name="" placeholder="검색"/>
                <input type="submit" name="" value="검색" id="search-click"/>
            </form>
        </div>

        <!--테이블-->
       
        <div class="inner_content">
                <div class="filter">
                <a class="search_filter" href="">최근 순</a>
                <span></span>
                <a class="search_filter" href="">인기 순</a>
                </div>
                <div class="list_wrap">
                    <!------ 리스트 -------->
                    <section class="list">
                        <ul>
                            <%=sbHtml %>
                        </ul>
                    </section>
                    <a type="button" href="./personal_thumb_write.jsp?categorySeq=<%=categorySeq%>" id="write-btn">글쓰기</a>
                <!--페이지-->
                <div class="search_pagination">
                    <nav class="pagination">
                                                <%
                   //forward
                   if(startBlock == 1){
                       out.println("<span class='forward'><a>&lt;&lt;</a></span>");
                   }else{
                       out.println("<span class='forward'><a href='./Thumbnail_board.jsp?cpage="
                                   + (startBlock-blockPerPage) +"'>&lt;&lt;</a></span>");

                   };

                   //숫자
                   for(int i = startBlock; i <= endBlock; i++){
                       if(cpage == i){
                           out.println("<span class='numbers'><a>"+i+"</a></span>");
                       }else{
                           out.println("<span class='numbers'><a href='./Thumbnail_board.jsp?cpage="+i+"'>"
                                   + i +"</a></span>");
                       };
                   };

                   if(endBlock == totalPage){
                       out.println("<span class='backward'><a>&gt;&gt;</a></span>");
                   }else{
                       out.println("<span class='backward'><a href='./Thumbnail_board.jsp?cpage="
                                   + (startBlock + blockPerPage)+"'>&gt;&gt;</a></span>");
                   };

%>
                    </nav>
                </div>
                <!--페이지 끝-->
            </div>
        </div>
    </div>
</div> <!-- 메인-->
    </main>

  </body>
</html>