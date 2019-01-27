<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="hsearch.*" %>

<jsp:useBean id="csdao" class="competition.CompetitionScrapDAO"/>

<%
	request.setCharacterEncoding("UTF-8");

	int member_ix = Integer.parseInt(request.getParameter("user_ix"));
	int scrap_comp_ix = Integer.parseInt(request.getParameter("comp_ix"));
	String scrapcheck = request.getParameter("scrapcheck");

	int check;
	String msg="";
	if(scrapcheck.equals("false")){
		check = csdao.insertScrapComp(member_ix, scrap_comp_ix);
		msg = check>0? "해당 공모전이 스크랩 되었습니다.마이페이지에서 확인 가능합니다.":"스크랩 실패";
	}else if(scrapcheck.equals("true")){
		check = csdao.deleteScrapComp(member_ix, scrap_comp_ix);
		msg = check>0? "스크랩이 해제되었습니다.":"스크랩해제 실패";
	}
%>
<script>
var idx = <%=scrap_comp_ix%>

alert('<%=msg%>');
location.href='/sp/Competition/CompetitionDetail.jsp?ix='+idx;
</script>