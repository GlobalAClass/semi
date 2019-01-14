<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>

<jsp:useBean id="mdto" class="member.MemberDTO"/>
<jsp:setProperty property="*" name="mdto"/>
<jsp:useBean id="mdao" class="member.MemberDAO"/>


<%
	
%>

<script>
alert('<%=mdto.getidEmail()%>');
alert('<%=mdto.getPwd()%>');
alert('<%=mdto.getMName()%>');
alert('<%=mdto.getFieldMajor()%>');
alert('<%=mdto.getEmailAgreement()%>');
</script>

