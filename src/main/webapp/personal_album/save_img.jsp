<%@ page language="java" contentType="plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

    
<%
// 1. 넘어온 이미지 파일 upload 폴더에 업로드
// 2. 넘어온 이미지 파일을 url 로 반환
/* String uploadPath = "C:/jproject/workspace/greenpaw0827v4.3/src/main/webapp/upload"; */
String uploadPath = request.getRealPath("upload");
int maxFileSize = 1024 * 1024 * 5; // 5메가
String encType = "utf-8";

MultipartRequest multi = new MultipartRequest(request, uploadPath, maxFileSize, encType, new DefaultFileRenamePolicy());
/* String originFileName = multi.getOriginalFileName("image"); */
//System.out.println(uploadPath);
String fileName = multi.getFilesystemName("image");


JSONObject json = new JSONObject();
json.put("url", "http://localhost:8080/greenpaw0903v4.6/upload/"+fileName);

out.println(json);

%>
