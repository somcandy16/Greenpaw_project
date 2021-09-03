<%@page import="model1.BoardDAO"%>
<%@page import="model1.BoardTO"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page language="Java" contentType="plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%
request.setCharacterEncoding("utf-8");

// 넘어온 파라미터로 디비에 insert 
String title = request.getParameter("title");
String subTitle = request.getParameter("subTitle");
String content = request.getParameter("content");
String thumbUrl = request.getParameter("thumbUrl");
String nickname = (String)session.getAttribute("nickname");
Boolean isPrivate = false;

String saleStatus ="";
String hit = "0";
String likeCount = "0";
String categorySeq = "5";
String familyMemberType = "";

System.out.println("세션 메일: "+session.getAttribute("mail"));
System.out.println("세션 닉네임: "+session.getAttribute("nickname"));
System.out.println("세션 권한: "+session.getAttribute("authType"));

if (request.getParameter("categorySeq") != null && !request.getParameter("categorySeq").equals("") ){
	categorySeq = request.getParameter("categorySeq");
}
if (request.getParameter("familyMemberType") != null && !request.getParameter("familyMemberType").equals("") ){
	familyMemberType = request.getParameter("familyMemberType");
} 
System.out.println("패밀리타입"+familyMemberType);
 if (request.getParameter("saleStatus") != null && !request.getParameter("saleStatus").equals("") ){
	saleStatus = request.getParameter("saleStatus");
}

System.out.println(categorySeq);
System.out.println(subTitle);
System.out.println(saleStatus);
System.out.println(familyMemberType);
System.out.println(title);
System.out.println(content);
/* System.out.println(thumbUrl); */
System.out.println(nickname);
System.out.println(likeCount);
System.out.println(hit);


BoardTO to = new BoardTO();
to.setCategorySeq(categorySeq); 
to.setSubTitle(subTitle);
to.setSaleStatus(saleStatus);
to.setFamilyMemberType(familyMemberType);
to.setTitle(title);
to.setContent(content);
to.setThumbUrl(thumbUrl);
to.setNickname(nickname);
to.setIsPrivate(isPrivate);
to.setLikeCount(likeCount);
to.setHit(hit);

BoardDAO dao = new BoardDAO();
int flag = dao.writeOk(to); 

JSONObject json = new JSONObject();
// 일단 성공한 척 넣기
json.put("flag", flag);

out.println(json);

%>
