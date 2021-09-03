<%@ page language="java" contentType="plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
    
<%@page import="org.json.simple.JSONObject"%>

<%@page import="model1.PersonalAlbumDAO"%>
<%@page import="model1.PersonalAlbumTO"%>

<%
	String seq = request.getParameter("seq");
	String nickname = (String)session.getAttribute("nickname");
	String catSeq = "2"; //성장앨범 게시판
	
	System.out.println(seq);
	System.out.println(nickname);
	
	PersonalAlbumTO to = new PersonalAlbumTO();
	to.setSeq(seq);
	to.setCatSeq(catSeq);
	to.setNickname(nickname);
	
	PersonalAlbumDAO dao = new PersonalAlbumDAO();
	int flag = dao.deleteOk(to);
	
	System.out.println(flag);

	JSONObject json = new JSONObject();
	json.put("flag", flag);
	
	out.println(json);

 %>
    