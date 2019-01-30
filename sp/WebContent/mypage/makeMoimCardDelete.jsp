<%@page import="match.MatchRecruitedDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
int match_ix = Integer.parseInt(request.getParameter("match_ix"));

MatchRecruitedDAO mdao = new MatchRecruitedDAO();
int res = mdao.applyDeleteAll(match_ix);
String msg = res>0?"모임이 삭제되었습니다.":"삭제 오류";
%>
<script>
alert('<%=msg%>');
location.href="/sp/mypage/makeMoim.jsp";
</script>