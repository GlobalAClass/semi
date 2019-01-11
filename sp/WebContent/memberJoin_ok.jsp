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
//이메일 주소를 합쳐서 mdto에 set하기
	String idEmail = request.getParameter("idEmail") +"@"+ request.getParameter("idEmail2");
	mdto.setidEmail(idEmail);
%>

<script>
alert('<%=mdto.getidEmail()%>');
alert('<%=mdto.getPwd()%>');
alert('<%=mdto.getMName()%>');
alert('<%=mdto.getFieldMajor()%>');
alert('<%=mdto.getEmailAgreement()%>');
</script>

<script>
	if(!'<%=mdao.memberJoinCheck(mdto)%>'){
		//필수항목 오류 : null, ""
		alert('필수항목을 기입하세요.');
		location.href='/sp/memberJoin.jsp'
	}else{
		//필수항목 제대로 기입하면 추가항목페이지로 이동.
		location.href='/sp/memberJoinAdd.jsp';
	}
</script>