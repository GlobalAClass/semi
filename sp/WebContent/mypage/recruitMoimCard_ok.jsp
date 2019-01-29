<%@page import="mypage.MyRecruitMoimDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

MyRecruitMoimDAO rdao = new MyRecruitMoimDAO();

int matchApplyIx = Integer.parseInt(request.getParameter("matchApplyIx"));
int memberIx = Integer.parseInt(request.getParameter("memberIx"));
int matchIx = Integer.parseInt(request.getParameter("matchIx"));
int matchWantedIx = Integer.parseInt(request.getParameter("matchWantedIx"));

int res = rdao.recuritDel(matchApplyIx, memberIx, matchIx, matchWantedIx);

%>
<script>
location.href="/sp/mypage/recruitMoim.jsp";
</script>