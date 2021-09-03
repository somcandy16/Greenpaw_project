<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model1.UserTO"%>
<%@page import="model1.UserDAO"%>    
<%
    String email = (String) session.getAttribute("mail");
            UserDAO dao = new UserDAO();
        	UserTO userData = dao.loginInformation(email);
        	
        	System.out.println(userData.getNickname());
        	session.setAttribute("nickname",userData.getNickname());
        	session.setAttribute("authType", userData.getAuthType());
        	
        	out.println("<script>");
        	out.println("location.href='../main.jsp'");
        	out.println("</script>");
%>

