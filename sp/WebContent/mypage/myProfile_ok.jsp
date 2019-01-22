<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<%
String idEmail = (String)session.getAttribute("sidEmail");
int index = dao.getMemberIndex(idEmail);

//수정된 이미지 들어갈 경로 설정
String path = request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+index;

//수정된 사진 업로드
try{
	int sizeLimit = 5*1024*1024; //프로필 사진 크기는 5MB로 제한.
	MultipartRequest mr = new MultipartRequest(request, path, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	//수정은 전공/분야 와 이메일 수신여부만 수정 가능함
	String fm=mr.getParameter("fieldMajor");
	String ea=mr.getParameter("emailAgreement");
	
	//추가 정보는 모든 정보 수정 가능함
	MemberDetailDTO ddto = new MemberDetailDTO(mr.getParameter("contact"),mr.getParameter("contactAgreement"),mr.getParameter("kakaoId"),
			mr.getParameter("kakaoIdAgreement"), mr.getParameter("birthYear"),mr.getParameter("sido"),
			mr.getParameter("sigungu"), mr.getParameter("mProfile"));
	
	//회원 추가 정보 DAO
	MemberDetailDAO ddao = new MemberDetailDAO();
	
	//회원 필수정보 수정
	int res = dao.memberUpdate(fm,ea,index);
	String msg1 = res<0?"필수 정보 수정 오류":"";
	
	//회원 선택정보 수정
	int res2 = ddao.memberDetailUpdate(ddto, index);
	String msg2 = res2<0?"추가 정보 수정 오류":"";
	
	//회원 공모전 정보 수정
	
	//오류 출력
		if(!msg1.equals("")){
			%><script>alert('<%=msg1%>');</script><%
		} else if(!msg2.equals("")){
			%><script>alert('<%=msg2%>');</script><%
		}
	
}catch(Exception e){
	out.print(e);
	%><script>alert('프로필 이밎 수정 시 문제 발생');</script><%
}

%>