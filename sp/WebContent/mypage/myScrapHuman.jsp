<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="member.*" %>
<%@page import="hsearch.*" %>
<%@page import="java.io.File"%>

<%
//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
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
<div align="center" style="font-size:40px;font-weight:bold;margin:20px;">내가 스크랩한 사람</div>
<%
HumanScrapDAO hdao = new HumanScrapDAO();
ArrayList<Pair<MemberDTO, MemberDetailDTO>> myScrapHumans = hdao.myScrapHumanCard(member_ix);

int cards = myScrapHumans.size();

if(cards>0){
	for(int i=0;i<cards;i++){
%>
<%@include file="/mypage/myScrapHumanCard.jsp" %>
<%
	}
}
%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>