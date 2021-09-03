<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model1.BoardTO"%>
<%@page import="model1.BoardDAO"%>
<%@page import="model1.PageTO"%>
<%
   	int flag = 1; //비로그인 상태
   	if(session.getAttribute("mail") != null){
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
   

	//검색했을때..
	String field = "title";
	String keyword ="";
	String sort="";
	if(request.getParameter("field") != null && !request.getParameter("field").equals("") ){
		field =request.getParameter("field");
	}
	//System.out.println("필드"+field);

	if( request.getParameter("keyword") != null && !request.getParameter("keyword").equals("")){
		keyword =request.getParameter("keyword");
	}

	//정렬
	
	
	if(request.getParameter("sort") != null && !request.getParameter("sort").equals("")){
		sort = request.getParameter("sort");
	}
	
	
//게시판 리스트
	
	//String category = String.valueOf(1);
	String category = request.getParameter("category");
	int cPage=1; //기본 페이지
	
	if(request.getParameter("page") != null && !request.getParameter("page").equals("") ){
		cPage = Integer.parseInt(request.getParameter("page"));
	}
	
	BoardDAO dao = new BoardDAO();
	int perPage =10;
	
	PageTO pages = new PageTO();
	pages.setCpage(cPage); 
	
	pages = dao.boardList(pages,category,field,keyword);
	int recordPerPage = pages.getRecordPerPage();
	
	int totalRecord = pages.getTotalRecord();
	int totalPage = pages.getTotalPage();
	
	int blockPerPage = pages.getBlockPerPage();
	int startBlock = pages.getStartBlock();
	int endBlock = pages.getEndBlock();	
	
	
	/******************게시글***************/

StringBuilder sbHtml = new StringBuilder();
ArrayList<BoardTO> result = null;

if(!field.equals("") && !keyword.equals("")){
	result = dao.getSearchList(category, field, keyword, cPage, recordPerPage);
} else if(!sort.equals("")){
	result = dao.listSort(category, field, keyword, sort, cPage, perPage);
} else {
	result = dao.getList(category,cPage,perPage);
}

	for(BoardTO to : result){
		String seq = to.getSeq();
		String subTitle = to.getSubTitle();
		String saleStatus = to.getSaleStatus();
		String memberType = to.getFamilyMemberType();
		String title = to.getTitle();
		String nickname = to.getNickname();
		String likeCount = to.getLikeCount();
		String hit = to.getHit();
		String createDate = to.getCreatedAt();
		
		//System.out.printf("%s, %s, %s, %s, %s, %s, %s \n", subTitle,saleStatus, memberType, title, likeCount, hit, createDate  );

		//리스트..
		
		sbHtml.append("<li class='item'>");
		sbHtml.append("	<div class='family-type'>");
		sbHtml.append("		<span>"+memberType+"</span>");
		sbHtml.append("	</div>");
		sbHtml.append("	<div class='list-title_wrap'>");
		sbHtml.append("		<div class='list-sub_title'>");
		sbHtml.append("			<a class='sub_title-item'>"+subTitle+"</a>");
		sbHtml.append("		</div>");
		sbHtml.append("		<div class='list-title'>");
		sbHtml.append("		<a href='?category="+category+"&seq="+seq+"' class='title-item'>"+title+"</a>");
		sbHtml.append("		</div>");
		sbHtml.append("	</div>");
		sbHtml.append("	<div class='list-info'>");
		sbHtml.append("		<span class='meta-item view-count' title='조회수: "+hit+"회'>");
		sbHtml.append("			<span class='stats-count'>조회수 "+hit+"</span>");
		sbHtml.append("		</span>");
		sbHtml.append("		<span class='meta-item like-count' title='좋아요: "+likeCount+"개'>");
		sbHtml.append("			<span class='stats-count'>좋아요 "+likeCount+"</span>");
		sbHtml.append("		</span>");
		sbHtml.append("		<span class='meta-item comment-count' title='댓글: 10개'>");
		sbHtml.append("			<span class='stats-count'>댓글 10</span>");
		sbHtml.append("		</span>");
		sbHtml.append("	</div>");
		sbHtml.append("	<div class='list-writer'>");
		sbHtml.append("		<img class='writer_photo' src=''>");
		sbHtml.append("		<div class='writer-info'>");
		sbHtml.append("			<a>"+nickname+"</a>");
		sbHtml.append("			<span>"+createDate+"</span>");
		sbHtml.append("		</div>");
		sbHtml.append("	</div>");
		sbHtml.append("</li>");
	}
	

%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>GreenPaw</title>
<link rel="stylesheet" href="../css/reset.css" />
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="../css/board.css" />
<link rel="stylesheet" href="../css/menu.css" />
<%
		if(flag == 1){ //비로그인 시
			out.println("<script src='../js/menu_logOut.js' defer></script>");
		}else{ // 로그인시
			out.println("<script src='../js/main_logIn.js' defer></script>");
			out.println("<script src='../js/menu_logeIn.js' defer></script>");
		}
	
	%>
<!-- 아이콘-->
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
	
<style>
	/*필터 색*/
	.filter_wrap a:link {
	color:#26a69a;
	}

	.filter_wrap a:visited {
	  color:#26a69a;
	}
	
	.filter_wrap a:active {
	  color: #00766c;
	  font-weight: bolder;
	}
	
	.filter_wrap a:hover {
	  color:#00766c;
	  font-weight: bolder;
	}
	
		

</style>
	
</head>
<body>
	<main>
		<div class="main">
			<%@ include file="../nav_bar.jsp" %>
			<div class="main-menu">
			</div>
			<div class="main-body">
				<!--배너-->
				<div class="main-body-banner">
					<div class="banner" style="cursor:pointer;" onclick="location.href='./normal_board1.jsp?category=${param.category}'"></div>
				</div>
				<!-- 검색창 -->
				<div class="search_wrap">
					<form action="./normal_board1.jsp" method="get" class="searchform">
						<input type="hidden" name="category" value="${param.category }" />
						<select name="field" class="selectbox">
							<option value="title" name="title">제목</option>
							<option value="content" name="content">내용</option>
						</select>
						<input type="text" id="search-input" name="keyword" placeholder="검색" />
						<input type="submit" value="검색" id="search-btn" />
					</form>
				</div>

				<!--테이블-->

				<div class="inner_content">
					<div class="filter_wrap">
						<div>
							<a class="search_filter" href="./normal_board1.jsp?category=${param.category }&field=${param.field }&keyword=${param.keyword}&sort=seq">최근 순</a>
							<!-- <span></span> -->
							<a class="search_filter" href="./normal_board1.jsp?category=${param.category }&field=${param.field }&keyword=${param.keyword}&sort=like_count">인기 순</a>
						
							<a class="search_filter" href="./normal_board1.jsp?category=${param.category }&field=type&keyword=pet">동물</a>
							<!-- <span></span> -->
							<a class="search_filter" href="./normal_board1.jsp?category=${param.category }&field=type&keyword=plant">식물</a>
						</div>
					</div>
					<!------ 리스트 -------->
					<div class="list_wrap">
						<section class="list">
							<ul>
								
								<%=sbHtml %>
							</ul>
						</section>
						<a type="button" href="./subTitle_write.jsp?category=${param.category }" id="write-btn">글쓰기</a>
						
						<!--페이지-->
						<div class="search_pagination">
							<nav class="pagination">
								<ul>
									<%
									//이전
									if(startBlock == 1){
										out.println("");
									}else{
										out.println("<li class='prev'><a href='?category="+category+"&field="+field+"&keyword="+keyword+"&sort="+sort+"&page="+(startBlock-blockPerPage)+"'>◀</a></li>");

									};
									//숫자
									for(int i = startBlock; i <= endBlock; i++){
										if(cPage == i){
											out.println("<li><strong>"+i+"</strong></li>");
										}else{
											out.println("<li><a href='?category="+category+"&field="+field+"&keyword="+keyword+"&sort="+sort+"&page="+i+"'>"+i+"</a></li>");
										};
									};
												                   
									//다음
									if (endBlock == totalPage) {
										out.println("");
									} else {
										out.println("<li class='next'><a href='?category="+category+"&field="+field+"&keyword="+keyword+"&sort="+sort+"&page="+ (startBlock + blockPerPage)+"'>▶</a></li>");
									};
									%>
								</ul>
							</nav>
						</div>
						<!--페이지 끝-->
					</div>
				</div>
			</div>
		</div>
		<!-- 메인-->
	</main>

</body>
</html>