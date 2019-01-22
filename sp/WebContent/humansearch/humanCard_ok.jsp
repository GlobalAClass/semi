<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="hsearch.*" %>

<jsp:useBean id="hsdao" class="hsearch.HumanScrapDAO"/>

<%
	request.setCharacterEncoding("UTF-8");

	int uix = Integer.parseInt(request.getParameter("user_ix"));
	int mix = Integer.parseInt(request.getParameter("member_ix"));
	String scrapcheck = request.getParameter("scrapcheck");

	int check;
	String msg="";
	if(scrapcheck.equals("false")){
		check = hsdao.scrapHuman(uix, mix);
		msg = check>0? "마음속에 저장~":"스크랩 실패";
	}else if(scrapcheck.equals("true")){
		check = hsdao.delScrapHuman(uix, mix);
		msg = check>0? "스크랩 해제":"스크랩해재 실패";
	}
%>

<script>
alert('<%=msg%>');
location.href='humanSearch.jsp';
</script>