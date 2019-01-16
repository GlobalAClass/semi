<%@page import="java.util.ArrayList"%>
<%@page import="java.nio.charset.Charset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDetailDTO" %>
<%@ page import="member.MemberHistoryDTO" %>
<%@ page import="member.MemberDAO" %>

<%
	request.setCharacterEncoding("UTF-8");
	int addCount = Integer.parseInt(request.getParameter("addCount")); //공모전 이력 개수.
	
	ArrayList<MemberHistoryDTO> mhdto = new ArrayList<MemberHistoryDTO>();
	for(int i = 0;i<addCount; i++){
		request.getParameter(""+i);
	}
	
		
%>

<jsp:useBean id="mdto" class="member.MemberDTO"/> <!-- 회원 필수 사항 -->
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mddto" class="member.MemberDetailDTO"/> <!-- 회원 추가 사항 -->
<jsp:setProperty property="*" name="mddto"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>

<script>
//alert('<%=mdto.getidEmail()%>');
//alert('<%=mdto.getPwd()%>');
//alert('<%=mdto.getMName()%>');
//alert('<%=mdto.getFieldMajor()%>');
//alert('<%=mdto.getEmailAgreement()%>');
</script>

