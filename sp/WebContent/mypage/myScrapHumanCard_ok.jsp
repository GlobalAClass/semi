<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="hdao" class="hsearch.HumanScrapDAO"/>

<%
request.setCharacterEncoding("UTF-8");

int my_idx = Integer.parseInt(request.getParameter("memberIx"));
int delete_idx = Integer.parseInt(request.getParameter("scrapMemberIdx"));

int res = hdao.delScrapHuman(my_idx, delete_idx);

%>
<script>
location.href="/sp/mypage/myScrapHuman.jsp";
</script>