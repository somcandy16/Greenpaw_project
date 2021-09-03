<%@page import="model1.BoardDAO"%>
<%@page import="model1.BoardTO"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page language="Java" contentType="plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%
request.setCharacterEncoding("utf-8");
System.out.println("카테고리 명:"+(String)request.getParameter("category"));



// 넘어온 파라미터로 디비에 insert 
String category = request.getParameter("category");
String title = request.getParameter("title");
String content = request.getParameter("content");
String thumbUrl = request.getParameter("thumbUrl");
String nickname = (String)session.getAttribute("nickname");
String familyMemberType = request.getParameter("type");

//String nickname = "닉네임";
 String subTitle = ""; //subTitle있는것 없는것이 있어서, 있으면 나타나도록 수정.. 
 if (request.getParameter("subTitle") != null && !request.getParameter("subTitle").equals("") ){
	 subTitle = request.getParameter("subTitle");
	//System.out.println("카테고리"+category);
} 

/* if (request.getParameter("familyMemberType") != null || !request.getParameter("familyMemberType").equals("") ){
	familyMemberType = request.getParameter("familyMemberType");
} */
String saleStatus = "";
if (request.getParameter("saleStatus") != null && !request.getParameter("saleStatus").equals("") ){
	saleStatus = request.getParameter("saleStatus");
}



/* System.out.println(title);
System.out.println(subTitle);
System.out.println(content);
System.out.println(thumbUrl);
System.out.println(nickname);
System.out.println(category);
System.out.println(familyMemberType);
System.out.println(saleStatus); */


BoardTO to = new BoardTO();
to.setCategorySeq(category); 
to.setTitle(title);
to.setSubTitle(subTitle);
to.setContent(content);
to.setThumbUrl(thumbUrl);
to.setNickname(nickname);
to.setFamilyMemberType(familyMemberType);
to.setSaleStatus(saleStatus);
to.setIsPrivate(false); //공개키

BoardDAO dao = new BoardDAO();
int flag = dao.writeOk(to); 

JSONObject json = new JSONObject();
// 일단 성공한 척 넣기
json.put("flag", flag);


out.println(json);

%>
