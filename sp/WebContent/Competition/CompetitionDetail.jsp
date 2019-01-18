<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="competition.*" %>
<jsp:useBean id="cdto" class="competition.CompetitionInfoDTO"/>
<jsp:setProperty property="*" name="cdto"/>
<jsp:useBean id="cdao" class="competition.CompetitionInfoDAO"/>
<% 
// 공모전 제목 클릭시 공모전 정보인덱스로 값 받아오기
String ix_s=request.getParameter("ix");
if(ix_s==null||ix_s.equals("")){
	ix_s="0";
}
Integer ix=Integer.parseInt(ix_s);
//공모전 제목 클릭시 정보보기 DAO
CompetitionInfoDTO dto=cdao.CompetitionCNameInfo(ix);
if(dto==null){
	%>
	<script>
	window.alret('삭제된 공모전이거나 잘못된 접근입니다.');
	location.href='Competition.jsp';
	</script>
	<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
.sub{
	font-weight: bold;
}
#Competition_title{
	width: 800px;
	margin-top: 10px;
	background: #D8D8D8;
	color: black;
	font-size: 30px;
	font-weight: bold;
	text-align: center;
}
article{
	width:800px;
	margin-left: 100px;
}
</style>
</head>
<body>
<%@include file="/header.jsp" %>
<%@include file="/Competition/aside.jsp" %>
<section>
	<article>
		<div>
			<table style="width:800px;height:250px;">
				<tr>
					<td style="width:200px;height:250px;" rowspan="9"><img style="width:200px;height:250px;border: 1px solid gray; margin-right:30px;" src="/sp/img/content.jpg"></td>
				</tr>
				<tr>
					<td colspan="2" style="font-size:20px;"><%=dto.getCName()%></td>
				</tr>
				<tr>
					<td class="sub">분야</td>
					<td><%=dto.getField()%></td>
				</tr>
				<tr>
					<td class="sub">팀/개인</td>
					<td><%=dto.getTeamSolo()%></td>
				</tr>
				<tr>
					<td class="sub">주최</td>
					<td><%=dto.getAuspice()%></td>
				</tr>
				<tr>
					<td class="sub">주관</td>
					<td><%=dto.getCManage()%></td>
				</tr>
				<tr>
					<td class="sub">참가자격</td>
					<td><%=dto.getEntitlement()%></td>
				</tr>
				<tr>
					<td class="sub">접수기간</td>
					<td><%=dto.getPeriod()%></td>
				</tr>
				<tr>
					<td class="sub">홈페이지</td>
					<td><a><%=dto.getCLink()%></a></td>
				</tr>
			</table>
		</div>
		
		<!-- 현재 생성된 모임 | 공모전 상세보기 -->
		<div>
			<table id="Competition_title">
			<tr>
				<td style="border-right:1px gray solid;">현재 생성된 모임</td><td>공모전 상세보기</td>
			</tr>
			</table>
		</div>
		<!-- 내부 영역 -->
		<div align="center">
		<!-- 현재 생성된 모임 클릭 시 -->
		<p align="right"><a href="/sp/Competition/CompetitionMoimMake.jsp"><input type="button" value="모임 생성하기"></a></p>
		<%@include file="CompetitionMoimCard.jsp" %>
		<!-- 공모전 상세보기 클릭 시 -->
		</div>
	</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>