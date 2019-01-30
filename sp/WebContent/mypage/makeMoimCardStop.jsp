<%@page import="mypage.MyMakeMoimDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

MyMakeMoimDAO mdao = new MyMakeMoimDAO();
int match_ix = Integer.parseInt(request.getParameter("mix"));

int res = mdao.applyHoldChange(match_ix);

%>
<script>
location.href="/sp/mypage/makeMoim.jsp";
</script>