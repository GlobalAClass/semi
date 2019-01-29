<%@page import="competition.CompetitionInfoDTO"%>
<%@page import="mypage.MyMakeMoimDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<%@ page import="match.*" %>
<%@ page import="java.util.*" %>
    
<%
//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
String crt_name = (String)session.getAttribute("smname");
MemberDAO dao = new MemberDAO();
int member_ix=dao.getMemberIndex(crt_id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
article{
	width:800px;
	margin-left: 100px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
	<div align="center" style="font-size:40px;font-weight:bold;margin:20px;">내가 만든 모임</div>
	<%
	MyMakeMoimDAO mdao = new MyMakeMoimDAO();
	
	ArrayList<MatchDTO> matchlist = mdao.makeMoimInfo(member_ix);
	ArrayList<CompetitionInfoDTO> complist = mdao.makeMoimCompInfo(member_ix);
	
	int length = matchlist.size();
	if(length==0){
		%><div>내가 만든모임이 존재하지 않습니다.</div><%
	}else{
		for(int i=0;i<length;i++){
			int match_ix = matchlist.get(i).getMatchIx();
			int comp_ix = complist.get(i).getCompetitionInfoIx();
			String matchName = matchlist.get(i).getMatchName();//모임명
			String compName = complist.get(i).getCName();//공모전명
			
			String myMainRole = matchlist.get(i).getMainRole();
			String myDetailRole = matchlist.get(i).getDetailRole();
			
	%>
		<%@include file="/mypage/makeMoimCard.jsp" %>
	<%
		}
	}
	%>
	
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>