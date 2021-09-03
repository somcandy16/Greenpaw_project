<%@ page language="java" contentType="plain; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%@ page import="org.json.simple.JSONObject"%>
<%@page import="java.io.File"%>

<%@page import="model1.PersonalAlbumDAO"%>
<%@page import="model1.PersonalAlbumTO"%>
    
<%
	request.setCharacterEncoding("utf-8");
	
	// 넘어온 파라미터로 디비에 insert 
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String thumbUrl = request.getParameter("thumbUrl");
	String nickname = (String)session.getAttribute("nickname");
	String isPrivateString = request.getParameter("isPrivate");
	Boolean isPrivate = true;
	if(isPrivateString.equals("false")){
		isPrivate = false;
	}
	
	String familyMemberType = request.getParameter("familyMemberType");
	
	int hit = 0;
	int likeCount = 0;
	String catSeq = "2"; //성장앨범 게시판
	String saleStatus = null;
	String subTitle = null;
	
	
	// 삭제해야하는 파일 배열
	String[] removedImg = request.getParameterValues("removedImg[]") ;
	if ( removedImg != null ){
    //System.out.println("removedImg length : "+ removedImg.length);

	    for( String fileUrl : removedImg ){
	        String[] splitedFileUrl = fileUrl.split("/");
	        String fileName = splitedFileUrl[splitedFileUrl.length-1];
	
	        // 각자 바꿔주기~! (아니면 realPath 쓰기)
	        String filePath =  request.getRealPath("upload")+"/";
	        filePath += fileName;
	        //System.out.println("filePath : "+filePath);
	
	        File file = new File(filePath);
	        if ( file.exists()){
	            file.delete(); // 파일이 있으면 삭제 
	        }
	    }
	}

	
	
	/* System.out.println(title);
	System.out.println(content);
	System.out.println(thumbUrl);
	System.out.println(nickname);
	System.out.println(familyMemberType);
	 */
	 System.out.println("is private String: "+isPrivateString);
	 System.out.println("is private Boolean: "+isPrivate);
	
	
	PersonalAlbumTO to = new PersonalAlbumTO();
	to.setTitle(title);
	to.setContent(content);
	to.setThumbUrl(thumbUrl);
	to.setNickname(nickname);
	to.setFamilyMember(familyMemberType);
	to.setIsPrivate(isPrivate);
	to.setHit(hit);
	to.setCatSeq(catSeq);
	to.setLikeCount(likeCount);
	to.setSaleStatus(saleStatus);
	to.setSubTitle(subTitle);
	
	PersonalAlbumDAO dao = new PersonalAlbumDAO();
	int flag = dao.writeOk(to);
	System.out.println(flag);
	
	JSONObject json = new JSONObject();
	json.put("flag", flag);
	json.put("seq", to.getSeq());
	
	out.println(json);

%>
